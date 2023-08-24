Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2441786D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbjHXK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbjHXK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:56:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0DE51
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:56:00 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58d41109351so10516087b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692874559; x=1693479359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DmxySgPzhnxxUTeywFheyR9KmyLlbR5/9tECTYy/UEo=;
        b=UaK5oz3c2QZPwlWA0J06xzTK/xDFzZZUAeUmpvMPlZj46JGOihJGLgJIi2kLwSrrCh
         3+85Zhuv0OQ85bwUFghZXFQtLS1OKK4f1KvUvXth2VCnAq7aXfnrUJZ09nXvftIj9ug1
         vqJdglFFR2XtF59xJ0TK8crRhW3Fj4vchycRaUAYcgkMH37beDeQeJdOalJdHnOTuK3X
         mFbwzsMfl/HgjTmkkxLCKn/VFwV13ccwjMX8L0dXjxo3YiUaYbjPyWWlCPv578PLRiY1
         YafaOaRX9Y1K/VGzxbHY8nTaj6bnuCZl9TTamO7gHZSeiUSWjP2tTsB/xR/7hR+6XAZj
         gJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874559; x=1693479359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmxySgPzhnxxUTeywFheyR9KmyLlbR5/9tECTYy/UEo=;
        b=EiP+GEC0Zb3NYRifM8vsT+d4ZxffQ700rUZscNzDxwOaIuhFaFy0Yy1j0FHPZevTc4
         +zthnuTQdGTGlF89rJdDIERIKgGw72trRHDRI0Wl5DtW7TxLQWtXkdMt4BmzY22EiED9
         rzi0693kIjscPSEySn3OCS4gNDF4XoWgPsEzvYGqTf9OSl7Bji1RUkDSz4yyvSBDZtxt
         +iPQ9cJqwBF0E6haCTJK1gxHmp3ZMCGz/0MFAiR2pjljFcHLIDgYGSLCqHfLXJTMJ7T+
         em6dI+0TjFno7HomCTP8CmIrvUnH8VHWQBSFyHXX3Z6t8fXaZNiCcilV1UCtbqwHUmac
         0n3g==
X-Gm-Message-State: AOJu0YybH1mX8oiokCHVeS50DfQY28N/qCF6xcJ9LDV/5nLIrWAdfdB/
        yhM6wAWSmLe49KN379soR3wxg9yAZ6MS4dvLikdh61lXNF1LNWLeKCg=
X-Google-Smtp-Source: AGHT+IG5g981hiNWc2Virq/saq14f3u+c5agrarXaFetTlwLXn91k4F7b/MHfUOZ5lpFVRkOWRINd19ymBubd9J94eU=
X-Received: by 2002:a81:4f49:0:b0:56c:f0c7:7d72 with SMTP id
 d70-20020a814f49000000b0056cf0c77d72mr13387507ywb.4.1692874559668; Thu, 24
 Aug 2023 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
In-Reply-To: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:55:23 +0200
Message-ID: <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
To:     Sharp.Xia@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@medaitek.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 at 04:45, <Sharp.Xia@mediatek.com> wrote:
>
> From: Sharp Xia <Sharp.Xia@mediatek.com>
>
> MMC does not set readahead and uses the default VM_READAHEAD_PAGES
> resulting in slower reading speed.
> Use the max_req_size reported by host driver to set the optimal
> I/O size to improve performance.

This seems reasonable to me. However, it would be nice if you could
share some performance numbers too - comparing before and after
$subject patch.

Kind regards
Uffe

>
> Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
> ---
>  drivers/mmc/core/queue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b396e3900717..fc83c4917360 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>                 blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
> +       blk_queue_io_opt(mq->queue, host->max_req_size);
>         if (host->can_dma_map_merge)
>                 WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
>                                                         mmc_dev(host)),
> --
> 2.18.0
>
