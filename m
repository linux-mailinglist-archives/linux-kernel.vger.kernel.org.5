Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2D7B11F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjI1FVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1FVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:21:34 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B3126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:21:29 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ljSlqFbLERAigljSlqPB4M; Thu, 28 Sep 2023 07:21:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695878486;
        bh=Qq/+0qhLjJW24ILoN1sDQ1g5q2A5YK960iOj7lPaxOc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=piDk27Q4uS2VS9NvUHCRIWX8Z/j4YURkBWsPUgfjildpTSeGRAdxexkNS63fw7uQs
         BLszkPyXgqa7FMeFhjfkaFZT5booJb1DLdXHP/7i8+3TyMp267BHSvdWosWochlHMR
         u377Xe3GV6jhwzuQXpqrRuKFWU1Z6KLA31YVm3yegEZszuX1rdCrcURy4LYDTrxO8+
         nf3O8F5NByE6Pt9tYSVDQqYusbiST+CE0uKh9QmNNfMFfD0dHGme1/mUi/S5n+33Ya
         Ja8zCFwJuhK+L9D+ZemPMkfeGRmSUGS+AanJdbsZZTLCDDr0aBUPWrGRC+AiL3eFbd
         BA3fUSqjUkQQQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 28 Sep 2023 07:21:26 +0200
X-ME-IP: 86.243.2.178
Message-ID: <73a189c9-6263-900e-ed6b-83a9d03fd855@wanadoo.fr>
Date:   Thu, 28 Sep 2023 07:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/5] power: supply: rt5033_charger: Add cable detection
 and USB OTG supply
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <cover.1695844349.git.jahau@rocketmail.com>
 <efe3e6132216ff87a1643c0fdbf471a672a3f4f3.1695844349.git.jahau@rocketmail.com>
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <efe3e6132216ff87a1643c0fdbf471a672a3f4f3.1695844349.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/09/2023 à 22:25, Jakob Hauser a écrit :
> Implement cable detection by extcon and handle the driver according to the
> connector type.
>
> There are basically three types of action: "set_charging", "set_otg" and
> "set_disconnect".
>
> A forth helper function to "unset_otg" was added because this is used in both
> "set_charging" and "set_disconnect". In the first case it covers the rather
> rare event that someone changes from OTG to charging without disconnect. In
> the second case, when disconnecting, the values are set back to the ones from
> initialization to return into a defined state.
>
> Additionally, there is "set_mivr". When connecting to e.g. a laptop/PC, the
> minimum input voltage regulation (MIVR) shall prevent a voltage drop if the
> cable or the supply is weak. The MIVR value is set to 4600MV, same as in the
> Android driver [1]. When disconnecting, MIVR is set back to DISABLED.
>
> In the function rt5033_get_charger_state(): When in OTG mode, the chip
> reports status "charging". Change this to "discharging" because there is
> no charging going on in OTG mode [2].
>
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L499
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L686-L687
>
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/power/supply/rt5033_charger.c | 276 +++++++++++++++++++++++++-
>   1 file changed, 274 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
> index 57a0dc631e85..2c2073b8979d 100644
> --- a/drivers/power/supply/rt5033_charger.c
> +++ b/drivers/power/supply/rt5033_charger.c
> @@ -6,8 +6,11 @@
>    * Author: Beomho Seo <beomho.seo@samsung.com>
>    */
>   
> +#include <linux/devm-helpers.h>
> +#include <linux/extcon.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/power_supply.h>
> @@ -27,6 +30,14 @@ struct rt5033_charger {
>   	struct regmap			*regmap;
>   	struct power_supply		*psy;
>   	struct rt5033_charger_data	*chg;
> +	struct extcon_dev		*edev;
> +	struct notifier_block		extcon_nb;
> +	struct work_struct		extcon_work;
> +	struct mutex			lock;
> +	bool online;
> +	bool otg;
> +	bool mivr_enabled;
> +	u8 cv_regval;
>   };
>   
>   static int rt5033_get_charger_state(struct rt5033_charger *charger)
> @@ -57,6 +68,10 @@ static int rt5033_get_charger_state(struct rt5033_charger *charger)
>   		state = POWER_SUPPLY_STATUS_UNKNOWN;
>   	}
>   
> +	/* For OTG mode, RT5033 would still report "charging" */
> +	if (charger->otg)
> +		state = POWER_SUPPLY_STATUS_DISCHARGING;
> +
>   	return state;
>   }
>   
> @@ -148,6 +163,9 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
>   		return -EINVAL;
>   	}
>   
> +	/* Store that value for later usage */
> +	charger->cv_regval = reg_data;
> +
>   	/* Set end of charge current */
>   	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
>   	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
> @@ -331,6 +349,152 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
>   	return 0;
>   }
>   
> +static int rt5033_charger_set_otg(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/* Set OTG boost v_out to 5 volts */
> +	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
> +			RT5033_CHGCTRL2_CV_MASK,
> +			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed set OTG boost v_out\n");


unlock


> +		return -EINVAL;
> +	}
> +
> +	/* Set operation mode to OTG */
> +	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
> +			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to update OTG mode.\n");


unlock


> +		return -EINVAL;
> +	}
> +
> +	/* In case someone switched from charging to OTG directly */
> +	if (charger->online)
> +		charger->online = false;
> +
> +	charger->otg = true;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
> +{
> +	int ret;
> +	u8 data;
> +
> +	/* Restore constant voltage for charging */
> +	data = charger->cv_regval;
> +	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
> +			RT5033_CHGCTRL2_CV_MASK,
> +			data << RT5033_CHGCTRL2_CV_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to restore constant voltage\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set operation mode to charging */
> +	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
> +			RT5033_CHGCTRL1_MODE_MASK, RT5033_CHARGER_MODE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to update charger mode.\n");
> +		return -EINVAL;
> +	}
> +
> +	charger->otg = false;
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_set_charging(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/* In case someone switched from OTG to charging directly */
> +	if (charger->otg) {
> +		ret = rt5033_charger_unset_otg(charger);
> +		if (ret)


unlock


> +			return -EINVAL;
> +	}
> +
> +	charger->online = true;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/*
> +	 * When connected via USB connector type SDP (Standard Downstream Port),
> +	 * the minimum input voltage regulation (MIVR) should be enabled. It
> +	 * prevents an input voltage drop due to insufficient current provided
> +	 * by the adapter or USB input. As a downside, it may reduces the
> +	 * charging current and thus slows the charging.
> +	 */
> +	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
> +			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to set MIVR level.\n");


unlock


> +		return -EINVAL;
> +	}
> +
> +	charger->mivr_enabled = true;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	/* Beyond this, do the same steps like setting charging */
> +	rt5033_charger_set_charging(charger);
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
> +{
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	/* Disable MIVR if enabled */
> +	if (charger->mivr_enabled) {
> +		ret = regmap_update_bits(charger->regmap,
> +				RT5033_REG_CHG_CTRL4,
> +				RT5033_CHGCTRL4_MIVR_MASK,
> +				RT5033_CHARGER_MIVR_DISABLE);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to disable MIVR.\n");


unlock


> +			return -EINVAL;
> +		}
> +
> +		charger->mivr_enabled = false;
> +	}
> +
> +	if (charger->otg) {
> +		ret = rt5033_charger_unset_otg(charger);
> +		if (ret)


unlock


> +			return -EINVAL;
> +	}
> +
> +	if (charger->online)
> +		charger->online = false;
> +
> +	mutex_unlock(&charger->lock);
> +
> +	return 0;
> +}
> +
>   static enum power_supply_property rt5033_charger_props[] = {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_CHARGE_TYPE,
> @@ -367,8 +531,7 @@ static int rt5033_charger_get_property(struct power_supply *psy,
>   		val->strval = RT5033_MANUFACTURER;
>   		break;
>   	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval = (rt5033_get_charger_state(charger) ==
> -				POWER_SUPPLY_STATUS_CHARGING);
> +		val->intval = charger->online;
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -403,6 +566,86 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
>   	return chg;
>   }
>   
> +static void rt5033_charger_extcon_work(struct work_struct *work)
> +{
> +	struct rt5033_charger *charger =
> +		container_of(work, struct rt5033_charger, extcon_work);
> +	struct extcon_dev *edev = charger->edev;
> +	int connector, state;
> +	int ret;
> +
> +	for (connector = EXTCON_USB_HOST; connector <= EXTCON_CHG_USB_PD;
> +	     connector++) {
> +		state = extcon_get_state(edev, connector);
> +		if (state == 1)
> +			break;
> +	}
> +
> +	/*
> +	 * Adding a delay between extcon notification and extcon action. This
> +	 * makes extcon action execution more reliable. Without the delay the
> +	 * execution sometimes fails, possibly because the chip is busy or not
> +	 * ready.
> +	 */
> +	msleep(100);
> +
> +	switch (connector) {
> +	case EXTCON_CHG_USB_SDP:
> +		ret = rt5033_charger_set_mivr(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set USB mode\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "USB mode. connector type: %d\n",
> +			 connector);
> +		break;
> +	case EXTCON_CHG_USB_DCP:
> +	case EXTCON_CHG_USB_CDP:
> +	case EXTCON_CHG_USB_ACA:
> +	case EXTCON_CHG_USB_FAST:
> +	case EXTCON_CHG_USB_SLOW:
> +	case EXTCON_CHG_WPT:
> +	case EXTCON_CHG_USB_PD:
> +		ret = rt5033_charger_set_charging(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set charging\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "charging. connector type: %d\n",
> +			 connector);
> +		break;
> +	case EXTCON_USB_HOST:
> +		ret = rt5033_charger_set_otg(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set OTG\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "OTG enabled\n");
> +		break;
> +	default:
> +		ret = rt5033_charger_set_disconnect(charger);
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set disconnect\n");
> +			break;
> +		}
> +		dev_info(charger->dev, "disconnected\n");
> +		break;
> +	}
> +
> +	power_supply_changed(charger->psy);
> +}
> +
> +static int rt5033_charger_extcon_notifier(struct notifier_block *nb,
> +					  unsigned long event, void *param)
> +{
> +	struct rt5033_charger *charger =
> +		container_of(nb, struct rt5033_charger, extcon_nb);
> +
> +	schedule_work(&charger->extcon_work);
> +
> +	return NOTIFY_OK;
> +}
> +
>   static const struct power_supply_desc rt5033_charger_desc = {
>   	.name = "rt5033-charger",
>   	.type = POWER_SUPPLY_TYPE_USB,
> @@ -415,6 +658,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
>   {
>   	struct rt5033_charger *charger;
>   	struct power_supply_config psy_cfg = {};
> +	struct device_node *np_conn, *np_edev;
>   	int ret;
>   
>   	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> @@ -424,6 +668,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, charger);
>   	charger->dev = &pdev->dev;
>   	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	mutex_init(&charger->lock);
>   
>   	psy_cfg.of_node = pdev->dev.of_node;
>   	psy_cfg.drv_data = charger;
> @@ -443,6 +688,33 @@ static int rt5033_charger_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * Extcon support is not vital for the charger to work. If no extcon
> +	 * is available, just emit a warning and leave the probe function.
> +	 */
> +	np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
> +	np_edev = of_get_parent(np_conn);
> +	charger->edev = extcon_find_edev_by_node(np_edev);
> +	if (IS_ERR(charger->edev)) {
> +		dev_warn(&pdev->dev, "no extcon device found in device-tree\n");
> +		goto out;
> +	}
> +
> +	ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
> +				   rt5033_charger_extcon_work);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize extcon work\n");
> +		return ret;
> +	}
> +
> +	charger->extcon_nb.notifier_call = rt5033_charger_extcon_notifier;
> +	ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> +						&charger->extcon_nb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register extcon notifier\n");
> +		return ret;
> +	}
> +out:
>   	return 0;
>   }
>   
