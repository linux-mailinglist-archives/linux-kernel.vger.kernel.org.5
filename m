Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE37FDE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjK2R1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjK2R1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:27:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC18D6E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701278825; x=1732814825;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=k2mWoObv1gssBSVnmPKejJUs1lly2wTPzdjAYt7xRog=;
  b=dZ10D57QLrO2D5WvU0IAcMyoSW+NktEROQ3v7noBF20Wb0NUL4cXxBp5
   DXuuieYuFWnv2hruOP2qEv/9PzvYjOFKf+igV0+gP28R9fj3LNZt4wxvU
   sNmDt6ADoH6VKk+b21TfPyezO0mlVA+ozdClJQo0I4+MW4nU1AZCTrb36
   1SlSuT/kaKVAHyv1aPd7uEA//XjT0HOY4Yp1bOEZxgncePig6F666Wr4o
   1KY4su+9c/+IjPyahkyFPOuGa1lI/YeBKtBJDfvlS4gSdvk9XoHJFP1Sd
   77h2u996OBdRMPsH1xlW0uN+C0jXq+K0WEjX5CNTec/y+Lw13ErxP49wB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392942186"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="392942186"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="10413712"
Received: from dstavrak-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:27:00 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     heminhong <heminhong@kylinos.cn>, heminhong@kylinos.cn
Cc:     airlied@gmail.com, animesh.manna@intel.com,
        ankit.k.nautiyal@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        kernel test robot <lkp@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH v2] drm/i915: correct the input parameter on
 _intel_dsb_commit()
In-Reply-To: <20231114024341.14524-1-heminhong@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231113033613.30339-1-heminhong@kylinos.cn>
 <20231114024341.14524-1-heminhong@kylinos.cn>
Date:   Wed, 29 Nov 2023 19:26:57 +0200
Message-ID: <87fs0o5v32.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023, heminhong <heminhong@kylinos.cn> wrote:
> Current, the dewake_scanline variable is defined as unsigned int,
> an unsigned int variable that is always greater than or equal to 0.
> when _intel_dsb_commit function is called by intel_dsb_commit function,
> the dewake_scanline variable may have an int value.
> So the dewake_scanline variable is necessary to defined as an int.
>
> Fixes: f83b94d23770 ("drm/i915/dsb: Use DEwake to combat PkgC latency")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310052201.AnVbpgPr-lkp@i=
ntel.com/
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
>
> Signed-off-by: heminhong <heminhong@kylinos.cn>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/intel_dsb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i=
915/display/intel_dsb.c
> index 78b6fe24dcd8..7fd6280c54a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsb.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsb.c
> @@ -340,7 +340,7 @@ static int intel_dsb_dewake_scanline(const struct int=
el_crtc_state *crtc_state)
>  }
>=20=20
>  static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
> -			      unsigned int dewake_scanline)
> +			      int dewake_scanline)
>  {
>  	struct intel_crtc *crtc =3D dsb->crtc;
>  	struct drm_i915_private *dev_priv =3D to_i915(crtc->base.dev);

--=20
Jani Nikula, Intel
