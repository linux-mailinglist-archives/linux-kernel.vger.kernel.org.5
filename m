Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D112D7B11FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjI1FXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1FXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:23:47 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448A3122
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:23:45 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ljUtq9EaLa6PDljUtqdzVs; Thu, 28 Sep 2023 07:23:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695878623;
        bh=K5LYNUETcp0qOAJpxVYNrqfYgPjTj2D48kgaIAy23YY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YUSISq9Cl/SHiLrMnGRgXt+HQoS/XFHpvOinBwhI22S0oSSdgX/T4VroXIp0CjlKC
         CVyQhT1BdBQgkobw8JuPpeTsNJ+/AzBDCbIUtGQv/2dx76g61Mvk9XvVNYOWcA6JBJ
         fTFZsbpJ976wxWKyWlQbvE+piOv1hu3QX7FVV82I3KW8ajUJDrX2OoFhsmSvlDqdtD
         wpq5NnjxUe0MhnoSEhwH/R0/iKC1qZsR0yQm9EG4dx8B9rBOEvwTGIAcyrVvRASiII
         kbHFtbz0YDCbieuosQBpbB00+UqVlSiWNvqfpm+aRLcTSsPB7Ml2eRLv5u2Uj3GOeo
         CutG4094UGBGw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 28 Sep 2023 07:23:43 +0200
X-ME-IP: 86.243.2.178
Message-ID: <89351ef6-ab81-c679-4432-cc44de9a91f1@wanadoo.fr>
Date:   Thu, 28 Sep 2023 07:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] power: supply: rt5033_charger: fix missing unlock
Content-Language: fr
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1695844349.git.jahau@rocketmail.com>
 <e437e728317b6a2a860f7812f64a98146a27965e.1695844349.git.jahau@rocketmail.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <e437e728317b6a2a860f7812f64a98146a27965e.1695844349.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, but why not already in patch #1?

CJ


Le 27/09/2023 à 22:26, Jakob Hauser a écrit :
> From: Yang Yingliang <yangyingliang@huawei.com>
>
> Fix missing mutex_unlock() in some error path.
>
> Fixes: 12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>   drivers/power/supply/rt5033_charger.c | 28 ++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
> index 2c2073b8979d..091ca4a21f29 100644
> --- a/drivers/power/supply/rt5033_charger.c
> +++ b/drivers/power/supply/rt5033_charger.c
> @@ -361,7 +361,8 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
>   			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
>   	if (ret) {
>   		dev_err(charger->dev, "Failed set OTG boost v_out\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_unlock;
>   	}
>   
>   	/* Set operation mode to OTG */
> @@ -369,7 +370,8 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
>   			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
>   	if (ret) {
>   		dev_err(charger->dev, "Failed to update OTG mode.\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_unlock;
>   	}
>   
>   	/* In case someone switched from charging to OTG directly */
> @@ -378,9 +380,10 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
>   
>   	charger->otg = true;
>   
> +out_unlock:
>   	mutex_unlock(&charger->lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
> @@ -420,8 +423,10 @@ static int rt5033_charger_set_charging(struct rt5033_charger *charger)
>   	/* In case someone switched from OTG to charging directly */
>   	if (charger->otg) {
>   		ret = rt5033_charger_unset_otg(charger);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&charger->lock);
>   			return -EINVAL;
> +		}
>   	}
>   
>   	charger->online = true;
> @@ -448,6 +453,7 @@ static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
>   			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
>   	if (ret) {
>   		dev_err(charger->dev, "Failed to set MIVR level.\n");
> +		mutex_unlock(&charger->lock);
>   		return -EINVAL;
>   	}
>   
> @@ -463,7 +469,7 @@ static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
>   
>   static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
>   {
> -	int ret;
> +	int ret = 0;
>   
>   	mutex_lock(&charger->lock);
>   
> @@ -475,7 +481,8 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
>   				RT5033_CHARGER_MIVR_DISABLE);
>   		if (ret) {
>   			dev_err(charger->dev, "Failed to disable MIVR.\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out_unlock;
>   		}
>   
>   		charger->mivr_enabled = false;
> @@ -483,16 +490,19 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
>   
>   	if (charger->otg) {
>   		ret = rt5033_charger_unset_otg(charger);
> -		if (ret)
> -			return -EINVAL;
> +		if (ret) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
>   	}
>   
>   	if (charger->online)
>   		charger->online = false;
>   
> +out_unlock:
>   	mutex_unlock(&charger->lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static enum power_supply_property rt5033_charger_props[] = {
