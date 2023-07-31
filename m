Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A356768C23
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGaGmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGaGmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:42:08 -0400
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254371A5;
        Sun, 30 Jul 2023 23:42:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00623896-0.000234438-0.993527;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.U4cHkoK_1690785714;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U4cHkoK_1690785714)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 14:41:57 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     13916275206@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, doug@schmorgal.com, fido_max@inbox.ru,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V3 4/5] ASoC: codecs: aw88261 device related operation functions
Date:   Mon, 31 Jul 2023 14:41:54 +0800
Message-ID: <20230731064154.4137-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <7cdd4825-c0da-f60e-bbef-970bea48dc95@linaro.org>
References: <7cdd4825-c0da-f60e-bbef-970bea48dc95@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your review, but I have a few questions
I'd like to discuss with you

On 29/07/2023 19:29, krzysztof.kozlowski@linaro.org wrote:
> On 29/07/2023 11:12, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Operate the aw88261 chip, including device initialization,
>> chip power-on and power-off, control volume, etc.
>> 
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
>> ---
>>  sound/soc/codecs/aw88261/aw88261_device.c | 877 ++++++++++++++++++++++
>>  sound/soc/codecs/aw88261/aw88261_device.h |  79 ++
>>  2 files changed, 956 insertions(+)
>>  create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
>>  create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h
>> 

...

>> +
>> +int aw88261_dev_stop(struct aw88261_device *aw_dev)
>> +{
>> +	if (aw_dev->aw88261_base->status == AW88261_DEV_PW_OFF) {
>> +		dev_info(aw_dev->aw88261_base->dev, "already power off");
>> +		return 0;
>> +	}
>> +
>> +	aw_dev->aw88261_base->status = AW88261_DEV_PW_OFF;
>> +
>> +	/* clear inturrupt */
>> +	aw_dev_clear_int_status(aw_dev);
>> +
>> +	aw88261_dev_uls_hmute(aw_dev, true);
>> +	/* set mute */
>> +	aw88261_dev_mute(aw_dev, true);
>> +
>> +	/* close tx feedback */
>> +	aw_dev_i2s_tx_enable(aw_dev, false);
>> +	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
>> +
>> +	/* enable amppd */
>> +	aw_dev_amppd(aw_dev, true);
>> +
>> +	/* set power down */
>> +	aw_dev_pwd(aw_dev, true);
>> +
>> +	dev_dbg(aw_dev->dev, "pa stop success\n");

> No for debug replacing tracing. We have tracing for this.

I will delete this print debug statement

>> +
>> +	return 0;
>> +}
>> +
>> +int aw88261_dev_init(struct aw88261_device *aw_dev, struct aw_container *aw_cfg)

> You already used this function in patch #3, so your order of patches is
> confusing.

Do I need to change the order of patch? 
Do I neeed to put aw88261_device.c aw88261_device.h in patch #3 and 
put aw88261.c aw88261.h in patch #4?
Is that how you change the order?

>> +{
>> +	int ret;
>> +
>> +	if ((!aw_dev) || (!aw_cfg)) {
>> +		pr_err("aw_dev is NULL or aw_cfg is NULL");

> Is this possible? If so, why?

Thank you very much, I will delete this judgment.

>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = aw88395_dev_cfg_load(aw_dev->aw88261_base, aw_cfg);
>> +	if (ret) {
>> +		dev_err(aw_dev->dev, "aw_dev acf parse failed");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_write(aw_dev->aw88261_base->regmap, AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	aw_dev->aw88261_base->fade_in_time = AW88261_1000_US / 10;
>> +	aw_dev->aw88261_base->fade_out_time = AW88261_1000_US >> 1;
>> +	aw_dev->aw88261_base->prof_cur = AW_INIT_PROFILE;
>> +	aw_dev->aw88261_base->prof_index = AW_INIT_PROFILE;
>> +
>> +	ret = aw_dev_fw_update(aw_dev);
>> +	if (ret) {
>> +		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = aw_frcset_check(aw_dev);
>> +	if (ret) {
>> +		dev_err(aw_dev->dev, "aw_frcset_check failed ret = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	aw_dev_clear_int_status(aw_dev);
>> +
>> +	aw88261_dev_uls_hmute(aw_dev, true);
>> +
>> +	aw88261_dev_mute(aw_dev, true);
>> +
>> +	aw_dev_i2s_tx_enable(aw_dev, false);
>> +
>> +	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
>> +
>> +	aw_dev_amppd(aw_dev, true);
>> +
>> +	aw_dev_pwd(aw_dev, true);
>> +
>> +	return 0;
>> +}
>> +
>> +static void aw_parse_channel_dt(struct aw88261_device *aw_dev)
>> +{
>> +	struct device_node *np = aw_dev->aw88261_base->dev->of_node;
>> +	u32 channel_value;
>> +	u32 sync_enable;
>> +	int ret;
>> +
>> +	ret = of_property_read_u32(np, "sound-channel", &channel_value);
>> +	if (ret)
>> +		channel_value = AW88261_DEV_DEFAULT_CH;
>> +
>> +	ret = of_property_read_u32(np, "sync-flag", &sync_enable);
>> +	if (ret)
>> +		sync_enable = false;
>> +
>> +	dev_dbg(aw_dev->dev,  "sync flag is %d", sync_enable);

> Fix style - only one space after ,

Thank you very much. I will modify it according to your suggestion.

>> +	dev_dbg(aw_dev->dev, "read sound-channel value is: %d", channel_value);
>> +
>> +	aw_dev->aw88261_base->channel = channel_value;
>> +	aw_dev->phase_sync = sync_enable;
>> +}
>> +
>> +static int aw_dev_init(struct aw88261_device *aw_dev)
>> +{
>> +	aw_dev->aw88261_base->chip_id = AW88261_CHIP_ID;
>> +	/* call aw device init func */
>> +	aw_dev->aw88261_base->acf = NULL;
>> +	aw_dev->aw88261_base->prof_info.prof_desc = NULL;
>> +	aw_dev->aw88261_base->prof_info.count = 0;
>> +	aw_dev->aw88261_base->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
>> +	aw_dev->aw88261_base->channel = 0;
>> +	aw_dev->aw88261_base->fw_status = AW88261_DEV_FW_FAILED;
>> +
>> +	aw_dev->aw88261_base->fade_step = AW88261_VOLUME_STEP_DB;
>> +	aw_dev->aw88261_base->volume_desc.ctl_volume = AW88261_VOL_DEFAULT_VALUE;
>> +	aw_dev->aw88261_base->volume_desc.mute_volume = AW88261_MUTE_VOL;
>> +	aw_parse_channel_dt(aw_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +int aw88261_dev_set_profile_index(struct aw88261_device *aw_dev, int index)
>> +{
>> +	struct aw_device *aw88261_base = aw_dev->aw88261_base;
>> +
>> +	/* check the index whether is valid */
>> +	if ((index >= aw88261_base->prof_info.count) || (index < 0))
>> +		return -EINVAL;
>> +	/* check the index whether change */
>> +	if (aw88261_base->prof_index == index)
>> +		return -EINVAL;
>> +
>> +	aw88261_base->prof_index = index;
>> +
>> +	return 0;
>> +}
>> +
>> +char *aw88261_dev_get_prof_name(struct aw88261_device *aw_dev, int index)
>> +{
>> +	struct aw_prof_info *prof_info = &aw_dev->aw88261_base->prof_info;
>> +	struct aw_prof_desc *prof_desc;
>> +
>> +	if ((index >= aw_dev->aw88261_base->prof_info.count) || (index < 0)) {
>> +		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
>> +			index, aw_dev->aw88261_base->prof_info.count);
>> +		return NULL;
>> +	}
>> +
>> +	prof_desc = &aw_dev->aw88261_base->prof_info.prof_desc[index];
>> +
>> +	return prof_info->prof_name_list[prof_desc->id];
>> +}
>> +
>> +int aw88261_dev_get_prof_data(struct aw88261_device *aw_dev, int index,
>> +			struct aw_prof_desc **prof_desc)
>> +{
>> +	if ((index >= aw_dev->aw88261_base->prof_info.count) || (index < 0)) {
>> +		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
>> +				__func__, index, aw_dev->aw88261_base->prof_info.count);
>> +		return -EINVAL;
>> +	}
>> +
>> +	*prof_desc = &aw_dev->aw88261_base->prof_info.prof_desc[index];
>> +
>> +	return 0;
>> +}
>> +
>> +int aw88261_init(struct aw88261_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap)

> You already used this function in patch #3, so your order of patches is
> confusing.

I will change the patch order as mentioned above

>> +{
>> +	unsigned int chip_id;
>> +	int ret;
>> +
>> +	if (*aw_dev) {
>> +		dev_info(&i2c->dev, "it should be initialized here.\n");

> How is this possible?

I will modify it according to your suggestion.

>> +	} else {
>> +		*aw_dev = devm_kzalloc(&i2c->dev, sizeof(struct aw88261_device), GFP_KERNEL);

> sizeof(**)

Thank you very much. I will modify it according to your suggestion.

>> +		if (!(*aw_dev))
>> +			return -ENOMEM;
>> +	}
>> +
>> +	(*aw_dev)->aw88261_base =
>> +			devm_kzalloc(&i2c->dev, sizeof(struct aw_device), GFP_KERNEL);

> sizeof(*)

Thank you very much. I will modify it according to your suggestion

>> +	if (!(*aw_dev)->aw88261_base)
>> +		return -ENOMEM;
>> +
>> +	(*aw_dev)->aw88261_base->i2c = i2c;

> I propose to use some local variable, to simplify all these assignments.

Thank you very much. I will modify it according to your suggestion

>> +	(*aw_dev)->aw88261_base->dev = &i2c->dev;
>> +	(*aw_dev)->aw88261_base->regmap = regmap;
>> +	(*aw_dev)->dev = &i2c->dev;

> In how many places do you need to store &i2c->dev?

There are many places where I use dev_err(aw_dev->dev, xxx) for error printing.
So I did this part of the storage.
Does it make sense to change to dev_err(aw_dev->aw88261_base->dev, xx) or add a local variable
and use "dev_err(aw88261_base->dev, xxx)"?

>> +
>> +	/* read chip id */
>> +	ret = regmap_read((*aw_dev)->aw88261_base->regmap, AW88261_CHIP_ID_REG, &chip_id);
>> +	if (ret) {
>> +		dev_err((*aw_dev)->dev, "%s read chipid error. ret = %d", __func__, ret);
>> +		return ret;
>> +	}
>> +	dev_info((*aw_dev)->dev, "chip id = %x\n", chip_id);

> "(*aw_dev)->dev" all over this function is not really readable.

Thank you very much, I will change it to "dev_info(&i2c->dev, xxx)";

>> +
>> +	switch (chip_id) {
>> +	case AW88261_CHIP_ID:
>> +		ret = aw_dev_init((*aw_dev));
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		dev_err((*aw_dev)->dev, "unsupported device");
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +MODULE_DESCRIPTION("AW88261 device");
>> +MODULE_LICENSE("GPL v2");

> Wait, is this a module? Does not look complete. I already saw one
> module, so what is this for? For which module?

Can it be changed to MODULE_DESCRIPTION("AW88261 device lib")?
The function in the aw88261_device.c file, which I used in the aw88261.c file.

Best regards,
Weidong Wang
