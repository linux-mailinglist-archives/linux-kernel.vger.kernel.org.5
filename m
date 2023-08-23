Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC1785ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbjHWRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjHWRkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D52EE77;
        Wed, 23 Aug 2023 10:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFD165409;
        Wed, 23 Aug 2023 17:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F1AC433C8;
        Wed, 23 Aug 2023 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692812419;
        bh=wYPeUBIR8U5c0sY0KlBDc33ytZlaiav6dZ/libZukws=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=vD5UN8kbnq7CzAYumPHUyk0rhZ1XntR/UQu/+v+EuvPL3+gou6yWnV2DYIsGYvSXl
         GsejHONZE4EHIv3QZLgDcb21Z1/Sw8EyFX2XS5BEpDzNcDb/BZeI7vfHwDMRWqIwrB
         Gfq+b7yQ4oP4jL8clB6k9lLL8IeMv066/t9LKvfhKhT9P5kkE26mVqvFSiMqri5Bln
         AWA4XH6GNV5xKzVt0ycW3YQ6X+5L4q57BmZt/quBwWGTVoUNuKjbPdteI7yuUCHxTg
         ZCxAGyDyD/kEyS0OXhRv7ihAyT7MlbgKl1Dul1UIP3rKFPmstpwNo8UY0cofkOgxrR
         0oCV7QwPNBK+Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 23 Aug 2023 20:40:15 +0300
Message-Id: <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>,
        "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.14.0
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
In-Reply-To: <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Thank you for your patch.
>
>
> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> > The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG f=
or
> > all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On t=
he
> > reported systems the TPM doesn't reply at bootup and returns back the
> > command code. This makes the TPM fail probe.
> >=20
> > Since only Microsoft Pluton is the only known combination of AMD CPU an=
d
> > fTPM from other vendor, disable hwrng otherwise. In order to make sysad=
min
> > aware of this, print also info message to the klog.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Mario=E2=80=99s patch also had the three reporters below listed:
>
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>

The problem here is that checkpatch throws three warnings:

WARNING: Reported-by: should be immediately followed by Closes: with a URL =
to the report
#19:
Reported-by: Patrick Steinhardt <ps@pks.im>
Reported-by: Ronan Pigott <ronan@rjp.ie>

WARNING: Reported-by: should be immediately followed by Closes: with a URL =
to the report
#20:
Reported-by: Ronan Pigott <ronan@rjp.ie>
Reported-by: Raymond Jay Golo <rjgolo@gmail.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL =
to the report
#21:
Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Since bugzilla is not part of the documented process afaik, I used this
field as the guideline:

Reported:	2023-08-17 20:59 UTC by Todd Brandt

How otherwise I should interpret kernel bugzilla?

In any case new version is still needed as the commit message must=20
contain a mention of "Lenovo Legion Y540" as the stimulus for doing
this code change in the first place.

BR, Jarkko
