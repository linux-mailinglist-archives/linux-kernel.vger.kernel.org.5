Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF71802A58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjLDCgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:36:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A802C5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:36:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D8C433C7;
        Mon,  4 Dec 2023 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701657376;
        bh=PYeF07rEgepH06KQnhf/cogiGP7iBaCv1QN0e6AXkSg=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=WR8uiLKGdRjtzzaL8yFDg1RHQwJt8ii46A4yFwPKj+OTZoKKa+rReBol14SaSly5u
         uaa5MGVCWn1+hWtm9xOCqb8y9UZGa0Fm0g9oiw/ic0g/baiUSTpT+/gsMWNksa4zC9
         3CBcGmu4Dq4u8+1Y/lV6hcUH3vSu20rwG0OM7yszs5kXd+aeTm/8YBX/qv+L/Xutek
         wTSLCWmE9rn1TBKX5ABqYznVAInTD558IsCMjJvdqMsPWom/U6VepHmJHi1XrdcWKa
         zw/Egq91urStUPTJ2FZEWxdoZCYQPboPFCa/GOuuvtOeu0iEIorfuh1IB77pwjZug1
         Ipgxav/7NShsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Dec 2023 04:36:13 +0200
Message-Id: <CXF771IUU5TC.2HU7I8Z27K1UF@suppilovahvero>
To:     "Angga" <Hermin.Anggawijaya@alliedtelesis.co.nz>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz> <85154bfe-6bd5-440a-acc1-f01497d59af5@linux.ibm.com> <b1d29d38-2d9c-4147-a53d-e240d8a436ae@alliedtelesis.co.nz>
In-Reply-To: <b1d29d38-2d9c-4147-a53d-e240d8a436ae@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 27, 2023 at 4:02 AM EET, Angga wrote:
> On 23/11/2023 1:34 am, Stefan Berger wrote:
> >
> >
> > On 11/22/23 01:55, Hermin Anggawijaya wrote:
> >> Before sending a command to attempt the self test, the TPM
> >> may need to be started, otherwise the self test returns
> >> TPM2_RC_INITIALIZE value causing a log as follows:
> >> "tpm tpm0: A TPM error (256) occurred attempting the self test".
> >>
> >> Signed-off-by: Hermin Anggawijaya=20
> >> <hermin.anggawijaya@alliedtelesis.co.nz>
> >> ---
> >> =C2=A0 drivers/char/tpm/tpm2-cmd.c | 8 ++++----
> >> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> >> index 93545be190a5..0530f3b5f86a 100644
> >> --- a/drivers/char/tpm/tpm2-cmd.c
> >> +++ b/drivers/char/tpm/tpm2-cmd.c
> >> @@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >> =C2=A0 +=C2=A0=C2=A0=C2=A0 rc =3D tpm2_startup(chip);
> >> +=C2=A0=C2=A0=C2=A0 if (rc && rc !=3D TPM2_RC_INITIALIZE)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >> +
> >
> > Most platforms should have firmware initialize the TPM 2 these days.=20
> > Therefore, a selftest should work and in case it doesn't work you fall=
=20
> > back to the tpm2_startup below and if you get an error message in the=
=20
> > log you at least know that you firmware is not up-to-date.
> >
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tpm2_do_selftest(chip);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc && rc !=3D TPM2_RC_INITIALIZE)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc =3D=3D TPM2_RC_INITIALIZE=
) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tpm2_startup(chip);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
> >> -
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tpm2_do_=
selftest(chip);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>
> Hello Stefan
>
> Thank you for your comments.
>
> Unfortunately our platforms (custom hardware design) are the ones which=
=20
> do not initialize/start the TPM2 from boot loader yet, and because of=20
> that the
> self test in tpm2_auto_startup always produce a log error message on the=
=20
> platform start up.
>
> While I understand your point about the log being useful for "pointing=20
> out not up-to-date firmware", but it might also generate unnecessary supp=
ort
> queries from some users on such platforms ? And maybe the kernel being=20
> able to deal with TPM being started more than once is better ?
>
> If wanted, I have the second version of the patch which consist of code=
=20
> changes as in v1, plus ability for tpm2_transmit_cmd to handle multiple
> attempts to start up the TPM silently, for example, once by the firmware=
=20
> and another by the kernel during tpm2 auto-startup.

To save your time: no.

Mainline kernel is not modified based hardware prototypes.

You have freedom to maintain your own kernel tree for whatever changes
you need but this is totally wrong place for these type of patches.

>
> Kind regards
>
> Hermin Anggawijaya

BR, Jarkko
