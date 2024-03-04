Return-Path: <linux-kernel+bounces-89993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832B86F8BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE6E1F2171E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08902CA4;
	Mon,  4 Mar 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltsoV4Bv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BC63DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521208; cv=none; b=H7OZGh/qK6z/wx5lJBp+k5qdhBLCkzCqe3228FU/g+NHaOpqK1bqF2zpZDaLP8m1xoBuXpBZZE+sNqu2lq4Bpe/HniFepmynGhfpf4xh5wgM/rxsygZEbhJ+yKYtmCq8suQ3WcTY4ID5V20hDCn8FNIeBHtL0XHs7bWlahS6IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521208; c=relaxed/simple;
	bh=c2Vi9fIkjTQ90K5e3JM+WiE51SJGyWOmrkvaQ1LNIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B1CH6HyxBFWkUexHGhHjymCV9YHUtrOALimkWS5g3U7m+Hz7MegHaXPVpGEsVCGTXnFC43iNKYQgeb7NZs9pA22alfSN2QBJQA3hUtab4/m/Vk8V8GzMx6B6VEpCzpb0h3VJ9Tb68iaSDe36GPYObrlMOqDO239GU1j9uG3Ws7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltsoV4Bv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709521206; x=1741057206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c2Vi9fIkjTQ90K5e3JM+WiE51SJGyWOmrkvaQ1LNIC4=;
  b=ltsoV4Bvi5ljgtUfAwpIhpMKTDAGrVem9pxOav8LopsTJLDmDloLhs6B
   Q563wHB3nWvH2gIubNSjiSead/lrEMtiO4ndj0gpVTW08Skj4MfZCIGRx
   hqlXMRP0O6xs5HRuxJx51FNGq7pCId70+Skt0kB1nyzHesY1HWgwlfkbW
   t8a5QFBKkvnmDJFuWhNUl7X84qbjhoEj52fyZBj2pzbb/Aqk4lUyMeDLV
   C0ZLSOmgMWpoZHWCvbfW7GI4esv6C71K1y2s+M1dRRnxS5uFdTTP5EzBo
   Nqx8Wz6FA00bWSy8cnjB78jMAhlPQs50jeZtyKql8xq2l6O5Elsq/Rf7j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4573269"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4573269"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 19:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13498488"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2024 19:00:02 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgyYZ-0002IT-2w;
	Mon, 04 Mar 2024 02:59:59 +0000
Date: Mon, 4 Mar 2024 10:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: George Stark <gnstark@sberdevices.ru>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: WARNING: modpost: "strcpy" [drivers/iio/adc/meson_saradc.ko] has no
 CRC!
Message-ID: <202403041010.vzeCY1aN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit: b593ce5db22483dd66405861ac3f782e5a7cd9f3 iio: adc: meson: add channel labels
date:   8 months ago
config: alpha-randconfig-r001-20230205 (https://download.01.org/0day-ci/archive/20240304/202403041010.vzeCY1aN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403041010.vzeCY1aN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403041010.vzeCY1aN-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "strcpy" [fs/hpfs/hpfs.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strcat" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "strcpy" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "strncpy" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpio/gpio-sim.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/backlight/backlight.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/soc/qcom/cmd-db.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/radeon/radeon.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/mgag200/mgag200.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/ast/ast.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/etnaviv/etnaviv.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/target/target_core_pscsi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/target/sbp/sbp_target.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/spi/spi-butterfly.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/spi/spi-lm70llp.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/phy/libphy.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/phy/fixed_phy.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/phy/smsc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/mdio/mdio-xgene.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/net/hamradio/baycom_ser_fdx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/hamradio/baycom_ser_fdx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/hamradio/baycom_ser_hdx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/net/hamradio/baycom_ser_hdx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/broadcom/b43/b43.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/broadcom/brcm80211/brcmutil/brcmutil.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcmsmac.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/intel/ipw2x00/ipw2100.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/intel/ipw2x00/ipw2200.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/intel/ipw2x00/ipw2200.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwifiex/mwifiex.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwifiex/mwifiex_pcie.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/ti/wlcore/wlcore.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/ti/wlcore/wlcore.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/ti/wl1251/wl1251.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/ti/wl18xx/wl18xx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wwan/rpmsg_wwan_ctrl.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/tun.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/thunderbolt/thunderbolt_net.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-qcom-cci.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-sprd.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/media/dvb-frontends/cxd2841er.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/power/supply/wm831x_power.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/charger-manager.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq24190_charger.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/raid1.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/raid10.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/md-cluster.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/md/bcache/bcache.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/md-mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/md/md-mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hid/uhid.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid-wiimote.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid-sensor-custom.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/rtl8192e/rtllib.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/rtl8192e/rtllib.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/rtl8723bs/r8723bs.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/rts5208/rts5208.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/iio/adc/ad7816.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/iio/addac/adt7316.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/iio/impedance-analyzer/ad5933.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/greybus/gb-firmware.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/greybus/gb-loopback.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/greybus/gb-arche.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/vc04_services/vchiq.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/vc04_services/vchiq-mmal/bcm2835-mmal-vchiq.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/perf/arm_smmuv3_pmu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/perf/arm_dmc620_pmu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/intel_th/intel_th.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/intel_th/intel_th_gth.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/rapidio/rapidio.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/input/keyboard/atkbd.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/adcxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/adt7475.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/gpio-fan.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/i5k_amb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/nct7802.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/greybus/greybus.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/rpmsg/rpmsg_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/rpmsg/rpmsg_ns.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/rpmsg/virtio_rpmsg_bus.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/soundwire/soundwire-bus.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/accel/sca3000.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/adc/hx711.ko] has no CRC!
>> WARNING: modpost: "strcpy" [drivers/iio/adc/meson_saradc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/adc/mxs-lradc-adc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/iio/adc/stm32-adc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/light/cm32181.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/light/tsl2583.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/thunderbolt/thunderbolt.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/thunderbolt/thunderbolt.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/fpga/fpga-mgr.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/fpga/dfl-fme.ko] has no CRC!
WARNING: modpost: "strncpy" [net/xfrm/xfrm_user.ko] has no CRC!
WARNING: modpost: "strcpy" [net/xfrm/xfrm_user.ko] has no CRC!
WARNING: modpost: "strcpy" [net/ipv6/ip6_tunnel.ko] has no CRC!
WARNING: modpost: "strcpy" [net/wireless/cfg80211.ko] has no CRC!
WARNING: modpost: "strcpy" [net/key/af_key.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rose/rose.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rfkill/rfkill.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

