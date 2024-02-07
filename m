Return-Path: <linux-kernel+bounces-56226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CD84C79B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311AAB2182B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C523776;
	Wed,  7 Feb 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvj1xyNv"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863F23748;
	Wed,  7 Feb 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298425; cv=none; b=tEXmwYU1REd95fCgmaFVeJPTgVIXuqKyJw3WMJW5jI6q8gmay7a+/mWnmcO3hb3OTA3DSqcNF0ltbjfxDFzJS1ue+RrUSkeV7/CrVl6FR9tJksEChPAv10UUTObo5SFmt0fsGSGddqvMh3qofbUxfdiDIbxFvUXucRuX/dQ3ErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298425; c=relaxed/simple;
	bh=JsN+70aPTg6lEAOrTx+Lx2fwdJbbiG3vSS3htAIip4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o3nYkntln6ObEWUs4NRrhaTU8I8DPJl3wH34CX9a76u4rnV3c7ZeZ8y77o5jFwth5X5L7WqpBs+mI0iYzrEyyKDhy7btmjE/bM+AKQllEc9XGyjbrZHmAOy5kmeFeO8knKyZtv8864TM6XeT7dGWfG45IJTKHQtuXsMLKamV2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvj1xyNv; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707298423; x=1738834423;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JsN+70aPTg6lEAOrTx+Lx2fwdJbbiG3vSS3htAIip4A=;
  b=kvj1xyNvu92BUmuUtWoOPnIrGfdIJOQTnhh5tFQwvaB9LNGThmUY/IAV
   9GVbGffsEWMM1QVI1Aq93uHYLuQea8KGyOLyzXAeRo954CuQHXz9jyhKM
   ATySjbjubFaIJ2s9PgwF2bTI8gA+jt/uymeQ/ssXnzSJJvDdjH+dfVU+n
   bwVDJBteTCTt0Xm6WVNkAv+2+uI4lNxlaUJ8tl1UFYkMRXnCxlMn621bp
   LhZhqBbxphjshy+pUFgjlJC2JfUFghIR5w7wuEbaMOq7jB/ZLRAM5YSNd
   PEebjXMoqDvUqN6tg1QOE+UbeWR1XCfJsms9rBg6yfZXknLxq7H6oJcRD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="436085940"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="436085940"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:33:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1601780"
Received: from mtiebout-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:33:37 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lucas De Marchi
 <lucas.demarchi@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Dave Airlie <airlied@gmail.com>,
 intel-xe@lists.freedesktop.org
Subject: Re: Re: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <5b3adb702cfaa944fdaa1b49ee7f10e4d0e86b2f.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240206122822.12a2df89@canb.auug.org.au>
 <f9a027765a3c65c69c2d49cf2964fe1155e914f4.camel@linux.intel.com>
 <tughiv3y52m6ruczgb3g6mvvek7ihfrxaxh7ovoogzqfi6jmun@jcn6xap7vwcg>
 <5b3adb702cfaa944fdaa1b49ee7f10e4d0e86b2f.camel@linux.intel.com>
Date: Wed, 07 Feb 2024 11:33:34 +0200
Message-ID: <87il30d3f5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Feb 2024, Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m> wrote:
> Indeed. Not even drm-misc itself compiles with xe enabled. I'll ping
> drm-misc maintainers.

We'll need CONFIG_DRM_XE=3Dm enabled in drm-rerere/drm-misc-*_defconfig,
and get people to use that.

BR,
Jani.


--=20
Jani Nikula, Intel

