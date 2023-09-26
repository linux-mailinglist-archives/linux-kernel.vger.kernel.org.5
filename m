Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29907AEAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjIZKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjIZKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:54:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271CB4;
        Tue, 26 Sep 2023 03:54:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65afd8af8bbso30194896d6.3;
        Tue, 26 Sep 2023 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725682; x=1696330482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hEe7gpz9O/IbuF6Xwxx1AfsWWLFpDZDyH/t90uDzBnA=;
        b=ZP6f7DRLvsEPd3C/+aumZG8dDbJpK6oSEkoQIJOUedh0OYgqf3RN+ysLS7ZQKPemXD
         rFx+i8B8a7k97NoGCNVjXOEC9/4zHP5LWZeWqVw7vpgADkf+6WDh8lNseHwHmpqAuiOT
         bYXqMftEMHPxt3do7Tb6xyYeUPap0pqQl9UBSETY9MJaM5MeK7lmeUccp3Ncsh5HzEwL
         um7iyeEhk7Z9qMi35C8+S0DeQTkvuDyA4IGRpmhl/ZIxHitkt1RDekLAFnnf9blPf8Th
         E9IqQY+nnhphnwgxCt+vJJRnWKF6HEoKMrBwSFL4bmb03Jwy/Fj2XfyEHUiTBNPgdRmI
         NO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725682; x=1696330482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEe7gpz9O/IbuF6Xwxx1AfsWWLFpDZDyH/t90uDzBnA=;
        b=LdbMhcC0CSWV7HlYmhJIGgX39tBDMg0X+Ou2j/cPci49jQsizHoSx055pNR/Us/3Wm
         d5mPYbf6QbEUpaEtH9d5eq4ehywOxj4O9YFFEcslARa3bVgabbon2dcxHYGWr6cO1lDU
         OCjcX8s+Ny25ubNTk/t53lhMysaZdDIwGThn+iKbV+5d4fuZHLmqhZSTbx3VyB9AKjJ4
         IQmXyHuh2YUAs1+9t8dKhwzl/8MppV/4o/iXdiXTnI73VTsU4F95SB8LR73rCOwu1dTI
         ecjVd4xTZvvaDNRMP/yPkNhZSXylG1Qk4ubkx8SqqgwFkIDl5jFbT95uDwool3bqyGD4
         jeEQ==
X-Gm-Message-State: AOJu0YzMUIdYAk8fpsDzQaBQks7TeYPtyNqdmVKlAvCdD/drf12RHLxP
        Fx5Mom2aX7r3NVmJzHZ+/aRKn0sSDeNXV9LOVpc=
X-Google-Smtp-Source: AGHT+IFJT66HvvUyaOQISGvS5hla1pblVYmG5a7HC0ngNchN7+H+eAJn/DG5uh3iCX9FlEMZKLxpxGMqNr0irNAqR7w=
X-Received: by 2002:a0c:b71a:0:b0:658:9168:e6b6 with SMTP id
 t26-20020a0cb71a000000b006589168e6b6mr11251431qvd.52.1695725682595; Tue, 26
 Sep 2023 03:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074707.25517-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230919074707.25517-1-wenchao.chen@unisoc.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Tue, 26 Sep 2023 18:54:30 +0800
Message-ID: <CA+Da2qyk0=Vt_3NE5=mQB6UqEE2y=jFyAm5jWGzVEhw4siT3pw@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] mmc: hsq: dynamically adjust hsq_depth to improve performance
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com, Wenchao Chen <wenchao.chen@unisoc.com>
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

A gentle ping.

On Tue, 19 Sept 2023 at 15:47, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v4:
> - Remove "struct hsq_slot *slot" and simplify the code.
> - In general, need_change has to be greater than or equal to 2 to allow the threshold
>   to be adjusted.
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
>  drivers/mmc/host/mmc_hsq.c | 22 ++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h | 11 +++++++++++
>  include/linux/mmc/host.h   |  1 +
>  4 files changed, 35 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>
