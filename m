Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAD761E57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGYQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGYQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:21:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465BDFD;
        Tue, 25 Jul 2023 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690302087; x=1721838087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0OasnjKOD3DXt993jhCeH30cDw19eOOCFg/dQ9cwwO4=;
  b=MxNdEbEOT7TwsRgCMdBcgrrr02OeVpmc4VbKdLcyqYduHX7e301b8m+B
   t7mnamzTNMedRKOMfkE49+RNsSwWp+c4h49XJo2wX8uZ8MSAcV1AcfWi1
   ua73543ahmW0AzoKQg2KfYIFa52s1H2Lach8LWn4nfc52JSIT5XZbIqus
   xDe+Kqul/KnCRPnWefFdt1GDU5d5xYMaViHT0Vtt/0gwoQiz4uLJTgtiM
   zvhAVI51d/EElxbsGmRa8JxNYoQDjzuebFzIsNmp9XqVl6jbtLGQWBPSA
   w+d7Z9Kva7KkRM6h1ri6oKslK9wX50+8s2h1tZB08L91PD3+NZK4lAt26
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370448821"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="370448821"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 09:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="720104629"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720104629"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 09:21:24 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOKm8-00008Z-1s;
        Tue, 25 Jul 2023 16:21:22 +0000
Date:   Wed, 26 Jul 2023 00:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
Message-ID: <202307260005.nDX1xks3-lkp@intel.com>
References: <20230725114030.1860571-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725114030.1860571-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 55612007f16b5d7b1fb83a7b0f5bb686829db7c7]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-pmbus-Add-ON_OFF_CONFIG-register-bits/20230725-194318
base:   55612007f16b5d7b1fb83a7b0f5bb686829db7c7
patch link:    https://lore.kernel.org/r/20230725114030.1860571-3-Naresh.Solanki%409elements.com
patch subject: [PATCH 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in SVID mode
config: riscv-randconfig-r042-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260005.nDX1xks3-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260005.nDX1xks3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260005.nDX1xks3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/pmbus/tda38640.c: In function 'tda38640_probe':
>> drivers/hwmon/pmbus/tda38640.c:118:14: error: 'CONFIG_SENSORS_TDA38640_REGULATOR' undeclared (first use in this function); did you mean 'CONFIG_SENSORS_TDA38640'?
     118 |         if (!CONFIG_SENSORS_TDA38640_REGULATOR || !np ||
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |              CONFIG_SENSORS_TDA38640
   drivers/hwmon/pmbus/tda38640.c:118:14: note: each undeclared identifier is reported only once for each function it appears in


vim +118 drivers/hwmon/pmbus/tda38640.c

   106	
   107	static int tda38640_probe(struct i2c_client *client)
   108	{
   109		struct device *dev = &client->dev;
   110		struct device_node *np = dev_of_node(dev);
   111		struct tda38640_data *data;
   112	
   113		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
   114		if (!data)
   115			return -ENOMEM;
   116		memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
   117	
 > 118		if (!CONFIG_SENSORS_TDA38640_REGULATOR || !np ||
   119		    of_property_read_u32(np, "infineon,en-pin-fixed-level", &data->en_pin_lvl))
   120			return pmbus_do_probe(client, &data->info);
   121	
   122		/*
   123		 * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
   124		 * OPERATION register doesn't work in SVID mode.
   125		 */
   126		data->info.read_byte_data = tda38640_read_byte_data;
   127		data->info.write_byte_data = tda38640_write_byte_data;
   128		/*
   129		 * One should configure PMBUS_ON_OFF_CONFIG here, but
   130		 * PB_ON_OFF_CONFIG_POWERUP_CONTROL, PB_ON_OFF_CONFIG_EN_PIN_REQ and
   131		 * PB_ON_OFF_CONFIG_EN_PIN_REQ are ignored by the device.
   132		 * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
   133		 */
   134	
   135		return pmbus_do_probe(client, &data->info);
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
