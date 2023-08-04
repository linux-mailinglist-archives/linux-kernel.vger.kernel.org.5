Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB0770C23
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHDWwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHDWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030E1BE;
        Fri,  4 Aug 2023 15:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A69262153;
        Fri,  4 Aug 2023 22:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FF5C433C8;
        Fri,  4 Aug 2023 22:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691189540;
        bh=JTeFe3yU6FTfVxHVzbN6FFW+rwd+24FgVbF4IkXJvlw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=DAi1vg4eGxZeRFG/j0+u3c83hJLIbyd5rrNPN+GakXezFYR7UzPD4UHChAxacNgfJ
         DcHb5ebX5RuJU9SDUDhWp7T10+i/KIChH3R+I/R1AY/bBii49/ffrK4qqlt+11sLTZ
         WMkUwGvNs5uDHae2qEcp2LQGpBVcV7kknLzhad2qf9XpbYa+ENQ90hEVHzt+y73UEj
         pWDVwAtSpidxjyqKN8gZguNdOuJXaMTGrMVNlEyQZoYE+zl6Yk+nmQW8nOzxknDgQX
         i++eBS8qKRsmFzwEd2SWdBTN3lCynHfhK0OLxWTqcyf1rvGdThOrxomXXiplL3HMFp
         xZT3e6RUognhQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 05 Aug 2023 01:52:17 +0300
Message-Id: <CUK4NNTX7G6W.669WZVTTH2SD@wks-101042-mac.ad.tuni.fi>
Cc:     <peterhuewe@gmx.de>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <dragonn@op.pl>
Subject: Re: [PATCH 1/3] tpm: Add a missing check for
 TPM_CHIP_FLAG_HWRNG_DISABLED
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.15.2
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-2-mario.limonciello@amd.com>
 <CUISBN0W36B2.1DXXNNGS6P7JC@suppilovahvero>
 <d19d0e9a-a788-8b33-506d-8a080d566366@amd.com> <ZMuwtE2IA-Hd3Vyd@zx2c4.com>
In-Reply-To: <ZMuwtE2IA-Hd3Vyd@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 3, 2023 at 4:50 PM EEST, Jason A. Donenfeld wrote:
> On Thu, Aug 03, 2023 at 06:35:36AM -0500, Mario Limonciello wrote:
> > On 8/3/23 03:59, Jarkko Sakkinen wrote:
> > > On Thu Aug 3, 2023 at 4:50 AM EEST, Mario Limonciello wrote:
> > >> If the TPM is opted out of hwrng the error handling for
> > >> tpm_chip_register() needs to know this so it doesn't try to clean
> > >> up an uninitialized chip->hwrng.
> > >>
> > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >> ---
> > >>   drivers/char/tpm/tpm-chip.c | 3 ++-
> > >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip=
.c
> > >> index e904aae9771be..8f61b784810d6 100644
> > >> --- a/drivers/char/tpm/tpm-chip.c
> > >> +++ b/drivers/char/tpm/tpm-chip.c
> > >> @@ -629,7 +629,8 @@ int tpm_chip_register(struct tpm_chip *chip)
> > >>   	return 0;
> > >>  =20
> > >>   out_hwrng:
> > >> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(c=
hip))
> > >> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(c=
hip) &&
> > >> +	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
> > >>   		hwrng_unregister(&chip->hwrng);
> > >>   out_ppi:
> > >>   	tpm_bios_log_teardown(chip);
> > >> --=20
> > >> 2.34.1
> > >=20
> > > Please add a fixes tag.
> > >=20
> > > BR, Jarkko
> >=20
> > I didn't add a fixes tag because you hadn't sent a PR for the other one=
=20
> > yet so I wasn't sure the hash would be stable.  Also I thought it might=
=20
> > just make sense to squash into it.
> >=20
> > If the hash is now stable, could you just just commit and add that tag=
=20
> > with it yourself?  Or do you want me to re-send as a v2 with that?
>
> What about just sending a v3 of the patch that this patch fixes? The
> stable@/fixes tags in that are wrong/incomplete so Jarkko's tree will
> need to be fixed before pushing to Linus anyway.

Sounds reasonable. I can hold the PR to rc6 and send it on Monday.

BR, Jarkko
