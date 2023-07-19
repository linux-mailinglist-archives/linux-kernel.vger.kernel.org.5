Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C6758BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGSDHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGSDHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:07:10 -0400
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996451BEE;
        Tue, 18 Jul 2023 20:07:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0581865-0.00128256-0.940531;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.Tx46JNx_1689736015;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Tx46JNx_1689736015)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 11:06:58 +0800
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
Subject: Re: [PATCH V1 1/5] ASoC: codecs: Add i2c and codec registration for aw88261 and their associated operation functions
Date:   Wed, 19 Jul 2023 11:06:55 +0800
Message-ID: <20230719030655.41451-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <0c534a51-dff3-84f1-34cb-41cae25d3871@linaro.org>
References: <0c534a51-dff3-84f1-34cb-41cae25d3871@linaro.org>
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
Thank you very much for your advice.

On 18/07/2023 16:39, krzysztof.kozlowski@linaro.org wrote:
> On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> The AW88261 is an I2S/TDM input, high efficiency
>> digital Smart K audio amplifier with an integrated 10.25V
>> smart boost convert
>> 

...

>> +
>> +static int aw88261_request_firmware_file(struct aw88261 *aw88261)
>> +{
>> +	const struct firmware *cont = NULL;
>> +	int ret;
>> +
>> +	aw88261->aw_pa->fw_status = AW88261_DEV_FW_FAILED;
>> +
>> +	ret = request_firmware(&cont, AW88261_ACF_FILE, aw88261->aw_pa->dev);
>> +	if ((ret < 0) || (!cont)) {
>> +		dev_err(aw88261->aw_pa->dev, "load [%s] failed!", AW88261_ACF_FILE);
>> +		return ret;

>return dev_err_probe?

I will modify it as suggested.

>> +	}
>> +
>> +	dev_info(aw88261->aw_pa->dev, "loaded %s - size: %zu\n",
>> +			AW88261_ACF_FILE, cont ? cont->size : 0);> +
>> +	aw88261->aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
>> +	if (!aw88261->aw_cfg) {
>> +		release_firmware(cont);
>> +		return -ENOMEM;
>> +	}
>> +	aw88261->aw_cfg->len = (int)cont->size;
>> +	memcpy(aw88261->aw_cfg->data, cont->data, cont->size);
>> +	release_firmware(cont);
>> +
>> +	ret = aw88261_dev_load_acf_check(aw88261->aw_pa, aw88261->aw_cfg);
>> +	if (ret < 0) {
>> +		dev_err(aw88261->aw_pa->dev, "Load [%s] failed ....!", AW88261_ACF_FILE);
>> +		return ret;
>> +	}
>> +
>> +	dev_dbg(aw88261->aw_pa->dev, "%s : bin load success\n", __func__);

> Drop dev_dbg on simple probe success/failure. There is tracing
> infrastructure for this.

I will delete this print statement.

>> +
>> +	mutex_lock(&aw88261->lock);
>> +	/* aw device init */
>> +	ret = aw88261_dev_init(aw88261->aw_pa, aw88261->aw_cfg);
>> +	if (ret < 0)
>> +		dev_err(aw88261->aw_pa->dev, "dev init failed");
>> +	mutex_unlock(&aw88261->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int aw88261_codec_probe(struct snd_soc_component *component)
>> +{
>> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
>> +	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
>> +	int ret;
>> +
>> +	INIT_DELAYED_WORK(&aw88261->start_work, aw88261_startup_work);
>> +
>> +	ret = aw88261_request_firmware_file(aw88261);
>> +	if (ret < 0) {
>> +		dev_err(aw88261->aw_pa->dev, "aw88261_request_firmware_file failed\n");
>> +		return ret;

> Consider here dev_err_probe, to annotate possibility of probe deferal
> (e.g. missing rootfs). I think component probe is called for device probes?

I will modify it as suggested.

>> +	}
>> +
>> +	/* add widgets */
>> +	ret = snd_soc_dapm_new_controls(dapm, aw88261_dapm_widgets,
>> +							ARRAY_SIZE(aw88261_dapm_widgets));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* add route */
>> +	ret = snd_soc_dapm_add_routes(dapm, aw88261_audio_map,
>> +							ARRAY_SIZE(aw88261_audio_map));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = snd_soc_add_component_controls(component, aw88261_controls,
>> +							ARRAY_SIZE(aw88261_controls));
>> +
>> +	return ret;
>> +}
>> +

>> +static void aw88261_codec_remove(struct snd_soc_component *aw_codec)
>> +{
>> +	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(aw_codec);
>> +
>> +	cancel_delayed_work_sync(&aw88261->start_work);
>> +}
>> +
>> +
>> +static void aw88261_hw_reset(struct aw88261 *aw88261)
>> +{
>> +	gpiod_set_value_cansleep(aw88261->reset_gpio, 0);
>> +	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
>> +	gpiod_set_value_cansleep(aw88261->reset_gpio, 1);
>> +	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
>> +}
>> +
>> +static int aw88261_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	struct aw88261 *aw88261;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
>> +		dev_err(&i2c->dev, "check_functionality failed");
>> +		return -EIO;
>> +	}
>> +
>> +	aw88261 = aw88261_malloc_init(i2c);
>> +	if (!aw88261) {
>> +		dev_err(&i2c->dev, "malloc aw88261 failed");

> Do not print messages on allocation errors.

> Also, there is little sense in moving one or two functions - kzalloc -
> to separate function. It does not make the code easier to read.

I will modify it as suggested.

>> +		return -ENOMEM;
>> +	}
>> +	i2c_set_clientdata(i2c, aw88261);
>> +
>> +	aw88261->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(aw88261->reset_gpio))
>> +		dev_info(&i2c->dev, "reset gpio not defined\n");
>> +	else
>> +		aw88261_hw_reset(aw88261);
>> +
>> +	aw88261->regmap = devm_regmap_init_i2c(i2c, &aw88261_remap_config);
>> +	if (IS_ERR(aw88261->regmap)) {
>> +		ret = PTR_ERR(aw88261->regmap);
>> +		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
>> +		return ret;

> return dev_err_probe

I will modify it as suggested.

>> +	}
>> +
>> +	/* aw pa init */
>> +	ret = aw88261_init(&aw88261->aw_pa, i2c, aw88261->regmap);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_snd_soc_register_component(&i2c->dev,
>> +			&soc_codec_dev_aw88261,
>> +			aw88261_dai, ARRAY_SIZE(aw88261_dai));
>> +	if (ret < 0)
>> +		dev_err(&i2c->dev, "failed to register aw88261: %d", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +#ifdef CONFIG_OF

> Drop

I will modify it as suggested.

>> +static const struct of_device_id aw88261_of_match[] = {
>> +	{ .compatible = "awinic,aw88261" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, aw88261_of_match);
>> +#endif
>> +
>> +static const struct i2c_device_id aw88261_i2c_id[] = {
>> +	{ AW88261_I2C_NAME, 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, aw88261_i2c_id);
>> +
>> +static struct i2c_driver aw88261_i2c_driver = {
>> +	.driver = {
>> +		.name = AW88261_I2C_NAME,
>> +		.of_match_table = of_match_ptr(aw88261_of_match),

> Drop of_match_ptr.

I will modify it as suggested.

Best regards,
Weidong Wang
