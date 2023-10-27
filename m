Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777C7D984B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbjJ0Mct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Mcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:32:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8438C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698409965; x=1729945965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2WFc0xktwdPr3K6DLDyFQydg5aZGQ7HEhIRKjX8dajE=;
  b=V1fedcgAV0oD4Zyv6Kk6ZquHbeNdbdrTMHzdeA+E59GTYpjJnSehlNGE
   2LxSxChgLagMCt3yc9Jy7ztgW8FYxCUi50YAxA1cwsr40BHcb1SZF7i4j
   5IOkqDDmgR0ehZPvB2i8ctWOnt0xEPewi+yeNeSigJLRGqCAIAUCKIOjH
   sKAnG7nIw1NO4D3aimK9y54F8MQVhKO715aWvRFYewzhNO8cV0hEbyhkh
   Y+EqGZumOmmn4aXBbOI+5DcUNiqwZXdO/E1tj+0BiIs/QuhMlg723S2dR
   w7mn+KZkVqsNPTXrVZVwKOo3kAuDUacd9xV22yr1hBJeNFHY0wA/ZVUPg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418877268"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="418877268"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709398360"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="709398360"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga003.jf.intel.com with SMTP; 27 Oct 2023 05:32:20 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 27 Oct 2023 15:32:19 +0300
Date:   Fri, 27 Oct 2023 15:32:19 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peng Hao <penghao@dingdao.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] gpu/drm/drm_framebuffer.c: Add judgement for return
 value of drm_get_format_info().
Message-ID: <ZTut09A43yidJD9Z@intel.com>
References: <20231027091912.1244107-1-penghao@dingdao.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027091912.1244107-1-penghao@dingdao.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:19:12PM +0800, Peng Hao wrote:
> Since drm_get_format_info() may return NULL,

Not in this case since we already checked it earlier.

> so a judgement of return
> value is needed to add.
> 
> Signed-off-by: Peng Hao <penghao@dingdao.com>
> ---
>  drivers/gpu/drm/drm_framebuffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index aff3746dedfb..be7dd1998c04 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -194,6 +194,10 @@ static int framebuffer_check(struct drm_device *dev,
>  
>  	/* now let the driver pick its own format info */
>  	info = drm_get_format_info(dev, r);
> +	if (!info) {
> +		drm_dbg_kms(dev, "no matched format info\n");
> +		return -EFAULT;
> +	}
>  
>  	for (i = 0; i < info->num_planes; i++) {
>  		unsigned int width = fb_plane_width(r->width, info, i);
> -- 
> 2.37.1

-- 
Ville Syrjälä
Intel
