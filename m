Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18829791E98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbjIDUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjIDUwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:52:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85041AD;
        Mon,  4 Sep 2023 13:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEF60CE0FD0;
        Mon,  4 Sep 2023 20:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1302C433C7;
        Mon,  4 Sep 2023 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693860717;
        bh=5f+w9wq1cKACBqEw4Mi47dxVltq/foUZBPbH+nXgbtc=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=icdRnncreM+UjsqGBMMBIXm5jZEBaz7aeMDQe/PsQNuC4eFBIOQZTLHElLFTQ1gAG
         MH+KLPLal0P/HfatjnUhTNZ3miIcxcCZGsQdSJaEAJNskfuIxgK6Cva3D803s0lrze
         3G6+GVNcd25hlHjnd64czJEuuo84hH+YkrUoMRr9P1j0MlK1hieu6+ZWUMdd5bDpze
         C2uIy38xhoKwoGhwzg1ydW4o3MtiNmi2ML63IO+ifRbl4Hgyzjh1kzSsmj0OOUaGj9
         b7L7bLhlH/dWZXdwccdlgnyvRzlof8omKGvK4C920VBxbLZK4qJp1RR50o4J+KbYDY
         ITiQOYLXPtroA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 23:51:53 +0300
Message-Id: <CVAFIDGCEPEC.2R5MSSAO5M8UA@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.14.0
References: <zlywbvfgkkygcpvmj5rd4thuhbdacit2meg2fj6eyua5qpwyoc@beyiattrr7o6> <446E94FC-C47A-453F-9A0E-CBE5049582ED@redhat.com>
In-Reply-To: <446E94FC-C47A-453F-9A0E-CBE5049582ED@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 30, 2023 at 9:25 PM EEST, Jerry Snitselaar wrote:
>
>
> > On Aug 29, 2023, at 12:03 PM, Jerry Snitselaar <jsnitsel@redhat.com> wr=
ote:
> >=20
> > =EF=BB=BFOn Wed, Aug 23, 2023 at 02:15:10AM +0300, Jarkko Sakkinen wrot=
e:
> >> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG =
for
> >> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On =
the
> >> reported systems the TPM doesn't reply at bootup and returns back the
> >> command code. This makes the TPM fail probe.
> >>=20
> >> Since only Microsoft Pluton is the only known combination of AMD CPU a=
nd
> >> fTPM from other vendor, disable hwrng otherwise. In order to make sysa=
dmin
> >> aware of this, print also info message to the klog.
> >>=20
> >> Cc: stable@vger.kernel.org
> >> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >> ---
> >> v3:
> >> * Forgot to amend config flags.
> >> v2:
> >> * CONFIG_X86
> >> * Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
> >> * Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com=
>"
> >> ---
> >> drivers/char/tpm/tpm_crb.c | 33 ++++++++-------------------------
> >> 1 file changed, 8 insertions(+), 25 deletions(-)
> >>=20
> >=20
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>
> It looks like the Fedora folks are getting more reports of the issue.

https://lore.kernel.org/linux-integrity/20230904202512.29825-1-jarkko@kerne=
l.org/T/#u

I have all the possible reported-by's. I still don't fully understand
kernel bugzilla's role. I don't oppose having it but e.g. for me
reporter has been traditionally someone who reports the bug in LKML, not
in bugzilla. Also the ambiguity of the whole discussion has been over
the top. E.g. why bugzilla even has a field for reporter if that is not
*the* reporter at least according to this discussion?

And in the case of this bug, the reporter in bugzilla was the same exact
person who mailed about it to LKML.

I'm actually cool with almost any policy, as long as there is at least
some policy in existence. Pretty confusing exercise overally, and very
time consuming for a maintainer.

BR, Jarkko
