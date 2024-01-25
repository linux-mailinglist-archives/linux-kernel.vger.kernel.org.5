Return-Path: <linux-kernel+bounces-38864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D144383C77A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E571C249BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86007A72C;
	Thu, 25 Jan 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COnc98BE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A971745C8;
	Thu, 25 Jan 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198733; cv=none; b=GBa84+BIzZ5827oN+YfcX1IQmpXfQh0i7xCTRYNdJXSJiOm5sjv+nQKDkG6749irNf8JQumXAVTj7bz4UAmQT09V7rVKAgSrl/Gyyd90wdxLoAT0MwJx9mOpr2yui/YeSybE3XiHnUqpSK27B7ZcbmFZkxkS/XgLomwuSzsGXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198733; c=relaxed/simple;
	bh=DNTN/lYZe7yjys99DYPQCerRcHwd8OfuFtEe4wkoNhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0gm4hnwHZcagkuetBPXWUsvCxAK2D3lyoXPsDVCSCwCyibGnzqCkv5S4WVC6HzX4ngeuLDcdKHYyXzja5sGUskEUv8+yyJF0YH3iQv1zEk0tYLMIHH0VP4hke+nJO+A1RnIUvZwmsWgoeQaxJ6uHSvnvgwS+xiCnO/y9RsTqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COnc98BE; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706198731; x=1737734731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DNTN/lYZe7yjys99DYPQCerRcHwd8OfuFtEe4wkoNhQ=;
  b=COnc98BE8m6CHh7X298kXojphwDApGBR8pJ++86mOq1RNRziBv3FC1gh
   yJJt89bnG5FyhVwQtYXQ7OCUXei1IwiCZcX88MexlKg9zgwhgjXDWRtEb
   1ILegw9DrWU30FL1/13JOAPrFEDi90CcXIvjhW01SbIzq1fX2CC9NVy3/
   /XrTzqVLJBIUHWDMfPMYM919ERcTCCqyzjmVMu8b7UX8y/IKXYPJhuotM
   EgrSjwpHkfrVJ0agZfES60uyodAqvyDPSyfd5g2WHDRlhsC/twriru5qv
   H1RZfRSSIYmZMShPZ8sQgAHOkpQS3U9TjR4jHq1KIdHrnOMojXp5sgNyu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401855468"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401855468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="820834834"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820834834"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:03:13 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1F56A11FB9B;
	Thu, 25 Jan 2024 18:03:11 +0200 (EET)
Date: Thu, 25 Jan 2024 16:03:11 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
	Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Adam Ford <aford173@gmail.com>
Subject: Re: [RESEND PATCH v6 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
Message-ID: <ZbKGPyDkunFgetYG@kekkonen.localdomain>
References: <20240110104642.532011-1-hugues.fruchet@foss.st.com>
 <f7f8344c-7a72-4450-81c7-8bff4569f044@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f8344c-7a72-4450-81c7-8bff4569f044@foss.st.com>

Hi Alexandre,

On Wed, Jan 24, 2024 at 01:36:02PM +0100, Alexandre TORGUE wrote:
> > Hugues Fruchet (5):
> >    dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
> >    media: hantro: add support for STM32MP25 VDEC
> >    media: hantro: add support for STM32MP25 VENC
> >    arm64: dts: st: add video decoder support to stm32mp255
> >    arm64: dts: st: add video encoder support to stm32mp255
> > 
> 
> Sakari, Mauro, do you plan to take patches 1 to 3 on your next branch ?
> I will take DT pacthes in mine but I would like to be sure that dt-binding
> will be applied in a next branch (for the next v6.9 cycle);

This being a codec driver, I presume Hans would pick these.

-- 
Regards,

Sakari Ailus

