Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910AB76EB36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjHCNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHCNv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB413D;
        Thu,  3 Aug 2023 06:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13DD861D85;
        Thu,  3 Aug 2023 13:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E23AC433C8;
        Thu,  3 Aug 2023 13:51:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vj6oUffI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691070713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5JwOoI+ZFbwXVeHhEPuM+BAtu3rUbpaUamON1nqc30=;
        b=Vj6oUffIrhn9fItDtdT/uTzNB0DS8JCpm0SQqquzdU9M0gpCW8XUILr1lr3sfe57FB07SB
        tgzS/zJGxcLRO5xACcWNsagXlzbJKVkbj/mfhkPEt9acO/+s9sI8Hiv708wLLhA2T67UaY
        d38AgQgGfILCKdjRuVSIiObA86ixNL0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c59b81e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Aug 2023 13:51:53 +0000 (UTC)
Date:   Thu, 3 Aug 2023 15:50:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        dragonn@op.pl
Subject: Re: [PATCH 1/3] tpm: Add a missing check for
 TPM_CHIP_FLAG_HWRNG_DISABLED
Message-ID: <ZMuwtE2IA-Hd3Vyd@zx2c4.com>
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-2-mario.limonciello@amd.com>
 <CUISBN0W36B2.1DXXNNGS6P7JC@suppilovahvero>
 <d19d0e9a-a788-8b33-506d-8a080d566366@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d19d0e9a-a788-8b33-506d-8a080d566366@amd.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:35:36AM -0500, Mario Limonciello wrote:
> On 8/3/23 03:59, Jarkko Sakkinen wrote:
> > On Thu Aug 3, 2023 at 4:50 AM EEST, Mario Limonciello wrote:
> >> If the TPM is opted out of hwrng the error handling for
> >> tpm_chip_register() needs to know this so it doesn't try to clean
> >> up an uninitialized chip->hwrng.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/char/tpm/tpm-chip.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >> index e904aae9771be..8f61b784810d6 100644
> >> --- a/drivers/char/tpm/tpm-chip.c
> >> +++ b/drivers/char/tpm/tpm-chip.c
> >> @@ -629,7 +629,8 @@ int tpm_chip_register(struct tpm_chip *chip)
> >>   	return 0;
> >>   
> >>   out_hwrng:
> >> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
> >> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
> >> +	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
> >>   		hwrng_unregister(&chip->hwrng);
> >>   out_ppi:
> >>   	tpm_bios_log_teardown(chip);
> >> -- 
> >> 2.34.1
> > 
> > Please add a fixes tag.
> > 
> > BR, Jarkko
> 
> I didn't add a fixes tag because you hadn't sent a PR for the other one 
> yet so I wasn't sure the hash would be stable.  Also I thought it might 
> just make sense to squash into it.
> 
> If the hash is now stable, could you just just commit and add that tag 
> with it yourself?  Or do you want me to re-send as a v2 with that?

What about just sending a v3 of the patch that this patch fixes? The
stable@/fixes tags in that are wrong/incomplete so Jarkko's tree will
need to be fixed before pushing to Linus anyway.

Jason
