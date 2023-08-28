Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188B078B480
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjH1Pcp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjH1Pcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:32:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9B2A8;
        Mon, 28 Aug 2023 08:32:38 -0700 (PDT)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 332E2660716E;
        Mon, 28 Aug 2023 16:32:36 +0100 (BST)
From:   "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
In-Reply-To: <tencent_73FCC06A3D1C14EE5175253C6FB46A07B709@qq.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 28 Aug 2023 16:32:35 +0100
Cc:     ldewangan@nvidia.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        christian.koenig@amd.com, linux-media@vger.kernel.org
To:     "Zhang Shurong" <zhang_shurong@foxmail.com>
MIME-Version: 1.0
Message-ID: <6fd4-64ecbe00-3-213b7840@157890307>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?spi=3A?==?utf-8?q?_tegra=3A?= Fix 
 missing IRQ check in =?utf-8?q?tegra=5Fslink=5Fprobe()?=
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 26, 2023 07:02 -03, Zhang Shurong <zhang_shurong@foxmail.com> wrote:

> This func misses checking for platform_get_irq()'s call and may passes the
> negative error codes to request_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> 
> Fix this by stop calling request_irq() with invalid IRQ #s.
> 
> Fixes: dc4dc3605639 ("spi: tegra: add spi driver for SLINK controller")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Reviewed-by: Helen Koike <helen.koike@collabora.com>

> ---
>  drivers/spi/spi-tegra20-slink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 4d6db6182c5e..f5cd365c913a 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1086,6 +1086,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
>  	reset_control_deassert(tspi->rst);
>  
>  	spi_irq = platform_get_irq(pdev, 0);
> +	if (spi_irq < 0)
> +		return spi_irq;
>  	tspi->irq = spi_irq;
>  	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
>  				   tegra_slink_isr_thread, IRQF_ONESHOT,
> -- 
> 2.30.2
>

