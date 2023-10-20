Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378ED7D0A75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjJTIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJTIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:20:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEEAB0;
        Fri, 20 Oct 2023 01:20:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60F966607352;
        Fri, 20 Oct 2023 09:20:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697790014;
        bh=RSQ5/DMeBnjdqm4h5GEDNo41Y8NPcwqWmF2hl3CzU4Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LTr/BwXEXjwM28l/WBLy3g4Y6rSO7GmucFVzcI6oDTvGsGkpsDiWKWtxsyA/UVPgO
         godKZqiaTA8xWdepYuPjuEOg1rJ8pG7MrICvM7PLNO8wrymvthXDzPCKoWtZj39ts4
         XxNQez3PUaVRWnI1iMFG6nJp7yYgnckhziuZ8yAJ5J9SHiW2m6z1cV0f7eDMT2IZ/i
         56Ykk4SQwQoFQHUAxA2Ce2pGKQxe5iIOcGD1X96lNDl+3daRKbujVdr+ZmJ8f/SQ+C
         43fnemdqYE1JnQRm2rxKJsly8AdjEh+0TT9H3iXfIvL4Hv5isgvxMUVb3h1i1Mg3km
         Vr7OwHYB0r7Xw==
Message-ID: <8b799079-fd98-46ba-a2cd-04ecf0c0df1d@collabora.com>
Date:   Fri, 20 Oct 2023 10:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to error path
 handling in mtk_jpeg_dec_device_run
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, dmitry.osipenko@collabora.com
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        amergnat@baylibre.com, wenst@chromium.org, stable@vger.kernel.org
References: <20231020040732.2499269-1-zyytlz.wz@163.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231020040732.2499269-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/10/23 06:07, Zheng Wang ha scritto:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work.
> 
> In mtk_jpeg_dec_device_run, if error happens in
> mtk_jpeg_set_dec_dst, it will finally start the worker while
> mark the job as finished by invoking v4l2_m2m_job_finish.
> 
> There are two methods to trigger the bug. If we remove the
> module, it which will call mtk_jpeg_remove to make cleanup.
> The possible sequence is as follows, which will cause a
> use-after-free bug.
> 
> CPU0                  CPU1
> mtk_jpeg_dec_...    |
>    start worker	    |
>                      |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>    v4l2_m2m_release  |
>      kfree(m2m_dev); |
>                      |
>                      | v4l2_m2m_get_curr_priv
>                      |   m2m_dev->curr_ctx //use
> 
> If we close the file descriptor, which will call mtk_jpeg_release,
> it will have a similar sequence.
> 
> Fix this bug by start timeout worker only if started jpegdec worker
> successfully so the v4l2_m2m_job_finish will only be called on
> either mtk_jpeg_job_timeout_work or mtk_jpeg_dec_device_run.
> 
> This patch also reverts commit c677d7ae8314
> ("media: mtk-jpeg: Fix use after free bug due to uncanceled work")
> for this patch also fixed the use-after-free bug mentioned before.
> Before mtk_jpeg_remove is invoked, mtk_jpeg_release must be invoked
> to close opened files. And it will call v4l2_m2m_cancel_job to wait
> for the timeout worker finished so the canceling in mtk_jpeg_remove
> is unnecessary.
> 
> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


