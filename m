Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11FB7CDD13
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjJRNUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjJRNUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:20:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925383
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:20:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697635211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MVR+ADnAzu3IGVyOn/9fY32v046O2wGqRN2Zyaap7Q=;
        b=pBwrt03+GeAi+FQfUhEzYlJyTDBHynbcTfzFBneHaNp5cVzoz6o9GDl0n7jEtP4W1be1o5
        e9YgTSvMzOt8OPfU24bDmac44M+y9Af2WSI9cl+xld0M8U96INTYo/+masnfS5bqh3SkRG
        u+ksy29pw6eGpL4vckmofqZfX2BYBUqDtPNh3/DAA5kAESEy6xrSh/JGPJ5ocx6jryQoou
        vdc6WPZFdlKSxZWxFPDvwZ9BgfSqAo7uDIUFLCVHEuJnv7GJGmn53gqs4qKxs5L1jwWkBJ
        OMZJ0rPzzDfNMfOUhuK8ufaGunymoWc866q7nxUlvHgccQPWYVuyCpBl7insgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697635211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MVR+ADnAzu3IGVyOn/9fY32v046O2wGqRN2Zyaap7Q=;
        b=J3c0F6Hq6HOJlQxcnCHwK1Kplqf9c2eGYCph997j1TjdQeVGV5uTEVmLVaHEb6ketau6do
        VeoOhUJ3DWb/ZTDg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch V5 03/39] x86/boot/32: De-uglify the 2/3 level paging
 difference in mk_early_pgtbl_32()
In-Reply-To: <20231018100023.GAZS+st5ePdAQjnO4z@fat_crate.local>
References: <20231017200758.877560658@linutronix.de>
 <20231017211722.111059491@linutronix.de>
 <20231018100023.GAZS+st5ePdAQjnO4z@fat_crate.local>
Date:   Wed, 18 Oct 2023 15:20:10 +0200
Message-ID: <87mswg3w51.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2023 at 12:00, Borislav Petkov wrote:
> On Tue, Oct 17, 2023 at 11:23:26PM +0200, Thomas Gleixner wrote:
>> Move the ifdeffery out of the function and use proper typedefs to make it
>> work for both 2 and 3 level paging.
>> 
>> No functional change.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>> V5: New patch
>> ---
>>  arch/x86/kernel/head32.c |   38 +++++++++++++++++++++-----------------
>>  1 file changed, 21 insertions(+), 17 deletions(-)
>> 
>> --- a/arch/x86/kernel/head32.c
>> +++ b/arch/x86/kernel/head32.c
>> @@ -71,39 +71,43 @@ asmlinkage __visible void __init __noret
>>   */
>>  void __init mk_early_pgtbl_32(void);
>
> Lemme zap that forward declaration too - it looks redundant.

Up to the point where the compiler complains about a missing prototype
for a global visible function, which will bring it back faster than you
think. :)
