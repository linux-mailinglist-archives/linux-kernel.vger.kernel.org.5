Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1927FD337
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjK2JtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjK2Js7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:48:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04402132
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:48:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bc36725bbso955444e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701251314; x=1701856114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mx325DtRKaxi+9uS3mKSouj4W90XaTo1Gq8eIdHtzI=;
        b=FsaqE7jLU97/EJKeoxPCH61jaAYwzlL0hZ6apWnoLJjD4KnbGtu+/ITAlSe05sheDW
         I4E8Rg/75YyV62X9kqfWLoPPGwa7NmkJixDX+BWv0GlrDCp1LjyEm4UUwTDpfzdr+3s7
         GwFN1spp1532goxyuuQEwngF8U45yCZGcGx1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251314; x=1701856114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Mx325DtRKaxi+9uS3mKSouj4W90XaTo1Gq8eIdHtzI=;
        b=cSqW9glvOJ6tR0LLVVE1LkxWch37xof3Zr3V/M9CeoeYP5qELBWKJdUahO2dQSTmZC
         c1j3eG0+7KAHtvqpyqUebSv/TLdLAD/v19vz6WkUJvaQTALzBR2X4TGnYRnQywwVOu/P
         CLb0tUfHKBoJHu3hqq/IHkjmEpQTxyG2kLSZ6qkubIVDCR0WmZCPKW8htUaolHdoqxO1
         LbGaJLrW31lRfBhFwkWffH46MsmjKVocWKcH6ukUhpYjeFnhcreN9/nm6SetDpgw1YwC
         NfdCLlxdtgS9oRf7bW7p4koKtBXK6dis1JomyQhYiiEunshcvKHXso+zYY7NmgWss3Ht
         Dv3g==
X-Gm-Message-State: AOJu0YxVMd3rnuyxIYUTHGJCGQWE/Emt/4jIXoV6zhPs0+H+m2hoNoGv
        occlD3miqEoapy2I6aVSfHH55ijpMYG5uFeGWg9mshZd
X-Google-Smtp-Source: AGHT+IE3Ztuu60ZDFSY7biChwWnqgw6oSeXmkpBcjGKAcf5U8JYyjz9B9OI89Nc6zp9mpCHk9vYQgA==
X-Received: by 2002:a05:6512:3584:b0:50b:bfc2:7911 with SMTP id m4-20020a056512358400b0050bbfc27911mr2353574lfr.68.1701251314195;
        Wed, 29 Nov 2023 01:48:34 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v4-20020ac25584000000b0050945385a2esm2118036lfg.228.2023.11.29.01.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:48:33 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9b5c12898so20170901fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:48:33 -0800 (PST)
X-Received: by 2002:a2e:b008:0:b0:2c9:bf5b:5408 with SMTP id
 y8-20020a2eb008000000b002c9bf5b5408mr833397ljk.24.1701251313149; Wed, 29 Nov
 2023 01:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-17-benjamin.gaignard@collabora.com> <cf444351-4305-450d-9b3a-a02a310543c7@xs4all.nl>
In-Reply-To: <cf444351-4305-450d-9b3a-a02a310543c7@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 29 Nov 2023 18:48:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DHQvvodpKTYN4AE6Q=48Mby+qtt_kE9xjgarn1jQextw@mail.gmail.com>
Message-ID: <CAAFQd5DHQvvodpKTYN4AE6Q=48Mby+qtt_kE9xjgarn1jQextw@mail.gmail.com>
Subject: Re: [PATCH 16/55] media: qcom: venus: Stop abusing of
 min_buffers_needed field
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 7:26=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 27/11/2023 17:54, Benjamin Gaignard wrote:
> > 'min_buffers_needed' is suppose to be used to indicate the number
> > of buffers needed by DMA engine to start streaming.
> > venus driver doesn't use DMA engine and just want to specify
> > the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
> > That 'min_reqbufs_allocation' field purpose so use it.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > CC: Stanimir Varbanov <stanimir.k.varbanov@gmail.com> (maintainer:QUALC=
OMM VENUS VIDEO ACCELERATOR DRIVER)
> > CC: Vikash Garodia <quic_vgarodia@quicinc.com> (maintainer:QUALCOMM VEN=
US VIDEO ACCELERATOR DRIVER)
> > CC: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org> (reviewer:QUALCOMM =
VENUS VIDEO ACCELERATOR DRIVER)
> > CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> > CC: Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUP=
PORT)
> > CC: Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM S=
UPPORT)
> > CC: linux-arm-msm@vger.kernel.org
> > ---
> >  drivers/media/platform/qcom/venus/vdec.c | 4 ++--
> >  drivers/media/platform/qcom/venus/venc.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/p=
latform/qcom/venus/vdec.c
> > index dbf305cec120..16b8d0dde10d 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -1641,7 +1641,7 @@ static int m2m_queue_init(void *priv, struct vb2_=
queue *src_vq,
> >       src_vq->drv_priv =3D inst;
> >       src_vq->buf_struct_size =3D sizeof(struct venus_buffer);
> >       src_vq->allow_zero_bytesused =3D 1;
> > -     src_vq->min_buffers_needed =3D 0;
> > +     src_vq->min_reqbufs_allocation =3D 0;
>
> Just drop this.
>
> >       src_vq->dev =3D inst->core->dev;
> >       src_vq->lock =3D &inst->ctx_q_lock;
> >       ret =3D vb2_queue_init(src_vq);
> > @@ -1656,7 +1656,7 @@ static int m2m_queue_init(void *priv, struct vb2_=
queue *src_vq,
> >       dst_vq->drv_priv =3D inst;
> >       dst_vq->buf_struct_size =3D sizeof(struct venus_buffer);
> >       dst_vq->allow_zero_bytesused =3D 1;
> > -     dst_vq->min_buffers_needed =3D 0;
> > +     dst_vq->min_reqbufs_allocation =3D 0;
> >       dst_vq->dev =3D inst->core->dev;
> >       dst_vq->lock =3D &inst->ctx_q_lock;
> >       return vb2_queue_init(dst_vq);
> > diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/p=
latform/qcom/venus/venc.c
> > index 44b13696cf82..e399d01c208c 100644
> > --- a/drivers/media/platform/qcom/venus/venc.c
> > +++ b/drivers/media/platform/qcom/venus/venc.c
> > @@ -1398,7 +1398,7 @@ static int m2m_queue_init(void *priv, struct vb2_=
queue *src_vq,
> >       src_vq->drv_priv =3D inst;
> >       src_vq->buf_struct_size =3D sizeof(struct venus_buffer);
> >       src_vq->allow_zero_bytesused =3D 1;
> > -     src_vq->min_buffers_needed =3D 1;
> > +     src_vq->min_reqbufs_allocation =3D 1;
>
> So for platform drivers like this it is going to be more difficult to
> determine which meaning min_buffers_needed had: is at least one queued
> buffer needed before you can start streaming, or is this for a minimum
> buffer allocation?

By the way, for stateful decoders, we also have the
V4L2_CID_MIN_BUFFERS_FOR_CAPTURE control, which tells the userspace
the minimum buffers that need to be allocated and the drivers also
should adjust the number requested in REQBUFS to be at least that.

>
> In the case of m2m devices using the v4l2-mem2mem framework it is almost
> certainly the minimum buffer allocation since the m2m framework already
> checks that there are input and output buffers queued (__v4l2_m2m_try_que=
ue).
>
> So just delete the src_vq->min_buffers_needed =3D 1; line, and there is
> no need to set min_reqbufs_allocation.
>
> >       src_vq->dev =3D inst->core->dev;
> >       src_vq->lock =3D &inst->ctx_q_lock;
> >       if (inst->core->res->hfi_version =3D=3D HFI_VERSION_1XX)
> > @@ -1415,7 +1415,7 @@ static int m2m_queue_init(void *priv, struct vb2_=
queue *src_vq,
> >       dst_vq->drv_priv =3D inst;
> >       dst_vq->buf_struct_size =3D sizeof(struct venus_buffer);
> >       dst_vq->allow_zero_bytesused =3D 1;
> > -     dst_vq->min_buffers_needed =3D 1;
> > +     dst_vq->min_reqbufs_allocation =3D 1;
> >       dst_vq->dev =3D inst->core->dev;
> >       dst_vq->lock =3D &inst->ctx_q_lock;
> >       return vb2_queue_init(dst_vq);
>
> Ditto.
>
> Regards,
>
>         Hans
