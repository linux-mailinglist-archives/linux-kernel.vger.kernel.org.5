Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C855F790DFD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347982AbjICUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjICUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:53:15 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E63F106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:53:12 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4F1CB200053;
        Sun,  3 Sep 2023 20:45:10 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id 38DB9A008B; Sun,  3 Sep 2023 22:43:59 +0200 (CEST)
Date:   Sun, 3 Sep 2023 22:43:59 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pcmcia: ds: fix refcount leak in pcmcia_device_add()
Message-ID: <ZPTwD3UX3I34VLbb@shine.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112092924.3608240-2-yangyingliang@huawei.com>
 <20221112092924.3608240-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sat, Nov 12, 2022 at 05:29:23PM +0800 schrieb Yang Yingliang:
> If device_register() returns error, the refcount of function_config
> need be put.
> 
> Fixes: 360b65b95bae ("[PATCH] pcmcia: make config_t independent, add reference counting")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pcmcia/ds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
> index ace133b9f7d4..7d3258a1f8f8 100644
> --- a/drivers/pcmcia/ds.c
> +++ b/drivers/pcmcia/ds.c
> @@ -574,10 +574,12 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
>  	pcmcia_device_query(p_dev);
>  
>  	if (device_register(&p_dev->dev))
> -		goto err_unreg;
> +		goto err_put_ref;
>  
>  	return p_dev;
>  
> + err_put_ref:
> +	kref_put(&p_dev->function_config->ref, pcmcia_release_function);
>   err_unreg:
>  	mutex_lock(&s->ops_mutex);
>  	list_del(&p_dev->socket_device_list);
> -- 
> 2.25.1
> 

Indeed, there's a reference leak here in this failure path. However, you
rightly note in your subsequent patch:

Am Sat, Nov 12, 2022 at 05:29:24PM +0800 schrieb Yang Yingliang:
> As comment of device_register() says, it should use put_device() to
> give up the reference in the error path, some resources is going to
> freed in pcmcia_release_dev(), so don't use error label, just return
> NULL after calling put_device().

Therefore, I'd suggest to combine both things:


From: Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH] pcmcia: ds: fix refcount leak in pcmcia_device_add()

As the comment of device_register() says, it should use put_device()
to give up the reference in the error path. Then, insofar resources
will be freed in pcmcia_release_dev(), the error path is no longer
needed. In particular, this means that the (previously missing) dropping
of the reference to &p_dev->function_config->ref is now handled by
pcmcia_release_dev().

Fixes: 360b65b95bae ("[PATCH] pcmcia: make config_t independent, add reference counting")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
[linux@dominikbrodowski.net: simplification, commit message rewrite]
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index d500e5dbbc3f..c90c68dee1e4 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -573,8 +573,14 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
-	if (device_register(&p_dev->dev))
-		goto err_unreg;
+	if (device_register(&p_dev->dev)) {
+		mutex_lock(&s->ops_mutex);
+		list_del(&p_dev->socket_device_list);
+		s->device_count--;
+		mutex_unlock(&s->ops_mutex);
+		put_device(&p_dev->dev);
+		return NULL;
+	}
 
 	return p_dev;
 



What do you think?

Best,
	Dominik
