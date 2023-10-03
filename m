Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688627B5DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjJCAKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJCAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:10:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2A9C6;
        Mon,  2 Oct 2023 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696291800;
        bh=qxtEAZde4kFbj1tXH6gOwr/ukfnaFXq940/Y/rS7DbI=;
        h=Date:From:To:Cc:Subject:From;
        b=BGeedbwldabh6z6QF3gwU1NWR5TdET3CLkHcmT+oCs7uyug4oskTp9CJR7aEAOuax
         if/JQ3NmFoZG0KvXqG5adK3yB/dOxIZ98zUNP3a/LsJSXH3pKKIdEwQKCyptVku9R4
         uhNBOz8127rhdVwxb1ElMJZBjzIf++j5W6PkIkudKQY4pwYBZfQapBID+Any83e/9u
         L5+MkoUO+7/A6xscCUXyNFgkBJIJwd6P3UI7JMHQEI8suJhOkyjaLiz0BWOCL/6Uja
         4MG9b+jjAjsgV/4nPXCDqTzj+WfpRS+PqAQtRHlT8kLLnRCnDPMp+HebmKp28c5RB0
         tKsjMSVVyrgBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rzyr66nM4z4x2r;
        Tue,  3 Oct 2023 11:09:58 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 11:09:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the drm tree
Message-ID: <20231003110957.34fc9483@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vcTvl.sbAssNW7vb1Uc0pbr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vcTvl.sbAssNW7vb1Uc0pbr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_drv.h

between commits:

  c9517783060a ("drm/i915/dg2: Drop Wa_16011777198")
  5a213086a025 ("drm/i915: Eliminate IS_MTL_GRAPHICS_STEP")
  81af8abe6513 ("drm/i915: Eliminate IS_MTL_MEDIA_STEP")

from the drm tree and commits:

  e50086f3d313 ("drm/i915/dg2: Drop pre-production display workarounds")
  213454b3af2e ("drm/i915: Eliminate IS_MTL_DISPLAY_STEP")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/i915_drv.h
index e994bd2d69db,cc229f08dfdb..000000000000
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@@ -647,21 -653,33 +649,6 @@@ IS_SUBPLATFORM(const struct drm_i915_pr
  #define IS_XEHPSDV_GRAPHICS_STEP(__i915, since, until) \
  	(IS_XEHPSDV(__i915) && IS_GRAPHICS_STEP(__i915, since, until))
 =20
- #define IS_MTL_DISPLAY_STEP(__i915, since, until) \
 -#define IS_MTL_GRAPHICS_STEP(__i915, variant, since, until) \
 -	(IS_SUBPLATFORM(__i915, INTEL_METEORLAKE, INTEL_SUBPLATFORM_##variant) &=
& \
 -	 IS_GRAPHICS_STEP(__i915, since, until))
 -
 -#define IS_MTL_MEDIA_STEP(__i915, since, until) \
--	(IS_METEORLAKE(__i915) && \
- 	 IS_DISPLAY_STEP(__i915, since, until))
 -	 IS_MEDIA_STEP(__i915, since, until))
--
- #define IS_DG2_DISPLAY_STEP(__i915, since, until) \
- 	(IS_DG2(__i915) && \
- 	 IS_DISPLAY_STEP(__i915, since, until))
 -/*
 - * DG2 hardware steppings are a bit unusual.  The hardware design was for=
ked to
 - * create three variants (G10, G11, and G12) which each have distinct
 - * workaround sets.  The G11 and G12 forks of the DG2 design reset the GT
 - * stepping back to "A0" for their first iterations, even though they're =
more
 - * similar to a G10 B0 stepping and G10 C0 stepping respectively in terms=
 of
 - * functionality and workarounds.  However the display stepping does not =
reset
 - * in the same manner --- a specific stepping like "B0" has a consistent
 - * meaning regardless of whether it belongs to a G10, G11, or G12 DG2.
 - *
 - * TLDR:  All GT workarounds and stepping-specific logic must be applied =
in
 - * relation to a specific subplatform (G10/G11/G12), whereas display work=
arounds
 - * and stepping-specific logic will be applied with a general DG2-wide st=
epping
 - * number.
 - */
 -#define IS_DG2_GRAPHICS_STEP(__i915, variant, since, until) \
 -	(IS_SUBPLATFORM(__i915, INTEL_DG2, INTEL_SUBPLATFORM_##variant) && \
 -	 IS_GRAPHICS_STEP(__i915, since, until))
--
  #define IS_PVC_BD_STEP(__i915, since, until) \
  	(IS_PONTEVECCHIO(__i915) && \
  	 IS_BASEDIE_STEP(__i915, since, until))

--Sig_/vcTvl.sbAssNW7vb1Uc0pbr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbW9UACgkQAVBC80lX
0Gw26wf9HbL90IKPELoLLlVbG2JcbbZd08SCv86GTf2FIg+fvKLZSEZa4L5eyE+u
VF2/6s177nCNBrWLbgyXu5NAJy33wOYu4xsn3lmEKeN2TxuXuaGbf956WJFqs4s6
+CbYsFEREk2lLTs7X4VhB5WwaWpHxzDd5x7prqZm26ELUS1iiSDEZh33SQRD/n/j
Tqs10RiHUxOn4XQR3bjm0LCJS6/i59IEYJ757Vz/EzQ3TmJe8By1HDn6Cr2ccr/c
Xwc5rLA4+m4yjgqgXBBnVq0Z85ewuFIbYmhe1+jQ3+NnLyUwRqy+mmgRZMQrgTOK
RrxubzQynv20tGptEK6dL/H3ZiJs3w==
=anKz
-----END PGP SIGNATURE-----

--Sig_/vcTvl.sbAssNW7vb1Uc0pbr--
