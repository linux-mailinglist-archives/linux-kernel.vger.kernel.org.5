Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A047EDD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjKPJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjKPJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EED1AB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700126582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w35rrT7mZxkd5tfTUmEJQuHgJFwG2ZKuKcURtyFKyzE=;
        b=X/afrMq9uw4dLqP52T9nPKLBx01Ke2TnCGYV1QiDLRPs0AzYna+VnL7BUh5C2Oc0CBqXid
        rhP8NrqwCPH5yYbPifm+6VumOZhCHA6lG7p+4r7WL6ATCo32Tmb0dVc+zrLunyfO237Sga
        sS1DjB9UMVlNrLDKoEMAhyyBzJcOyf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-jLnydnr_P_eKlbTJCyqEag-1; Thu, 16 Nov 2023 04:23:00 -0500
X-MC-Unique: jLnydnr_P_eKlbTJCyqEag-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084e4ce543so3280545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126579; x=1700731379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w35rrT7mZxkd5tfTUmEJQuHgJFwG2ZKuKcURtyFKyzE=;
        b=s4Hh820xtN1yNABFc92RzoKSbRKEBAb4pea0ncvsatXcw4oH66a6PUJ4p/zlNl6SPm
         4RZHgo/CxzEYp1GO7cW2kusuXNPjhx37C1pYLMY8P+y9ITLWNg3weK+tUvjw0J5zhqEs
         W7zUzLJ87agxrUKFo+QeTXPaEVqLwEAJAm9r7nlDr772SBgV2RSZK7WrAJGiz8xRfVAf
         r0dBUkbSC6HVjUAGFAusmwA8vEcB0umLQXs5BDobLYnJZBAHWyihyAqhjvLxyvtBMD5/
         4oSCjv0bxOcNlrLRMPJL50pn9cvkvrV3QUCD+GiOvw8xRyepka6P0Z9tjL71G8eOPnpN
         J7Og==
X-Gm-Message-State: AOJu0YytmyLTaht5X4hVu7M2I8rvRv6+xN0ua2iC/61mWI5c/RzR5I0E
        kmXOJq9wmJNPeEPUExqMqNPrLiHcvJnKjsLTWKyEpc8INUrl93I2oosC4nsHOOhTRAZBO7WiW05
        kI3QncsnC3mI7xOC8e9iG5gZ7
X-Received: by 2002:a05:600c:1906:b0:408:5ba9:d707 with SMTP id j6-20020a05600c190600b004085ba9d707mr12879658wmq.16.1700126579448;
        Thu, 16 Nov 2023 01:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyuBLaQ9uVYXCAgGY4tjsp6WBRdoWBL/6H3EJ08muS9pK4nQxBMd8/uWN9ZKr7eoapbzo5sw==
X-Received: by 2002:a05:600c:1906:b0:408:5ba9:d707 with SMTP id j6-20020a05600c190600b004085ba9d707mr12879634wmq.16.1700126579048;
        Thu, 16 Nov 2023 01:22:59 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id dn17-20020a0560000c1100b0032db1d741a6sm12734556wrb.99.2023.11.16.01.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:22:58 -0800 (PST)
Date:   Thu, 16 Nov 2023 10:22:58 +0100
From:   Maxime Ripard <mripard@redhat.com>
To:     Luben Tuikov <ltuikov89@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
Message-ID: <53oamsiakocoohdvs2raagdpzfj73xlrxuxvrsdvxkkwxdrm3m@dlu2tno6tjgv>
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oucpashu4qkda5nm"
Content-Disposition: inline
In-Reply-To: <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oucpashu4qkda5nm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 13, 2023 at 09:56:32PM -0500, Luben Tuikov wrote:
> On 2023-11-13 21:45, Stephen Rothwell wrote:
> > Hi Luben,
> >=20
> > On Mon, 13 Nov 2023 20:32:40 -0500 Luben Tuikov <ltuikov89@gmail.com> w=
rote:
> >>
> >> On 2023-11-13 20:08, Luben Tuikov wrote:
> >>> On 2023-11-13 15:55, Stephen Rothwell wrote: =20
> >>>> Hi all,
> >>>>
> >>>> Commit
> >>>>
> >>>>   0da611a87021 ("dma-buf: add dma_fence_timestamp helper")
> >>>>
> >>>> is missing a Signed-off-by from its committer.
> >>>> =20
> >>>
> >>> In order to merge the scheduler changes necessary for the Xe driver, =
those changes
> >>> were based on drm-tip, which included this change from drm-misc-fixes=
, but which
> >>> wasn't present in drm-misc-next.
> >>>
> >>> I didn't want to create a merge conflict between drm-misc-next and dr=
m-misc-fixes,
> >>> when pulling that change from drm-misc-next to drm-misc-fixes, so tha=
t I can apply =20
> >>
> >> ... when pulling that change from from drm-misc-fixes into drm-misc-ne=
xt, so that I can apply...
> >>
> >>> the Xe scheduler changes on top of drm-misc-next. =20
> >>
> >> The change in drm-misc-fixes is b83ce9cb4a465b. The latter is contained
> >> in linus-master, and in drm-misc-fixes, while the former is in drm-mis=
c-next.
> >> When we merge linus-master/drm-misc-fixes into drm-misc-next, or which=
ever way
> >> it happens, I'd like to avoid a merge conflict, but wanted to expedite=
 the changes
> >> for Xe.
> >=20
> > None of that is relevant ... if you commit a patch to a tree that will
> > be in the linux kernel tree, you must add your Signed-off-by to the com=
mit.
>
> Noted!
>=20
> So I always do this when I do git-am and such, but wasn't sure for this o=
ne single cherry-pick whose
> original author was the committer in drm-misc-fixes, but will add my Sign=
ed-off-by in those
> rare circumstances.
>=20
> Thanks for the clarification!

In order to move forward with this, can you provide your SoB here for
that patch so that we can at least point to it in the drm-misc-next PR?

Maxime

--oucpashu4qkda5nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVXfcgAKCRDj7w1vZxhR
xQ0TAQD+tZvFBotDMwtlIexNUj36LAdqeTNlZf+et4C/TGjE6wD8Cpt1DNsNFwD7
HtkspJgcjo7h41mN5yevjDoR2XxRbAo=
=ZICb
-----END PGP SIGNATURE-----

--oucpashu4qkda5nm--

