Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52371797863
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbjIGQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjIGQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:46:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AEF7683;
        Thu,  7 Sep 2023 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694103600; x=1725639600;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DBrL4mS557cxBvRouvwV9QF+iy39q5mSe7MPFfBAAyY=;
  b=lfdlF99KklkzalsqntVN6PKzyH0ow+w0VQACqIar0NT6NHtTXD9DM89u
   y4/rNSXkpy7fnGUQb+gEXAOrp0rLGDajdtaV+SJW9eXAVoG5KlzA/OmeJ
   CztiZMrVmqnEA3cQgIyJlj+RpIB6exyUvDjoiM3Q3gpDJ/eVr5qIo7txc
   kdIFkreJGQD0nOhXfdweFSh0LJRWm9Q4/ywY1k3xUbus2dgycbJ+8HCnf
   lJKafiXQGZJ4xVLQ2Qb9uJRsNAEx9HmvnEQhL3eq4tycCVi4g6d4qslDH
   WWFL8hwaE4hp4b/sUIUHVb2M93dB3GaYnOTKBLXb+Jx7KXJBDWgSGsgMB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441323679"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="441323679"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="807515912"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="807515912"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:14:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-doc@vger.kernel.org, hns@goldelico.com,
        krzysztof.kozlowski+dt@linaro.org, matthew.brost@intel.com,
        corbet@lwn.net, luben.tuikov@amd.com, dakr@redhat.com,
        donald.robson@imgtec.com, devicetree@vger.kernel.org,
        conor+dt@kernel.org, mripard@kernel.org, matt.coster@imgtec.com,
        robh+dt@kernel.org, faith.ekstrand@collabora.com,
        linux-kernel@vger.kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, tzimmermann@suse.de,
        christian.koenig@amd.com
Subject: Re: [PATCH v6 02/20] drm/gpuva_mgr: Helper to get range of unmap
 from a remap op.
In-Reply-To: <20230906095542.3280699-3-sarah.walker@imgtec.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230906095542.3280699-1-sarah.walker@imgtec.com>
 <20230906095542.3280699-3-sarah.walker@imgtec.com>
Date:   Thu, 07 Sep 2023 15:14:14 +0300
Message-ID: <87a5tygoyx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023, Sarah Walker <sarah.walker@imgtec.com> wrote:
> From: Donald Robson <donald.robson@imgtec.com>
>
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>
> ---
>  include/drm/drm_gpuva_mgr.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/include/drm/drm_gpuva_mgr.h b/include/drm/drm_gpuva_mgr.h
> index ed8d50200cc3..be7b3a6d7e67 100644
> --- a/include/drm/drm_gpuva_mgr.h
> +++ b/include/drm/drm_gpuva_mgr.h
> @@ -703,4 +703,31 @@ void drm_gpuva_remap(struct drm_gpuva *prev,
>  
>  void drm_gpuva_unmap(struct drm_gpuva_op_unmap *op);
>  
> +/**
> + * drm_gpuva_op_remap_get_unmap_range() - Helper to get the start and range of
> + * the unmap stage of a remap op.
> + * @op: Remap op.
> + * @start_addr: Output pointer for the start of the required unmap.
> + * @range: Output pointer for the length of the required unmap.
> + *
> + * These parameters can then be used by the caller to unmap memory pages that
> + * are no longer required.
> + */
> +static __always_inline void

IMO __always_inline *always* requires a justification in the commit
message.

BR,
Jani.


> +drm_gpuva_op_remap_get_unmap_range(const struct drm_gpuva_op_remap *op,
> +				   u64 *start_addr, u64 *range)
> +{
> +	const u64 va_start = op->prev ?
> +			     op->prev->va.addr + op->prev->va.range :
> +			     op->unmap->va->va.addr;
> +	const u64 va_end = op->next ?
> +			   op->next->va.addr :
> +			   op->unmap->va->va.addr + op->unmap->va->va.range;
> +
> +	if (start_addr)
> +		*start_addr = va_start;
> +	if (range)
> +		*range = va_end - va_start;
> +}
> +
>  #endif /* __DRM_GPUVA_MGR_H__ */

-- 
Jani Nikula, Intel Open Source Graphics Center
