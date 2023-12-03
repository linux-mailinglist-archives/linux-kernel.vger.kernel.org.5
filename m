Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B4802285
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjLCKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjLCKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:34:19 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44955F3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:34:24 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 9jnnrzqJl1Jmd9jnnrQmaj; Sun, 03 Dec 2023 11:34:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701599662;
        bh=SpJ1CYeXnFol7k9kyFWf28kKK7//pxX9y3k8iQStw7U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iQl/hqLb9G5a3dwXg5GPC1loCFNzjKZuTaENg+/o1uwROK63L5mBXyEUOcbj2GQqb
         ZvnWY5tyroWmM4F3Gzcz6rIwC+7CWbjJYMZmTF5S4btTCGZqnwc785FmRCX2ZThh2C
         mgrlgvCc1Z4w1R1wMsg+2ee42qCY7coH63usmo4nQPr0UOOF12gYmwi17Fussts3dh
         y5HYtTqi4CJV0ZvT5PyeknO5DYAltSgUjz2Dn1AfoooCJsGdrd6feSTvqsTn1zQ59A
         6d/SKU0kDXhspKyJNXa6BTcPGqTRmcV7iXCLT0dKngGptR++ft8yK2vyTFPZoGXJT4
         /6NMNvqqk2wOQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Dec 2023 11:34:22 +0100
X-ME-IP: 92.140.202.140
Message-ID: <87d394e4-e290-41a6-aaf2-92cf6b5ad919@wanadoo.fr>
Date:   Sun, 3 Dec 2023 11:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: aic7xxx: return negative error codes in
 aic7770_probe()
To:     Su Hui <suhui@nfschina.com>, dan.carpenter@linaro.org,
        hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20231201025955.1584260-1-suhui@nfschina.com>
 <20231201025955.1584260-4-suhui@nfschina.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231201025955.1584260-4-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/12/2023 à 03:59, Su Hui a écrit :
> aic7770_config() returns both negative and positive error code.
> it's better to make aic7770_probe() only return negative error codes.
> 
> And the previous patch made ahc_linux_register_host() return negative error
> codes, which makes sure aic7770_probe() returns negative error codes.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   drivers/scsi/aic7xxx/aic7770_osm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c b/drivers/scsi/aic7xxx/aic7770_osm.c
> index bdd177e3d762..a19cdd87c453 100644
> --- a/drivers/scsi/aic7xxx/aic7770_osm.c
> +++ b/drivers/scsi/aic7xxx/aic7770_osm.c
> @@ -87,17 +87,17 @@ aic7770_probe(struct device *dev)
>   	sprintf(buf, "ahc_eisa:%d", eisaBase >> 12);
>   	name = kstrdup(buf, GFP_ATOMIC);
>   	if (name == NULL)
> -		return (ENOMEM);
> +		return -ENOMEM;
>   	ahc = ahc_alloc(&aic7xxx_driver_template, name);
>   	if (ahc == NULL)

Unrelated to your fix, but 'name' is leaking here.

Also, kasprintf() could be used to avoid buf+sprintf()+kstrdup()

The GFP_ATOMIC in the allocation could certainly also be just a GFP_KERNEL.

CJ

> -		return (ENOMEM);
> +		return -ENOMEM;
>   	ahc->dev = dev;
>   	error = aic7770_config(ahc, aic7770_ident_table + edev->id.driver_data,
>   			       eisaBase);
>   	if (error != 0) {
>   		ahc->bsh.ioport = 0;
>   		ahc_free(ahc);
> -		return (error);
> +		return error < 0 ? error : -error;
>   	}
>   
>    	dev_set_drvdata(dev, ahc);

