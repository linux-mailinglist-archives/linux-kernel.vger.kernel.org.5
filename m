Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E997A87CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbjITPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjITPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:03:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54C7AD;
        Wed, 20 Sep 2023 08:03:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43EEE66071DC;
        Wed, 20 Sep 2023 16:03:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695222231;
        bh=0HPlpQakJrXjW7SQHdHHGKTtA1MdZ9XLz+FFXgI3KvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9LsKxu/5SkYzDko1gEYhQqW2EhOn2AaMzI4Uemgy9+L9fiLIEyKpJXwKApxOgBzr
         ZIwSSO45NeACSR5G5Vy0T1sE2+S9fixrrpQmdiw4JVapyZgQxMQDmYyQ+zwCkuTBEl
         3DoTuwEJ5LVq/52PkVB69a/bCpAolPPdKKg5FVK53dkS2ECcAyKM2FKjoyRxuLVaUv
         MbmQB5fNUXM55rbnD4za8myRBz2CDnguAkYYOKVV9qXM5CuwYm6DOBCAdQqxTqwLO6
         jY/swgWX97zvfIbZwltfnibPzqM9y7vf3rTpVeeCvJ0q1ajVjBGzeNFL8ogwarSBgI
         mER0f7sSEDxNw==
From:   Laura Nao <laura.nao@collabora.com>
To:     angelogioacchino.delregno@collabora.com
Cc:     andersson@kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        matthias.bgg@gmail.com, tinghan.shen@mediatek.com,
        wenst@chromium.org, Laura Nao <laura.nao@collabora.com>
Subject: Re: [PATCH] remoteproc: mediatek: Refactor single core check and fix retrocompatibility
Date:   Wed, 20 Sep 2023 17:03:32 +0200
Message-Id: <20230920150332.318851-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
References: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 11:23, AngeloGioacchino Del Regno wrote:
> In older devicetrees we had the ChromeOS EC in a node called "cros-ec"
> instead of the newer "cros-ec-rpmsg", but this driver is now checking
> only for the latter, breaking compatibility with those.
> 
> Besides, we can check if the SCP is single or dual core by simply
> walking through the children of the main SCP node and checking if
> if there's more than one "mediatek,scp-core" compatible node.
> 
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/remoteproc/mtk_scp.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 

Tested on asurada (spherion) and jacuzzi (juniper). The issue was detected by KernelCI, so:

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Tested-by: Laura Nao <laura.nao@collabora.com>

Thanks!
Laura

> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index ea227b566c54..a35409eda0cf 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1144,29 +1144,25 @@ static int scp_add_multi_core(struct platform_device *pdev,
>   	return ret;
>   }
>   
> -static int scp_is_single_core(struct platform_device *pdev)
> +static bool scp_is_single_core(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev_of_node(dev);
>   	struct device_node *child;
> +	int num_cores = 0;
>   
> -	child = of_get_next_available_child(np, NULL);
> -	if (!child)
> -		return dev_err_probe(dev, -ENODEV, "No child node\n");
> +	for_each_child_of_node(np, child)
> +		if (of_device_is_compatible(child, "mediatek,scp-core"))
> +			num_cores++;
>   
> -	of_node_put(child);
> -	return of_node_name_eq(child, "cros-ec-rpmsg");
> +	return num_cores < 2;
>   }
>   
>   static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
>   {
>   	int ret;
>   
> -	ret = scp_is_single_core(pdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret)
> +	if (scp_is_single_core(pdev))
>   		ret = scp_add_single_core(pdev, scp_cluster);
>   	else
>   		ret = scp_add_multi_core(pdev, scp_cluster);

