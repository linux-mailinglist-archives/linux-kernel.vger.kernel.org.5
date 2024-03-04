Return-Path: <linux-kernel+bounces-89951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0386F800
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADF81F21265
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C81854;
	Mon,  4 Mar 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNaPcdNt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411E64D;
	Mon,  4 Mar 2024 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709512962; cv=none; b=j1As81cA1LwONG75j2Jui3UeVUOumaFJ9X5TCe85qmK8XDXVuvYSxZvVhg5z9H6Iy7H2ahdAXF1ulcFIRoqflskhbvV97ZaMG+Wo5L9L82cong2H55RK+tK8rNTupmHMjx4fUax9Y+y/u+4wBh8O+7MOwa3j1dkdWLddkPASyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709512962; c=relaxed/simple;
	bh=EaqFz1aU1LFJy50LAfuxSbt3Xrl9diEj8YEoxK9Kz1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/Jka/Lw1EGOeiIr+yBgz4KccN+oEOtsMEDsmxQXC2jCzgIZ1zHKsJUd+rKBA/LBQ4Lz44CQLkL+QCNmrIJ3gGWEzNzmFe2G47/hWDqLIWsSDLJYanqxEpCJ6lJxZ+0FCmbmDYmhFZQfllg8aVfNSthmmbtJxgTUTCZ3FM2GeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNaPcdNt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709512960; x=1741048960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EaqFz1aU1LFJy50LAfuxSbt3Xrl9diEj8YEoxK9Kz1c=;
  b=JNaPcdNtMd2vXpUUnE9CgwdRYz16U/54CQcCogO4VkoEsrsnQ2Rcd4Uo
   NlGP9ZsKjfPiIOLDowdkD+xqsGgM1/7kGYtCJuNrJk7/gLFf9zFY27CeB
   bRjSBXKF0IlJcXDNNAo6KReAmW1ct/wXKxtTIs/9A9YmzNOWzUk1He6yh
   MRe2tP9VDiixV3x3h1Nc0Qpgo+xI/oQtDxd03NEl05FckEw+aOYzlXySg
   U/JtrLCvOFhSurZWVerj405S7KIUL+g35Ouf0AI6Dc2Wd07OOow86d7/4
   0V10G/mVt8BP11I6DffEPYbKCI82m/WoGQxaAqsTNs8RavZ9pHNoCUpcN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="6939915"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="6939915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 16:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="9257394"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2024 16:42:36 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgwPZ-0002E5-1w;
	Mon, 04 Mar 2024 00:42:33 +0000
Date: Mon, 4 Mar 2024 08:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: Canfeng Zhuang <quic_czhuang@quicinc.com>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Canfeng Zhuang <quic_czhuang@quicinc.com>
Subject: Re: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
Message-ID: <202403040831.fk22ur0f-lkp@intel.com>
References: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>

Hi Canfeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7]

url:    https://github.com/intel-lab-lkp/linux/commits/Canfeng-Zhuang/misc-qualcomm-QRC-driver-for-Robotic-SDK-MCU/20240304-005601
base:   805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
patch link:    https://lore.kernel.org/r/20240304-qcom_qrc-v1-1-2a709f95fd61%40quicinc.com
patch subject: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240304/202403040831.fk22ur0f-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040831.fk22ur0f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040831.fk22ur0f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/misc/qrc/qrc_uart.c:83:24: error: initialization of 'ssize_t (*)(struct serdev_device *, const u8 *, size_t)' {aka 'long int (*)(struct serdev_device *, const unsigned char *, long unsigned int)'} from incompatible pointer type 'int (*)(struct serdev_device *, const unsigned char *, size_t)' {aka 'int (*)(struct serdev_device *, const unsigned char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
      83 |         .receive_buf = qrc_uart_receive,
         |                        ^~~~~~~~~~~~~~~~
   drivers/misc/qrc/qrc_uart.c:83:24: note: (near initialization for 'qrc_serdev_ops.receive_buf')
   cc1: some warnings being treated as errors


vim +83 drivers/misc/qrc/qrc_uart.c

    81	
    82	static struct serdev_device_ops qrc_serdev_ops = {
  > 83		.receive_buf = qrc_uart_receive,
    84		.write_wakeup = qrc_uart_wakeup,
    85	};
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

