Return-Path: <linux-kernel+bounces-70282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083185958E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EA71F214DA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD3FBEA;
	Sun, 18 Feb 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0q2WsUM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA4EAEB;
	Sun, 18 Feb 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244125; cv=none; b=GGWBsMmkq8fwn6iagOu6fWG3PvAs0ujYjqlsm0YNg/K4NRkOp76O37Y0KRgQ86qpXgofn/bxUktMU1rGIV2xrpIMo3NHzEMJBGW7oHzJ7PV6jR9chqDWs/k+mlTsPZ1+kKe5lTICQD3TbWF4fydsVzK/sRq91Ym3XeM2GBzbpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244125; c=relaxed/simple;
	bh=nIUi3+5qE2Fu+BpbvRSLMr1JZHmcSqsOnohOrMctUSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWM+eb99wJcC7GQ21d4UdUoDzRbI9Y4Ygv++qeKBg5vxkd4fqYXRfNEoJH7EBzlqTPLoPWsIhsbtiZinQ6VpM3wxXQHCUjOunNNnvFyViP5JUP0NGaltO+8G6yCqcPc+Azw/0ytNBq4sTvjVYIXraoRPYBGEcZSnpS6Iv2kCkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0q2WsUM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708244124; x=1739780124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIUi3+5qE2Fu+BpbvRSLMr1JZHmcSqsOnohOrMctUSA=;
  b=e0q2WsUMnMpsT8ZRkKNNfpe/cP8B2Ynvtxsj25mCfoDv9qXrLFNJkFxQ
   qW47CJXfL6HlHrL5zJEjg5ypI+NVXu4UsfvdoJ/rGbBTfVODEXN0Oxk9q
   i56H9Jodie6W5wv4iv3K5cTOlUj5FniNmGtHNYe2pg8usELz+7LcwmDFc
   8DWHTvjgLqMoVgolQbn4WY5vnMgbLmYbEH9OYD02rOGhFkFJCBo4/kzKY
   8z6Wl0D8ee+axhBTq7LUxUy6TkNzEKfPgnvntCKM6tVH/GJ5Bq+kEebwT
   dJ0r+uegW8kwh1NIRpgDBn00o4iYlQI/YQoLBLN32voEkqZGLV/Y1SxN1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2199076"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2199076"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="35259770"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2024 00:15:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbcKR-0002tA-2n;
	Sun, 18 Feb 2024 08:15:15 +0000
Date: Sun, 18 Feb 2024 16:14:38 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
	konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_srichara@quicinc.com, quic_varada@quicinc.com,
	quic_mdalam@quicinc.com
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Message-ID: <202402181614.N6WuWtRU-lkp@intel.com>
References: <20240215134856.1313239-4-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215134856.1313239-4-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240215]
[also build test ERROR on linus/master v6.8-rc4]
[cannot apply to mtd/nand/next broonie-spi/for-next robh/for-next v6.8-rc4 v6.8-rc3 v6.8-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-add-binding-doc-for-spi-qpic-snand/20240215-215348
base:   next-20240215
patch link:    https://lore.kernel.org/r/20240215134856.1313239-4-quic_mdalam%40quicinc.com
patch subject: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240218/202402181614.N6WuWtRU-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402181614.N6WuWtRU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402181614.N6WuWtRU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-qpic-snand.c:161:7: warning: variable 'ecc_user' set but not used [-Wunused-but-set-variable]
           bool ecc_user = false;
                ^
   drivers/spi/spi-qpic-snand.c:160:35: warning: variable 'desired_correction' set but not used [-Wunused-but-set-variable]
           int step_size = 0, strength = 0, desired_correction = 0, steps;
                                            ^
   drivers/spi/spi-qpic-snand.c:399:6: warning: variable 'oob_buf' set but not used [-Wunused-but-set-variable]
           u8 *oob_buf;
               ^
   drivers/spi/spi-qpic-snand.c:452:30: warning: variable 'erased' set but not used [-Wunused-but-set-variable]
           bool serial_op_err = false, erased;
                                       ^
>> drivers/spi/spi-qpic-snand.c:682:16: error: assigning to 'u8 *' (aka 'unsigned char *') from 'const void *const' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   snandc->wbuf = op->data.buf.out;
                                ^ ~~~~~~~~~~~~~~~~
   4 warnings and 1 error generated.


vim +682 drivers/spi/spi-qpic-snand.c

   671	
   672	static int qpic_snand_write_page_cache(struct qcom_nand_controller *snandc,
   673					       const struct spi_mem_op *op)
   674	{
   675		struct qpic_snand_op s_op = {};
   676		u32 cmd;
   677	
   678		cmd = qpic_snand_cmd_mapping(snandc, op->cmd.opcode);
   679		s_op.cmd_reg = cmd;
   680	
   681		if (op->cmd.opcode == SPINAND_PROGRAM_LOAD) {
 > 682			snandc->wbuf = op->data.buf.out;
   683			snandc->wlen = op->data.nbytes;
   684		}
   685	
   686		return 0;
   687	}
   688	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

