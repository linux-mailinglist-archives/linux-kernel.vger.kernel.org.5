Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5A804414
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjLEBbj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 20:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:31:37 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF89D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:31:43 -0800 (PST)
Received: from [192.168.2.4] (51b68398.dsl.pool.telekom.hu [::ffff:81.182.131.152])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071433.00000000656E7D7D.001150F6; Tue, 05 Dec 2023 02:31:41 +0100
Message-ID: <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
From:   Gergo Koteles <soyer@irl.hu>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Tue, 05 Dec 2023 02:31:40 +0100
In-Reply-To: <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
References: <cover.1701733441.git.soyer@irl.hu>
         <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
         <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

On Mon, 2023-12-04 at 18:22 -0600, Pierre-Louis Bossart wrote:
> 
> 
> > 
> > -	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
> > +	 tas2xxx_generic_fixup(cdc, action, "i2c", "TIAS2781");
> > +}
> 
> this sort of rename should be part of a separate patch IMHO, it'd be
> easier to review.
> 
Okey.

> > +
> > +static void tas2563_fixup_i2c(struct hda_codec *cdc,
> > +	const struct hda_fixup *fix, int action)
> > +{
> > +	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
> 
> Any specific reason to use an Intel ACPI identifier? Why not use
> "TIAS2563" ?
> 
INT8866 is in the ACPI.
I don't know why Lenovo uses this name.
I think it's more internal than intel.

   Scope (_SB.I2CD)
    {
        Device (TAS)
        {
            Name (_HID, "INT8866")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource
Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x004C, ControllerInitiated,
0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CD",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    I2cSerialBusV2 (0x004D, ControllerInitiated,
0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CD",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Edge, ActiveLow, SharedAndWake, PullNone,
0x0000,
                        "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0020
                        }
                })
                Return (RBUF) /* \_SB_.I2CD.TAS_._CRS.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }
    }


> > +#define TAS2563_REG_INIT_N 12
> 
> newline
> 
> > +static const struct reg_default tas2563_reg_init[TAS2563_MAX_CHANNELS]
> > +	[TAS2563_REG_INIT_N] = {
> > +	{
> > +		{ TAS2562_TDM_CFG2, 0x5a },
> > +		{ TAS2562_TDM_CFG4, 0xf3 },
> > +		{ TAS2562_TDM_CFG5, 0x42 },
> > +		{ TAS2562_TDM_CFG6, 0x40 },
> > +		{ TAS2562_BOOST_CFG1, 0xd4 },
> > +		{ TAS2562_BOOST_CFG3, 0xa4 },
> > +		{ TAS2562_REG(0x00, 0x36), 0x0b },
> > +		{ TAS2562_REG(0x00, 0x38), 0x21 },
> > +		{ TAS2562_REG(0x00, 0x3c), 0x58 },
> > +		{ TAS2562_BOOST_CFG4, 0xb6 },
> > +		{ TAS2562_ASI_CONFIG3, 0x04},
> > +		{ TAS2562_REG(0x00, 0x47), 0xb1 },
> 
> > +/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
> 
> update the calibration data,
> 
> > + * Calibrate data is done by manufacturer in the factory. These data are used
> 
> The manufacturer calibrates the data in the factory.
> 
> > + * by Algo for calucating the speaker temperature, speaker membrance excursion
> 
> calculating
> 
> membrane
> 
> 
> > +static int tas2563_hda_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct tas2563_data *tas2563;
> > +	int ret;
> > +
> > +	tas2563 = devm_kzalloc(&client->dev, sizeof(struct tas2563_data),
> > +		GFP_KERNEL);
> > +	if (!tas2563)
> > +		return -ENOMEM;
> > +	tas2563->dev = &client->dev;
> > +	tas2563->client = client;
> > +
> > +	dev_set_drvdata(tas2563->dev, tas2563);
> > +
> > +	ret = tas2563_read_acpi(tas2563);
> > +	if (ret)
> > +		return dev_err_probe(tas2563->dev, ret,
> > +			"Platform not supported\n");
> > +
> > +	for (int i = 0; i < tas2563->ndev; ++i) {
> > +		struct tas2563_dev *tasdev = &tas2563->tasdevs[i];
> > +
> > +		ret = tas2563_tasdev_read_efi(tas2563, tasdev);
> > +		if (ret)
> > +			return dev_err_probe(tas2563->dev, ret,
> > +				"Calibration data cannot be read from EFI\n");
> > +
> > +		ret = tas2563_tasdev_init_client(tas2563, tasdev);
> > +		if (ret)
> > +			return dev_err_probe(tas2563->dev, ret,
> > +				"Failed to init i2c client\n");
> > +
> > +		ret = tas2563_tasdev_init_regmap(tas2563, tasdev);
> > +		if (ret)
> > +			return dev_err_probe(tas2563->dev, ret,
> > +				"Failed to allocate register map\n");
> > +	}
> > +
> > +	ret = component_add(tas2563->dev, &tas2563_hda_comp_ops);
> > +	if (ret) {
> > +		return dev_err_probe(tas2563->dev, ret,
> > +			"Register component failed\n");
> > +	}
> 
> I wonder how many of those tests actually depend on deferred probe, and
> if this isn't a case of copy-paste "just in case"?
> 
> > +
> > +	pm_runtime_set_autosuspend_delay(tas2563->dev, 3000);
> > +	pm_runtime_use_autosuspend(tas2563->dev);
> > +	pm_runtime_mark_last_busy(tas2563->dev);
> > +	pm_runtime_set_active(tas2563->dev);
> > +	pm_runtime_get_noresume(tas2563->dev);
> > +	pm_runtime_enable(tas2563->dev);
> > +
> > +	pm_runtime_put_autosuspend(tas2563->dev);
> 
> the sequence get_noresume/enable/put_autosuspend makes no sense to me.
> doing a get_noresume *before* enable should do exactly nothing, and
> releasing the resource would already be handled with autosuspend based
> on the last_busy mark.
> 
I copied this from the tas2781-hda driver, I'll dig into this more.

> > +
> > +	return 0;
> > +}
> > +
> > +static void tas2563_hda_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct tas2563_data *tas2563 = dev_get_drvdata(&client->dev);
> > +
> > +	pm_runtime_get_sync(tas2563->dev);
> > +	pm_runtime_disable(tas2563->dev);
> > +
> > +	component_del(tas2563->dev, &tas2563_hda_comp_ops);
> > +
> > +	pm_runtime_put_noidle(tas2563->dev);
> 
> that pm_runtime sequence also makes no sense to me, if you disable
> pm_runtime the last command is useless/no-op.
> 
> > +}
> > +
> > +static int tas2563_system_suspend(struct device *dev)
> > +{
> > +	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	dev_dbg(tas2563->dev, "System Suspend\n");
> > +
> > +	ret = pm_runtime_force_suspend(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int tas2563_system_resume(struct device *dev)
> > +{
> > +	int ret;
> > +	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
> > +
> > +	dev_dbg(tas2563->dev, "System Resume\n");
> > +
> > +	ret = pm_runtime_force_resume(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (int i = 0; i < tas2563->ndev; ++i)
> > +		tas2563_tasdev_setup(tas2563, &tas2563->tasdevs[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops tas2563_hda_pm_ops = {
> > +	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)
> 
> where's the pm_runtime stuff?
> 

The amp stores its state in software shutdown mode.
The tas2563_hda_playback_hook wakes/shutdowns the amp, not the
pm_runtime.

> > +};
> 

Regards,

Gergo
