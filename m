Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD27925B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbjIEQJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352879AbjIEGDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:03:38 -0400
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240B1B6;
        Mon,  4 Sep 2023 23:03:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437018|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0078599-0.000796544-0.991344;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.UXsaVvi_1693893801;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UXsaVvi_1693893801)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 14:03:29 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, rdunlap@infradead.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
Date:   Tue,  5 Sep 2023 14:03:21 +0800
Message-ID: <20230905060321.15849-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
References: <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much. Here are some things I'd like to discuss with you.

On 05/09/2023 11:50, krzysztof.kozlowski@linaro.org wrote:
> On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 

> ...

>> +static void aw87390_parse_channel_dt(struct aw87390 *aw87390)
>> +{
>> +	struct aw_device *aw_dev = aw87390->aw_pa;
>> +	struct device_node *np = aw_dev->dev->of_node;
>> +	u32 channel_value = AW87390_DEV_DEFAULT_CH;
>> +
>> +	of_property_read_u32(np, "sound-channel", &channel_value);

> NAK, there is no such property. It seems you already sneaked in such for
> other codecs. Please do not repeat such patterns of work.

> That's also why I expect full DTS example, not some reduced pieces.

Thank you very much. I would like to add a sound-channel property to awinic,aw87390.yaml
This property is used to distinguish between multiple PA's in order to 
load different configurations for different PA's

>> +
>> +	aw_dev->channel = channel_value;
>> +}
>> +
>> +static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct regmap *regmap)
>> +{
>> +	struct aw_device *aw_dev;
>> +	unsigned int chip_id;
>> +	int ret;
>> +
>> +	/* read chip id */
>> +	ret = regmap_read(regmap, AW87390_ID_REG, &chip_id);
>> +	if (ret) {
>> +		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
>> +		return ret;
>> +	}
>> +
>> +	if (chip_id != AW87390_CHIP_ID) {
>> +		dev_err(&i2c->dev, "unsupported device\n");

> Why? The compatible tells it cannot be anything else.

>> +		return -ENXIO;
>> +	}
>> +
>> +	dev_info(&i2c->dev, "chip id = 0x%x\n", chip_id);
>> +
>> +	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
>> +	if (!aw_dev)
>> +		return -ENOMEM;
>> +
>> +	(*aw87390)->aw_pa = aw_dev;
>> +	aw_dev->i2c = i2c;
>> +	aw_dev->regmap = regmap;
>> +	aw_dev->dev = &i2c->dev;
>> +	aw_dev->chip_id = AW87390_CHIP_ID;
>> +	aw_dev->acf = NULL;
>> +	aw_dev->prof_info.prof_desc = NULL;
>> +	aw_dev->prof_info.count = 0;
>> +	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
>> +	aw_dev->channel = AW87390_DEV_DEFAULT_CH;
>> +	aw_dev->fw_status = AW87390_DEV_FW_FAILED;
>> +	aw_dev->prof_index = AW87390_INIT_PROFILE;
>> +	aw_dev->status = AW87390_DEV_PW_OFF;
>> +
>> +	aw87390_parse_channel_dt(*aw87390);
>> +
>> +	return ret;
>> +}
>> +
>> +static int aw87390_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	struct aw87390 *aw87390;
>> +	int ret;
>> +
>> +	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
>> +	if (!ret)
>> +		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed\n");
>> +
>> +	aw87390 = devm_kzalloc(&i2c->dev, sizeof(*aw87390), GFP_KERNEL);
>> +	if (!aw87390)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&aw87390->lock);
>> +
>> +	i2c_set_clientdata(i2c, aw87390);
>> +
>> +	aw87390->regmap = devm_regmap_init_i2c(i2c, &aw87390_remap_config);
>> +	if (IS_ERR(aw87390->regmap)) {
>> +		ret = PTR_ERR(aw87390->regmap);

> ret is not needed here, so just:
> return dev_err_probe()

Thank you very much. I will modify it to 
"return dev_err_probe(&i2c->dev, PTR_ERR(aw87390->regmap), "failed to init regmap: %d\n", ret);"

>> +		return dev_err_probe(&i2c->dev, ret, "failed to init regmap: %d\n", ret);
>> +	}
>> +
>> +	/* aw pa init */
>> +	ret = aw87390_init(&aw87390, i2c, aw87390->regmap);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(aw87390->regmap, AW87390_ID_REG, AW87390_SOFT_RESET_VALUE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_snd_soc_register_component(&i2c->dev,
>> +				&soc_codec_dev_aw87390, NULL, 0);
>> +	if (ret)
>> +		dev_err(&i2c->dev, "failed to register aw87390: %d\n", ret);
>> +
>> +	return ret;
>> +}


Best regards,
Weidong Wang
