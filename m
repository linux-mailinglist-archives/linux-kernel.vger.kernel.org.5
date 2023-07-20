Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5729B75A81C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGTHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjGTHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:45:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F7213D;
        Thu, 20 Jul 2023 00:45:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD3F2660707E;
        Thu, 20 Jul 2023 08:45:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689839107;
        bh=rgSn9DWoFWUAm/Y0pTg4nWPsIDpMJSJrwWH1cSs9tnk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gcAqBmgd+oAnAri/JPEFpV2Yyrt9NdM06QT3VWpsjqfzIBmhFoeUSpDVOdLeGbLNy
         QGBh/cah2lyrLpxEP2bKq/WpLjFeMAyUt+Hki6f2m9MtX45P+YHdoG3G+5dG0OSnnw
         VV/eseh1JZ2Ci5TBLMWHiSLuBKy049eXLCjzDM/VZrwtgymPPI+AMpXJ9xnufX7nVz
         cypd0/SDfA9pSpuyzpUqhlAcuN4u6X+kCwDMnebdG60ktZ5DHkUD5mQyKnp0Oi3rx/
         azPOPbxtlSsBoyRr+bzt8OroYDabKfpWhTDpBkRticKl1RjqRloXeDtbtAUAYKroaY
         GrzmdnQxLuJ5A==
Message-ID: <03449762-33b9-3e86-c65f-4bb9e0e917c6@collabora.com>
Date:   Thu, 20 Jul 2023 09:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com
Cc:     bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
References: <20230707092414.866760-1-zyytlz.wz@163.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230707092414.866760-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/07/23 11:24, Zheng Wang ha scritto:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
> 
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> 
> CPU0                  CPU1
> 
>                      |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>    v4l2_m2m_release  |
>      kfree(m2m_dev); |
>                      |
>                      | v4l2_m2m_get_curr_priv
>                      |   m2m_dev->curr_ctx //use
> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


