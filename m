Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72F57DF590
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbjKBPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjKBPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:01:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D9181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:01:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272F2C433C9;
        Thu,  2 Nov 2023 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698937299;
        bh=fmOwJyB04PaoZH9ELzMtvpiRvHraTu/GpKJhuwh2U5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIgkj/TT5WWRVfeIeTiV1V5AkGmKYZ8swMn/7HNF5u94sKFRveZSfBPRGbv8ffbjA
         bwQRQ+r5Bw9brFk2Oq5pES4KLK/bFtnRyUM0844EhYzvxoSrzCr7e7ZV8ubO6iIC9V
         G0hz1LlIJ6mnasi7n+BJl+Snwpon78uz5otbVFRnpmEwG/NkH/DWSZHlCZLmsJVfg1
         AAU+QkALFQDPMmd0VnlxGfUBWysfn7tFCvMcCx6RhHpzYKkrwc8URJvABjpC8mgbEW
         cPxYiZtzC/W0YTMu9XwMywscM84rHl3Knq7JWg1Z2Xa6jMTs3C28tGM8BTQ1s6AYLh
         5+Nf1Z8DF++Lg==
Date:   Thu, 2 Nov 2023 15:01:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
Message-ID: <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk>
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
 <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
 <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WEH39aLhKbvS+56k"
Content-Disposition: inline
In-Reply-To: <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
X-Cookie: A is for Apple.
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WEH39aLhKbvS+56k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2023 at 08:17:35PM +0530, Naresh Solanki wrote:
> On Thu, 2 Nov 2023 at 18:36, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Nov 02, 2023 at 05:35:42PM +0530, Naresh Solanki wrote:

> > > > We probably should filter the events more, there's events for pre and
> > > > post voltage change for example which aren't status changes so would be
> > > > spurious.  It ought not to break anything but we should still avoid
> > > > unneeded work.

> > > Can you please provide me inputs on the additional filtering needed for this.
> > > Like some list of events for notify on status?

> > I think I'd start off with just reporting things that are obviously
> > errors and not things that should ever go off during normal operation.

> This is what I could come up with:
>         if (event & REGULATOR_EVENT_VOLTAGE_CHANGE) {
>                 name = dev_attr_microvolts.attr.name;
>                 sysfs_notify(&rdev->dev.kobj, NULL, name);
>         } else if (event & (REGULATOR_EVENT_DISABLE | REGULATOR_EVENT_ENABLE)){
>                 name = dev_attr_status.attr.name;
>                 sysfs_notify(&rdev->dev.kobj, NULL, name);
>         }

That's the opposite sense to what I was thinking of - we're reporting
voltage changes and enables to userspace rather than just errors.  My
concern here is that this could generate an awful lot of notificaitons
for normal operation on systems that don't use the uevents, I was
expecting this to be used for errors.  Could you remind me what the use
case is here, I think I might've got myself confused sorry?

--WEH39aLhKbvS+56k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVDuc4ACgkQJNaLcl1U
h9AP2gf/T9vW4sXkzI9WXS9YG/AYUayuS/T91MPXRfPvenhWPwjUdUUeyVyPcmec
coSmMfbdsWMvD+tqhlqdowUqqJfqiTsRtBzWi4Jk9+u4QId7wbPyGptXiNSMOh8l
N/zipc8O/IFet9DaiWeIeqfvbSC2E68eesOR/sJ9wwHFqM4mcVQREZ+aRfU+0dpW
uW+XSMgXOe2f1ibyEnkKw5doPNpiTo3/RFKI1X93j6PjNN9Fiy9Kjsypmr+UzKW9
1P4YiMZCw8TMLI3duKBRWFydSEalvzKoPjlzp+xYqabl/0K8ICyZ6KgZxvm+677Q
2YRB8g2o/fpnu/iDrkhlrhAHqF6jUg==
=ipEo
-----END PGP SIGNATURE-----

--WEH39aLhKbvS+56k--
