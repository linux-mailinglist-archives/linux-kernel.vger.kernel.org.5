Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA32772982
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjHGPlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjHGPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:41:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201B5BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:41:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691422900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjn+siovhRN5AojBNf+LUjUDgv7urxT8t+Hk0E3jT/8=;
        b=mEdMhDQi0L8xyiW6vfd38ex4sL1tFpqiDIHTgxiHTl+8QkTKvTakKixF9ed+jbV6pxlXea
        lthtLCnfI6qduH29GJ4eb7oGOcbL29HJrZf1ZPzyQ9RKkdsC3M7p09Wtj/ORPF0g5aVdPF
        IXacNk1o1AKA7IUVTRBwLfdSBKfOSstD2k7BnicptE8lclLweTLeK5o2m+ZkfmylK7kH9R
        WeN7GLPnFxIz4AnyMXn76FCLo6+dj4/WPv2PzuA/x+5jT0g7fBsIg84LU9OreuINGbVkGQ
        k9MAbdr30YT3DvjhLoYP+Boro9w49d1ESiGIpsbIGx2Bo5e2J2aSdWxUAJ697w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691422900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjn+siovhRN5AojBNf+LUjUDgv7urxT8t+Hk0E3jT/8=;
        b=4YyddQYaMvVwmAKDYiTcy2CUydpoZZtENbIKx6FWhbhoWO/Ur4FLhSMvU2XrN3klXBYoVq
        7vLJBOTPucqvx0DA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 25/53] x86/acpi: Use new APIC registration functions
In-Reply-To: <20230807152706.GC569857@hirez.programming.kicks-ass.net>
References: <20230807130108.853357011@linutronix.de>
 <20230807135027.744726431@linutronix.de>
 <20230807152706.GC569857@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Aug 2023 17:41:40 +0200
Message-ID: <874jlavozv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07 2023 at 17:27, Peter Zijlstra wrote:

> On Mon, Aug 07, 2023 at 03:53:12PM +0200, Thomas Gleixner wrote:
>> +static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
>
> just stating on the record what I said during review last week: whoever
> caused these APIC and ACPI names to go together was a sadist.
>
> Same 4 letters but permuted differently :-/ this is so very hard to keep
> straight.

Good thing that the kernel has no use for Atmospheric Pressure Chemical
Ionization otherwise we'd have APCI right next to it.

