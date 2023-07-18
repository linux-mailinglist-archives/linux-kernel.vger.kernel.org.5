Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824EE757DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjGRNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjGRNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:32:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924497;
        Tue, 18 Jul 2023 06:32:00 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EB1A7F3;
        Tue, 18 Jul 2023 15:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689687065;
        bh=CDlQt/aqwwdzSm2yeQRiyABXS9GNnR7K1F2R3sEC9uE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VpvfGkQ3WeiTuXcwWtmEetaO4KTQ5/OwKr1CuGLEQsENY3Vm0XkTb1SUxBLXC/GD0
         5131USLBvBFhopUH9hbS9QXTT/mRuZUjOvLs924ljQz8KgwhiuikTxLD4F6Wu/UPZs
         nuMR37HXVkAPFpHm7/gfgxHc84Npvv+tpdigwZFs=
Message-ID: <159ca9b9-0702-b347-3e4f-66272dfce55e@ideasonboard.com>
Date:   Tue, 18 Jul 2023 16:31:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH next] media: i2c: fix error handling in
 ub960_rxport_add_serializer()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/07/2023 11:58, Harshit Mogalapalli wrote:
> Smatch warns:
>   drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
>   err: 'rxport->ser.client' dereferencing possible ERR_PTR()
> 
> i2c_new_client_device() returns error pointers on failure and in
> dev_dbg statement we are dereferencing error pointer which is a bug.
> 
> Fix this by using IS_ERR() which checks for error pointers.
> 
> Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Found with static analysis, only compile tested. Although in
> drivers/media i2c_client_has_driver() checks are present, IS_ERR() would
> probably be sufficient here.
> ---
>   drivers/media/i2c/ds90ub960.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> index e101bcf2356a..88144e3ec183 100644
> --- a/drivers/media/i2c/ds90ub960.c
> +++ b/drivers/media/i2c/ds90ub960.c
> @@ -1662,7 +1662,7 @@ static int ub960_rxport_add_serializer(struct ub960_data *priv, u8 nport)
>   	ser_info.addr = rxport->ser.alias;
>   	rxport->ser.client =
>   		i2c_new_client_device(priv->client->adapter, &ser_info);
> -	if (!rxport->ser.client) {
> +	if (IS_ERR(rxport->ser.client)) {
>   		dev_err(dev, "rx%u: cannot add %s i2c device", nport,
>   			ser_info.type);
>   		return -EIO;

Good catch. I think this should be modified to return 
PTR_ERR(rxport->ser.client) instead of -EIO. Do you want to update the 
patch or shall I do the change?

  Tomi

