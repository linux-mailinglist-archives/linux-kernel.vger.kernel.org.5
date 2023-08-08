Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25477473E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjHHTMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjHHTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:12:04 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A7D33B0C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:34:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bd04558784so822415a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512422; x=1692117222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s++4blSxMjulxr4WqQlajWQp+reqB47xPJw4qPYyIJs=;
        b=Uh5+pSCPOEPp6P1A5BrXHrmv10wp9kgrS8mxAgqbJQj0IcwzFJuLwRZ4fAUh8FpA5j
         ZBP0trXgA2P9TyobMLLGe+CxYQ/fD7gXtih6WMK1M89r2v8/AL2f8YqGEh1n63g1gU6b
         5j0x3Iwr3m2IP745hbFw1IkK81XESsIVJONxJrIrNOQ8/g9QieRKbv00vxQdVy4Wo3kS
         VziiuF4emTRC0XhVuyhj5qA0ObqnBDkdI1Pf2jHxH6hKcW3z3R480LSJHUESgakNq1UI
         UWYkNK4NHWAsn44QjF9l3XJGHyb1gbLrp7FMwJkcqgtw3gmzF0doEHpLORKU3889WR/P
         XZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512422; x=1692117222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s++4blSxMjulxr4WqQlajWQp+reqB47xPJw4qPYyIJs=;
        b=kKApbzOKW+0IT3MQMe/2JkQP6I6KB78XoIon4Mj3fctQ/Q+ezi4UENSVakkyBT/1e2
         Jl6saBE6AAXvcuLTaZJ3bQzAsXhPmFpAb8CwpEaxDz2XBr+kPDwDhka2qjdmBxlyosSv
         /cVdxrjtRG3NKvWqbifz1vPNAKH6pCQMsPd3EH7FeL2Kprbw9GIZFwrUAdNAomTB2RjI
         x/OubPMMEXPj+ptUausaeSnRurYaOehnrfGtiHUcn/GsrQ8QWGwMEwbW46Qj1CLsrq/b
         oO3hMasE5a32W1Tw504/MRxBUrFji/e2MNsHJIV/FfRAraJQxkU4wXwb+/f54UVnve5h
         UobA==
X-Gm-Message-State: AOJu0YynJa33IEPnf37JoHdLMxA/XVuGlcT9se5q3n0mbqQd5gIsBCKm
        lnjEquZCmWXjEAzDb6usbSWyDYbxjhyY0tc8UL1rHt2KBl/GElIB
X-Google-Smtp-Source: AGHT+IGGcAj42nyoezAnxw/gRQ5a8aT9hrh74ET1epNHdpkHqryPud6eA2qTIgp9XEhLBjrOsYxl27ezpR/VAqMtR6k=
X-Received: by 2002:a25:6943:0:b0:ce8:42b6:46f9 with SMTP id
 e64-20020a256943000000b00ce842b646f9mr15212913ybc.45.1691491995143; Tue, 08
 Aug 2023 03:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
In-Reply-To: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:52:39 +0200
Message-ID: <CAPDyKFr1ts4yE3it=+fFsvQaSPTa=R01yobaNVhHfRh4nRicow@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: block: Fix in_flight[issue_type] value error
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     adrian.hunter@intel.com, CLoehle@hyperstone.com,
        brauner@kernel.org, hare@suse.de, asuk4.q@gmail.com,
        avri.altman@wdc.com, beanhuo@micron.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, hongyu.jin@unisoc.com,
        zhiguo.niu@unisoc.com, yunlong.xing23@gmail.com,
        yibin.ding@unisoc.com, dongliang.cui@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 04:33, Yunlong Xing <yunlong.xing@unisoc.com> wrote:
>
> From: Yibin Ding <yibin.ding@unisoc.com>
>
> For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
> function is executed, the bitmap_tags corresponding to the
> request will be cleared, that is, the request will be regarded as
> idle. If the request is acquired by a different type of process at
> this time, the issue_type of the request may change. It further
> caused the value of mq->in_flight[issue_type] to be abnormal,
> and a large number of requests could not be sent.
>
> p1:                                           p2:
> mmc_blk_mq_complete_rq
>   blk_mq_free_request
>                                               blk_mq_get_request
>                                                 blk_mq_rq_ctx_init
> mmc_blk_mq_dec_in_flight
>   mmc_issue_type(mq, req)
>
> This strategy can ensure the consistency of issue_type
> before and after executing mmc_blk_mq_complete_rq.
>
> Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> changes of v2: Sort local declarations in descending order of
> line length
> ---
>  drivers/mmc/core/block.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..b6f4be25b31b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2097,14 +2097,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>         mmc_blk_urgent_bkops(mq, mqrq);
>  }
>
> -static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
>  {
>         unsigned long flags;
>         bool put_card;
>
>         spin_lock_irqsave(&mq->lock, flags);
>
> -       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
> +       mq->in_flight[issue_type] -= 1;
>
>         put_card = (mmc_tot_in_flight(mq) == 0);
>
> @@ -2117,6 +2117,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
>  static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>                                 bool can_sleep)
>  {
> +       enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>         struct mmc_request *mrq = &mqrq->brq.mrq;
>         struct mmc_host *host = mq->card->host;
> @@ -2136,7 +2137,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>                         blk_mq_complete_request(req);
>         }
>
> -       mmc_blk_mq_dec_in_flight(mq, req);
> +       mmc_blk_mq_dec_in_flight(mq, issue_type);
>  }
>
>  void mmc_blk_mq_recovery(struct mmc_queue *mq)
> --
> 2.25.1
>
