Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBE790DFC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbjICUxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjICUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:53:16 -0400
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Sep 2023 13:53:12 PDT
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785EC103
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:53:12 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5031E200054;
        Sun,  3 Sep 2023 20:45:10 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id 3508CA008D; Sun,  3 Sep 2023 22:45:02 +0200 (CEST)
Date:   Sun, 3 Sep 2023 22:45:02 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pcmcia: ds: fix possible name leak in error path in
 pcmcia_device_add()
Message-ID: <ZPTwTiTr1N0Gz7HY@shine.dominikbrodowski.net>
References: <20221112092924.3608240-1-yangyingliang@huawei.com>
 <20221112092924.3608240-2-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112092924.3608240-2-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, Nov 12, 2022 at 05:29:24PM +0800 schrieb Yang Yingliang:
> Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
> bus_id string array"), the name of device is allocated dynamically,
> it need bee freed.
> 
> As comment of device_register() says, it should use put_device() to
> give up the reference in the error path, some resources is going to
> freed in pcmcia_release_dev(), so don't use error label, just return
> NULL after calling put_device().
> 
> Before device_initialize(), it can not call put_device(), so move the
> dev_set_name() before device_register().
> 
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pcmcia/ds.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
> index 7d3258a1f8f8..a249d9a0457b 100644
> --- a/drivers/pcmcia/ds.c
> +++ b/drivers/pcmcia/ds.c
> @@ -513,9 +513,6 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
>  	/* by default don't allow DMA */
>  	p_dev->dma_mask = 0;
>  	p_dev->dev.dma_mask = &p_dev->dma_mask;
> -	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
> -	if (!dev_name(&p_dev->dev))
> -		goto err_free;
>  	p_dev->devname = kasprintf(GFP_KERNEL, "pcmcia%s", dev_name(&p_dev->dev));
>  	if (!p_dev->devname)
>  		goto err_free;
> @@ -573,8 +570,17 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
>  
>  	pcmcia_device_query(p_dev);
>  
> -	if (device_register(&p_dev->dev))
> +	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
> +	if (!dev_name(&p_dev->dev))
>  		goto err_put_ref;
> +	if (device_register(&p_dev->dev)) {

Thanks for your patch! I totally see your point. However, err_put_ref puts
the "wrong" reference (to &p_dev->function_config->ref), which doesn't help
with the issue you detected, as that requires &p_dev->dev to be dropped.
What about the following instead?

From: Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH] pcmcia: ds: fix possible name leak in error path in
 pcmcia_device_add()

Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
bus_id string array"), the name of device is allocated dynamically.
Therefore, it needs to be freed, which is done by the driver core for
us once all references to the device are gone. Therefore, move the
dev_set_name() call immediately before the call device_register(), which
either succeeds (then the freeing will be done upon subsequent remvoal),
or puts the reference in the error call. Also, it is not unusual that the
return value of dev_set_name is not checked.

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
[linux@dominikbrodowski.net: simplification, commit message modified]
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index c90c68dee1e4..b4b8363d1de2 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -513,9 +513,6 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	/* by default don't allow DMA */
 	p_dev->dma_mask = 0;
 	p_dev->dev.dma_mask = &p_dev->dma_mask;
-	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
-	if (!dev_name(&p_dev->dev))
-		goto err_free;
 	p_dev->devname = kasprintf(GFP_KERNEL, "pcmcia%s", dev_name(&p_dev->dev));
 	if (!p_dev->devname)
 		goto err_free;
@@ -573,6 +570,7 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
+	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
 	if (device_register(&p_dev->dev)) {
 		mutex_lock(&s->ops_mutex);
 		list_del(&p_dev->socket_device_list);
