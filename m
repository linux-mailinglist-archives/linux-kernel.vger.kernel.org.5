Return-Path: <linux-kernel+bounces-17903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8738254D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF01C2149E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897602DF62;
	Fri,  5 Jan 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="rF/0IQUd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC502D7A6;
	Fri,  5 Jan 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405CRxc9029289;
	Fri, 5 Jan 2024 08:04:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=NgK0ariODaAJM3u
	rz57AUlxKnvsuFzT7i1lyaH/qe3g=; b=rF/0IQUdGm0Wd99Ij94Tkra47dqAYQz
	UGL7T28kFbh9N5oq6IVFe4E6gU8n9KczZ7rnVg0BD/gWCalL+ihrEyh7A+ZumIHi
	KKmgPlp7oFU3KQ05XhnvLZmWufI8fdzejd6SA6Hckobkld8GfsbPJJQYY9nyZMG1
	nKMuZcsqdicAfddO5tyRM9C8hR0q4T9KTGRY1NItuS+OLq4MDibork6d+g9yWYqO
	mppwJtpehHA5CtMtnzWZI0uqc6J0wNTq09hJtZTNLrNfj0DFksQN+7fMkrN0dgJh
	ckfwTaMxidrgksrvgUc6Jq53quiiHuZC/qWBaMAoWe9JCp7k7evgU3Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ve9d00n13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 08:04:24 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 14:04:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Fri, 5 Jan 2024 14:04:08 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0008C468;
	Fri,  5 Jan 2024 14:04:07 +0000 (UTC)
Date: Fri, 5 Jan 2024 14:04:07 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: James Ogletree <jogletre@opensource.cirrus.com>
CC: James Ogletree <james.ogletree@cirrus.com>,
        Fred Treven
	<fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jacky Bai
	<ping.bai@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
        Peng Fan
	<peng.fan@nxp.com>, Weidong Wang <wangweidong.a@awinic.com>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Shenghao Ding
	<13916275206@139.com>,
        Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Shuming Fan
	<shumingf@realtek.com>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 3/5] mfd: cs40l50: Add support for CS40L50 core driver
Message-ID: <20240105140407.GG14858@ediswmail.ad.cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-4-jogletre@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104223643.876292-4-jogletre@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: pMkVg0owTryzh09Kt_vwlElCrMJXezxQ
X-Proofpoint-GUID: pMkVg0owTryzh09Kt_vwlElCrMJXezxQ
X-Proofpoint-Spam-Reason: safe

On Thu, Jan 04, 2024 at 10:36:36PM +0000, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptic driver with waveform memory, integrated DSP,
> and closed-loop algorithms.
> 
> The MFD component registers and initializes the device.
> 
> Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>
> ---
> +config MFD_CS40L50_CORE
> +	tristate
> +	select MFD_CORE
> +	select FW_CS_DSP
> +	select REGMAP_IRQ
> +
> +config MFD_CS40L50_I2C
> +	tristate "Cirrus Logic CS40L50 (I2C)"
> +	select REGMAP_I2C
> +	select MFD_CS40L50_CORE
> +	depends on I2C
> +	help
> +	  Select this to support the Cirrus Logic CS40L50 Haptic
> +	  Driver over I2C.
> +
> +	  This driver can be built as a module. If built as a module it will be
> +	  called "cs40l50-i2c".
> +
> +config MFD_CS40L50_SPI
> +	tristate "Cirrus Logic CS40L50 (SPI)"
> +	select REGMAP_SPI
> +	select MFD_CS40L50_CORE
> +	depends on SPI
> +	help
> +	  Select this to support the Cirrus Logic CS40L50 Haptic
> +	  Driver over SPI.
> +
> +	  This driver can be built as a module. If built as a module it will be
> +	  called "cs40l50-spi".
> +

Generally the order in Kconfigs should be alphabetical, probably
up around Cirrus Madera stuff would make most sense.

> +static int cs40l50_dsp_init(struct cs40l50 *cs40l50)
> +{
> +	int err;
> +
> +	cs40l50->dsp.num = 1;
> +	cs40l50->dsp.type = WMFW_HALO;
> +	cs40l50->dsp.dev = cs40l50->dev;
> +	cs40l50->dsp.regmap = cs40l50->regmap;
> +	cs40l50->dsp.base = CS40L50_CORE_BASE;
> +	cs40l50->dsp.base_sysinfo = CS40L50_SYS_INFO_ID;
> +	cs40l50->dsp.mem = cs40l50_dsp_regions;
> +	cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
> +	cs40l50->dsp.no_core_startstop = true;
> +
> +	err = cs_dsp_halo_init(&cs40l50->dsp);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(cs40l50->dev, cs40l50_dsp_remove,
> +					&cs40l50->dsp);

Hmm... I notice you use this for both dsp_remove and
dsp_power_down. Are you sure devm will guarantee those are called
in the right order? Its not immediately clear to me that would be
have to be the case.

> +static irqreturn_t cs40l50_irq_handler(int irq, void *data)
> +{
> +	struct cs40l50 *cs40l50 = data;
> +	int err;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	if (irq == cs40l50_irqs[0].virq)
> +		err = cs40l50_process_dsp_queue(cs40l50);
> +	else
> +		err = cs40l50_handle_hw_err(cs40l50, irq);

Feels kinda weird to assign the same handler to every IRQ and
then depending on which IRQ it was call a different function.
Would it not be simpler just to assign a different handler?

> +static int cs40l50_power_up_dsp(struct cs40l50 *cs40l50)
> +{
> +	int err;
> +
> +	mutex_lock(&cs40l50->lock);
> +
> +	if (cs40l50->patch) {
> +		/* Stop core if loading patch file */
> +		err = regmap_multi_reg_write(cs40l50->regmap, cs40l50_stop_core,
> +					     ARRAY_SIZE(cs40l50_stop_core));
> +		if (err)
> +			goto err_mutex;
> +	}
> +
> +	err = cs_dsp_power_up(&cs40l50->dsp, cs40l50->patch, "cs40l50.wmfw",
> +			      cs40l50->bin, "cs40l50.bin", "cs40l50");
> +	if (err)
> +		goto err_mutex;
> +
> +	err = devm_add_action_or_reset(cs40l50->dev, cs40l50_dsp_power_down,
> +				       &cs40l50->dsp);
> +	if (err)
> +		goto err_mutex;
> +
> +	if (cs40l50->patch) {
> +		/* Resume core after loading patch file */
> +		err = regmap_write(cs40l50->regmap, CS40L50_CCM_CORE_CONTROL,
> +				   CS40L50_CLOCK_ENABLE);

This feels like this needs a comment, why are we skipping the
normal DSP init and doing it manually (this appears to be the
same writes start_core would have done)? I assume its something to
do with what you are really doing is you don't want lock_memory
to run?

> +static int cs40l50_configure_dsp(struct cs40l50 *cs40l50)
> +{
> +	u32 nwaves;
> +	int err;
> +
> +	if (cs40l50->bin) {
> +		/* Log number of effects if wavetable was loaded */
> +		err = regmap_read(cs40l50->regmap, CS40L50_NUM_WAVES, &nwaves);
> +		if (err)
> +			return err;
> +
> +		dev_info(cs40l50->dev, "Loaded with %u RAM waveforms\n", nwaves);

Kinda nervous about the fact we access all these DSP controls
directly through address, rather than using the DSP control
accessors, we have the accessors for a reason. They manage things
like access permissions etc. and historically, the firmware
guys have not been able to guarantee these remain in consistent
locations between firmware versions.

I guess this is so you can access them even in the case of the
ROM firmware, but you could have a meta-data only firmware file
that you load in that case to give you the controls.  I don't
feel the need to NAK the driver based on this but please think
about this very carefully it's a strange way to use the DSP
controls, and feels likely to cause problems to me. It is also
quite hostile to fixing it in the future since as you are not
using the controls no one will be checking that things like the
access flags in the firmware are set correctly, which is annoying
if the decision has to be reversed later since there will likely
be a bunch of broken firmwares already in the field.

> +int cs40l50_probe(struct cs40l50 *cs40l50)
> +{
> +	struct device *dev = cs40l50->dev;
> +	int err;
> +
> +	mutex_init(&cs40l50->lock);
> +
> +	cs40l50->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(cs40l50->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(cs40l50->reset_gpio),
> +				     "Failed getting reset GPIO\n");
> +
> +	err = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(cs40l50_supplies),
> +					     cs40l50_supplies);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed getting supplies\n");
> +
> +	/* Ensure minimum reset pulse width */
> +	usleep_range(CS40L50_RESET_PULSE_US, CS40L50_RESET_PULSE_US + 100);
> +
> +	gpiod_set_value_cansleep(cs40l50->reset_gpio, 0);
> +
> +	/* Wait for control port to be ready */
> +	usleep_range(CS40L50_CP_READY_US, CS40L50_CP_READY_US + 100);
> +
> +	err = cs40l50_dsp_init(cs40l50);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to initialize DSP\n");
> +
> +	cs40l50_pm_runtime_setup(dev);
> +
> +	err = cs40l50_get_model(cs40l50);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to get part number\n");
> +
> +	err = cs40l50_irq_init(cs40l50);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to initialize IRQs\n");
> +
> +	err = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT, CS40L50_FW,
> +				      dev, GFP_KERNEL, cs40l50, cs40l50_request_patch);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to request %s\n", CS40L50_FW);
> +
> +	err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cs40l50_devs,
> +				   ARRAY_SIZE(cs40l50_devs), NULL, 0, NULL);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to add sub devices\n");
> +

Do you want to add the child devices here? Or after the firmware
init has been done? If you do it here then the child devices may
well probe and become available before all the setup you have in
the DSP loading stuff is done. What happens if one of those
drivers tries to do something before init is complete?

> +static int cs40l50_runtime_resume(struct device *dev)
> +{
> +	struct cs40l50 *cs40l50 = dev_get_drvdata(dev);
> +	int err, i;
> +	u32 val;
> +
> +	/* Device NAKs when exiting hibernation, so optionally retry here. */
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		err = regmap_write(cs40l50->regmap, CS40L50_DSP_QUEUE,
> +				     CS40L50_PREVENT_HIBER);
> +		if (!err)
> +			break;
> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}

Are you comfortable with the behaviour here? If the chip fails to
respond before the TIMEOUT, you will proceed on and do the read
loop. Since the read loop is just looking for a zero in the
queue, it looks like if for some reason the chip was too slow to
respond this function would succeed despite the chip never
receiving the PREVENT_HIBER. Would it not be safer to skip the
read loop if you fail to send the PREVENT_HIBER?

> +
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		err = regmap_read(cs40l50->regmap, CS40L50_DSP_QUEUE, &val);
> +		if (!err && val == 0)
> +			return 0;
> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}

I am not sure if the ignoring errors is important here (as it is
for the first loop), but if it is a comment should be added to
say why, and if it isn't, couldn't this be a
regmap_read_poll_timeout instead of a manual loop?

> +++ b/drivers/mfd/cs40l50-spi.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with waveform memory,
> + * integrated DSP, and closed-loop algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + * Author: James Ogletree <james.ogletree@cirrus.com>
> + */
> +
> +#include <linux/mfd/cs40l50.h>
> +#include <linux/mfd/spi.h>

Should be linux/spi/spi.h, make sure your build testing the whole
patch.

> +#ifndef __CS40L50_H__
> +#define __CS40L50_H__
> +
> +#include <linux/firmware/cirrus/cs_dsp.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +
> +/* Power Supply Configuration */
> +#define CS40L50_BLOCK_ENABLES2			0x201C
> +#define CS40L50_ERR_RLS				0x2034
> +#define CS40L50_PWRMGT_CTL			0x2900
> +#define CS40L50_BST_LPMODE_SEL			0x3810
> +#define CS40L50_DCM_LOW_POWER		0x1
> +#define CS40L50_OVERTEMP_WARN		0x4000010
> +
> +/* Interrupts */
> +#define CS40L50_IRQ1_INT_1			0xE010
> +#define CS40L50_IRQ1_MASK_1			0xE090
> +#define CS40L50_IRQ1_MASK_2			0xE094
> +#define CS40L50_IRQ1_MASK_20			0xE0DC
> +#define CS40L50_IRQ_MASK_2_OVERRIDE	0xFFDF7FFF
> +#define CS40L50_IRQ_MASK_20_OVERRIDE	0x15C01000
> +#define CS40L50_IRQ1_INT_1_OFFSET	(4 * 0)
> +#define CS40L50_IRQ1_INT_2_OFFSET	(4 * 1)
> +#define CS40L50_IRQ1_INT_8_OFFSET	(4 * 7)
> +#define CS40L50_IRQ1_INT_9_OFFSET	(4 * 8)
> +#define CS40L50_IRQ1_INT_10_OFFSET	(4 * 9)
> +#define CS40L50_IRQ1_INT_18_OFFSET	(4 * 17)
> +#define CS40L50_GLOBAL_ERR_RLS_SET	BIT(11)
> +#define CS40L50_GLOBAL_ERR_RLS_CLEAR	0
> +#define CS40L50_AMP_SHORT_MASK		BIT(31)
> +#define CS40L50_DSP_QUEUE_MASK		BIT(21)
> +#define CS40L50_TEMP_ERR_MASK		BIT(31)
> +#define CS40L50_BST_UVP_MASK		BIT(6)
> +#define CS40L50_BST_SHORT_MASK		BIT(7)
> +#define CS40L50_BST_ILIMIT_MASK		BIT(18)
> +#define CS40L50_UVLO_VDDBATT_MASK	BIT(16)
> +#define CS40L50_GLOBAL_ERROR_MASK	BIT(15)
> +
> +enum cs40l50_irq_list {
> +	CS40L50_DSP_QUEUE_IRQ,
> +	CS40L50_GLOBAL_ERROR_IRQ,
> +	CS40L50_UVLO_VDDBATT_IRQ,
> +	CS40L50_BST_ILIMIT_IRQ,
> +	CS40L50_BST_SHORT_IRQ,
> +	CS40L50_BST_UVP_IRQ,
> +	CS40L50_TEMP_ERR_IRQ,
> +	CS40L50_AMP_SHORT_IRQ,
> +};
> +
> +/* DSP */
> +#define CS40L50_XMEM_PACKED_0			0x2000000
> +#define CS40L50_XMEM_UNPACKED24_0		0x2800000
> +#define CS40L50_SYS_INFO_ID			0x25E0000
> +#define CS40L50_RAM_INIT			0x28021DC
> +#define CS40L50_DSP_QUEUE_WT			0x28042C8
> +#define CS40L50_DSP_QUEUE_RD			0x28042CC
> +#define CS40L50_POWER_ON_WSEQ			0x2804320
> +#define CS40L50_NUM_WAVES			0x280CB4C
> +#define CS40L50_CORE_BASE			0x2B80000
> +#define CS40L50_CCM_CORE_CONTROL		0x2BC1000
> +#define CS40L50_YMEM_PACKED_0			0x2C00000
> +#define CS40L50_YMEM_UNPACKED24_0		0x3400000
> +#define CS40L50_PMEM_0				0x3800000
> +#define CS40L50_MEM_RDY_HW		0x2
> +#define CS40L50_RAM_INIT_FLAG		0x1
> +#define CS40L50_CLOCK_DISABLE		0x80
> +#define CS40L50_CLOCK_ENABLE		0x281
> +#define CS40L50_DSP_POLL_US		1000
> +#define CS40L50_DSP_TIMEOUT_COUNT	100
> +#define CS40L50_RESET_PULSE_US		2200
> +#define CS40L50_CP_READY_US		3100
> +#define CS40L50_AUTOSUSPEND_MS		2000
> +#define CS40L50_PSEQ_SIZE		200
> +
> +/* DSP Commands */
> +#define CS40L50_DSP_QUEUE_BASE		0x11004
> +#define CS40L50_DSP_QUEUE_END		0x1101C
> +#define CS40L50_DSP_QUEUE		0x11020
> +#define CS40L50_PREVENT_HIBER	0x2000003
> +#define CS40L50_ALLOW_HIBER	0x2000004
> +#define CS40L50_START_I2S	0x3000002
> +#define CS40L50_OWT_PUSH	0x3000008
> +#define CS40L50_STOP_PLAYBACK	0x5000000
> +#define CS40L50_OWT_DELETE	0xD000000
> +
> +/* Firmware files */
> +#define CS40L50_FW	"cs40l50.wmfw"
> +#define CS40L50_WT	"cs40l50.bin"
> +
> +/* Device */
> +#define CS40L50_DEVID			0x0
> +#define CS40L50_REVID			0x4
> +#define CS40L50_DEVID_A		0x40A50
> +#define CS40L50_REVID_B0	0xB0

Admittedly a bit nitpicky but the tabbing here is all over the
place, would be nicer to line up the values on these defines.

Thanks,
Charles

