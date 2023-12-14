Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5518139BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572970AbjLNSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444214AbjLNSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:16:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F5CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:16:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D50DC433C7;
        Thu, 14 Dec 2023 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702577801;
        bh=Pf8WEkmg/p1UYf/KczRbr+QOJbe21dt16Gmp2yRVACI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xs1cYlmb6iE360KCEn9ot8ir0F934QmsYPpxsI9nXVWIsHdKhvZo/9kxt9XNlUHt3
         hOvjzMmQxEpGroOokP0vcdeW1Htb8iWrZPJCn9AeI/xDWA51wQqCdyboe583VmshfA
         GuNV03mpyIH6m/08ygL0bdGmJTglSyt+zMr/LtgT0wC/WiVeBgt2ZFQDerDOD81xKB
         Vv+hkIkS/gRNXNsmmev0nJXVv48QwupIEZSCtuiGVv1GFTjIFnLKgN3EMFYHtVAXdh
         AB6WfjhBS0rChH8HPqbSFj8DU/U3XbmB+hWFFUi0kwuRhhPIJ6as2u85/0ahIx+exn
         PsJI7/u13g/KA==
Date:   Thu, 14 Dec 2023 19:16:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 04/26] drm/shmem-helper: Refactor locked/unlocked
 functions
Message-ID: <xvo6rwsripjoiwazvjhkxvyleiexuhvclh7wvt5kuiw5cmkaa7@jgcdrtkzw7a6>
References: <kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
 <20231128133712.53a6f6cb@collabora.com>
 <37208c72-7908-0a78-fc89-2fa9b8d756a5@collabora.com>
 <20231129085330.7ccb35d3@collabora.com>
 <ioqghyaeftyo7tuyfecn252ykxwgltrkhh2pwktjejqhewntbb@bym3rsjxnxfp>
 <20231129144609.7544e773@collabora.com>
 <6da6mzwfzwbn5rhiebypo5e2v6rhtpn2fovwvfnoo333zjgobf@bgtuwhum3trp>
 <20231129164705.7461a294@collabora.com>
 <jvhedgegvavn5mvvx2men2rxitvnq7u3dsxwfx3wokxldmysjz@y5av3l2w4gk6>
 <161189c2-db65-2542-5d19-77a56b56cfac@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mogag3hjc3jfzn6"
Content-Disposition: inline
In-Reply-To: <161189c2-db65-2542-5d19-77a56b56cfac@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mogag3hjc3jfzn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 02:43:16PM +0300, Dmitry Osipenko wrote:
> On 12/4/23 15:55, Maxime Ripard wrote:
> >> Okay, that means s/_locked/_nolock/ in drm_gem_shmem_helpers.{c,h}, I
> >> guess.
>=20
> DRM subsys and majority of kernel uses common _locked postfix. We should
> retain the old naming scheme by using _locked() in DRM. It's not
> worthwhile changing the name to a much less popular variant for a no
> good reason.
>=20
> Maxime, are you okay with keeping the _locked name?

Yeah... I still don't really like it, but you're right that it's best to
remain consistent over my opinion :)

Maxime

--5mogag3hjc3jfzn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXtGhgAKCRDj7w1vZxhR
xdWmAQCtgo8n/tvT2Kt3YvY+zwK+WyI5LucgGMiuXB4A1VJkmwEAgpA7YSFGzvRg
qhtdUYJJREmkWwghndQNv4kd/aVYhw0=
=rtVm
-----END PGP SIGNATURE-----

--5mogag3hjc3jfzn6--
