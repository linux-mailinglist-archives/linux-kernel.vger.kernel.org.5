Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CE79B760
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359627AbjIKWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjIKLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:35:48 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F23CDD;
        Mon, 11 Sep 2023 04:35:44 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64f4ac604c2so23616506d6.1;
        Mon, 11 Sep 2023 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694432142; x=1695036942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfhyDcoChV91gT7BZOcZOKjPTTphZ99Y65ZjQNCETsY=;
        b=j8htr0Rv+5wDAbiJ3xxTdgkyK80QCVYGdXqDZ/8O4cwMesWH3szkyGAWYJosmzGYtU
         gZa2c+1rYMHj29pQlxP7isn+uL1GMqxsnERj+X9zHt0/Eq6TiYfD5eSUCzZZncxnhBiz
         CY7cNXsQ/mQyX7ofcZJyjlCxZmFHPB+rBK/JKK+m/XgLUB2nLjRSzco9IgrIWKbXFc8c
         HUcEaCh4ZiCOCSR+fz8TaAXrAr0vvvQHTt0Hr66ZHYTxeo4xnXbATOpIvU+6p2L9zl1M
         XB/tP+3MZ4SiPN9wxq8kyRLYSDQetxPbVVdj6pYJa6KWdEE9DkUy8ejgSwJhGmvlAwJL
         5foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432142; x=1695036942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfhyDcoChV91gT7BZOcZOKjPTTphZ99Y65ZjQNCETsY=;
        b=LSQyKkkd034+kUSh2a6Y2eAvtnU6XqRau13kLtavhNHj2aNApMgEjj5Eeib8xoinfF
         OgcHRbDkKbRMUH/1h0mSxTrNtJNOCESVhWu5Pq9Z2LuqVv1dztrSEybOXwrjpza7h+t3
         9g9UUj2C0QemfEw59qQx38Cr7ruqNyTLLp4FjVeZVDY2xGABxvhjUZbLLYf3wG+d3eLy
         AY0INpcZRf7VL6pY1h/r3+DiEFOtdah62jGxDHIPBZ7eWCFDNaZFRDGn35juDuGdYe9Q
         ndPJrFuEVHDIPBbhpUdE4zpLSTjbp2KLrr0H6zMIJ3WF9KmCNM2E/X6GxMihHxgEoEbo
         LlxA==
X-Gm-Message-State: AOJu0YxH36UnaEZBMAFRXtfGsW80L2gifuEFzc3QRqwXqySCWv+LQptI
        djvmsalpKu7v12bHglheEJYXYoj2VVSGV+mEq2Fgz//F
X-Google-Smtp-Source: AGHT+IExTVrxJSlXVu7/JurFF/CvjBFs8advpdQems+83jE0bH+zIsnvYWvbFb1WHf+4EaVBeN8B59R10uW1q3rDTDw=
X-Received: by 2002:a0c:f312:0:b0:636:1daa:94e with SMTP id
 j18-20020a0cf312000000b006361daa094emr7994387qvl.38.1694432142263; Mon, 11
 Sep 2023 04:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230905023921.10766-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230905023921.10766-1-wenchao.chen@unisoc.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 11 Sep 2023 19:35:31 +0800
Message-ID: <CA+Da2qx77FVJk0Mesbm34su_cuHZU6Me8WMZFt3MkjjtDyGc1w@mail.gmail.com>
Subject: Re: [PATCH V3 0/2 RESEND] mmc: hsq: dynamically adjust hsq_depth to
 improve performance
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        Wenchao Chen <wenchao.chen@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...
On Tue, 5 Sept 2023 at 10:40, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v3:
> - Use "mrq->data->blksz * mrq->data->blocks == 4096" for 4K.
> - Add explanation for "HSQ_PERFORMANCE_DEPTH".
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
>
> In addition, we tested 8K and 16K.
> 1.Fixed hsq_depth
> 1) Random write(bs=8K):
> Speed: 116 114 115
> Average speed: 115MB/S
>
> 2) Random read(bs=8K):
> Speed: 83 83 82.5
> Average speed: 82.8MB/S
>
> 3) Random write(bs=16K):
> Speed: 141 142 141
> Average speed: 141.3MB/S
>
> 4) Random read(bs=16K):
> Speed: 132 132 132
> Average speed: 132MB/S
>
> 2.Dynamic hsq_depth(mrq->data->blksz * mrq->data->blocks == 8192 or 16384)
> 1) Random write(bs=8K):
> Speed: 115 115 115
> Average speed: 115MB/S
>
> 2) Random read(bs=8K):
> Speed: 82.7 82.9 82.8
> Average speed: 82.8MB/S
>
> 3) Random write(bs=16K):
> Speed: 143 141 141
> Average speed: 141.6MB/S
>
> 4) Random read(bs=16K):
> Speed: 132 132 132
> Average speed: 132MB/S
>
> Increasing hsq_depth cannot improve 8k and 16k random read/write performance.
> To reduce latency, we dynamically increase hsq_depth only for 4k random writes.
>
> Test cmd
> =========
> 1)write: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=write -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 2)read: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=read -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 3)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 4)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 5)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=8K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 6)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=8K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 7)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=16K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 8)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=16K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
>
> Wenchao Chen (2):
>   mmc: queue: replace immediate with hsq->depth
>   mmc: hsq: dynamic adjustment of hsq->depth
>
>  drivers/mmc/core/queue.c   |  6 +-----
>  drivers/mmc/host/mmc_hsq.c | 28 ++++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h | 11 +++++++++++
>  include/linux/mmc/host.h   |  1 +
>  4 files changed, 41 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>
