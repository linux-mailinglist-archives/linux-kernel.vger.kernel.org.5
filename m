Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4680B970
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjLJGzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJGzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:55:01 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA013F3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:55:06 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CDiQrvZbCPWeOCDiRrfpzQ; Sun, 10 Dec 2023 07:55:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702191304;
        bh=Ops1ZNxu7HNrhKVpPxwdyUcur4Rz0l4wMUB2Kb6o1as=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tVpkiRyrHPR+W+9JQPRvx1ZTR1agbEucnIH6Q9kJTvwWcuROiCVtURRJwmnG2D3iR
         khAwIvMIffgJO4iBCTJL1ABVq/whWr/dElnhHhvPBV00Hi/ZWy+t7JvTSSIF8GbGc9
         roTgF9ruAnaqnzMLo46Dq4Oy0Q9Q35dilH7LoHuXCrG4eHBdQVR5JfSWrGYKNuw9jk
         NmpJU74QLdu5UsdExLaEpep0Or3iB6ITC6OalebgWuvPA4toK6+PJGoAjFkBTNlIaP
         h4iFHlcVG4L64LYYyYTXpCiErt8Q75vJnjkP9LPhI23neEv0OUGej/AEntlsChN+qt
         TKCR5TjWRhj+A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 07:55:04 +0100
X-ME-IP: 92.140.202.140
Message-ID: <e02bc48e-58dd-44d6-ae89-a6a2936df778@wanadoo.fr>
Date:   Sun, 10 Dec 2023 07:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bus: ts-nbus: Improve error reporting
Content-Language: fr
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
 <20702efe8ab96add9773e97ceed1a6cf91a065ee.1702160838.git.u.kleine-koenig@pengutronix.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20702efe8ab96add9773e97ceed1a6cf91a065ee.1702160838.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/12/2023 à 23:35, Uwe Kleine-König a écrit :
> Using dev_err_probe() brings several improvements:
> 
>   - emits the symbolic error code
>   - properly handles EPROBE_DEFER
>   - combines error message generation and return value handling
> 
> While at it add error messages to two error paths that were silent
> before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/bus/ts-nbus.c | 65 ++++++++++++++++++-------------------------
>   1 file changed, 27 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c

...

> @@ -289,25 +283,19 @@ static int ts_nbus_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	pwm = devm_pwm_get(dev, NULL);
> -	if (IS_ERR(pwm)) {
> -		ret = PTR_ERR(pwm);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "unable to request PWM\n");
> -		return ret;
> -	}
> +	if (IS_ERR(pwm))
> +		return dev_err_probe(dev, ret, "unable to request PWM\n");

s/ret/PTR_ERR(pwm)/

CJ
