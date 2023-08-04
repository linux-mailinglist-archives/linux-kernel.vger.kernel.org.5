Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596E4770949
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHDUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHDUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:03:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC0E6E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:03:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691179380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RY+KCV1GUXfeSnkP8tqvx9zZQuvcAFi0lgOCs2qp6A=;
        b=VPuvWxgS9WL0RP96ZN9kUdijJh3CwzcQey6tV9zq51WWMR+uqIvVv2qV1JJfsLrKQJOGYZ
        8G2imsLnzehztKlKlL/znmIinXQvadpPvnnWBPLuRbjBimLRsF3FbZRexso+yi48Hs3zLY
        hZ7x5lLwGU/QYpENg2QfNAZjHkKgSnaiMVd2m+Sh9eZqSMCDMwvClwa2nTdNnwN/PJ98QT
        xxkLAXihGNfLh6nqo+3cXeZa4bHnYGCGPKn/QIIvvRLo7bK/MJlVxHau+CVTdVt5MrdQCT
        yTrf5P3MSAtedixtVuCnkRwF0cLgPupogvmVjUmNDPIWsGuatTUBG/xYhMwePQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691179380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RY+KCV1GUXfeSnkP8tqvx9zZQuvcAFi0lgOCs2qp6A=;
        b=x+AFNYVBEQEQ2mok/wwqJqI0IAODMT/+/KmVcqEkm4uQO5F9vgNUaEHE03U4udST8Z7qrm
        O/yTL92kiOU5CTDQ==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3 02/40] x86/apic: Fake primary thread mask for XEN/PV
In-Reply-To: <20230804181243.GLZM0/m0xXb/wMpUcD@fat_crate.local>
References: <20230802101635.459108805@linutronix.de>
 <20230802101932.819070039@linutronix.de>
 <20230804181243.GLZM0/m0xXb/wMpUcD@fat_crate.local>
Date:   Fri, 04 Aug 2023 22:02:59 +0200
Message-ID: <87r0oimv7w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04 2023 at 20:12, Borislav Petkov wrote:
>> @@ -2344,6 +2346,15 @@ static int __init smp_init_primary_threa
>>  {
>>  	unsigned int cpu;
>>  
>> +	/*
>> +	 * XEN/PV provides either none or useless topology information.
>> +	 * Pretend that all vCPUs are primary threads.
>> +	 */
>> +	if (xen_pv_domain()) {
>> +		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
>> +		return 0;
>> +	}
>
> Can this be somewhere in the Xen init code instead?

Not for now. That's all going away with the 3rd installment. But right
now it's the right place to be.
