Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB3278153C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbjHRWHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjHRWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1CF3AB5;
        Fri, 18 Aug 2023 15:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C8A612F3;
        Fri, 18 Aug 2023 22:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E0C433C7;
        Fri, 18 Aug 2023 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692396452;
        bh=Jn/enJycIQczuSxJepo7xuHciUhfnR+IXdjyxJATpBw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=sboiAs42p0nxUU6YVZeaqeZWnMkR4RQn8KbBYgqXxe6XMaHAUOYGXEkvpZzOGeunA
         yHrOhX1rGFBLtSY1TRT6pGMR5OU9Bm/d851gpvngx8oF1qbdusPfbrFUIA8wQ410wx
         98y/tamI1qPCtvyIC+UGjks3t4CnsMSdji3+3o2LF4HLlZrZ9mHXHVRUgLvTuaQO2R
         LJMIzRRz5SbkxK1XGIxDzFixdczv8fGD5G2B53jLSWEqiCQfCoxXJlb6ZUoqSXhJqw
         Xjt8DgoMUnR+ZN6KsdACLLcEHFAjws4aO8XpzMMJK6HeHIySMw9Z1Sbh4NHYsHlHCY
         RNSYYxJ/U7EdA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 22:07:28 +0000
Message-Id: <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>,
        <len.brown@intel.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>
X-Mailer: aerc 0.14.0
References: <20230818181516.19167-1-mario.limonciello@amd.com>
In-Reply-To: <20230818181516.19167-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 6:15 PM UTC, Mario Limonciello wrote:
> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't rep=
ly
> at bootup and returns back the command code.

Is this reproducible with any production hardware? You are stating it
as it was reproducible categorically with any Intel fTPM.

> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, throw
> away the error code to let Intel fTPM continue to work.
>
> Cc: stable@vger.kernel.org
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")

It does make sense not to exercise this outside of AMD CPus but since
there is no production hardware failing, it cannot be categorized as a
bug fix.

> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 9eb1a18590123..b0e9931fe436c 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> -	if (ret)
> +	if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
>  		goto release;

It would be better not to exercise a potentially failing code path at
all. This initiates full transaction with the TPM.

> =20
>  	if (val =3D=3D 0x414D4400U /* AMD */)
> --=20
> 2.34.1

BR, Jarkko
