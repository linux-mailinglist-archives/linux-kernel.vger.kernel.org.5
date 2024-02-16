Return-Path: <linux-kernel+bounces-68590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776BF857CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C96B23E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7DD128818;
	Fri, 16 Feb 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjPL0vOi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD058203
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087246; cv=none; b=Jnk9eYTpmu/4/HfUK628Dggspm4vjLep6SnVgVqOmksGKUMAa/IQg+laVMYNkmZ+2XUeLraH0VeplgoKK0DzYg/2Qti5cgAtUXpuayJaOoNaW7GdlO1zqD2kn3aU/SPLvGn5TymnyJkHg0LVLWBmSRHmMyNRG0xakFET3/J53c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087246; c=relaxed/simple;
	bh=RHAVrJDR02TPJMiqDrO+AXDbXSsrU8gpy27+NAKnQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muLmdTpYuj5fQK4s+pu16CsbSKrdzHn3aeIcusMSx4DBDmHyRJ4i0qR4ObEXSsePaSJyCh15Nr7tu2Uq8vYl02JbKguhhZVb+k+/M+HLF0FmUkkjvzsK9eCzwH9KkhnlzZuSZndacOLIAccOurbNUFLCQ3al+Vi4Xp96t8DhoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjPL0vOi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51162964d46so335215e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708087243; x=1708692043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/BEPC0f21cX8+pFxjO9Xj6ogm+sj9UMJhy8cDHL9rc=;
        b=OjPL0vOimtW7ZC6XYz/uqraVgMt/tWb0TRO9C3fEQBOkN8RvTzXoETvZtApZLyQSnu
         HTMOqnFbTJ2f5T7XrAuXwxoQZJEvVgi+DxLSonkJinfLo/8LO79xIXpWI5YjZTqHnUC8
         5UpcnaR9ilMex32doJ8BSlkiqqJtUTISqDqzb+fGuJDamd1U2lasTs/6NcVKYovbRcC7
         s399z2VrSe1UKEGijaqUl1L38tQyokuRB+32403ww4wImgs0d4QxNcevPWNks1W3jz93
         t2GoxK50nxBWWgHjMj2v5lZpDCE1e967q79+hL3MsoSv9URYUp4zA9MGiaZOb0K4FqHG
         A3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708087243; x=1708692043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/BEPC0f21cX8+pFxjO9Xj6ogm+sj9UMJhy8cDHL9rc=;
        b=RP5r7EeON57uoHGdKeEPU7kykXABSTU7YFlZHIsugNAdvMMEuoyn6yuK/tN4adQmqa
         qlmoyvdO3OmdHMVCtwthL1rlIZrTtqrtdIXLIf/vrkoMy8d32ikbr+VPqJxh/PHYTHfN
         uEKKSioqTW28p3nohGn1LzPrHU3/E60MtQGJBomtwWHfUGPpR9V1tlQSTD5QvDQ4MM8H
         O+QymTMuoI8VG6ZMvAMZD4hIcjraPjzvVQqXt5rzDE9K36Fg73pTPUDERvfWAuA1QLAJ
         CTqv7NnFyr4bQrL74Z211ptIMK81om24vDhQnxE5OTuRhk2xKj8E12P95qevVLxEG5BM
         K7pg==
X-Forwarded-Encrypted: i=1; AJvYcCUZfy1+xeyJn3q9nrIm2DCkEhECJkhW+O47qxDfALcA41c246+A/kPZ/GZrh2QIQwP4RC2zYPuvXifoMH4/mdez1aAHrO7nI4c81BDi
X-Gm-Message-State: AOJu0YyVp5xCeyJEiC66wjFU86mwJSNMjc+pYJO+F0koXLOQybLhoc6S
	i85UCO+TayhcWevj4GAm6im8M1CRRjTJTrLAzZr/LSoC9ytk2Y3ml8cAok6z
X-Google-Smtp-Source: AGHT+IFRSaMnjw8+3knZoCRYoJ3YhOgeltpJKK6FMRHJWpFVSx03+fMwDDJJ9ib7uI6P0LQYFOzXgg==
X-Received: by 2002:a05:6512:249:b0:511:8e03:c9a3 with SMTP id b9-20020a056512024900b005118e03c9a3mr1302245lfo.2.1708087242403;
        Fri, 16 Feb 2024 04:40:42 -0800 (PST)
Received: from localhost (88-115-160-21.elisa-laajakaista.fi. [88.115.160.21])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b005129c9758e0sm6230lfn.306.2024.02.16.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:40:42 -0800 (PST)
Date: Fri, 16 Feb 2024 14:40:26 +0200
From: Zhi Wang <zhi.wang.linux@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Zhenyu Wang <zhenyuw@linux.intel.com>, intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH 00/21] drm/i915: remove unused structure members
Message-ID: <20240216144026.00005144.zhi.wang.linux@gmail.com>
In-Reply-To: <87plww4ws7.fsf@intel.com>
References: <20240216065326.6910-1-jirislaby@kernel.org>
	<87plww4ws7.fsf@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 10:51:20 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Fri, 16 Feb 2024, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
> > this series removes unused i915 structure members as found by
> > clang-struct (and manually checked by me).
> 
> Thanks Jiri, good stuff!
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> However, you may have overlooked that drivers/gpu/drm/i915/gvt/ is
> maintained separately.
> 
> Cc: Zhenyu, Zhi, how do you want the gvt patches in this series
> handled?
> 

Many thanks for the clean-up patch Jiri! Jani, it would be easier
for us that you can help to apply the patches through i915.

Thanks,
Zhi.

> 
> BR,
> Jani.
> 
> 
> >
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> >
> > Jiri Slaby (SUSE) (21):
> >   drm/i915: remove unused intel_dvo_dev_ops hooks
> >   drm/i915: remove structs intel_vgpu_pipe_format and
> >     intel_vgpu_fb_format
> >   drm/i915: remove intel_dsi::{port_bits,hs}
> >   drm/i915: remove
> >     intel_gvt_gtt::{mm_alloc_page_table,mm_free_page_table}
> >   drm/i915: remove intel_gvt_mmio_info::{device,addr_range}
> >   drm/i915: remove
> > intel_vgpu_workload::{ring_context,restore_inhibit} drm/i915:
> > remove intel_vbt_panel_data::edp::initialized drm/i915: remove
> > intel_guc::ads_engine_usage_size drm/i915: remove
> > i915_drm_client::id drm/i915: remove i915_perf_stream::size_exponent
> >   drm/i915: remove intel_vgpu_gtt::active_ppgtt_mm_bitmap
> >   drm/i915: remove intel_vgpu_fence::base
> >   drm/i915: remove intel_vgpu_opregion::mapped
> >   drm/i915: remove intel_vgpu::intx_trigger
> >   drm/i915: remove gvt_mmio_block::device
> >   drm/i915: remove intel_gvt_irq_info::warned
> >   drm/i915: remove intel_gvt_event_info::policy
> >   drm/i915: remove intel_gvt_irq::pending_events
> >   drm/i915: remove execute_cb::signal
> >   drm/i915: remove i915_vma::obj_hash
> >   drm/i915: remove intel_memory_region_ops::flags
> >
> >  .../drm/i915/display/intel_display_types.h    |  1 -
> >  drivers/gpu/drm/i915/display/intel_dsi.h      |  4 ---
> >  drivers/gpu/drm/i915/display/intel_dvo_dev.h  | 25
> > ------------------- drivers/gpu/drm/i915/gt/uc/intel_guc.h        |
> >  2 -- drivers/gpu/drm/i915/gvt/fb_decoder.h         | 11 --------
> >  drivers/gpu/drm/i915/gvt/gtt.h                |  3 ---
> >  drivers/gpu/drm/i915/gvt/gvt.h                |  5 ----
> >  drivers/gpu/drm/i915/gvt/interrupt.c          |  1 -
> >  drivers/gpu/drm/i915/gvt/interrupt.h          |  2 --
> >  drivers/gpu/drm/i915/gvt/mmio.h               |  2 --
> >  drivers/gpu/drm/i915/gvt/scheduler.h          |  2 --
> >  drivers/gpu/drm/i915/i915_drm_client.h        |  2 --
> >  drivers/gpu/drm/i915/i915_perf_types.h        |  1 -
> >  drivers/gpu/drm/i915/i915_request.c           |  1 -
> >  drivers/gpu/drm/i915/i915_vma_types.h         |  1 -
> >  drivers/gpu/drm/i915/intel_memory_region.h    |  2 --
> >  16 files changed, 65 deletions(-)
> 


