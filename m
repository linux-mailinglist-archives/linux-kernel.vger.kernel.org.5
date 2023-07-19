Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE43758BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGSDKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGSDKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:10:11 -0400
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872761BDC;
        Tue, 18 Jul 2023 20:10:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0745111|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0197397-0.000681479-0.979579;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.Tx3Tklt_1689736195;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Tx3Tklt_1689736195)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 11:09:59 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        doug@schmorgal.com, fido_max@inbox.ru, flatmax@flatmax.com,
        herve.codina@bootlin.com, kiseok.jo@irondevice.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
        robh+dt@kernel.org, shumingf@realtek.com, tiwai@suse.com,
        trix@redhat.com, wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 2/5] ASoC: codecs: aw88261 function for ALSA Audio Driver
Date:   Wed, 19 Jul 2023 11:09:55 +0800
Message-ID: <20230719030955.41489-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <4ef0d83e-b0c9-1f6e-c1a4-24d650630fe4@linaro.org>
References: <4ef0d83e-b0c9-1f6e-c1a4-24d650630fe4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof,
Thank you very much for your advice, 
 but I have a few questions I'd like to discuss with you

On 18/07/2023 16:58, krzysztof.kozlowski@linaro.org wrote:
> On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> The AW88261 is an I2S/TDM input, high efficiency
>> digital Smart K audio amplifier with an integrated 10.25V
>> smart boost convert

> It's the same as in patch before. This does not help and does not
> justify having one driver split into two.

I will modify the commit information and differentiate the commit 
 information for each file

>> 

...

>> +
>> +static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
>> +{
>> +	int ret;
>> +
>> +	if (flag) {
>> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
>> +			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
>> +	} else {
>> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
>> +			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
>> +	}

> You should not need {} here and in multiple other places.

I will delete {} as suggested

>> +	if (ret)
>> +		dev_dbg(aw_dev->dev, "%s failed", __func__);

> Why you are not handling the errors properly?

Do you need to use dev_err instead?

>> +}
>> +
>> +static void aw_dev_pwd(struct aw_device *aw_dev, bool pwd)
>> +{
>> +	int ret;
>> +
>> +	if (pwd) {
>> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
>> +				~AW88261_PWDN_MASK,	AW88261_PWDN_POWER_DOWN_VALUE);
>> +	} else {
>> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
>> +				~AW88261_PWDN_MASK,	AW88261_PWDN_WORKING_VALUE);
>> +	}
>> +	if (ret)
>> +		dev_dbg(aw_dev->dev, "%s failed", __func__);
>> +}
>> +

...

>> +
>> +int aw88261_dev_fw_update(struct aw_device *aw_dev)
>> +{
>> +	struct aw_prof_desc *prof_index_desc;
>> +	struct aw_sec_data_desc *sec_desc;
>> +	char *prof_name;
>> +	int ret;
>> +
>> +	prof_name = aw88261_dev_get_prof_name(aw_dev, aw_dev->prof_index);
>> +	if (!prof_name) {
>> +		dev_err(aw_dev->dev, "get prof name failed");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(aw_dev->dev, "start update %s", prof_name);
>> +
>> +	ret = aw88261_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* update reg */
>> +	sec_desc = prof_index_desc->sec_desc;
>> +	ret = aw_dev_reg_update(aw_dev, sec_desc[AW88261_DATA_TYPE_REG].data,
>> +					sec_desc[AW88261_DATA_TYPE_REG].len);
>> +	if (ret) {
>> +		dev_err(aw_dev->dev, "update reg failed");
>> +		return ret;
>> +	}
>> +
>> +	aw_dev->prof_cur = aw_dev->prof_index;
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(aw88261_dev_fw_update);

> Why do you need to export this? Where is the user?

I will delete this export

>> +
>> +int aw88261_dev_reg_update(struct aw_device *aw_dev, bool force)
>> +{
>> +	int ret;
>> +
>> +	if (force) {
>> +		aw88261_dev_soft_reset(aw_dev);
>> +		ret = aw88261_dev_fw_update(aw_dev);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else {
>> +		if (aw_dev->prof_cur != aw_dev->prof_index) {
>> +			ret = aw88261_dev_fw_update(aw_dev);
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	aw_dev->prof_cur = aw_dev->prof_index;
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(aw88261_dev_reg_update);

> Same question. And in all other places as well.

This function will be called in aw88261.c, can I keep it?

Best regards,
Weidong Wang
