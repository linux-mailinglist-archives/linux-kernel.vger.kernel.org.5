Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4664784B60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHVU32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjHVU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38239CC;
        Tue, 22 Aug 2023 13:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAFE363DFD;
        Tue, 22 Aug 2023 20:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D58AC433C7;
        Tue, 22 Aug 2023 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692736165;
        bh=MOFk/K2jnaZQy4oe58yWvy2dHUryRYRINRnSTf0C3pA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=PIbq42PPQp8ULA2r5h1leW+ecCqQeSAjzYseS2KT1CvIVsHocx/Rsd3sx5Y9YOGuc
         O7STZMkQd44OEczSCl488pMb2QzqCtk7fZnxEfpxZ7Ky5kJOti9r8CeObuqKsO3OPI
         0OnNMX9g91y4lwpsa4SMwaISAQO0r3BiSdaJqpZSUbIM9DGoquN7eFqWPOGfSi6YlF
         K8A932DPKTTV1NcGNWAER2A+YzTlcAIIzQQOjvfsCASegkXQo3DxyccCUSWJSMo3VJ
         41OKTG6+dDtINpxTMZMLX99dGyb4ZSo9Mh9M4KA+PCMMuTW3qzZ/nHyLx8O5RlCve1
         5lOCWvktYuuag==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 23:29:21 +0300
Message-Id: <CUZCW1BVUATQ.1I4RX0X8OT8SP@suppilovahvero>
Cc:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, "Todd Brandt" <todd.e.brandt@intel.com>,
        "Patrick Steinhardt" <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230821140230.1168-1-mario.limonciello@amd.com>
 <CUZ3T3G99JG2.29X1G67HRO9QT@suppilovahvero>
 <b7d45df7-3d1c-4b31-9da1-5f81d3e5b279@amd.com>
 <CUZ5SUEX8IUC.2LBS3FZP9XUTA@suppilovahvero>
 <lpt7tqahlsekfyfh7qwlznxpitpcqjxwmeps7lljnuzdygkaqp@xcqfenucomie>
In-Reply-To: <lpt7tqahlsekfyfh7qwlznxpitpcqjxwmeps7lljnuzdygkaqp@xcqfenucomie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 22, 2023 at 10:50 PM EEST, Jerry Snitselaar wrote:
> On Tue, Aug 22, 2023 at 05:56:03PM +0300, Jarkko Sakkinen wrote:
> > On Tue Aug 22, 2023 at 5:05 PM EEST, Mario Limonciello wrote:
> > > On 8/22/2023 08:22, Jarkko Sakkinen wrote:
> > > > On Mon Aug 21, 2023 at 5:02 PM EEST, Mario Limonciello wrote:
> > > >> The vendor check introduced by commit 554b841d4703 ("tpm: Disable =
RNG for
> > > >> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs. =
 On the
> > > >> reported systems the TPM doesn't reply at bootup and returns back =
the
> > > >> command code. This makes the TPM fail probe.
> > > >>
> > > >> As this isn't crucial for anything but AMD fTPM and AMD fTPM works=
, check
> > > >> the chip vendor and if it's not AMD don't run the checks.
> > > >>
> > > >> Cc: stable@vger.kernel.org
> > > >> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > > >> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > > >> Reported-by: Patrick Steinhardt <ps@pks.im>
> > > >> Reported-by: Ronan Pigott <ronan@rjp.ie>
> > > >> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> > > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > >> ---
> > > >> v1->v2:
> > > >>   * Check x86 vendor for AMD
> > > >> ---
> > > >>   drivers/char/tpm/tpm_crb.c | 7 ++++++-
> > > >>   1 file changed, 6 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb=
.c
> > > >> index 9eb1a18590123..7faf670201ccc 100644
> > > >> --- a/drivers/char/tpm/tpm_crb.c
> > > >> +++ b/drivers/char/tpm/tpm_crb.c
> > > >> @@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip =
*chip, u8 status)
> > > >>  =20
> > > >>   static int crb_check_flags(struct tpm_chip *chip)
> > > >>   {
> > > >> +	int ret =3D 0;

Oops I missed this. This adds unnecessary clutter to the diff.
> > > >> +#ifdef CONFIG_X86 u32 val;
> > > >> -	int ret;
> > > >> +
> > > >> +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> > > >> +		return ret;

No reason to use variable here. Should be just "return 0". It also
documents what is going on. Now this gives impression as the "ret"
could change.

I dropped the current version from my -next. I did not notice the
change in declarations earlier, sorry.

> > > >>  =20
> > > >>   	ret =3D crb_request_locality(chip, 0);
> > > >>   	if (ret)
> > > >> @@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *ch=
ip)
> > > >>  =20
> > > >>   release:
> > > >>   	crb_relinquish_locality(chip, 0);
> > > >> +#endif
> > > >=20
> > > > Looks much better but the main question here is that is this combin=
ation
> > > > possible:
> > > >=20
> > > > 1. AMD CPU
> > > > 2. Non-AMD fTPM (i.e. manufacturer property differs)
> > > >=20
> > > > BR, Jarkko
> > >
> > > Yes that combination is possible.
> > >
> > > Pluton TPM uses the tpm_crb driver.
> >=20
> > Then I guess we'll go with this for now. Thanks for the effort.
> >=20
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # QEMU + swtpm
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > I'm planning to send a pull request right after this with the fix so it
> > will land to v6.6-rc1 or v6.6-rc2:
> > https://lore.kernel.org/linux-integrity/20230817201935.31399-1-jarkko@k=
ernel.org/
> >=20
> > BR, Jarkko
>
>
> Super minor nit that isn't this patch in particular so don't hold this
> up, but it seems like the function name for the earlier attempt to
> solve this issue that mentioned amd and ftpm was a clearer description
> of what was happening than crb_check_flags.

I posted an alternative: https://lkml.org/lkml/2023/8/22/1188

BR, Jarkko
