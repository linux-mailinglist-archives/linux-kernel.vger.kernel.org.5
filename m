Return-Path: <linux-kernel+bounces-89944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532086F7DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A412814D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FEA7BAFD;
	Sun,  3 Mar 2024 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="De8fizQg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC267AE78;
	Sun,  3 Mar 2024 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709508575; cv=none; b=APNLcZ71muCHt8dZ3beybHEoUz4CR2y39mXoBuXZiCNP8gLcPMyH14HjIpvL+tBBCR0A2XwHaSysk+pxQFmcejoIb2R2kFejqUSQ42Umdvjhx1gzwEknm0PinUgpaGk/KbkuWoNUe5W+XqR0j5OYvdcvcKhblKT0DeBBe/H0Rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709508575; c=relaxed/simple;
	bh=CyGQyvmbBBdQkWE0hZjr/baDC3wB1RFELJ1ax71eAF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtvMZefeH4OfnDMkpVwuOdSisQq1mj67drWqOX93UbCiXt6yf14sEBZcELntGf5fwgBUDeFYfwXV8VsKdkw1ydEiADWC2aJuq1fSck1BlwMQOyAUjpu+mI88sUXIclhVdBk3FHNMF9kIEoUDRd8lgxys/6A1XzpkmL2bOg+FF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=De8fizQg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709508574; x=1741044574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CyGQyvmbBBdQkWE0hZjr/baDC3wB1RFELJ1ax71eAF4=;
  b=De8fizQgxmbaM9guD63NEajpunGJQYsomxVlE8wUC0jKGKYUrFL2DmcM
   iz8HisDGIRKHbXaHkYHMMw46V/92yjZn1fPXeS3ounN+4Qgi38tSsZcCA
   Ico9ofi/pITAWGJf2HqJj8kl6iw7R0hDjgSRM8pD891MfBfLKPfMEBK5+
   L4SKT2OrGeD0S+UIxvJQf4zbDR/Gw230ErJwueKSv7EQcSydMV0lkI4Wx
   KkmwqKmtiJnVlG5DC6WdG4LW3eHnryxpQNP7oQfdMjcrR6exEJytZa+d9
   F+vjem3BvtF+Ak7okCnzcbNnNuHnVDQ+GuVrU/fmNg8Oefd2nAq2PRka4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7803783"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="7803783"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 15:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="9370453"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Mar 2024 15:29:30 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgvGp-0002Ao-13;
	Sun, 03 Mar 2024 23:29:27 +0000
Date: Mon, 4 Mar 2024 07:29:22 +0800
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
Message-ID: <202403040745.kD48ZDkC-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7]

url:    https://github.com/intel-lab-lkp/linux/commits/Canfeng-Zhuang/misc-qualcomm-QRC-driver-for-Robotic-SDK-MCU/20240304-005601
base:   805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
patch link:    https://lore.kernel.org/r/20240304-qcom_qrc-v1-1-2a709f95fd61%40quicinc.com
patch subject: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240304/202403040745.kD48ZDkC-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040745.kD48ZDkC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040745.kD48ZDkC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/serdev.h:9,
                    from drivers/misc/qrc/qrc_uart.c:10:
   drivers/misc/qrc/qrc_uart.c: In function 'qrcuart_xmit':
>> drivers/misc/qrc/qrc_uart.c:203:35: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     203 |                 dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/misc/qrc/qrc_uart.c:203:17: note: in expansion of macro 'dev_err'
     203 |                 dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
         |                 ^~~~~~~
   drivers/misc/qrc/qrc_uart.c:203:69: note: format string is defined here
     203 |                 dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
         |                                                                   ~~^
         |                                                                     |
         |                                                                     long int
         |                                                                   %d


vim +203 drivers/misc/qrc/qrc_uart.c

   190	
   191	static enum qrcdev_tx qrcuart_xmit(const char __user  *buf,
   192					   size_t data_length, struct qrc_dev *dev)
   193	{
   194		struct qrcuart *qrc = qrc_get_data(dev);
   195		struct qrc_device_stats *n_stats = &dev->stats;
   196		size_t written;
   197		u8 *pos;
   198	
   199		WARN_ON(qrc->tx_left);
   200	
   201		pos = qrc->tx_buffer + qrc->tx_left;
   202		if ((data_length + qrc->tx_left) > QRC_TX_BUFF_SIZE) {
 > 203			dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
   204			return __QRCDEV_TX_MIN;
   205		}
   206	
   207		if (copy_from_user(pos, buf, data_length))
   208			return __QRCDEV_TX_MIN;
   209	
   210		pos += data_length;
   211	
   212		spin_lock(&qrc->lock);
   213	
   214		written = serdev_device_write_buf(qrc->serdev, qrc->tx_buffer,
   215						  pos - qrc->tx_buffer);
   216		if (written > 0) {
   217			qrc->tx_left = (pos - qrc->tx_buffer) - written;
   218			qrc->tx_head = qrc->tx_buffer + written;
   219			n_stats->tx_bytes += written;
   220		}
   221	
   222		spin_unlock(&qrc->lock);
   223	
   224		return QRCDEV_TX_OK;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

