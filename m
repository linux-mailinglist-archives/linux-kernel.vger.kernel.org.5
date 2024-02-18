Return-Path: <linux-kernel+bounces-70319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1558595FE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC98F1C20A75
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4988B17570;
	Sun, 18 Feb 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqLT55/j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA724CA6B;
	Sun, 18 Feb 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248682; cv=none; b=CEmw/Us7EvkkYrGHlu0PadFiAxliUP0bNVYL84TKpZv+esndDI9bpxv4wZww91VNijMXwVlbXShWNKD6XxzNv+ylPvxpcYWSqJy9NAUp6wuAYc+yh7fxeDrmntGiQ60gkzH1hTn3nK4EvT+tu5HSIqQ1DIshJ8Kh/NxStvT4njI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248682; c=relaxed/simple;
	bh=H/OSay05+csAHwBP0A3xim8Jfufbq4gn0ZbQ5TgLGOo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rGSV4ZuDzUys3nfkt6j1WTifmbq+0Hg9908NM82Mt0XRbuJl6jwFudJYPE1Ir2+GuSUGrMHAMzmyV2Egb6R5SeptxawyXkS9F+yb/tosmFrBt7ozpLu7khJZP/Rh0FsaNged27DFsC7DzLE0GKeIeSgoBncwvgxDTaPdiPnSUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqLT55/j; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708248679; x=1739784679;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H/OSay05+csAHwBP0A3xim8Jfufbq4gn0ZbQ5TgLGOo=;
  b=JqLT55/jGf/mUSf/KMB9jcH+qdN2G2FOxnvgQwGg+kLgaDuxDe8yXCRL
   LAp/HjSkJw96zBbYKjq5gX02GSDGRGR+kxWc+2CjKlqm3zXnzGleF6mdH
   JYOvAVBBAA0vDZ8XepE8C7UsoMnPhP/LelOO+rB3da/g1ttVI+Q3IRGat
   jTzTU/wLexgSQM7R90612dhYoHZWDbovy3SizmHpLRz52mjxEYwEq6P2P
   RhEdz15kphhFj8ukkG9i/JYNWQVY57Zhgpc83uQOr7QFWc5k5jl+Xd0Un
   GnCfjzJ4boz62YSnNKMYefz0ZEtJComBoBPzKWhXXcJWkteizNEJdUhLr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2200303"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2200303"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 01:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912682691"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912682691"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.212]) ([10.254.209.212])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 01:31:09 -0800
Message-ID: <7b18a339-d0e3-4347-a20b-8fca9bbc7eb4@linux.intel.com>
Date: Sun, 18 Feb 2024 17:31:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 1/4] iommu: constify pointer to bus_type
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Clark <robdclark@gmail.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev
References: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/16 22:40, Krzysztof Kozlowski wrote:
> Make pointer to bus_type a pointer to const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> ---
>   drivers/iommu/iommu-priv.h | 5 +++--
>   drivers/iommu/iommu.c      | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

