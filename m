Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17376625D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjG1DUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjG1DUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:20:42 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBC271D;
        Thu, 27 Jul 2023 20:20:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08359193|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00645394-0.00094167-0.992604;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=like@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.U2YPvKi_1690514426;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U2YPvKi_1690514426)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 11:20:33 +0800
From:   like@awinic.com
To:     christophe.jaillet@wanadoo.fr
Cc:     broonie@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, liangdong@awinic.com, like@awinic.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        robh+dt@kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH V1 1/2] regulator: aw37503: add regulator driver for AWINIC AW37503
Date:   Fri, 28 Jul 2023 03:20:26 +0000
Message-ID: <20230728032026.1479380-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <f4d588e1-18e1-e7e1-e862-e87f9c7d7b9e@wanadoo.fr>
References: <f4d588e1-18e1-e7e1-e862-e87f9c7d7b9e@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe JAILLET,
Thank you very much for your advice.

> > From: Alec Li <like-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> > 
> > Add regulator driver for the device AWINIC AW37503 which is single
> > inductor - dual output power supply device. AW37503 device is
> > designed to support general positive/negative driven applications
> > like TFT display panels.
> > 
> > AW37503 regulator driver supports to enable/disable and set voltage
> > on its output.
> > 
> > Signed-off-by: Alec Li <like-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> 
> [...]
> 
> > +static int aw37503_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct aw37503_regulator *chip;
> > +	struct regulator_dev *rdev;
> > +	struct regmap *regmap;
> > +	struct regulator_config config = { };
> > +	int id;
> > +	int ret;
> > +
> > +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> > +	if (!chip)
> > +		return -ENOMEM;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &aw37503_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		ret = PTR_ERR(regmap);
> > +		dev_err(dev, "regmap init failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	i2c_set_clientdata(client, chip);
> > +	chip->dev = dev;
> > +
> > +	for (id = 0; id < AW37503_MAX_REGULATORS; ++id) {
> > +		config.regmap = regmap;
> > +		config.dev = dev;
> > +		config.driver_data = chip;
> 
> I think that these 3 lines could be outside of the loop.

I will modify it as suggested.

> > +
> > +		rdev = devm_regulator_register(dev, &aw_regs_desc[id],
> > +					       &config);
> > +		if (IS_ERR(rdev)) {
> > +			ret = PTR_ERR(rdev);
> > +			dev_err(dev, "regulator %s register failed: %d\n",
> > +				aw_regs_desc[id].name, ret);
> > +			return ret;
> > +		}
> > +	}
> > +	return 0;
> > +}


Best regards,
Alec Li
