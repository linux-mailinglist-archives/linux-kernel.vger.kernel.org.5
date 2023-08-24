Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A959C786CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjHXK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbjHXK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:26:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D13198E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:26:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-591ba8bd094so48981337b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692872803; x=1693477603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiVO2zIIfAlMOLu1hE32MnDX+QGTLXrL91WCVdNOGro=;
        b=snHFrSX9kpgGnVaHypf4EWd1p7qcpSAzammAIwD8QSTejP8bl8J0oy6MiEPe5zkjLT
         5Kx/3ON3pU4omX68exa8+FuX/R67h9YdNt1Fyqi811yca+pdnjcXscyxyDaP02PFUGAu
         ORcAJf5fRlvWUsoRIbVvbuvyNXfmTdnd4bebXz92mGG2Ks6x9eJ9zrvLqtWy9AJ+ixUI
         8k5zgJqipAjc32b8Te5RIs0nr3rw4W7SUe+8Mzlbq11hj1eoNauIiojBVxwKkQGR3Kc4
         +5cY/4d2Jscl0HWHqdf/bXPL2i7g34EmSBWVXKCtoetsQ0usHZgvmsRrUhb1RV6zf26C
         jsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692872803; x=1693477603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiVO2zIIfAlMOLu1hE32MnDX+QGTLXrL91WCVdNOGro=;
        b=hLI7WjwVIzzZUaQXwKFq+QGyl5kotZ2fHlikiuc3LqJfdyQ5RGO5CtgcnjWeg2YNVH
         sdPmL4SXmsuHxvHQpDaT1effY/0ABFu03W8IHakt2cPL4LCPmqO0mOCBzcanNoh6Tv3L
         LRHZjRj2YW0LHv2qPQ5YALKq5x74Wq+tRDSAfNNUAi/BJm4b0cPtlvY077eesQuoV/4i
         6pX9NJL8LtMSDDepakenjr+1wlHtxfqImn8wo4O/t+b1eUfxRYX/hwcz9DZ4zVpGC8uP
         f6+LniakG/jNl5lSQOQ1y7jC+f6SZ2aJ3zBukViMhdGYnOQlX1gBWXh4wasDHqhvTNTV
         fmPQ==
X-Gm-Message-State: AOJu0YxcNBgKC8xY6eZXz9y1UAcj7cCwcvmG5kAgvVDlsUrsjMPPD3ff
        TQ+Y/3CAaZ+Z5t8fiE2xJEu3B/Lj/0qKu4MUuCkv/yIe/ZWBEz7r4UzJPg==
X-Google-Smtp-Source: AGHT+IGEF/ohPnecRPr+1/Us9nPZdUGng0F281dTDctUO63ONUqAvna6vjLJF4sW+SdB52LmJ61MFUpiBprWMIl6vSk=
X-Received: by 2002:a81:6cd5:0:b0:54f:ba89:225d with SMTP id
 h204-20020a816cd5000000b0054fba89225dmr14041774ywc.19.1692872803527; Thu, 24
 Aug 2023 03:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061734.27479-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230823061734.27479-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:26:07 +0200
Message-ID: <CAPDyKFqbY5yLNwhODDq0XimKtnf0V93rEbmSdG+qZ2FrYWJFsw@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: hsq: Dynamically adjust hsq_depth to improve performance
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 08:18, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v2:
> - Support for dynamic adjustment of hsq_depth.
>
> Test
> =====
> I tested 3 times for each case and output a average speed.
> Ran 'fio' to evaluate the performance:
> 1.Fixed hsq_depth
> 1) Sequential write:
> Speed: 168 164 165
> Average speed: 165.67MB/S
>
> 2) Sequential read:
> Speed: 326 326 326
> Average speed: 326MB/S
>
> 3) Random write:
> Speed: 82.6 83 83
> Average speed: 82.87MB/S
>
> 4) Random read:
> Speed: 48.2 48.3 47.6
> Average speed: 48.03MB/S
>
> 2.Dynamic hsq_depth
> 1) Sequential write:
> Speed: 167 166 166
> Average speed: 166.33MB/S
>
> 2) Sequential read:
> Speed: 327 326 326
> Average speed: 326.3MB/S
>
> 3) Random write:
> Speed: 86.1 86.2 87.7
> Average speed: 86.67MB/S
>
> 4) Random read:
> Speed: 48.1 48 48
> Average speed: 48.03MB/S
>
> Based on the above data, dynamic hsq_depth can improve the performance of random writes.
> Random write improved by 4.6%.

Thanks for sharing this, interesting!

>
> Test cmd
> =========
> 1)write: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=write -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 2)read: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=read -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 3)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 4)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
>

The buffer you used for randwrite/randread is 4K blocks. Did you try
with something bigger too?

Or maybe we are afraid of introducing a bigger latency if we
dynamically change the hsq_depth to match something bigger than 4K?

>
> Wenchao Chen (2):
>   mmc: queue: replace immediate with hsq->depth
>   mmc: hsq: dynamic adjustment of hsq->depth
>
>  drivers/mmc/core/queue.c   |  6 +-----
>  drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h |  8 ++++++++
>  include/linux/mmc/host.h   |  1 +
>  4 files changed, 37 insertions(+), 5 deletions(-)
>

Kind regards
Uffe
