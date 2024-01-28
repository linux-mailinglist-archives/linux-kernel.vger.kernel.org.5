Return-Path: <linux-kernel+bounces-41616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C083F569
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F05282AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813F200DE;
	Sun, 28 Jan 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCy8fSza"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663024B41;
	Sun, 28 Jan 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443593; cv=none; b=GDyhbCxEj1ZOoGhmhHxclXj3RTQzLrQXQsF5K0ILshsYR5qLLH7qZ9ABZ0NxhyHpYQWOPkvX03HjFussxVvppHK0VNgQ0E0yFxGCVfCqKRutEqnRvsDaWlKt1RKv1sPISgHY9y4S0eZKei0wKsyNCdZVK0+1wvhEwGVlFmhikis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443593; c=relaxed/simple;
	bh=5HGhh25r1BgSRoDuJplNgMobpaM/J1zwreviykkiK6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC0w3uX/5wvGIfNa7OaNst92H1DpG8QvAPtKdOiJv1sjHCnd+cO8r5Sr+qT0WmzaznS5gPzire4B2Qrui1AxsPRZh7H7Z3sjGIiy7qn0kRe39G3avEWDggbP3iO6e0rCUZNGzLtE8KVaa5o67Y+mvSs9bFyMAOKLYxYjo1WRFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCy8fSza; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706443591; x=1737979591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HGhh25r1BgSRoDuJplNgMobpaM/J1zwreviykkiK6A=;
  b=NCy8fSzaLSsp5/baf0mQiD7W23IwdOvvDhfv7skeTFyKpOo0lzL0QVnH
   Kz62eN7K6kr34B4afaIykBhINhKZGJ8kEJl0OznOTzXp0TfRlpUB2qCrD
   fu4RyYgxbegvb2cAqrFBz+OBdo3YC9ZUDuTgiU2MEb8PGAzqEQVMLOwAR
   7qR6OZJ80Q9ZqrykZcKrhZQWTVyCL/TXbs+hkzFkiLrckxR0DR9TgJB2S
   xKqJE+W0WKpADjm2qj+N4tNq5fndvq6TybGVqb9OHTLgXdNW5D7exf9Ac
   I4mRDfi6f9kv1riurXJy3YAsnMPX5JBvmTEjTZm+7p/YqkkT5LgZTlzCR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2596582"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2596582"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 04:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="21833555"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jan 2024 04:06:26 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU3vc-0003NO-0c;
	Sun, 28 Jan 2024 12:06:24 +0000
Date: Sun, 28 Jan 2024 20:06:07 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for PAC193x
Message-ID: <202401281913.alVFRURI-lkp@intel.com>
References: <20240122084712.11507-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084712.11507-3-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b1a1eaf6183697b77f7243780a25f35c7c0c8bdf]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC193X/20240122-165539
base:   b1a1eaf6183697b77f7243780a25f35c7c0c8bdf
patch link:    https://lore.kernel.org/r/20240122084712.11507-3-marius.cristea%40microchip.com
patch subject: [PATCH v4 2/2] iio: adc: adding support for PAC193x
config: x86_64-randconfig-121-20240128 (https://download.01.org/0day-ci/archive/20240128/202401281913.alVFRURI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281913.alVFRURI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281913.alVFRURI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/pac1934.c:1265:17: sparse: sparse: dubious: x & !y
   drivers/iio/adc/pac1934.c:1266:17: sparse: sparse: dubious: x & !y
   drivers/iio/adc/pac1934.c:1267:17: sparse: sparse: dubious: x & !y
   drivers/iio/adc/pac1934.c:1268:17: sparse: sparse: dubious: x & !y

vim +1265 drivers/iio/adc/pac1934.c

  1233	
  1234	static int pac1934_chip_configure(struct pac1934_chip_info *info)
  1235	{
  1236		int cnt, ret;
  1237		struct i2c_client *client = info->client;
  1238		u8 regs[PAC1934_CTRL_STATUS_INFO_LEN], idx, ctrl_reg;
  1239		u32 wait_time;
  1240	
  1241		info->chip_reg_data.num_enabled_channels = 0;
  1242		for (cnt = 0;  cnt < info->phys_channels; cnt++) {
  1243			if (info->active_channels[cnt])
  1244				info->chip_reg_data.num_enabled_channels++;
  1245		}
  1246	
  1247		/*
  1248		 * read whatever information was gathered before the driver was loaded
  1249		 * establish which channels are enabled/disabled and then establish the
  1250		 * information retrieval mode (using SKIP or no).
  1251		 * Read the chip ID values
  1252		 */
  1253		ret = i2c_smbus_read_i2c_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
  1254						    ARRAY_SIZE(regs),
  1255						    (u8 *)regs);
  1256		if (ret < 0) {
  1257			dev_err_probe(&client->dev, ret,
  1258				      "%s - cannot read regs from 0x%02X\n",
  1259				      __func__, PAC1934_CTRL_STAT_REGS_ADDR);
  1260			return ret;
  1261		}
  1262	
  1263		/* write the CHANNEL_DIS and the NEG_PWR registers */
  1264		regs[PAC1934_CHANNEL_DIS_REG_OFF] =
> 1265			FIELD_PREP(PAC1934_CHAN_DIS_CH1_OFF_MASK, !(info->active_channels[0])) |
  1266			FIELD_PREP(PAC1934_CHAN_DIS_CH2_OFF_MASK, !(info->active_channels[1])) |
  1267			FIELD_PREP(PAC1934_CHAN_DIS_CH3_OFF_MASK, !(info->active_channels[2])) |
  1268			FIELD_PREP(PAC1934_CHAN_DIS_CH4_OFF_MASK, !(info->active_channels[3])) |
  1269			FIELD_PREP(PAC1934_SMBUS_TIMEOUT_MASK, 0) |
  1270			FIELD_PREP(PAC1934_SMBUS_BYTECOUNT_MASK, 0) |
  1271			FIELD_PREP(PAC1934_SMBUS_NO_SKIP_MASK, 0);
  1272	
  1273		regs[PAC1934_NEG_PWR_REG_OFF] =
  1274			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDI_MASK, info->bi_dir[0]) |
  1275			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDI_MASK, info->bi_dir[1]) |
  1276			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDI_MASK, info->bi_dir[2]) |
  1277			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDI_MASK, info->bi_dir[3]) |
  1278			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[0]) |
  1279			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDV_MASK, info->bi_dir[1]) |
  1280			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDV_MASK, info->bi_dir[2]) |
  1281			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDV_MASK, info->bi_dir[3]);
  1282	
  1283		/* no SLOW triggered REFRESH, clear POR */
  1284		regs[PAC1934_SLOW_REG_OFF] = 0;
  1285	
  1286		ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
  1287						  ARRAY_SIZE(regs), (u8 *)regs);
  1288		if (ret)
  1289			return ret;
  1290	
  1291		ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK, info->crt_samp_spd_bitfield);
  1292	
  1293		ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
  1294		if (ret)
  1295			return ret;
  1296	
  1297		/*
  1298		 * send a REFRESH to the chip, so the new settings take place
  1299		 * as well as resetting the accumulators
  1300		 */
  1301		ret = i2c_smbus_write_byte(client, PAC1934_REFRESH_REG_ADDR);
  1302		if (ret) {
  1303			dev_err(&client->dev,
  1304				"%s - cannot send 0x%02X\n",
  1305				__func__, PAC1934_REFRESH_REG_ADDR);
  1306			return ret;
  1307		}
  1308	
  1309		/*
  1310		 * get the current(in the chip) sampling speed and compute the
  1311		 * required timeout based on its value
  1312		 * the timeout is 1/sampling_speed
  1313		 */
  1314		idx = regs[PAC1934_CTRL_ACT_REG_OFF] >> PAC1934_SAMPLE_RATE_SHIFT;
  1315		wait_time = (1024 / samp_rate_map_tbl[idx]) * 1000;
  1316	
  1317		/*
  1318		 * wait the maximum amount of time to be on the safe side
  1319		 * the maximum wait time is for 8sps
  1320		 */
  1321		usleep_range(wait_time, wait_time + 100);
  1322	
  1323		INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1934_work_periodic_rfsh);
  1324		/* Setup the latest moment for reading the regs before saturation */
  1325		schedule_delayed_work(&info->work_chip_rfsh,
  1326				      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
  1327	
  1328		devm_add_action_or_reset(&client->dev, pac1934_cancel_delayed_work,
  1329					 &info->work_chip_rfsh);
  1330	
  1331		return 0;
  1332	}
  1333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

