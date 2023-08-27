Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964EC78A0E8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjH0SMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjH0SMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:12:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E5E6;
        Sun, 27 Aug 2023 11:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00AB6147A;
        Sun, 27 Aug 2023 18:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDC9C433C7;
        Sun, 27 Aug 2023 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693159942;
        bh=Gtx6YMuQyMDzt4yTSZYJd+5ko0zLjEAbXXqlwMLbtf4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ZV9xzsu4xCOooWtwbzQw+WArL2yBSnAJdISGkNiPuBu2whAPZ86qFRkOZVMTFckFV
         XIsvv6urrRCCvBvrmhgm3W1WRnnp6r2MWQ72ZngWClhbZ727qf29eUXfB+X0GMKGZy
         P6k+lw6V6Ja14/caNIXZOPONxIb+Pu00L2p5s+MIJRogFPZ+HlbhC+Nm3LSY2f708D
         ao6j4mcGCotf18GDiFJfGC9sfIdMvICCB76OqEt1bncCg82eVGNAvXcya8PpBzdXN8
         FIfXesRNkZQIaxQkxVfH9RwE81gqWOn9dxlp9cnRBrC3PfrN0kjUH7AFKhqqQLk8+l
         k1wOl4fJKm+rw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Aug 2023 21:12:17 +0300
Message-Id: <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        "Patrick Steinhardt" <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.14.0
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
In-Reply-To: <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 23, 2023 at 9:58 PM EEST, Mario Limonciello wrote:
> On 8/23/2023 12:40, Jarkko Sakkinen wrote:
> > On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
> >> Dear Jarkko,
> >>
> >>
> >> Thank you for your patch.
> >>
> >>
> >> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> >>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG=
 for
> >>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On=
 the
> >>> reported systems the TPM doesn't reply at bootup and returns back the
> >>> command code. This makes the TPM fail probe.
> >>>
> >>> Since only Microsoft Pluton is the only known combination of AMD CPU =
and
> >>> fTPM from other vendor, disable hwrng otherwise. In order to make sys=
admin
> >>> aware of this, print also info message to the klog.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>
> >> Mario=E2=80=99s patch also had the three reporters below listed:
> >>
> >> Reported-by: Patrick Steinhardt <ps@pks.im>
> >> Reported-by: Ronan Pigott <ronan@rjp.ie>
> >> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >=20
> > The problem here is that checkpatch throws three warnings:
> >=20
> > WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
> > #19:
> > Reported-by: Patrick Steinhardt <ps@pks.im>
> > Reported-by: Ronan Pigott <ronan@rjp.ie>
> >=20
> > WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
> > #20:
> > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >=20
> > WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
> > #21:
> > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
>
> FWIW I observed the same checkpatch warning when I submitted my version=
=20
> of the patch.  I figured it's better to ignore the warning and attribute=
=20
> everyone who reported the issue affected them.

OK so:

1. checkpatch.pl is part of the kernel process.
2. Bugzilla is not part of the kernel process.

Why emphasis on 1?

BR, Jarkko
