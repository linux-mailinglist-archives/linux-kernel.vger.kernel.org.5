Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948D17687A1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjG3Tol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjG3Toh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:44:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1619AC;
        Sun, 30 Jul 2023 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690746253; x=1722282253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjdNexIQe3xd5lo8mFEIfQ/m0eBrLTeOcFw9xalhEdw=;
  b=hfNFaBc/RBM+MkPUuhpuGU+wKFynWoF3JUpUknMG15XpbgW4Zh7YTwUZ
   OmtpFTCA/nvAwm3U8o8rPX/+a8tO0IG/JFz+zv6LcD4uSZu8rnMB+gKmj
   j+TlCDMw16ba1Gur3zngvjfPBNH8s+lrbufJhcvssnZxJGTJsbEKKWGr4
   PhqHqMgjfdiy25BwoygSAx67TGew5NJeJly/g95WpFul4O9+6pfjeV/jY
   741mwol5fhv22x1d3qmw3ycfu+hpoPpFo3174KxaS4DnKRvnfxCQp0K6N
   QgcjuOqL93fQvjZKjTqbii7WPp6u/B5Aqc1PS8HnkcpzKvoOBRIhlxumo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="366351083"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="366351083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 12:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="841968894"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="841968894"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2023 12:43:45 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQCKO-0004kt-0o;
        Sun, 30 Jul 2023 19:43:44 +0000
Date:   Mon, 31 Jul 2023 03:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power: max17040: get thermal data from adc if
 available
Message-ID: <202307310322.iEuhtMME-lkp@intel.com>
References: <20230730172648.71578-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730172648.71578-4-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk-dt/for-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230728]
[cannot apply to sre-power-supply/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230731-012920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git for-next
patch link:    https://lore.kernel.org/r/20230730172648.71578-4-clamor95%40gmail.com
patch subject: [PATCH v2 3/3] power: max17040: get thermal data from adc if available
config: s390-randconfig-r044-20230731 (https://download.01.org/0day-ci/archive/20230731/202307310322.iEuhtMME-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310322.iEuhtMME-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310322.iEuhtMME-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_probe':
>> drivers/power/supply/max17040_battery.c:483: undefined reference to `devm_iio_channel_get'
   s390x-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_get_property':
>> drivers/power/supply/max17040_battery.c:413: undefined reference to `iio_read_channel_processed_scale'


vim +483 drivers/power/supply/max17040_battery.c

   385	
   386	static int max17040_get_property(struct power_supply *psy,
   387				    enum power_supply_property psp,
   388				    union power_supply_propval *val)
   389	{
   390		struct max17040_chip *chip = power_supply_get_drvdata(psy);
   391	
   392		switch (psp) {
   393		case POWER_SUPPLY_PROP_ONLINE:
   394		case POWER_SUPPLY_PROP_PRESENT:
   395			val->intval = max17040_get_online(chip);
   396			break;
   397		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   398			val->intval = max17040_get_vcell(chip);
   399			break;
   400		case POWER_SUPPLY_PROP_CAPACITY:
   401			val->intval = max17040_get_soc(chip);
   402			break;
   403		case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
   404			val->intval = chip->low_soc_alert;
   405			break;
   406		case POWER_SUPPLY_PROP_STATUS:
   407			power_supply_get_property_from_supplier(psy, psp, val);
   408			break;
   409		case POWER_SUPPLY_PROP_TEMP:
   410			if (!chip->channel_temp)
   411				return -ENODATA;
   412	
 > 413			iio_read_channel_processed_scale(chip->channel_temp,
   414							 &val->intval, 10);
   415			break;
   416		default:
   417			return -EINVAL;
   418		}
   419		return 0;
   420	}
   421	
   422	static const struct regmap_config max17040_regmap = {
   423		.reg_bits	= 8,
   424		.reg_stride	= 2,
   425		.val_bits	= 16,
   426		.val_format_endian = REGMAP_ENDIAN_BIG,
   427	};
   428	
   429	static enum power_supply_property max17040_battery_props[] = {
   430		POWER_SUPPLY_PROP_ONLINE,
   431		POWER_SUPPLY_PROP_PRESENT,
   432		POWER_SUPPLY_PROP_VOLTAGE_NOW,
   433		POWER_SUPPLY_PROP_CAPACITY,
   434		POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
   435		POWER_SUPPLY_PROP_STATUS,
   436		POWER_SUPPLY_PROP_TEMP,
   437	};
   438	
   439	static const struct power_supply_desc max17040_battery_desc = {
   440		.name			= "battery",
   441		.type			= POWER_SUPPLY_TYPE_BATTERY,
   442		.get_property		= max17040_get_property,
   443		.set_property		= max17040_set_property,
   444		.property_is_writeable  = max17040_prop_writeable,
   445		.properties		= max17040_battery_props,
   446		.num_properties		= ARRAY_SIZE(max17040_battery_props),
   447	};
   448	
   449	static int max17040_probe(struct i2c_client *client)
   450	{
   451		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   452		struct i2c_adapter *adapter = client->adapter;
   453		struct power_supply_config psy_cfg = {};
   454		struct max17040_chip *chip;
   455		enum chip_id chip_id;
   456		bool enable_irq = false;
   457		int ret;
   458	
   459		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
   460			return -EIO;
   461	
   462		chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
   463		if (!chip)
   464			return -ENOMEM;
   465	
   466		chip->client = client;
   467		chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
   468		if (IS_ERR(chip->regmap))
   469			return PTR_ERR(chip->regmap);
   470		chip_id = (enum chip_id) id->driver_data;
   471		if (client->dev.of_node) {
   472			ret = max17040_get_of_data(chip);
   473			if (ret)
   474				return ret;
   475			chip_id = (uintptr_t)of_device_get_match_data(&client->dev);
   476		}
   477		chip->data = max17040_family[chip_id];
   478	
   479		i2c_set_clientdata(client, chip);
   480		psy_cfg.drv_data = chip;
   481	
   482		/* Switch to devm_iio_channel_get_optional when available  */
 > 483		chip->channel_temp = devm_iio_channel_get(&client->dev, "temp");
   484		if (IS_ERR(chip->channel_temp)) {
   485			ret = PTR_ERR(chip->channel_temp);
   486			if (ret != -ENODEV)
   487				return dev_err_probe(&client->dev, PTR_ERR(chip->channel_temp),
   488						     "failed to get temp\n");
   489			else
   490				chip->channel_temp = NULL;
   491		}
   492	
   493		chip->battery = devm_power_supply_register(&client->dev,
   494					&max17040_battery_desc, &psy_cfg);
   495		if (IS_ERR(chip->battery)) {
   496			dev_err(&client->dev, "failed: power supply register\n");
   497			return PTR_ERR(chip->battery);
   498		}
   499	
   500		ret = max17040_get_version(chip);
   501		if (ret < 0)
   502			return ret;
   503		dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", ret);
   504	
   505		if (chip_id == ID_MAX17040 || chip_id == ID_MAX17041)
   506			max17040_reset(chip);
   507	
   508		max17040_set_rcomp(chip, chip->rcomp);
   509	
   510		/* check interrupt */
   511		if (client->irq && chip->data.has_low_soc_alert) {
   512			ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
   513			if (ret) {
   514				dev_err(&client->dev,
   515					"Failed to set low SOC alert: err %d\n", ret);
   516				return ret;
   517			}
   518	
   519			enable_irq = true;
   520		}
   521	
   522		if (client->irq && chip->data.has_soc_alert) {
   523			ret = max17040_set_soc_alert(chip, 1);
   524			if (ret) {
   525				dev_err(&client->dev,
   526					"Failed to set SOC alert: err %d\n", ret);
   527				return ret;
   528			}
   529			enable_irq = true;
   530		} else {
   531			/* soc alerts negate the need for polling */
   532			INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
   533			ret = devm_add_action(&client->dev, max17040_stop_work, chip);
   534			if (ret)
   535				return ret;
   536			max17040_queue_work(chip);
   537		}
   538	
   539		if (enable_irq) {
   540			ret = max17040_enable_alert_irq(chip);
   541			if (ret) {
   542				client->irq = 0;
   543				dev_warn(&client->dev,
   544					 "Failed to get IRQ err %d\n", ret);
   545			}
   546		}
   547	
   548		return 0;
   549	}
   550	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
