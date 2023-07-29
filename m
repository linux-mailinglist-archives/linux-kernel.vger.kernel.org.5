Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0780768043
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjG2PH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjG2PHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 11:07:25 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28ED2;
        Sat, 29 Jul 2023 08:07:20 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 915F3866AA;
        Sat, 29 Jul 2023 17:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690643237;
        bh=1IMdoRv4SuV4LxSu2XB9KSAUCBJsiYb/zydT9wcVmoM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F6qXZS+pg4o7k2obTkpt5wM5iEAHZGeTjM3856iErssCURP/6ancKKZZTqNWxzu70
         3zCsG4SPGe1o2KUNCyDL5qbIc1wCKQ2YBuvawxk6zFKMnyTd3Mej9UsrCVMa6GPIyQ
         Z/rKjG2rr4U7GGjbDBSmLO98LU+hwom0n2xyBQVC9wF3ULcgh+7Js7XhEPJmEP23ha
         QpKJw7G2vnpkGyMWEQvlqkY2O/TRMgHXjFX4vGutslNfpnEFYrpmfYCCs5j7R5U42i
         DAN6ug6Wkj+84AqXQeDY6xiIZOwhNyG97pvlVpWhuFJeE3fHt2SV1majRdMNhhd4H/
         xzyYj4Fko1A5Q==
Message-ID: <fd975ac8-bea4-22ae-cb5f-cbdaa3566d25@denx.de>
Date:   Sat, 29 Jul 2023 17:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/22] Input: ili210x - use device core to create
 driver-specific device attributes
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-13-dmitry.torokhov@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230729005133.1095051-13-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/23 02:51, Dmitry Torokhov wrote:
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/touchscreen/ili210x.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
> index ad6828e4f2e2..31ffdc2a93f3 100644
> --- a/drivers/input/touchscreen/ili210x.c
> +++ b/drivers/input/touchscreen/ili210x.c
> @@ -876,7 +876,7 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
>   
>   static DEVICE_ATTR(firmware_update, 0200, NULL, ili210x_firmware_update_store);
>   
> -static struct attribute *ili210x_attributes[] = {
> +static struct attribute *ili210x_attrs[] = {
>   	&dev_attr_calibrate.attr,
>   	&dev_attr_firmware_update.attr,
>   	&dev_attr_firmware_version.attr,
> @@ -904,10 +904,11 @@ static umode_t ili210x_attributes_visible(struct kobject *kobj,
>   	return attr->mode;
>   }
>   
> -static const struct attribute_group ili210x_attr_group = {
> -	.attrs = ili210x_attributes,
> +static const struct attribute_group ili210x_group = {
> +	.attrs = ili210x_attrs,

Is all the renaming really necessary and relevant to this patch ?

btw since I have your attention, could you also look at discussion
[PATCH] Input: pwm-beeper - Support volume setting via sysfs
? I've been waiting for any maintainer input for over two months now.

Thanks
