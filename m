Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00C76646B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjG1Gqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjG1Gqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:46:46 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA393584
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:46:43 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40834e70dddso818311cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690526802; x=1691131602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGY2nO4ftRXQP63Y2pNslApqrzNNXCRHiRU0fSeA3Xw=;
        b=k4Oigcu7aqKetFKoVexIE83Bu8ETLioCwuptG6SBn9YOfxWfNfnGv3G529VdF7B8uq
         o3OupE40gllWnOarBVs8Fz/vxsZXz68E9WJpnOzNSkzIU6EneDGTxLNYU4pnDbqtNE1N
         fJxrelkBzy9zdsFb14Bw/svw1stDs8fGmExJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526802; x=1691131602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGY2nO4ftRXQP63Y2pNslApqrzNNXCRHiRU0fSeA3Xw=;
        b=kmLctwMbKpjih4C8hqHO2Xf+jTblvXCFggjQA48NInz/8A0YJLIxTb708Mtqz/gRKb
         s29mh0iqE36oC+dcK7bN6MCzqAyE22Rf2dTcAUamyrME197RbAHeCp+mRRbS1qao7SsZ
         Soy8AtDoor4DOMa5C0Ca6V1A8av/LWOWXdVQIWdjb3BhwZSVgUeQMoOg5hqEMIqYBous
         y9WfgZ3fNFz5kNFX0ZotQYabo+naVWskI1Ibl+pqvMPRum4SzGKpZHV5XKmywZvBp3hn
         x1KQqqrIYTjH/V+LwL5gOZx7XEJJWFV4zO0h67dxZMxbLkb4q10jiFQLkrVFkmkn0PX1
         PR6Q==
X-Gm-Message-State: ABy/qLZRI/REc33xQUxTsmCNr9vGl7xoPCYOHx2LCUE6lYNYboI2ZkLm
        J8ajTAbWVINHVJ0RqLW7Q2WhTOWqd8UEKdqNa2WVBaT3
X-Google-Smtp-Source: APBJJlHEo/gt13jwP9dEwxvcOw4paJE/7K+iOx9VZ96q5+AnH4ZAbMxd+NF0c4vwkKcZEL+U6Anjog==
X-Received: by 2002:a05:622a:294:b0:403:9e72:5e93 with SMTP id z20-20020a05622a029400b004039e725e93mr2104481qtw.9.1690526801559;
        Thu, 27 Jul 2023 23:46:41 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id a26-20020ac8001a000000b00403ad6ec2e8sm965163qtg.26.2023.07.27.23.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 23:46:40 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-63d09d886a3so11693036d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:46:40 -0700 (PDT)
X-Received: by 2002:a05:6214:3b84:b0:63d:23c:41d with SMTP id
 nf4-20020a0562143b8400b0063d023c041dmr1469017qvb.25.1690526800244; Thu, 27
 Jul 2023 23:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com> <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com> <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
 <20230712104801.tgawhexpm53ocgd6@chromium.org> <2d239d33-b05d-1b51-2268-43b2839b64ea@synaptics.com>
In-Reply-To: <2d239d33-b05d-1b51-2268-43b2839b64ea@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 28 Jul 2023 15:46:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D7oNG8oZB66qEW720fR79paw_q0LGBg7X4jK-ZkgYD_g@mail.gmail.com>
Message-ID: <CAAFQd5D7oNG8oZB66qEW720fR79paw_q0LGBg7X4jK-ZkgYD_g@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as global
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, linux-staging@lists.linux.dev,
        ming.qian@nxp.com, kernel@collabora.com,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 4:44=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
>
>
> On 7/12/23 18:48, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
> >> On 7/3/23 16:09, Benjamin Gaignard wrote:
> >>> CAUTION: Email originated externally, do not click links or open
> >>> attachments unless you recognize the sender and know the content is
> >>> safe.
> >>>
> >>>
> >>> Le 30/06/2023 =C3=A0 11:51, Hsia-Jun Li a =C3=A9crit :
> >>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
> >>>>> CAUTION: Email originated externally, do not click links or open
> >>>>> attachments unless you recognize the sender and know the content is
> >>>>> safe.
> >>>>>
> >>>>>
> >>>>> After changing bufs arrays to a dynamic allocated array
> >>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
> >>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel =
is
> >>>> more reasonable.
> >>>>
> >>>> It would be hard to iterate the whole array, it would go worse with =
a
> >>>> filter. Such iterate may need to go twice because you mix
> >>>> post-processing buffer and decoding buffer(with MV) in the same arra=
y.
> >>> Here I don't want to change drivers behavior so I keep the same value=
.
> >>> If it happens that they need more buffers, like for dynamic resolutio=
n
> >>> change
> >>> feature for Verisilicon VP9 decoder, case by case patches will be nee=
ded.
> >>>
> >> I just don't like the idea that using a variant length array here.
> >>
> > "I don't like" is not an argument. We had a number of arguments for
> > using a generic helper (originally idr, but later decided to go with
> > XArray, because the former is now deprecated) that we pointed out in
> > our review comments for previous revisions. It wasn't really about the
> > size being variable, but rather avoiding open coding things in vb2 and
> > duplicating what's already implemented in generic code.
>
> I just want to say I don't think we need a variable length array to
> store the buffer here.
>
> And the below is the reason that such a case could be avoided in the
> first place.
>
> >
> >> And I could explain why you won't need so many buffers for the perform=
ance
> >> of decoding.
> >>
> >> VP9 could support 10 reference frames in dpb.
> >>
> >> Even for those frequent resolution changing test set, it would only ha=
ppen
> >> to two resolutions,
> >>
> >> 32 would be enough for 20 buffers of two resolution plus golden frames=
. It
> >> also leaves enough slots for re-order latency.
> >>
> >> If your case had more two resolutions, likes low->medium->high.
> >>
> >> I would suggest just skip the medium resolutions, just allocate the lo=
wer
> >> one first for fast playback then the highest for all the possible
> >>
> >> medium cases. Reallocation happens frequently would only cause memory
> >> fragment, nothing benefits your performance.
> >>
> > We have mechanisms in the kernel to deal with memory fragmentation
> > (migration/compaction) and it would still only matters for the
> > pathologic cases of hardware that require physically contiguous memory.
> > Modern hardware with proper DMA capabilities can either scatter-gather
> > or are equipped with an IOMMU, so the allocation always happens in page
> > granularity and fragmentation is avoided.
>
> Unfortunately, there are more devices that didn't have a IOMMU attached
> to it, supporting scatter gather is more odd.
>
> It would be more likely that IOMMU would be disabled for the performance
> reason.

These days IOMMU is totally mandatory if you want to think about
having any level of security in your system. Sure, there could be some
systems that are completely isolated from any external environment,
like some offline industry automation machines, but then arguably
their running conditions would also be quite static and require very
little memory re-allocation.

I also don't buy the performance reason. CPUs have been behind MMUs
for ages and nobody is running them with paging disabled for
performance reasons. Similarly, most of the modern consumer systems
(mobile phones, PCs) run with IOMMUs enabled for pretty much anything
because of the security reason and they don't seem to be having any
performance issues. In fact, it can improve the performance, because
memory allocation is much easier and without contiguous careouts (as
we used to have long ago on Android devices) the extra memory can be
used for buffers and caches to improve system performance.

Best regards,
Tomasz

>
> >
> > Best regards,
> > Tomasz
> >
> >>>>> Remove it from the core definitions but keep it for drivers interna=
l
> >>>>> needs.
> >>>>>
> >>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>>>> ---
> >>>>>    drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
> >>>>>    drivers/media/platform/amphion/vdec.c | 1 +
> >>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 +=
+
> >>>>>    drivers/media/platform/qcom/venus/hfi.h | 2 ++
> >>>>>    drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
> >>>>>    drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
> >>>>>    include/media/videobuf2-core.h | 1 -
> >>>>>    include/media/videobuf2-v4l2.h | 4 ----
> >>>>>    8 files changed, 11 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> index 86e1e926fa45..899783f67580 100644
> >>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>> @@ -31,6 +31,8 @@
> >>>>>
> >>>>>    #include <trace/events/vb2.h>
> >>>>>
> >>>>> +#define VB2_MAX_FRAME  32
> >>>>> +
> >>>>>    static int debug;
> >>>>>    module_param(debug, int, 0644);
> >>>>>
> >>>>> diff --git a/drivers/media/platform/amphion/vdec.c
> >>>>> b/drivers/media/platform/amphion/vdec.c
> >>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
> >>>>> --- a/drivers/media/platform/amphion/vdec.c
> >>>>> +++ b/drivers/media/platform/amphion/vdec.c
> >>>>> @@ -28,6 +28,7 @@
> >>>>>
> >>>>>    #define VDEC_MIN_BUFFER_CAP            8
> >>>>>    #define VDEC_MIN_BUFFER_OUT            8
> >>>>> +#define VB2_MAX_FRAME                  32
> >>>>>
> >>>>>    struct vdec_fs_info {
> >>>>>           char name[8];
> >>>>> diff --git
> >>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> >>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> >>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
> >>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c
> >>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c
> >>>>> @@ -16,6 +16,8 @@
> >>>>>    #include "../vdec_drv_if.h"
> >>>>>    #include "../vdec_vpu_if.h"
> >>>>>
> >>>>> +#define VB2_MAX_FRAME  32
> >>>>> +
> >>>>>    /* reset_frame_context defined in VP9 spec */
> >>>>>    #define VP9_RESET_FRAME_CONTEXT_NONE0 0
> >>>>>    #define VP9_RESET_FRAME_CONTEXT_NONE1 1
> >>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
> >>>>> b/drivers/media/platform/qcom/venus/hfi.h
> >>>>> index f25d412d6553..bd5ca5a8b945 100644
> >>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
> >>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
> >>>>> @@ -10,6 +10,8 @@
> >>>>>
> >>>>>    #include "hfi_helper.h"
> >>>>>
> >>>>> +#define VB2_MAX_FRAME                          32
> >>>>> +
> >>>>>    #define VIDC_SESSION_TYPE_VPE                  0
> >>>>>    #define VIDC_SESSION_TYPE_ENC                  1
> >>>>>    #define VIDC_SESSION_TYPE_DEC                  2
> >>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>> index e83f0c523a30..9e8faf7ba6fb 100644
> >>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>> @@ -15,6 +15,8 @@
> >>>>>    #include <media/v4l2-vp9.h>
> >>>>>    #include <media/videobuf2-core.h>
> >>>>>
> >>>>> +#define VB2_MAX_FRAME  32
> >>>>> +
> >>>>>    #define DEC_8190_ALIGN_MASK    0x07U
> >>>>>
> >>>>>    #define MB_DIM                 16
> >>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>> index e530767e80a5..6627b5c2d4d6 100644
> >>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>> @@ -10,6 +10,8 @@
> >>>>>    #include "ipu3.h"
> >>>>>    #include "ipu3-dmamap.h"
> >>>>>
> >>>>> +#define VB2_MAX_FRAME  32
> >>>>> +
> >>>>>    /******************** v4l2_subdev_ops ********************/
> >>>>>
> >>>>>    #define IPU3_RUNNING_MODE_VIDEO                0
> >>>>> diff --git a/include/media/videobuf2-core.h
> >>>>> b/include/media/videobuf2-core.h
> >>>>> index 77921cf894ef..080b783d608d 100644
> >>>>> --- a/include/media/videobuf2-core.h
> >>>>> +++ b/include/media/videobuf2-core.h
> >>>>> @@ -20,7 +20,6 @@
> >>>>>    #include <media/media-request.h>
> >>>>>    #include <media/frame_vector.h>
> >>>>>
> >>>>> -#define VB2_MAX_FRAME  (32)
> >>>>>    #define VB2_MAX_PLANES (8)
> >>>>>
> >>>>>    /**
> >>>>> diff --git a/include/media/videobuf2-v4l2.h
> >>>>> b/include/media/videobuf2-v4l2.h
> >>>>> index 5a845887850b..88a7a565170e 100644
> >>>>> --- a/include/media/videobuf2-v4l2.h
> >>>>> +++ b/include/media/videobuf2-v4l2.h
> >>>>> @@ -15,10 +15,6 @@
> >>>>>    #include <linux/videodev2.h>
> >>>>>    #include <media/videobuf2-core.h>
> >>>>>
> >>>>> -#if VB2_MAX_FRAME !=3D VIDEO_MAX_FRAME
> >>>>> -#error VB2_MAX_FRAME !=3D VIDEO_MAX_FRAME
> >>>>> -#endif
> >>>>> -
> >>>>>    #if VB2_MAX_PLANES !=3D VIDEO_MAX_PLANES
> >>>>>    #error VB2_MAX_PLANES !=3D VIDEO_MAX_PLANES
> >>>>>    #endif
> >>>>> --
> >>>>> 2.39.2
> >>>>>
> >> --
> >> Hsia-Jun(Randy) Li
> >>
> --
> Hsia-Jun(Randy) Li
>
