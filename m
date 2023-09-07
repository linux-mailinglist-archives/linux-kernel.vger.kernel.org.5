Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174B0797A90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbjIGRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245307AbjIGRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:44:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88311BCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:44:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2C7E660730A;
        Thu,  7 Sep 2023 13:20:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694089212;
        bh=9nFIF3CS/uUveFelu84S9tXR3ZFKHURU3blJxWp35Mo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UcLWjEw45AJI43p/8EiHne0nwzX8pZ1kfZ7Fnh+yFsoJIZyMIYfxyVHtQL1eBE+kG
         B2gxgGgCslcNKATRDaS6vqN9tnQtaaGb1Wh0YXK1UO5AZsA00fSLaZ8bDJin96mdQI
         BtxXNg6zI7FE0krVRLK6KplRXApp/BR9zJrPc9eBOxzrDBa2E4B5reuv8wdQ8gDKr2
         JzFE2UrJniQ197okp/0hJnn/oLF0M6bPBVm8e0BeSAtiLWIookpC30wKBAMn+HhJBz
         iuaczJ0GqSu5mgqtjUe1/nDNEItuuojLQYkWQHQv4JtscdJ95eH8DVEbPnJ4+toY0w
         f5Hgpf15LcBaQ==
Message-ID: <304cf77f-b239-6ed7-2f86-7cc601f6067a@collabora.com>
Date:   Thu, 7 Sep 2023 14:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/15] drm/mediatek: Support CRC in display driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
 <20230823151332.28811-11-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-11-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/08/23 17:13, Hsiao Chien Sung ha scritto:
> Register CRC related function pointers to support CRC
> retrieval.
> 
> Skip the first CRC because when the first vblank triggered,
> the frame buffer is not ready for CRC calculation yet.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 53 +++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.h     | 20 ++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  5 ++
>   3 files changed, 78 insertions(+)
> 

..snip..

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index febcaeef16a1..3b67c3dc0525 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -45,6 +45,10 @@ enum mtk_ddp_comp_type {
>   
>   struct mtk_ddp_comp;
>   struct cmdq_pkt;
> +
> +/* struct mtk_ddp_comp_funcs - function pointers of the ddp components

While at it, can you at this point just add kerneldoc for the entire structure?
That should be pretty straightforward, and just a 10 minutes job.

Thanks!
Angelo

> + * @crc_cnt: how many CRCs the component supports
> + */
>   struct mtk_ddp_comp_funcs {
>   	int (*clk_enable)(struct device *dev);
>   	void (*clk_disable)(struct device *dev);
> @@ -80,6 +84,7 @@ struct mtk_ddp_comp_funcs {
>   	void (*disconnect)(struct device *dev, struct device *mmsys_dev, unsigned int next);
>   	void (*add)(struct device *dev, struct mtk_mutex *mutex);
>   	void (*remove)(struct device *dev, struct mtk_mutex *mutex);
> +	u32 (*crc_cnt)(struct device *dev);
>   };
>   

