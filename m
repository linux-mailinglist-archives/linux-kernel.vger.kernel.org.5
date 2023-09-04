Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1F791C45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjIDSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjIDSBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:01:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFEDD;
        Mon,  4 Sep 2023 11:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 337D6B80ED9;
        Mon,  4 Sep 2023 18:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4DC433C8;
        Mon,  4 Sep 2023 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693850463;
        bh=ZO4d1HawvJ//3ptwuwm7onPYcLR7YnU0KtC0ZhmK0kQ=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=euqAD0ji2Pw8IAPMadKYJapR9GhENHWAyoLQTeF5iaEwYKY4v7adIY/4UD+yqj8q2
         Gcy/9FXv5lBDSdvGJDaFqHF9o56D/f4wNnJka314gE+CVU+5zXCvSwfC4vMN7J7kcb
         xlYuPfy6WImRtm+H4u+YoprHwtFiwsJYmHeAUhnA8lmmsvE7S5uaRPzeGPfYfYC206
         eLFgCtFTJ2qxMWq4C5TOlVCDppfIwzI7i1vt7x+cGXDr7pauvcyO60EHFkBTI0iRIi
         NpsR3VvfIXzW4y9AdNjFDOdgMf7JILKh9LNmcywhgS5lM2UrUwQYU7M/djc1VxJhhJ
         LOEk2lReGNnBw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 21:00:59 +0300
Message-Id: <CVABVIQB3858.CWOHMN527J67@suppilovahvero>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc:     <linux-integrity@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        "Patrick Steinhardt" <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
 <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
 <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
In-Reply-To: <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 28, 2023 at 3:35 AM EEST, Mario Limonciello wrote:
> On 8/27/2023 13:12, Jarkko Sakkinen wrote:
> > On Wed Aug 23, 2023 at 9:58 PM EEST, Mario Limonciello wrote:
> >> On 8/23/2023 12:40, Jarkko Sakkinen wrote:
> >>> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
> >>>> Dear Jarkko,
> >>>>
> >>>>
> >>>> Thank you for your patch.
> >>>>
> >>>>
> >>>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> >>>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable R=
NG for
> >>>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  =
On the
> >>>>> reported systems the TPM doesn't reply at bootup and returns back t=
he
> >>>>> command code. This makes the TPM fail probe.
> >>>>>
> >>>>> Since only Microsoft Pluton is the only known combination of AMD CP=
U and
> >>>>> fTPM from other vendor, disable hwrng otherwise. In order to make s=
ysadmin
> >>>>> aware of this, print also info message to the klog.
> >>>>>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >>>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >>>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>>>
> >>>> Mario=E2=80=99s patch also had the three reporters below listed:
> >>>>
> >>>> Reported-by: Patrick Steinhardt <ps@pks.im>
> >>>> Reported-by: Ronan Pigott <ronan@rjp.ie>
> >>>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >>>
> >>> The problem here is that checkpatch throws three warnings:
> >>>
> >>> WARNING: Reported-by: should be immediately followed by Closes: with =
a URL to the report
> >>> #19:
> >>> Reported-by: Patrick Steinhardt <ps@pks.im>
> >>> Reported-by: Ronan Pigott <ronan@rjp.ie>
> >>>
> >>> WARNING: Reported-by: should be immediately followed by Closes: with =
a URL to the report
> >>> #20:
> >>> Reported-by: Ronan Pigott <ronan@rjp.ie>
> >>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >>>
> >>> WARNING: Reported-by: should be immediately followed by Closes: with =
a URL to the report
> >>> #21:
> >>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>>
> >>
> >> FWIW I observed the same checkpatch warning when I submitted my versio=
n
> >> of the patch.  I figured it's better to ignore the warning and attribu=
te
> >> everyone who reported the issue affected them.
> >=20
> > OK so:
> >=20
> > 1. checkpatch.pl is part of the kernel process.
> > 2. Bugzilla is not part of the kernel process.
> >=20
> > Why emphasis on 1?
> >=20
> > BR, Jarkko
>
> The reason I submitted it this way is because of this quote from the=20
> documentation [1].
>
> "Check your patches with the patch style checker prior to submission=20
> (scripts/checkpatch.pl). Note, though, that the style checker should be=
=20
> viewed as a guide, not as a replacement for human judgment. If your code=
=20
> looks better with a violation then its probably best left alone."
>
> I wanted the patch to capture and attribute all those that reported it=20
> not just the "first one".  Like I said previously, it's better to have a=
=20
> collection of people to ping to notify if something needs to be reverted.
>
> [1]=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#st=
yle-check-your-changes

Please denote also that kernel bugzilla is not mentioned in the page
that you put as a reference, and only reporter in the LKML has been
Todd.

BR, Jarkko
