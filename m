Return-Path: <linux-kernel+bounces-31953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A59835429
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B85AB21696
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C636128;
	Sun, 21 Jan 2024 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QauSL30y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702153610A;
	Sun, 21 Jan 2024 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705802825; cv=none; b=W4pvHIJ1KSSJqphLi6mD7L/5Sb4Iy+DpciKxckJbVIntX6+bSIAnbjAwyv3Gk8VCQRoQrDu/aJjBZU0HsbpX4bGAMJyjXP1fkTre4i5XDV4jZYy+tXsIhATeiCpmyVrWWRgSuVLNygarLWsijKqMfYnlIK7dQ+AEfbI9X+s6dRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705802825; c=relaxed/simple;
	bh=SYFDB18YSASADrg7kQUk2ZYfq0PEGYsVZP7Xd6Nm+3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am3dEsel1rtRy8a6+UNlY8dfpXNX1ORlF34ZPdlESEiGEor+C+cwbXIWHjN7JYT/nzdZIRFLYg7WGZFThlr0eGe28ZHHG4FmvTKFifIaKbaJicMcPJPd0eIoOERAhjWDiWTDwRY7nGJY3M8lPbbCMOdSk+1+92YBlo3yvqPgyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QauSL30y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705802824; x=1737338824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SYFDB18YSASADrg7kQUk2ZYfq0PEGYsVZP7Xd6Nm+3s=;
  b=QauSL30yLYcKxEAMUR7n5YsiVGxmCsd7mdHHCr779ThhMYo7CX9Guq2L
   ihkgIKa2uLy+MB7rs5rSUdSqoe51cB4T9dxJkO1jQamfBGjMGnHctvOSA
   DhtwUSDaakiYBDuNMWCjK/qX9jezgdygHKRUAr0xfme1Pj9unTbFW/MJ6
   mz0QSg2Y7hXfE01hKQtJKVAL3YhW9FlD37JUl+hJRAMgAeuF7F4gFd4Oq
   g9HalXhkXlVsn/nFjFX8Ih1xMCc4PBLlfK1ARjEwRmisj9L2lTlfg8MdU
   wK+UzEehzuaLz0/tQFl50++S0ppM+pYQf+gVKPRz+vMyR5QaPBXXlNZDt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="863136"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="863136"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 18:07:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="958419171"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="958419171"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2024 18:06:58 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRNEe-0005bG-1u;
	Sun, 21 Jan 2024 02:06:56 +0000
Date: Sun, 21 Jan 2024 10:05:56 +0800
From: kernel test robot <lkp@intel.com>
To: Amrit Anand <quic_amrianan@quicinc.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	kernel@quicinc.com, Amrit Anand <quic_amrianan@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
Message-ID: <202401210920.aPy2DJwj-lkp@intel.com>
References: <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>

Hi Amrit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Amrit-Anand/dt-bindings-hwinfo-Introduce-board-id/20240120-192358
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1705749649-4708-3-git-send-email-quic_amrianan%40quicinc.com
patch subject: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240121/202401210920.aPy2DJwj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401210920.aPy2DJwj-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/hwinfo/board-id.yaml:23:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
   Documentation/devicetree/bindings/hwinfo/board-id.yaml:25:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
>> Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml:70:4: [warning] wrong indentation: expected 2 but found 3 (indentation)

vim +70 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml

    68	
    69	examples:
  > 70	   - |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

