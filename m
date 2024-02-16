Return-Path: <linux-kernel+bounces-68274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8E857815
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263751F227F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EB1BF53;
	Fri, 16 Feb 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aszf+Gf5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F91B957
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073490; cv=none; b=DQsiF9RS734bEIYuxEuwxWuVW3UEB7WcrP+24Oe4AUxnoUMq8GEZ6+eyHQAclC690MbHUATBgV1lNrEC/qzJlFFm320ZBZQcsPfYR2bvE0uAt0EotBtkPpTXGOWakGLQ7FWi7XUrgn1/Iiy5IlLty91pTvSYrfiRA8dX7AVe8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073490; c=relaxed/simple;
	bh=tldO0oAElb0EM3Jm2vnWyFrp/x3ZCudlzcDdQgwDE3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWaOu/9YBVcLbHk1jy7Hcq9CTv7an8uXO2rt3HZ2lEzKDiVowVZ1u4lCl3rkr3gMZTSoOo5T5jVRF1krLizBD5kPSLDcXFi+GjeOuCP6xLi1RcNyuC8dOIp26MxvlzI5znqIe0SJgoi90dLPDZngcFoHvi5CGgS3Y9E1ouUJAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aszf+Gf5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708073488; x=1739609488;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tldO0oAElb0EM3Jm2vnWyFrp/x3ZCudlzcDdQgwDE3c=;
  b=aszf+Gf5xpyf2pydKx42YNQzRfukyiXP6MHTgMbOLyfivOBVTo6Sgv9G
   8KUBxI/0lnsbn216ExzwHFkJZU9ZnFsFJiX/x9oyG7fvDTXlAsV2+F+n+
   x7KWIfwaa+Xd2L3AXQy3gWIyzefc8ns4yHTROaqaxe6vXycKcVcYH3veC
   ZTlyWk0RMgS+L0DDaLXQfl57KWt7t93dvjZ35y4p9jiSVYY7IdAARjeQQ
   tNI3MeMAbkzDZRv4REfxdDyAdSnCWFmRSVdk66PJEyXrqnpNFLRJ644BI
   mPRjlaS8+SKsOzcz9b/HVA5jylTwE5oF0YhIUglUezD/N8xuwVeSibHpn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6025302"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="6025302"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8428450"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.79])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:51:23 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Jiri Slaby (SUSE)"
 <jirislaby@kernel.org>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Zhenyu Wang
 <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH 00/21] drm/i915: remove unused structure members
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240216065326.6910-1-jirislaby@kernel.org>
Date: Fri, 16 Feb 2024 10:51:20 +0200
Message-ID: <87plww4ws7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 16 Feb 2024, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
> this series removes unused i915 structure members as found by
> clang-struct (and manually checked by me).

Thanks Jiri, good stuff!

Acked-by: Jani Nikula <jani.nikula@intel.com>

However, you may have overlooked that drivers/gpu/drm/i915/gvt/ is
maintained separately.

Cc: Zhenyu, Zhi, how do you want the gvt patches in this series handled?


BR,
Jani.


>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>
> Jiri Slaby (SUSE) (21):
>   drm/i915: remove unused intel_dvo_dev_ops hooks
>   drm/i915: remove structs intel_vgpu_pipe_format and
>     intel_vgpu_fb_format
>   drm/i915: remove intel_dsi::{port_bits,hs}
>   drm/i915: remove
>     intel_gvt_gtt::{mm_alloc_page_table,mm_free_page_table}
>   drm/i915: remove intel_gvt_mmio_info::{device,addr_range}
>   drm/i915: remove intel_vgpu_workload::{ring_context,restore_inhibit}
>   drm/i915: remove intel_vbt_panel_data::edp::initialized
>   drm/i915: remove intel_guc::ads_engine_usage_size
>   drm/i915: remove i915_drm_client::id
>   drm/i915: remove i915_perf_stream::size_exponent
>   drm/i915: remove intel_vgpu_gtt::active_ppgtt_mm_bitmap
>   drm/i915: remove intel_vgpu_fence::base
>   drm/i915: remove intel_vgpu_opregion::mapped
>   drm/i915: remove intel_vgpu::intx_trigger
>   drm/i915: remove gvt_mmio_block::device
>   drm/i915: remove intel_gvt_irq_info::warned
>   drm/i915: remove intel_gvt_event_info::policy
>   drm/i915: remove intel_gvt_irq::pending_events
>   drm/i915: remove execute_cb::signal
>   drm/i915: remove i915_vma::obj_hash
>   drm/i915: remove intel_memory_region_ops::flags
>
>  .../drm/i915/display/intel_display_types.h    |  1 -
>  drivers/gpu/drm/i915/display/intel_dsi.h      |  4 ---
>  drivers/gpu/drm/i915/display/intel_dvo_dev.h  | 25 -------------------
>  drivers/gpu/drm/i915/gt/uc/intel_guc.h        |  2 --
>  drivers/gpu/drm/i915/gvt/fb_decoder.h         | 11 --------
>  drivers/gpu/drm/i915/gvt/gtt.h                |  3 ---
>  drivers/gpu/drm/i915/gvt/gvt.h                |  5 ----
>  drivers/gpu/drm/i915/gvt/interrupt.c          |  1 -
>  drivers/gpu/drm/i915/gvt/interrupt.h          |  2 --
>  drivers/gpu/drm/i915/gvt/mmio.h               |  2 --
>  drivers/gpu/drm/i915/gvt/scheduler.h          |  2 --
>  drivers/gpu/drm/i915/i915_drm_client.h        |  2 --
>  drivers/gpu/drm/i915/i915_perf_types.h        |  1 -
>  drivers/gpu/drm/i915/i915_request.c           |  1 -
>  drivers/gpu/drm/i915/i915_vma_types.h         |  1 -
>  drivers/gpu/drm/i915/intel_memory_region.h    |  2 --
>  16 files changed, 65 deletions(-)

-- 
Jani Nikula, Intel

