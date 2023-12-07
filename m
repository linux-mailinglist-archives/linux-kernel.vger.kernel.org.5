Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A58808DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjLGQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGQej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:34:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC610EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:34:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701966883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZZRTAGsbxpCLCT0Tjc7lz8XNJGX1CN0KzENj38zzU0=;
        b=RuFkf7Uq2CoPdMPkgz9UYVqlOkarrxqc5XQ6FrSQrqFCtd2Z75hGmhmiqlFKY56nFkV0ll
        9iVtT9u5FgESZlcYx1cnMMd9Uy2Wn+rXKR1czS1aNKUnqFl0vy1LcrNc6uBxJBtGZELV2b
        EfRkVfDws9U7uB+L1lzu6//ZEB97AG/tfRm6SypfCy7ONMnSpxhil0lETLBmj/hrlxJSRy
        WNEIDfa/HtnJenIwOwDOKJg0Nh/FvqIibkv06qsqaVyEoWqgJbWwg+3IaZd+iYQR5Ct9t4
        rPmp7D8z8qXBEGDUXoTu8MNsSY4F/YPEJK5RBW6yNuO2ZPQ1lYASxgg91lnvbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701966883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZZRTAGsbxpCLCT0Tjc7lz8XNJGX1CN0KzENj38zzU0=;
        b=SpZtmGguv8BGZ/OSAOe1A3xr+G9Vo3utlaBLfM0y06MowtLkvSFYkp9GSxD8NOTMCoWeBK
        p0mmhNGZIHHtAwBQ==
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, bp@alien8.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        richard.purdie@linuxfoundation.org, x86@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
In-Reply-To: <ZXCXc+BtnLzqMbFv@windriver.com>
References: <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info> <87r0k9ym0y.ffs@tglx>
 <ZXCXc+BtnLzqMbFv@windriver.com>
Date:   Thu, 07 Dec 2023 17:34:42 +0100
Message-ID: <87h6kut1i5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06 2023 at 10:46, Paul Gortmaker wrote:
> The config file and both "good" and "bad" files are there now:
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=15230
>
> There are a lot more debug lines in the good/working output!
>
> $ grep alternatives: dmesg-debug-alt-good.txt | wc -l
> 4868
> $ grep alternatives: dmesg-debug-alt.txt | wc -l
> 19

Unsurprisingly so. The failing one dies right at the start of
alternative patching....
