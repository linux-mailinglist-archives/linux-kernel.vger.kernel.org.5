Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1826783EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjHVLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjHVLZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82BFCD1;
        Tue, 22 Aug 2023 04:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 644CF64619;
        Tue, 22 Aug 2023 11:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06C5C433C8;
        Tue, 22 Aug 2023 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703513;
        bh=aKL6Ww4HSe7JFLDgTpjsybTa65dCu+935Jo7W5suW4Y=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=mzq9GHZAzTl5EASu0CxooNuulBuPPu6kZH+NeOJ94vxmzgbV0lyV1yEVCUjudXCkT
         WZp1JkM7m0D1IvMSlcRKjhhr3CBK0n1Q+THGLwgHhqqJN5rO3ljm+yTeEbgLilHsuf
         MbaXc2JGbbPD71Gc8UwYBGJDx8/FQIX3Zu7fKshuE9IUoxN9YEPxCi8EK000+k9Q2/
         hFnu62N2nZv+9311pAPvsPqtqMfKxo640dL4zOkWwtkLbWureahChVNRfYjwJlsHlM
         uvD5P5seEjkeGbRTkPwSfvpr5F1rkDLyvQuMAxpoW2pHv7t9i/ohIWItA/iPeQwEy+
         hLlp+AU6XTNkg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 14:25:09 +0300
Message-Id: <CUZ1BDCFZ7S8.26LGWT9U1C87H@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>,
        <len.brown@intel.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
X-Mailer: aerc 0.14.0
References: <20230818181516.19167-1-mario.limonciello@amd.com>
 <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
 <25a21516-7201-4ee4-be2b-f67edaf97e2a@amd.com>
 <CUW2JM314GAR.36XV41132X3OX@seitikki>
 <719602ec-c9fc-4a72-9585-d50595cb6dca@amd.com>
In-Reply-To: <719602ec-c9fc-4a72-9585-d50595cb6dca@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 2:57 AM EEST, Limonciello, Mario wrote:
>
>
> On 8/18/2023 6:44 PM, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 10:38 PM UTC, Limonciello, Mario wrote:
> >>
> >>
> >> On 8/18/2023 5:07 PM, Jarkko Sakkinen wrote:
> >>> On Fri Aug 18, 2023 at 6:15 PM UTC, Mario Limonciello wrote:
> >>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RN=
G for
> >>>> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn'=
t reply
> >>>> at bootup and returns back the command code.
> >>>
> >>> Is this reproducible with any production hardware? You are stating it
> >>> as it was reproducible categorically with any Intel fTPM.
> >>>
> >>
> >> Yes, it's affecting production hardware too.
> >> Someone came to the kernel bugzilla and reported a regression on 6.4.1=
1
> >> on a Lenovo Intel laptop as well.
> >=20
> > Now the description says that cateogrically all Intel fTPM's fail.
>
> According to Todd this change caused 5 *different* reference Intel=20
> systems all to fail.  I know they're not production hardware, but still..

Kind of sane requirement is to scope on known systems that exists. We
are not fixing bugs for R&D platforms.

>
> >=20
> > I asked for the laptop model in the bugzilla bug, which should be put t=
o
> > the commit description later on (hopefully with a snippet of klog
> > transcript). This commit cannot be applied as it is at the moment, even
> > if it turned out to be a legit fix.
> >=20
> >>>> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, =
throw
> >>>> away the error code to let Intel fTPM continue to work.
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >>>
> >>> It does make sense not to exercise this outside of AMD CPus but since
> >>> there is no production hardware failing, it cannot be categorized as =
a
> >>> bug fix.
> >>
> >> See above (and also kernel bugzilla).
> >>
> >>>
> >>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/char/tpm/tpm_crb.c | 3 +--
> >>>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> >>>> index 9eb1a18590123..b0e9931fe436c 100644
> >>>> --- a/drivers/char/tpm/tpm_crb.c
> >>>> +++ b/drivers/char/tpm/tpm_crb.c
> >>>> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip=
)
> >>>>    	if (ret)
> >>>>    		return ret;
> >>>>   =20
> >>>> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> >>>> -	if (ret)
> >>>> +	if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
> >>>>    		goto release;
> >>>
> >>> It would be better not to exercise a potentially failing code path at
> >>> all. This initiates full transaction with the TPM.
> >>
> >> So why does a full transaction not work in this case?
> >=20
> > It makes absolutely zero sense to send a message to a TPM just to know
> > that you are on AMD CPU, right?
> >=20
> > E.g. you could check if boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD =
right
> > in the beginning of this function.
> >=20
>
> You couldn't replace the whole function with this check.
>
> If you apply it to everything on an AMD system you catch too much.  You=
=20
> need to know it's specifically an AMD fTPM to avoid tripping the stutter=
=20
> bug.  Pluton is fine, dTPMs are fine too.

dTPM's have nothing to be with tpm_crb. They use tpm_tis_core.

Is there a system with CPU recognized as AMD and *firmware* TPM from
some 3rd party vendor? If not, then you could also drop
tpm2_get_tpm_pt() altogether.


BR, Jarkko
