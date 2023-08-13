Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686777A5C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHMJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHMJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:08:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A0170C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 02:08:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691917684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ssv4I1NxHnPTIp5CIJdhY75oD/NKqd/mvxBJ1DoAHc4=;
        b=0gswTzyHzSS7LLA5vxGtu70t8aXUC/mW5QqCtBArflYBmqUGmDxJF0OMWFn2mNTxJ07XxC
        w4VV5yrfvu1GmoYO9rLaWhspCpSph9NeUs/+BQKkuHSJ+BeIcfuqskKvEMrJOsByGhYt9P
        6mXATMhvB4cNc+hzVP510BnS1Hf9gnl4EqWsNLCANLcIhiaV3oBsOLls+NzwvyV0kzh4pv
        TH2nmenSg4debUiRC7Rody/6lZO+3JZN4gGVaGePVZA+h44yoXnrSjcbP5ItXoRHxDiuDg
        Zwuulzo+LTLCYpKPCspxVTC6BoCnzmcGfSZK6L6F2tvcUFuIR8j5rxdUILrYhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691917684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ssv4I1NxHnPTIp5CIJdhY75oD/NKqd/mvxBJ1DoAHc4=;
        b=yuDamak9VdMFRbqJyWItx7baBKXqBJmb0X2tFZ0FatHE6wQ0Qy23lPO6NfFG9nfyWT2K66
        NcD7YKmQlvtPApBQ==
To:     Nikolay Borisov <nik.borisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch V2 09/37] x86/microcode/intel: Remove pointless mutex
In-Reply-To: <c1fb4972-765a-d06a-14d1-028a8a75bd97@suse.com>
References: <20230812194003.682298127@linutronix.de>
 <20230812195728.069849788@linutronix.de>
 <c1fb4972-765a-d06a-14d1-028a8a75bd97@suse.com>
Date:   Sun, 13 Aug 2023 11:08:03 +0200
Message-ID: <87zg2vfgy4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13 2023 at 09:55, Nikolay Borisov wrote:
> On 12.08.23 =D0=B3. 22:58 =D1=87., Thomas Gleixner wrote:
>
> So this function is ultimately invoked from a write to the 'reload'=20
> sysfs file, what about 2 racing writes to this file ? Though if it's=20
> about cpu hotplug then in reload_store() this is handled via=20
> cpus_read_lock I guess so indeed this is correct.

80347cd515ca ("x86/microcode: Remove microcode_mutex")
