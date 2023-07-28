Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607B766259
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjG1DUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjG1DUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:20:02 -0400
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE8826B2;
        Thu, 27 Jul 2023 20:19:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07643589|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0266834-7.05271e-05-0.973246;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=like@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.U2YlzlR_1690514383;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U2YlzlR_1690514383)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 11:19:51 +0800
From:   like@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     broonie@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, liangdong@awinic.com, like@awinic.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        robh+dt@kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH V1 1/2] regulator: aw37503: add regulator driver for AWINIC AW37503
Date:   Fri, 28 Jul 2023 03:19:43 +0000
Message-ID: <20230728031943.1479106-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <284e464a-85dc-f07b-27f8-fda516ca7b24@linaro.org>
References: <284e464a-85dc-f07b-27f8-fda516ca7b24@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof Kozlowski,
Thank you very much for your advice.

> On 26/07/2023 10:16, like@awinic.com wrote:
> > From: Alec Li <like@awinic.com>
> > 
> > Add regulator driver for the device AWINIC AW37503 which is single
> > inductor - dual output power supply device. AW37503 device is
> > designed to support general positive/negative driven applications
> > like TFT display panels.
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
> > +
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
> 
> return dev_err_probe

I will modify it as suggested.

> > +	}
> > +
> > +	i2c_set_clientdata(client, chip);
> > +	chip->dev = dev;
> > +
> > +	for (id = 0; id < AW37503_MAX_REGULATORS; ++id) {
> > +		config.regmap = regmap;
> > +		config.dev = dev;
> > +		config.driver_data = chip;
> > +
> > +		rdev = devm_regulator_register(dev, &aw_regs_desc[id],
> > +					       &config);
> > +		if (IS_ERR(rdev)) {
> > +			ret = PTR_ERR(rdev);
> > +			dev_err(dev, "regulator %s register failed: %d\n",
> > +				aw_regs_desc[id].name, ret);
> > +			return ret;
> 
> return dev_err_probe will be easier

I will modify it as suggested.

> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id aw37503_id[] = {
> > +	{.name = "aw37503",},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, aw37503_id);
> > +
> > +static const struct of_device_id aw37503_dt_ids[] = {
> > +	{.compatible = "awinic,aw37503",},
> > +	{ /* Sentinel */ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, aw37503_dt_ids);
> > +
> > +static struct i2c_driver aw37503_i2c_driver = {
> > +	.driver = {
> > +		.name = "aw37503",
> > +		.of_match_table = of_match_ptr(aw37503_dt_ids),
> 
> Drop of_match_ptr()

I will modify it as suggested.


Best regards,
Alec Li
