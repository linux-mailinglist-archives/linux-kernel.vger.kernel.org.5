Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498347C4B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjJKHK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbjJKHKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:10:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EA90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697008253; x=1728544253;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Ml7Fp7eHHGupyYR1HlJpyyVZB1D65axD2PsS0w1/tPc=;
  b=bOhGOa7Y9z+3ff/Ogzmb32U+UOcjVFsnNgHfoSRIrpZOmCUMqFm+MPIz
   bxx4W01Sya/WhUYzAm6TRLxWrXi1u3qNLiVbg88DcTRfMM+z1nRDatEfA
   HFewSHCHFTlOMyU3XkaiSdITqJkNjJUH8dtgQYmcAcvU5VIfhvykWP788
   GcGvHC5VBO/fhePEkSYUF/pibKZzkrFNcotm5yNx46SE6ERcJm64MWTgX
   67cqgO46grUu9If1sUcbdJfxXNdxJYB8LxVHxBZRbpb3Of3TLGPJdroTO
   QRy3eEOXYpPzzpcwWG5qT+SjemesSl88st6BnFlaVCd6UdSF4Dymeb5wv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451090801"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451090801"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824057686"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824057686"
Received: from wprelogx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.56.229])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:10:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ma Ke <make_ruc2021@163.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ma Ke <make_ruc2021@163.com>
Subject: Re: [PATCH] drm/edid: fix a possible null pointer dereference
In-Reply-To: <20231011013316.4091845-1-make_ruc2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231011013316.4091845-1-make_ruc2021@163.com>
Date:   Wed, 11 Oct 2023 10:10:30 +0300
Message-ID: <874jix63dl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023, Ma Ke <make_ruc2021@163.com> wrote:
> In drm_mode_std(), the return value of drm_gtf_mode(),
> drm_gtf_mode() and drm_cvt_mode() is assigned to mode,
> which will lead to a NULL pointer dereference on failure
> of drm_gtf_mode(), drm_gtf_mode() and drm_cvt_mode().
> Add a check to avoid null point dereference.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 340da8257b51..e2c154c2b896 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -3381,6 +3381,8 @@ static struct drm_display_mode *drm_mode_std(struct drm_connector *connector,
>  				    false);
>  		break;
>  	}
> +	if (!mode)
> +		return NULL;

This doesn't change anything.

BR,
Jani.


>  	return mode;
>  }

-- 
Jani Nikula, Intel
