Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4F781294
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379359AbjHRSIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379352AbjHRSHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29AE2D65;
        Fri, 18 Aug 2023 11:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C9DA616AF;
        Fri, 18 Aug 2023 18:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FF6C433C8;
        Fri, 18 Aug 2023 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692382060;
        bh=PA0g8MCD9n4RuyvKxhBTM/ICSokS9hykwXFI16iYb8c=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=aHoTf9RtY2olfw4rw5fje0l5NBU+OSKkuhMlPtdAx4vNSjMpHcPagUt24feerw/+r
         3kxZta+tM5PqCMiUkJUAF9JeiqGeks5U7NfWTyLAR5G2sN+2UYY0ixww3M9ILbTUAC
         O25rdJLpAPci87adndnENrVCsS8Ggrlabq4Llyo3DRawuHxmJI7L0odfRQimTnFj+k
         vMV6oo9JvnFD9HuecmA2ygs5tcl44hKtojMIf5Taym2tW1O8NkGeOj4edQDSkikBkz
         O22YByZVLKXBIaBqg9xpbigng6sSTMW9ZKBcTKkHUOgZto8QYPAmbHqJeUb21ooeUH
         yS+fR7C+EPsGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 21:07:37 +0300
Message-Id: <CUVVDC2QGWV6.HGLDFFEGMGGU@suppilovahvero>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <todd.e.brandt@linux.intel.com>, <linux-integrity@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <len.brown@intel.com>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>
X-Mailer: aerc 0.14.0
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
 <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
 <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
 <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
 <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
 <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
 <92b93b79-14b9-46fe-9d4f-f44ab75fd229@amd.com>
 <CUVV2MQRCGET.2U22LFQPX1J3G@suppilovahvero>
 <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
In-Reply-To: <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 8:57 PM EEST, Mario Limonciello wrote:
> On 8/18/2023 12:53, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 8:21 PM EEST, Mario Limonciello wrote:
> >> On 8/18/2023 12:00, Jarkko Sakkinen wrote:
> >>> On Fri Aug 18, 2023 at 4:58 AM EEST, Limonciello, Mario wrote:
> >>>>
> >>>>
> >>>> On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
> >>>>> On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
> >>>>>> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
> >>>>>>> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
> >>>>>>>> While testing S3 on 6.5.0-rc6 we've found that 5 systems are see=
ing
> >>>>>>>> a
> >>>>>>>> crash and reboot situation when S3 suspend is initiated. To
> >>>>>>>> reproduce
> >>>>>>>> it, this call is all that's required "sudo sleepgraph -m mem
> >>>>>>>> -rtcwake
> >>>>>>>> 15".
> >>>>>>>
> >>>>>>> 1. Are there logs available?
> >>>>>>> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (n=
ever
> >>>>>>> used it before).
> >>>>>>
> >>>>>> There are no dmesg logs because the S3 crash wipes them out. Sleep=
graph
> >>>>>> isn't actually necessary to activate it, just an S3 suspend "echo =
mem >
> >>>>>> /sys/power/state".
> >>>>>>
> >>>>>> So far it appears to only have affected test systems, not producti=
on
> >>>>>> hardware, and none of them have TPM chips, so I'm beginning to won=
der
> >>>>>> if this patch just inadvertently activated a bug somewhere else in=
 the
> >>>>>> kernel that happens to affect test hardware.
> >>>>>>
> >>>>>> I'll continue to debug it, this isn't an emergency as so far I hav=
en't
> >>>>>> seen it in production hardware.
> >>>>>
> >>>>> OK, I'll still see if I could reproduce it just in case.
> >>>>>
> >>>>> BR, Jarkko
> >>>>
> >>>> I'd like to better understand what kind of TPM initialization path h=
as
> >>>> run.  Does the machine have some sort of TPM that failed to fully
> >>>> initialize perhaps?
> >>>>
> >>>> If you can't share a full bootup dmesg, can you at least share
> >>>>
> >>>> # dmesg | grep -i tpm
> >>>
> >>> It would be more useful perhaps to get full dmesg output after power =
on
> >>> and before going into suspend.
> >>>
> >>> Also ftrace filter could be added to the kernel command-line:
> >>>
> >>> ftrace=3Dfunction ftrace_filter=3Dtpm*
> >>>
> >>> After bootup:
> >>>
> >>> mount -t tracefs nodev /sys/kernel/tracing
> >>> cat /sys/kernel/tracing/trace
> >>>
> >>> BR, Jarkko
> >>
> >> Todd and I have gone back and forth a little bit on the bugzilla
> >> (https://bugzilla.kernel.org/show_bug.cgi?id=3D217804), and it seems t=
hat
> >> this isn't an S3 problem - it's a probing problem.
> >>
> >> [    1.132521] tpm_crb: probe of INTC6001:00 failed with error 378
> >>
> >> That error 378 specifically matches TPM2_CC_GET_CAPABILITY, which is t=
he
> >> same command that was being requested.  This leads me to believe the T=
PM
> >> isn't ready at the time of probing.
> >>
> >> In this case one solution is we could potentially ignore failures for
> >> that tpm2_get_tpm_pt() call, but I think we should first understand wh=
y
> >> it doesn't work at probing time for this TPM to ensure the actual quir=
k
> >> isn't built on a house of cards.
> >=20
> > Given that there is nothing known broken (at the moment) in production,
> > I think the following might be a reasonable change.
> >=20
> > BR, Jarkko
> >=20
>
> Yeah that would prevent it.
>
> Here's a simpler change that I think should work too though:
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 9eb1a18590123..b0e9931fe436c 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>          if (ret)
>                  return ret;
>
> -       ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> -       if (ret)
> +       if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
>                  goto release;
>
>          if (val =3D=3D 0x414D4400U /* AMD */)
>
> I think Todd needs to check whether TPM works with that or not though.

Hmm... I'm sorry if I have a blind spot now but what is that changing?

BR, Jarkko
