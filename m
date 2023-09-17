Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C67A3754
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjIQTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjIQTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:17:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D3FA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:17:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694978253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dsze4QgNpH5PAtMmi41Vkp4H1iwRUhvw6y9SRfKFP50=;
        b=GNU3Mv/RUR+HzCM+m3CKnQEZyiTQuR+HMX9/q18yVGWr0AdR8lnKJnWt0NSK1ngRQZJTc8
        pETSMH1WU8u/rV760Gap0QakcQSU8wjjje2lfZF4bEfNfJ4LJtHOQsklhW60vIdvhHqD8S
        ZF8iu14eITiEAFOcj3n4ZzX6jkloKpOeJ2MZtxNnHVcVwf9fluChQLx7wOOby7gSZGeX41
        gJBYXvuN3fjFTwuONyGiMmUJHub0/4E/5/PnL1iuC3WfWcwTSTiG0EYp5SLFq+V08S74xX
        Rsbum9WIeKOORUKK+k1Bssx1FTC/Ht827UGdNgAKFPUoKYI4s62Ts97meq/hSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694978253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dsze4QgNpH5PAtMmi41Vkp4H1iwRUhvw6y9SRfKFP50=;
        b=UhGswsCOuMnv9hgt9ofMZ7hoXwQfW1EwrOj1QOJs6WLy6CZ6fkunASgt5LWyMOLVqYwMOR
        Bj6O6frEObdRxYDw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Subject: Re: [patch V3 01/30] x86/microcode/32: Move early loading after
 paging enable
In-Reply-To: <1e2ecded-c1f6-462c-f66e-756a9d76c41d@intel.com>
References: <20230912065249.695681286@linutronix.de>
 <20230912065500.823314239@linutronix.de>
 <1e2ecded-c1f6-462c-f66e-756a9d76c41d@intel.com>
Date:   Sun, 17 Sep 2023 21:17:33 +0200
Message-ID: <87jzsozk1e.ffs@tglx>
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

On Sat, Sep 16 2023 at 02:03, Chang S. Bae wrote:
> On 9/12/2023 12:57 AM, Thomas Gleixner wrote:
>> 
>>   static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
>>   {
> ...
>> -	if (early)
>> -		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
>> -	else
>> -		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
>> -
>
> Nitpick:
>
> with this change, there is no need for the second argument -- 'bool early'.

Duh. Yes ...
