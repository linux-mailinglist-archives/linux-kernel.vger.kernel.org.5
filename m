Return-Path: <linux-kernel+bounces-85224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3586B279
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FF028B0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755CE15B0FD;
	Wed, 28 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQq51VjO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC115B969
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132181; cv=none; b=a5bQh0sLxzxg+Xxi4s3rxg+Mh0AVHmXKvrhza3xZyAkmA7a/eyPxgNjW9GjOa5zIGN0lzn7jjQ6pW+oj3NhdIaiaYVUG4CZIYlcAz3o3YD/oG2WP5Hng2xnG2YVnUYQnp0rDmhuyw3VlEyRSJyTnnwa6QN9/zwML/4Sf5TeYw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132181; c=relaxed/simple;
	bh=XHKMIZTbj9bitp8a+76rJdKa+WSqMzI2I1WztVw5LMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hk8Y5I3W4leeIN3MXJNcrlZwbTLoqFwQs9k6s/JZ4CkISLZD9Fxzl6uvR5pjyxAsL3jmXCYO/8smAsprnVOWRPO+I8337ArjViqAjPA8qkm2e+Q/4NbxQbLfyQQ5quVugusCmJnw7iuSAeNgN/flxuxAHvUcho96Ypx5BpqkTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQq51VjO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709132178; x=1740668178;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=XHKMIZTbj9bitp8a+76rJdKa+WSqMzI2I1WztVw5LMs=;
  b=cQq51VjOJgJ2AD+9TD0UOSMjyJ8cLsPMVe6/TphCoBU1JONBTqc7OwEc
   42HNLUc13sn63Oan6bhzf+o5GNPXLbhpUfy52mwaEiBUxeS5gYTUoj0vc
   g3dUDZ3QdrhvsaemwyjcjICEhCV26HAYva80KrK7bafhHA+F4Ssr4w9S7
   5xYW9t4gC1+vypdslrS1bKVAyVawuBW59ehMSX8z+KNrJUj9qa/D5i8Hv
   Y6wP8yn/JeUUnlHEN3/UyviQRRuFJ9Fi8zzgTk/I57ijGq8nyaLHeZkno
   07+SKYDofNKd+e2uCzdoN/qIopJOCFY8W7TnRUG4ojxK7GPvPq8aExx1x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14952691"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14952691"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12121542"
Received: from tmelzer-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.32.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:56:13 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Daniel Vetter
 <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Tvrtko Ursulin
In-Reply-To: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
Date: Wed, 28 Feb 2024 16:56:09 +0200
Message-ID: <8734tcab92.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> I will lose access to my @.*intel.com e-mail addresses soon so let me
> adjust the maintainers entry and update the mailmap too.
>
> While at it consolidate a few other of my old emails to point to the
> main one.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  .mailmap    | 5 +++++
>  MAINTAINERS | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index b99a238ee3bd..d67e351bce8e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -608,6 +608,11 @@ TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel=
org>
>  TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
>  Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
>  Tudor Ambarus <tudor.ambarus@linaro.org> <tudor.ambarus@microchip.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@intel.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@linux.intel.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@sophos.com>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@onelan.co.uk>
> +Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko@ursulin.net>
>  Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
>  Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
>  Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19f6f8014f94..b940bfe2a692 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10734,7 +10734,7 @@ INTEL DRM I915 DRIVER (Meteor Lake, DG2 and older=
 excluding Poulsbo, Moorestown
>  M:	Jani Nikula <jani.nikula@linux.intel.com>
>  M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>  M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> -M:	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> +M:	Tvrtko Ursulin <tursulin@ursulin.net>
>  L:	intel-gfx@lists.freedesktop.org
>  S:	Supported
>  W:	https://drm.pages.freedesktop.org/intel-docs/

--=20
Jani Nikula, Intel

