Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8A780701
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358540AbjHRITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358571AbjHRISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:18:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D71FCE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:18:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692346718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4baXtMHgqkhMrtV98Vd43pFr6FjCa33MyghzUYnsJho=;
        b=hQbJr+8ikWKy4OEqcrqtKDnwz3de7BUplorAsgtL3M5gmsKafKq1vv1Fa4Eg0KpRx/VVMV
        jfxVfNw07/9ftg/jvlanpuVs8vGM90Sz2T2zITcu0teonq09r1xmO0d7wh7JU0Ssjf+9Lm
        k6NX7Cb9+MRGJECfE9gd24wTbnvl+aJJTmBcgrHEYL/2/3nwz8OQutrorEaOuH9ANgbY6Z
        LNmAyElt6PW+PUwD06zAPX/FUo8l6vPQZ7MABESc4gjMUCsxSHTI1un+lQUK1u1dENbrVG
        2E0X5xFxnuQ7IS8sDEQICnXW1zGY8JKGHrjKXcvKotBxigJW47lfY/bz96uwRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692346718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4baXtMHgqkhMrtV98Vd43pFr6FjCa33MyghzUYnsJho=;
        b=qNqm2pHIcxKF8Z2VGCrwOjTCqoVgUZPA6au4W4HKsYQWS7RxOKmTSRktHlRndPSKJy+Wde
        /yxzNyLarUBdAACA==
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/earlycpio: Mark find_cpio_data() __no_stack_protector
In-Reply-To: <20230816100221.12209-1-bp@alien8.de>
References: <20230816100221.12209-1-bp@alien8.de>
Date:   Fri, 18 Aug 2023 10:18:38 +0200
Message-ID: <87a5uohig1.ffs@tglx>
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

On Wed, Aug 16 2023 at 12:02, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> find_cpio_data() is called by the 32-bit x86 microcode loader while
> paging is not yet enabled and the CPU is running off physical addresses.
> However, when stack protector is enabled, the compiler adds the stack
> protection check for this function:

There are a lot more functions which have the same problem.

It's completely unclear to me how this is supposed to work at that point
where paging is disabled.

The stackprotector does:

 321:	64 8b 35 00 00 00 00 	mov    %fs:0xc2686834,%esi
 328:	89 75 f0             	mov    %esi,-0x10(%ebp)

....

 531:	8b 75 f0             	mov    -0x10(%ebp),%esi
 534:	64 2b 35 00 00 00 00 	sub    %fs:c2686834,%esi
 53b:	0f 85 42 01 00 00    	jne    683

c2686834 is the compile time address of __stack_chk_guard, which is a
per CPU variable.

%fs is __DS_BOOT at that point which uses the boot GDT. __DS_BOOT is 4GB
 data rw segment.

So this reads from some random place in memory or if there is not big
enough memory it either reads from an alias address or just whatever the
hardware decides to read from the void.

IOW, this just works by chance, but certainly not by any form of design.

Not sure what to do about that.

Thanks,

        tglx
