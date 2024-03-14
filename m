Return-Path: <linux-kernel+bounces-102895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30687B81E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC951C223A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FA8BF6;
	Thu, 14 Mar 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPyrTpy0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A6522D;
	Thu, 14 Mar 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399447; cv=none; b=jBkVIQAcWvCVPEkJVZpeURoP0BY4fiKuZLvHosOqtEVzD/sBDWG74MXhi6ykukzvLT3IQTnFFLjM8cSGCDcpGuASnXJsgG3GpI2ntxH452tDQzZ9omt/JpNjY3NPaPjdVOPff7Meles9iuybMI9fGQ6nh6wuax66RU7faDxu6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399447; c=relaxed/simple;
	bh=tiBtaMmoMsw7Uh+LzBp2iNShBcSw/aBjTzqAHjXsZQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljpv8bzHpmcvVWVgSAXk26yHNWrZhzzJDXfWe0tr8hJFEQlnPiVS0UCPiAGwxi1RCn8/4akO1b41shWv873PvuRDbgmXVuG5IxzB3xnhs3Uzp5Z/MP/B4jctKGbVWWBOZHpz5vRIAg+ntCo49EKoBH/AfSTmfBjv+GnropENLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPyrTpy0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710399445; x=1741935445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tiBtaMmoMsw7Uh+LzBp2iNShBcSw/aBjTzqAHjXsZQs=;
  b=mPyrTpy0a+aDLinTQn+2TTgINy8nCK+t1D6FlAzI4/Njl2Swsz3018xN
   Ard+YFHO8pN24Ui3R1ImLaqayS45P24MQz02KIBc5hXY+1jstIhPDB7a1
   KKIPH+Fu46t14k/P4bzzc13pgTuVk0SUK6GqYpQAMGCtEkkAvjL8JMt3m
   hdFciyjiCOEvFVP6Ic4Y4p6UyzHWzG9BkD+9Hfvw4i8hFcsNhIhBgVaZQ
   VqVNIb37LNiE6d4s+CQKzfsxTEqOibOHnDYJEmZeoCv46ubO97kWuEBO9
   RgInxV39Pbrc27u0hb3lOGSmUihxktgvzU7LEe9uBDVqhcsH3VLVAZQTv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="27675657"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="27675657"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 23:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12588920"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Mar 2024 23:57:21 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkf1h-000DBT-1i;
	Thu, 14 Mar 2024 06:57:17 +0000
Date: Thu, 14 Mar 2024 14:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	willl will <will@willwhang.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	tomi.valkeinen@ideasonboard.com,
	Umang Jain <umang.jain@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
Message-ID: <202403141436.KEQj1YzE-lkp@intel.com>
References: <20240313070705.91140-3-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313070705.91140-3-umang.jain@ideasonboard.com>

Hi Umang,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linuxtv-media-stage/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-dt-bindings-media-Add-bindings-for-IMX283/20240313-151107
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20240313070705.91140-3-umang.jain%40ideasonboard.com
patch subject: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240314/202403141436.KEQj1YzE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403141436.KEQj1YzE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403141436.KEQj1YzE-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/tplink_safeloader.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/spmi-pmic-arb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_pruss.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82365.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/ingenic-adc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/oss/dmasound/dmasound_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/oss/dmasound/dmasound_atari.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/oss/dmasound/dmasound_paula.o
WARNING: modpost: sound/oss/dmasound/dmasound_paula: section mismatch in reference: amiga_audio_driver+0x8 (section: .data) -> amiga_audio_remove (section: .exit.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/core/snd-pcm-dmaengine.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/drivers/snd-pcmtest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/pci/hda/snd-hda-cirrus-scodec-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/soc-topology-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-soc-ab8500-codec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-soc-sigmadsp.o
WARNING: modpost: sound/soc/codecs/snd-soc-tlv320adc3xxx: section mismatch in reference: adc3xxx_i2c_driver+0x8 (section: .data) -> adc3xxx_i2c_remove (section: .exit.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-soc-wm-adsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-dma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/mxs/snd-soc-mxs-pcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/qdsp6/snd-q6dsp-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/intel/snd-sof-intel-atom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/intel/snd-sof-acpi-intel-byt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/intel/snd-sof-acpi-intel-bdw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/imx/snd-sof-imx8.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/imx/snd-sof-imx8m.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/imx/snd-sof-imx8ulp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/imx/imx-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/mediatek/mtk-adsp-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/mediatek/mt8195/snd-sof-mt8195.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/mediatek/mt8186/snd-sof-mt8186.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/snd-sof-utils.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/snd-sof-acpi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/snd-sof-of.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/xilinx/snd-soc-xlnx-i2s.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/xilinx/snd-soc-xlnx-formatter-pcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/ac97_bus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mtty.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mdpy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mdpy-fb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/vfio-mdev/mbochs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/configfs/configfs_sample.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/bytestream-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/dma-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/inttype-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/record-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kobject/kobject-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kobject/kset-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_cmp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_nbyte.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_u32.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_meta.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_text.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_canid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ipip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ah4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_algo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ah6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/esp6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/xfrm6_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/tunnel6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/mip6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/sit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ip6_udp_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/key/af_key.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/mpoa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/6lowpan/6lowpan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/6lowpan/ieee802154_6lowpan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/ieee802154_socket.o
>> ERROR: modpost: "__udivdi3" [drivers/media/i2c/imx283.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

