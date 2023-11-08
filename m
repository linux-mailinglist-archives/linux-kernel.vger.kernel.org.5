Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C937E4F34
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjKHC5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKHC5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:57:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7812D;
        Tue,  7 Nov 2023 18:57:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc9784dbc1so39880735ad.2;
        Tue, 07 Nov 2023 18:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699412225; x=1700017025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR16R3nH7fmv/BxEUykAASSecaa8iTYdR38F9yHcXJs=;
        b=dj2UTaHW3gKJYOflcBZOB1wVK2FafSoc4PCZR+5rSsYNZGoO8hapZIzLaM3LqTgl6t
         m6lvYBZcJ0RCiTPH7yvkSKHxWtlznZyA6w/ISkw0Ndn1Ptzpv5gPIBBJI9ZalXJ00H4e
         PNhsDW0g1/QHR0IjgJpmBMh/eBT830inUdxIT5B6FW+O7Xpgs/u85qEjzqRZl1Rp9tc6
         K94B/TkjSU2jHEbhYduQTl21EBdUbzkDz+Vrivi15o5IiXKG1PnINE2dxjILqe5eusZB
         aQPhdrjCa9u1/ePj+emKOWKvZDuQ36AgkV6KrNho78Seczt6uFTtZEdZ6vtAB42Sl3lh
         Fnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412225; x=1700017025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR16R3nH7fmv/BxEUykAASSecaa8iTYdR38F9yHcXJs=;
        b=KsiHOa3q8/igLQmdZ46sVjbS7dZTQXv2tkOcwvNN/UzROl7VXrjrtAVjghoC8LOv3d
         hRMEI8nzsPx/GeVUxLDya9Gn89RIZEVDPxRMLz27BBUUHZcmoYRDhTMbM7mEd1BNO4Cs
         ZQSc8FZGrUbEu2RNMhVQG2SdCiuOOeSL+LFAHYpV5qPIx8LhiypkJg6Ty2th2sWYG5KK
         bAQnbxhqVFYHujndkWIL+A5i2FopPb4nCs/J8RJPTX43Nn3Tr8MhXCXahrB3qKu/ljb2
         FwyawfTOXvfnT4GPDoxFlLSFLmxMzyE49NiTTLVSvWtR9PB+MXCZjtg1yjVsLMwxMxqH
         ci/Q==
X-Gm-Message-State: AOJu0Yyha/UeTRgJwI0brIrYLUXZgM+ohPyndkhfLI+wIoVGmht+1ULF
        MaRUogKnfM57qykwzCdHGda90joKSKI1Na4vLbE=
X-Google-Smtp-Source: AGHT+IF3q4D8mSxtA0NdLkdfYSoxbFu7W4fzZDtMoDCUqUarRgS7ohRJloJqc4hOG4cnBnvyiD/RosFjWtNu0PZ4qcQ=
X-Received: by 2002:a05:6300:8004:b0:180:eef7:b3b7 with SMTP id
 an4-20020a056300800400b00180eef7b3b7mr1118305pzc.51.1699412224768; Tue, 07
 Nov 2023 18:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20231106144811.868127-1-zyytlz.wz@163.com> <b5f9d751-5425-4281-8a21-99e92bd447b7@xs4all.nl>
In-Reply-To: <b5f9d751-5425-4281-8a21-99e92bd447b7@xs4all.nl>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 8 Nov 2023 10:56:52 +0800
Message-ID: <CAJedcCwaHCEksJpUz1Y0s-SX2zd_ncfOZs53qiMcaeBN2sw1YQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Fix use-after-free bug in
 mtk_jpeg_dec_device_run and fix schedule error in mtk_jpegdec_worker
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dmitry.osipenko@collabora.com,
        Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, amergnat@baylibre.com, wenst@chromium.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Verkuil <hverkuil@xs4all.nl> =E4=BA=8E2023=E5=B9=B411=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=BA=8C 18:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 06/11/2023 15:48, Zheng Wang wrote:
> > Hello,
> >
> > This v2 series fixes the use-after-free bug in mtk_jpeg_dec_device_run.
> > This patch fixes the security bug in chrome-os.
> > It inclues reverting the incomplete fix before and make the right fix.
> > Also,it fixes the error of timeout-worker-schedule in multiple-core
> > devices.
> >
> > 1. Remove cancel worker in mtk_jpeg_remove for the worker is only
> > registered in single-core device but we try to cacnel it in both
> > single-core and multiple-core devices.
> >
> > 2. Fix use-after-free bug by delay the schedule_delayed_work only if
> > mtk_jpeg_set_dec_dst runs successfully.
> >
> > 3. Delay the schedule_delayed_work in mtk_jpegdec_worker as it has same
> > code logic in mtk_jpeg_dec_device_run.
> >
> > version 2 changes
> >
> > -put the patches into on series suggested by Dmitry
> >
> > Zheng Wang (3):
> >   media: mtk-jpeg: Remove cancel worker in mtk_jpeg_remove to avoid the
> >     crash of multi-core JPEG devices
> >   media: mtk-jpeg: Fix use after free bug due to error path handling
> >     in mtk_jpeg_dec_device_run
> >   media: mtk-jpeg: Fix timeout schedule error in mtk_jpegdec_worker.
> >
> >  .../media/platform/mediatek/jpeg/mtk_jpeg_core.c    | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
>
> Please don't resend. If it is in patchwork.linuxtv.org then it is good.
> Fixes (unless they fix something really nasty) can take several weeks bef=
ore
> they are picked up. I usually schedule 2 or 3 rounds per kernel cycle whe=
re
> I go through all the pending patches with fixes.
>

Oh Sorry for my rudeness. And I'm deeply appreciative of your contributions
to the community.

Best regards,
Zheng


> Regards,
>
>         Hans
