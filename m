Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4E7BF56E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442700AbjJJIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442638AbjJJIPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:15:11 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA997;
        Tue, 10 Oct 2023 01:15:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9F241C0009;
        Tue, 10 Oct 2023 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696925708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tRpb3t7fopvwXtyYlHe5ClDQc/xxw7GjN/sHh0MTOA=;
        b=UC5MhKsZOHE76bgSA8mh7nAAx4qWRNSNw9OgpGZSuq7yDVsPbi0cXr6AQEb3h0y5Ba5KCI
        r2buftggrKtGjoAUdspBQGxQUmy28Wsw/3z1rqL6ULb0+tRAdVWg8hUIPTIcVb0RVa7NVa
        Z/QwTsWkYgy23zdLpqndm92BBkjccPZzeUHnnMIaurLrRT67Qm+7jzXQ8vRr8HzeRY7e7w
        u2uVn484d6G3juiE7R1mY/5finbi+tQ8WUHefk6OhrSG6izCdL7b9V5pfne1El15z6E5hd
        FI8Kj1qkn45O6eBbMAPvgr9gdM9en5CODzUo6Xy3zPT7528nSnqwHELlzDAL0A==
Date:   Tue, 10 Oct 2023 10:15:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drivers/rtc/sysfs: move code to
 count_attribute_groups()
Message-ID: <202310100815076048fb2c@mail.local>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 18:57:34+0200, Max Kellermann wrote:
> This avoids overloading the "groups" variable for three different
> purposes
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  drivers/rtc/sysfs.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
> index e3062c4d3f2c..617933d52324 100644
> --- a/drivers/rtc/sysfs.c
> +++ b/drivers/rtc/sysfs.c
> @@ -313,21 +313,25 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
>  	return rtc_attr_groups;
>  }
>  
> +static size_t count_attribute_groups(const struct attribute_group *const*groups)

Shouldn't that live out of the rtc subsystem?

> +{
> +	size_t count = 0;
> +
> +	for (; *groups; ++groups)
> +		++count;
> +	return count;
> +}
> +
>  int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
>  {
> -	size_t old_cnt = 0, add_cnt = 0, new_cnt;
> +	size_t old_cnt, add_cnt, new_cnt;
>  	const struct attribute_group **groups, **old;
>  
>  	if (!grps)
>  		return -EINVAL;
>  
> -	groups = rtc->dev.groups;
> -	if (groups)
> -		for (; *groups; groups++)
> -			old_cnt++;
> -
> -	for (groups = grps; *groups; groups++)
> -		add_cnt++;
> +	old_cnt = rtc->dev.groups ? count_attribute_groups(rtc->dev.groups) : 0;
> +	add_cnt = count_attribute_groups(grps);
>  
>  	new_cnt = old_cnt + add_cnt + 1;
>  	groups = devm_kcalloc(&rtc->dev, new_cnt, sizeof(*groups), GFP_KERNEL);
> -- 
> 2.39.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
