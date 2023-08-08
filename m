Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF42774268
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjHHRoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjHHRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:44:04 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7A0662D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:19:43 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4475d891d0eso10718137.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511536; x=1692116336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=czs5FLmho01QLwa901GjqRSik4ONk7iijh3u8NKJArY=;
        b=HBPBd+vzaR3aP/oSd9Io6BFjBkqIef3U/57d0AzrbiJjgWGwbKJ8Vik3tNpo7+yNUA
         zJo6+/UktRBTGYGrRKOJl24yzssI4CNE36gO8I0CyUD7ijDG/y1GU3QBIrqfLK79S9n+
         0CIP+uqvGJF2/HYwNGn4gmFxzMEual6Bg6O0HjbkuCth2M+cYXGIvs8GsYCSqroGo9zI
         JBD5HBLNrfl1PZoHfc/Va52TzfnHysngr7uFspg5+9BQyCT4zPvOm3ZdMLPM+6JW0c1K
         jxlHt0Xb326wMIYXIwAhNmjU+Xn2uhBPY5uLIjjJBvlOiIxiTSLaFY2s54MTL1WYotHr
         l2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511536; x=1692116336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czs5FLmho01QLwa901GjqRSik4ONk7iijh3u8NKJArY=;
        b=ZRDdBiCagMKEeqryw/6x9//zJLs9JlMRlsrAQiP9WkZsKluXTwW/vn2Dar/EYtkQMA
         ZpqnUB3bvoIVq6fUeKYSzK/GGI2RPXIZgOsZlYV+HaFtkwggBj9CQSeViabNlbpReKaB
         u+vafuVne0hlsOv9zmfw6vd1uaL9Ly8yEGx04Q+6FxZoyNlwUgJH/13iENkefdzQiGq8
         XjKkJnm8lDd5dAZeLucn4yPinsqSHlHNhjfkz4ye6ZooxwDBSBFZQL95zcfz/mm6fH3r
         ++8ycOuQK+RPhdeCqieLjbzWc+6iKGotq3KO4K4pCTvgJ41EOCHsxwPGA1ihaYAXkjBu
         VAKg==
X-Gm-Message-State: AOJu0YznYQ3A7g8TfoaxZwdfT2+cWSZBmlJqdg+fYmxjijaYHOf7U4vB
        yzouDXPn1SsXPjHuMsLAA/cTvA+OJ6tWOA+i+iw5qdqIXXGOhKH4bO8=
X-Google-Smtp-Source: AGHT+IHmsYhhTMQA8QWVnEJgqgdgilOlaBxIemkx0xK04YjnhMHfG6KL7pFK7r+wL4NOpFmKd9ZI1l5xuVudgAueyCI=
X-Received: by 2002:a25:e0cd:0:b0:d4d:fea4:fb5b with SMTP id
 x196-20020a25e0cd000000b00d4dfea4fb5bmr7659878ybg.31.1691486896076; Tue, 08
 Aug 2023 02:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230803054544.22007-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230803054544.22007-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:27:40 +0200
Message-ID: <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: replace immediate with hsq->depth
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 07:46, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Hsq is similar to cqe, using hsq->depth to represent
> the maximum processing capacity of hsq. We can adjust
> hsq->depth according to the actual situation.

Sorry, but I don't quite follow here.

Are you planning to update the host->hsq_depth dynamically from somewhere?

Kind regards
Uffe

>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/queue.c   | 6 +-----
>  drivers/mmc/host/mmc_hsq.c | 1 +
>  drivers/mmc/host/mmc_hsq.h | 7 +++++++
>  include/linux/mmc/host.h   | 1 +
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b396e3900717..a0a2412f62a7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 }
>                 break;
>         case MMC_ISSUE_ASYNC:
> -               /*
> -                * For MMC host software queue, we only allow 2 requests in
> -                * flight to avoid a long latency.
> -                */
> -               if (host->hsq_enabled && mq->in_flight[issue_type] > 2) {
> +               if (host->hsq_enabled && mq->in_flight[issue_type] > host->hsq_depth) {
>                         spin_unlock_irq(&mq->lock);
>                         return BLK_STS_RESOURCE;
>                 }
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 424dc7b07858..7b3952721c17 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>         hsq->mmc = mmc;
>         hsq->mmc->cqe_private = hsq;
>         mmc->cqe_ops = &mmc_hsq_ops;
> +       mmc->hsq_depth = HSQ_MAX_DEPTH;
>
>         for (i = 0; i < HSQ_NUM_SLOTS; i++)
>                 hsq->tag_slot[i] = HSQ_INVALID_TAG;
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index 1808024fc6c5..795f6b9421d7 100644
> --- a/drivers/mmc/host/mmc_hsq.h
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -5,6 +5,13 @@
>  #define HSQ_NUM_SLOTS  64
>  #define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
>
> +/*
> + * For MMC host software queue, we usually allow 2 requests in
> + * flight to avoid a long latency. But we can adjust hsq->depth
> + * according to the actual situation.
> + */
> +#define HSQ_MAX_DEPTH  2
> +
>  struct hsq_slot {
>         struct mmc_request *mrq;
>  };
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..1fd8b1dd8698 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -520,6 +520,7 @@ struct mmc_host {
>
>         /* Host Software Queue support */
>         bool                    hsq_enabled;
> +       int                     hsq_depth;
>
>         u32                     err_stats[MMC_ERR_MAX];
>         unsigned long           private[] ____cacheline_aligned;
> --
> 2.17.1
>
