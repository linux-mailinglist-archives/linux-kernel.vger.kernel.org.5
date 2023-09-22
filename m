Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972437AB9F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjIVTWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:22:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C9A3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695410524; x=1726946524;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=nvcrQo2rL5r9UFSm+cmfQJnb28t5Kpu5MR2khnCIlMk=;
  b=CtFB6ulYab+549jKJj4LOoNGgmGcNP4HYt2xcguvaAbrZDaxTqM53odX
   1hg5wmghIxXLiBvNKczWiscOPMIq85Kbq+2DihYSGd2UWlS+xW/+cnXPf
   lD9Y6it1cq5Jr1HKZwg9Ltv2iWLFwXGvfIQPCpAbXvUjTUTwrlXOQbGoG
   wpc7DtyQquSfyaMrixieU0PdrSGvdAeqb6aL/HwsI44AXKV//WKdZojG9
   UDFzDfN4oM4Ywx0zhnBKjK6E4ctBdoGlxUoyviiQlxYTesMC6DgEAvqUZ
   Ew6vrLsOgh6stQ4tWNUxZKE5EoAN4fBVGEu/5DsvMHHIkx3SpeJRuhwhE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360303436"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="360303436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 12:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="817915002"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="817915002"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 12:22:00 -0700
Date:   Fri, 22 Sep 2023 22:22:21 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Ramya SR <quic_rsr@quicinc.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jeff Layton <jlayton@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/dp/mst: fix missing modeset unlock for MST port
 detect
Message-ID: <ZQ3pbVHRXMiLfUCf@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <1694753689-29782-1-git-send-email-quic_rsr@quicinc.com>
 <19ce2cd9abfd3bdf3ea91f9bceb43206e4740c2e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ce2cd9abfd3bdf3ea91f9bceb43206e4740c2e.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:02:23PM -0400, Lyude Paul wrote:
> 
> Oh! wow thank you for catching this:
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> I will go and push this to drm-misc-next in just a moment
> 
> On Fri, 2023-09-15 at 10:24 +0530, Ramya SR wrote:
> > Modeset mutex unlock is missing in drm_dp_mst_detect_port function.
> > This will lead to deadlock if calling the function multiple times in
> > an atomic operation, for example, getting imultiple MST ports status
> > for a DP MST bonding scenario.
> > 
> > Signed-off-by: Ramya SR <quic_rsr@quicinc.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > index ed96cfc..d6512c4 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -4154,7 +4154,7 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
> >  
> >  	ret = drm_modeset_lock(&mgr->base.lock, ctx);
> >  	if (ret)
> > -		goto out;
> > +		goto fail;
> >  
> >  	ret = connector_status_disconnected;
> >  
> > @@ -4181,6 +4181,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
> >  		break;
> >  	}
> >  out:
> > +	drm_modeset_unlock(&mgr->base.lock);

Isn't this supposed to be unlocked only by drm_helper_probe_detect_ctx()
/ drm_helper_probe_detect() ?

> > +fail:
> >  	drm_dp_mst_topology_put_port(port);
> >  	return ret;
> >  }
> 
> -- 
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
> 
