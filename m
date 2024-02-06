Return-Path: <linux-kernel+bounces-54829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31584B429
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC798B26B56
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63313343B;
	Tue,  6 Feb 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qjc9efYM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8913342B;
	Tue,  6 Feb 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219987; cv=none; b=WsGBfoXkYeeeg8S0PrFCNW0L+rGu08RwNlS6bJ4Cg2I+9MKwFRtOl7zANWTPtY4NNImLdAwPKCHcWjbOE+CrKNda+Pmsd9XveE++ZucgYShDXxqhvk4DH9Eb7vUlXbJ7hEiEQDigHm09B9PM6vtq25aSljmr7qLE+18zM2eptWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219987; c=relaxed/simple;
	bh=g1yd67TDqY5Jh0DtJ2vM94qZdQRy9Ffyfjqi/oL+iD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqP/Q/v+JxY2BlnG1X2HTmoOWFBfR3LHI96zCbgul/CGtJlmDE4QeKlrbzen9+/x5Xtb5rWdClRnVIuY9/ncrrFSv9IhHHppmYSGn/FKBvr/kNKtdAjar/STl9LClibgaSb/N6hZ+xzwkMI8jsH6zDwj1ZRyYaT1Q96Km7rMTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qjc9efYM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707219985; x=1738755985;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=g1yd67TDqY5Jh0DtJ2vM94qZdQRy9Ffyfjqi/oL+iD4=;
  b=Qjc9efYMAmBQzDSJiFEWpK3uj98dX6yyoiBQ56bHRciNM2Cz/QSJP/Hf
   PxXni1U7qQoSrnJvCLBcuZR4idkMqkNcEv5Lv2l31sMT3908hjpivc35T
   VSBCPfYrCCxPc9+TSRMLCxWAHquJD4NN//1sNOLPH8iI892WhMkZgkt31
   Ti93ZsKm8hmX+e3zIkwjWxKEzRGVzmfNpp5VaGrDQb2LiRZn6r7V2JTKn
   g/VYi+4drAnePxGU96loorSjJYpYO7ZHVLz1zOUqAtdn29XbYuo/jZUWe
   RjJcntULEn57xtkzuq9U7rfXrdoJQAUo3prwfDf4C2LM6KDAH1+ajEb63
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="625018"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="625018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="993166"
Received: from lgrunert-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.150])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:46:19 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter
 <daniel.vetter@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Subject: Re: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <20240206122822.12a2df89@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240206122822.12a2df89@canb.auug.org.au>
Date: Tue, 06 Feb 2024 13:46:16 +0200
Message-ID: <87plx9dddj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Feb 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
>
> Caused by commit
>
>   a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
>
> interacting with commit
>
>   dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>
> (and maybe others) from Linus' tree (v6.8-rc1).
>
> I have applied the following merge fix patch for today.  This makes it bu=
ild,
> but more is likely needed ...
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 6 Feb 2024 12:21:07 +1100
> Subject: [PATCH] fix up for "drm/ttm: replace busy placement with flags v=
6"
>
> interacting with commit
>
>   dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/xe/xe_bo.c | 11 -----------
>  1 file changed, 11 deletions(-)

Please see the new MAINTAINERS entry for drm/xe changes:

INTEL DRM XE DRIVER (Lunar Lake and newer)
M:	Lucas De Marchi <lucas.demarchi@intel.com>
M:	Oded Gabbay <ogabbay@kernel.org>
M:	Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
L:	intel-xe@lists.freedesktop.org

BR,
Jani.


--=20
Jani Nikula, Intel

