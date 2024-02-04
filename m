Return-Path: <linux-kernel+bounces-51559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB9848C7B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DF1B2224B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC818B1A;
	Sun,  4 Feb 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guG1s1xW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3918AF4;
	Sun,  4 Feb 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039146; cv=none; b=GXoE7hgY5bHBgO4bAMqgvfuw0eGB0ir6J43aASqvoWQ8iT1PUtVBBFcyLrkNBym0cVGXi3OkYWAAcdknJu3XquaspMtWcNwm5DsLg5LUhyFEze9Zo6Hc3ap22YUpw1P+djY6ruTRgg/hsHvMiqwLs9T3c2HzXyK0e8920PAgivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039146; c=relaxed/simple;
	bh=4HfFIjzTJXK5+dvzfP1F90fWe6JyO8lLx8Fekvj1EY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAtewaOmHYupNwyF/LpibhSK8r4DDnIH7+Af+CqnOK/0xuJxr430bOKj7hmZez13d7Gb2vV+2ZSqQty0/EcYVTutxvFmgf6WYXcBHcqGYR8fN2UgMJNsC+W4ZD4fgk7WT2LpQARPJ8f8wQaLnJgDXwWGadyxnKr8MwxZOzc7K6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guG1s1xW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707039144; x=1738575144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4HfFIjzTJXK5+dvzfP1F90fWe6JyO8lLx8Fekvj1EY4=;
  b=guG1s1xWJ6QjuPJusDnLLn6tsGeoePbnujwdDAn0b4FBcFxja08Sgmf0
   CIGtMysMRsKDOOZNOwaeQkNLOVjmFjY36+aqEz0gjKlCKDwn2JtM/Oh8L
   6j9/uS8yMZMGXdwZPvuBfxXDb2bphIjrZ/vk0PaP70+SDjtQc+aGOr50v
   qAA/he1UimARKOkB1NNiC7duJ1O8ANDArE9cnLQNuXsV7m0c3/q6Xj5kZ
   BvxFnDH9VMoYkhuYHMPn04PcpSOCYs5LSEtnNLBaJEdHgbGuKGy8Bh7qJ
   nguJlh8xmyCJOlYEXb6ivseXp1YOhPL90Cv9gep/yRp2fBHsQ9OtRzy57
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="10970035"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="10970035"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 01:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="469101"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Feb 2024 01:32:20 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWYrJ-0006Cm-0X;
	Sun, 04 Feb 2024 09:32:17 +0000
Date: Sun, 4 Feb 2024 17:31:47 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	wenst@chromium.org, hsinyi@chromium.org, nfraprado@collabora.com,
	macpaul.lin@mediatek.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	stephen@radxa.com, tom@radxa.com
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce the MT8395 Radxa
 NIO 12L board
Message-ID: <202402041754.SHJCpnEP-lkp@intel.com>
References: <20240202114821.79227-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202114821.79227-3-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-arm64-mediatek-Add-MT8395-Radxa-NIO-12L-board-compatible/20240202-195207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240202114821.79227-3-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 2/2] arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240204/202402041754.SHJCpnEP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041754.SHJCpnEP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041754.SHJCpnEP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts:791.1-8 Label or path ssusb0 not found
>> Error: arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts:804.1-8 Label or path ssusb2 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

