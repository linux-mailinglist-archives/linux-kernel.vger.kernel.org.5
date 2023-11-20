Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E197F122A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjKTLff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjKTLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:35:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46E10D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:35:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50a938dda08so6036467e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700480107; x=1701084907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnHXXBG/PcSIOhkoJ9kEnpC6kzNN9AjZ6LY10zqo+h0=;
        b=OkzZomg3mm3SnDgawRoHg0LjYZ65kjkK8Gq/OKkPk2jjp0DSrQ//u8NihcHHv22SR5
         80l7VRiYkrFZmfc5RgF/kuJ47w+WIH0LEHrIz4JyhvnIzRlXIEoZ782D8Ik+roLoT4E7
         JHc4IFUbJVMpIFnwycfVpqogMDNBmLSRlmIMv7lGDld1GKA/Sger4khVtAEy9DeGp9vg
         aHdfXxSouKPyLsl4z3C473J2PQ3ShoJSPSo2SzRRnJi6xYKU+uKQs3HPV3c+rREZ584C
         wlNiQa0dknIQD4Z82ceWkWx+ItjQjWKYxiaxpG/fF0JoJewmBUVXzjJ0Wp8Gy6DE6BGW
         1w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700480107; x=1701084907;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnHXXBG/PcSIOhkoJ9kEnpC6kzNN9AjZ6LY10zqo+h0=;
        b=i4fzvdl1hF4XpuvPk5q5UgeOj3IQ+KH2BoSUHvCJ06NkO7A+SVRQwUfyI91p8lSAUp
         31MbhGnQF+0YoqUuvqEH0oNV8pN5iZc22Li6nkuqWy7bq45EDOkZhm9yjjnFIbvFXSlI
         kviSAghTpgxzELnioTDcshB1lSgPn/dLmH3gpAf8gsbsyWy7be2X9ngizKRsXVHuRm3J
         dGh962qMtZ2Q1Hu51idYGJC3eKjz8F6RNxgTZW3DHei3oIGc2Gi//KYBrFLxXeL4dGjD
         DTod0v/0q2YGWlN/Y8F3AOU6oVYNUC9mVjItvmlKIzcocVAhI/rHjwzEKEpH3PWw+/ZW
         avsg==
X-Gm-Message-State: AOJu0Yz+Ep2rr03dJn8PCsYmGOxUL0Z5RTsh/TJ8vUjBfrPjsdvNKXZ+
        rkc8KKVAAoomiPaLiFb3BZooJQ==
X-Google-Smtp-Source: AGHT+IE4p1HjJUlGRGxGDBmDUsbIOwoBbIXNzM2Hj8ktYhCtgv5uw2xJHZLQAN5AdJEy4CeFtILz0A==
X-Received: by 2002:a05:6512:360e:b0:509:8e13:48e0 with SMTP id f14-20020a056512360e00b005098e1348e0mr4603700lfs.37.1700480107308;
        Mon, 20 Nov 2023 03:35:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b00405d9a950a2sm17666272wmq.28.2023.11.20.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:35:07 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 20 Nov 2023 06:35:04 -0500
To:     oe-kbuild@lists.linux.dev,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 2/2] rtc: max31335: add driver support
Message-ID: <ad78bb08-d415-481d-8f26-0b0195a1ad9d@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101449.8347-2-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoniu,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/rtc-max31335-add-driver-support/20231109-231755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20231109101449.8347-2-antoniu.miclaus%40analog.com
patch subject: [PATCH v7 2/2] rtc: max31335: add driver support
config: i386-randconfig-141-20231111 (https://download.01.org/0day-ci/archive/20231111/202311110943.V2lcrQlf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231111/202311110943.V2lcrQlf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311110943.V2lcrQlf-lkp@intel.com/

smatch warnings:
drivers/rtc/rtc-max31335.c:415 max31335_trickle_charger_setup() error: uninitialized symbol 'trickle_cfg'.

vim +/trickle_cfg +415 drivers/rtc/rtc-max31335.c

d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  383  static int max31335_trickle_charger_setup(struct device *dev,
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  384  					  struct max31335_data *max31335)
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  385  {
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  386  	u32 ohms, chargeable;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  387  	int i, trickle_cfg;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  388  	const char *diode;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  389  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  390  	if (device_property_read_u32(dev, "aux-voltage-chargeable",
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  391  				     &chargeable))
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  392  		return 0;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  393  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  394  	if (device_property_read_u32(dev, "trickle-resistor-ohms", &ohms))
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  395  		return 0;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  396  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  397  	if (device_property_read_string(dev, "adi,tc-diode", &diode))
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  398  		return 0;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  399  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  400  	if (!strcmp(diode, "schottky"))
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  401  		trickle_cfg = MAX31335_TRICKLE_SCHOTTKY_DIODE;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  402  	else if (!strcmp(diode, "standard+schottky"))
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  403  		trickle_cfg = MAX31335_TRICKLE_STANDARD_DIODE;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  404  	else
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  405  		dev_err_probe(dev, -EINVAL, "Invalid tc-diode value: %s\n",
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  406  			      diode);

Probably was intended to be return dev_err_probe();

d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  407  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  408  	for (i = 0; i < ARRAY_SIZE(max31335_trickle_resistors); i++)
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  409  		if (ohms == max31335_trickle_resistors[i])
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  410  			break;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  411  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  412  	if (i >= ARRAY_SIZE(max31335_trickle_resistors))
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  413  		return 0;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  414  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09 @415  	i = i + trickle_cfg;
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  416  
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  417  	return regmap_write(max31335->regmap, MAX31335_TRICKLE_REG,
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  418  			    FIELD_PREP(MAX31335_TRICKLE_REG_TRICKLE, i) |
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  419  			    FIELD_PREP(MAX31335_TRICKLE_REG_EN_TRICKLE,
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  420  				       chargeable));
d76a0d3a61615e5 Antoniu Miclaus 2023-11-09  421  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

