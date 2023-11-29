Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1487FDE80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjK2RhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2RhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:37:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AE3C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701279447; x=1732815447;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=un2pqzgXqiJEa07g1HptOb4P01cfdzdlVQihNRd8ix8=;
  b=Mi6w/xWpsm6EahzLuiy95Zac0KbSB2YpZ6piDZJ5mv27MC06nL0UrU7o
   lnnti/zg45uRzxtyknjjd8JKd28uoX8nvhhuJUtZQZYXjm8X+T8DT6NzQ
   nyFiqyeZuBbpoDeIDY6KCy1T5PyGzKAEpmQqTGmi0YwlK2kByLoYchlXq
   RrxJAJ17zgmwbMMvw+b8nR9UYSJn3NwMVdWsuj9W/K5vtUM63hDuS28Jj
   fVw+8YGOqa63NIoC53WZ5nZe4O3gOhbnns9hl+8JVU2OAulwp7n86OWz8
   3ncR+J3Va5efdn18EmAS4h/ZfPqYayIfvz5E8PmpCEg3xnkNtma+xBrt4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="390361314"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="390361314"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942401674"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="942401674"
Received: from dstavrak-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:37:20 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>,
        "ville.syrjala" <ville.syrjala@linux.intel.com>,
        "uma.shankar" <uma.shankar@intel.com>
Cc:     airlied <airlied@gmail.com>,
        "animesh.manna" <animesh.manna@intel.com>,
        "ankit.k.nautiyal" <ankit.k.nautiyal@intel.com>,
        daniel <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "joonas.lahtinen" <joonas.lahtinen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "rodrigo.vivi" <rodrigo.vivi@intel.com>,
        "tvrtko.ursulin" <tvrtko.ursulin@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH v2] drm/i915: correct the input
 parameter on
 _intel_dsb_commit()
In-Reply-To: <1lagfvi0ner-1laizr4ur2c@nsmail7.0.0--kylin--1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1lagfvi0ner-1laizr4ur2c@nsmail7.0.0--kylin--1>
Date:   Wed, 29 Nov 2023 19:37:17 +0200
Message-ID: <87cyvs5ulu.fsf@intel.com>
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

On Wed, 29 Nov 2023, =E4=BD=95=E6=95=8F=E7=BA=A2 <heminhong@kylinos.cn> wro=
te:
> Friendly ping. I think this patch was forgotten.

Pushed, thanks for the patch.

>
> ----
>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9A[PATCH v2] drm/i915: correct the inpu=
t parameter on _intel_dsb_commit()=20
> =E6=97=A5=E3=80=80=E6=9C=9F=EF=BC=9A2023-11-14 10:43=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E4=BD=95=E6=95=8F=E7=BA=A2=20
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E4=BD=95=E6=95=8F=E7=BA=A2;
>
> Current, the dewake_scanline variable is defined as unsigned int,
> an unsigned int variable that is always greater than or equal to 0.
> when _intel_dsb_commit function is called by intel_dsb_commit function,
> the dewake_scanline variable may have an int value.
> So the dewake_scanline variable is necessary to defined as an int.
>
> Fixes: f83b94d23770 ("drm/i915/dsb: Use DEwake to combat PkgC latency")
> Reported-by: kernel test robot=20
> Closes: https://lore.kernel.org/oe-kbuild-all/202310052201.AnVbpgPr-lkp@i=
ntel.com/
> Cc: Ville Syrj=C3=A4l=C3=A4=20
> Cc: Uma Shankar=20
>
> Signed-off-by: heminhong=20
> ---
> drivers/gpu/drm/i915/display/intel_dsb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i=
915/display/intel_dsb.c
> index 78b6fe24dcd8..7fd6280c54a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsb.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsb.c
> @@ -340,7 +340,7 @@ static int intel_dsb_dewake_scanline(const struct int=
el_crtc_state *crtc_state)
> }
>
> static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
> - unsigned int dewake_scanline)
> + int dewake_scanline)
> {
> struct intel_crtc *crtc =3D dsb->crtc;
> struct drm_i915_private *dev_priv =3D to_i915(crtc->base.dev);

--=20
Jani Nikula, Intel
