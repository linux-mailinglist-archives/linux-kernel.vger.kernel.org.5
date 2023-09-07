Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949F796F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjIGEQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjIGEPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:15:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC1199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:15:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76ef8b91a72so36540285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694060143; x=1694664943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHSZVsclUSPq3qNI//pbigdakyCDFL1AOVrJMm5Sok8=;
        b=B0+7QDnwoJ+nsR02ZP0t76c7P8TayzHQ+XYouFtIsizcuoCT/ZxKAF71d436OoRRMQ
         Q0DbFl5aT1dwgJsWu7uEk4sFjANEymafD5HEBhA6q+j1I87viJFGeuv8t5LFiQmiZkJa
         JKpSoejKENhbK3WoCaQPzorA6mbrYC3x4j9Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694060143; x=1694664943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHSZVsclUSPq3qNI//pbigdakyCDFL1AOVrJMm5Sok8=;
        b=As82jpGjEpiWzOX1o6ruwxeSNBNSloTb2Wz/X4hATsAFCNp9Sc9nIhNKITBlcgdvVs
         VfJpaHD8F/Ys0aGhqJNoTcupEPbk8PADPtTW4vcgnSEmtdFUhyR2/LUmQnLBVzdaa8Am
         I20ONTkCtQw2t3buPjU+LuCBj1cAHTDSiK58kTDq22mCzersvlJOnGYxEcKRPItmuSJF
         vP3zXIaariBvsgluYlThbExmfDshzjk43qPnFfIfrxGGkAsjOhH6abXFgHu7ytRd/4Cr
         u6uK2MIyxIGVjrru8Jkz6gBKiTjxLEjnGwW4PLYdlESIH9ouHYbjECdwv3Qsg475EtB6
         7heA==
X-Gm-Message-State: AOJu0Yx1st7SCdhFZ907LTPDBLymdYVxXJuOfNSmQKTeKVTgQegXm3jT
        gCmHatpWShp/ryD4qRMPi9QLBCxWmzg4JoXkZDTFBQ==
X-Google-Smtp-Source: AGHT+IFHG8I2Nii2J98KR6AI8SeJtT97mn0UHz+5MLC626XmtkjJKRQIBpV3yZ6wn7o2blAplMwy+Q==
X-Received: by 2002:a05:620a:4414:b0:767:2919:f38f with SMTP id v20-20020a05620a441400b007672919f38fmr23841750qkp.10.1694060143388;
        Wed, 06 Sep 2023 21:15:43 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b0076cf49bcb50sm5456874qkl.37.2023.09.06.21.15.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 21:15:41 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-64f457c97a3so3372066d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 21:15:40 -0700 (PDT)
X-Received: by 2002:a0c:f0d4:0:b0:64f:9361:6b19 with SMTP id
 d20-20020a0cf0d4000000b0064f93616b19mr14561910qvl.9.1694060140283; Wed, 06
 Sep 2023 21:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com> <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com> <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
 <20230712104801.tgawhexpm53ocgd6@chromium.org> <2d239d33-b05d-1b51-2268-43b2839b64ea@synaptics.com>
 <CAAFQd5D7oNG8oZB66qEW720fR79paw_q0LGBg7X4jK-ZkgYD_g@mail.gmail.com>
 <f6a3e3e5-14be-6d5c-48d3-009424e1a49a@synaptics.com> <CAAFQd5D3NUqvkJFYgystFVFRQvq-5S0ZNUOrv1LJqmCA_8+a_w@mail.gmail.com>
 <9bc67e88-bce1-b812-aa57-76eca764cb38@synaptics.com>
In-Reply-To: <9bc67e88-bce1-b812-aa57-76eca764cb38@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 7 Sep 2023 13:15:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DpCfS7RyTbd_kfFz+wQ41=gnLosMMNK_GcH8JO=DbzSQ@mail.gmail.com>
Message-ID: <CAAFQd5DpCfS7RyTbd_kfFz+wQ41=gnLosMMNK_GcH8JO=DbzSQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:25=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
>
>
>
> On 7/28/23 15:03, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Fri, Jul 28, 2023 at 3:55=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics=
.com> wrote:
> >>
> >>
> >>
> >> On 7/28/23 14:46, Tomasz Figa wrote:
> >>> CAUTION: Email originated externally, do not click links or open atta=
chments unless you recognize the sender and know the content is safe.
> >>>
> >>>
> >>> On Mon, Jul 17, 2023 at 4:44=E2=80=AFPM Hsia-Jun Li <Randy.Li@synapti=
cs.com> wrote:
> >>>>
> >>>>
> >>>> On 7/12/23 18:48, Tomasz Figa wrote:
> >>>>> CAUTION: Email originated externally, do not click links or open at=
tachments unless you recognize the sender and know the content is safe.
> >>>>>
> >>>>>
> >>>>> On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
> >>>>>> On 7/3/23 16:09, Benjamin Gaignard wrote:
> >>>>>>> CAUTION: Email originated externally, do not click links or open
> >>>>>>> attachments unless you recognize the sender and know the content =
is
> >>>>>>> safe.
> >>>>>>>
> >>>>>>>
> >>>>>>> Le 30/06/2023 =C3=A0 11:51, Hsia-Jun Li a =C3=A9crit :
> >>>>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
> >>>>>>>>> CAUTION: Email originated externally, do not click links or ope=
n
> >>>>>>>>> attachments unless you recognize the sender and know the conten=
t is
> >>>>>>>>> safe.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> After changing bufs arrays to a dynamic allocated array
> >>>>>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
> >>>>>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI ker=
nel is
> >>>>>>>> more reasonable.
> >>>>>>>>
> >>>>>>>> It would be hard to iterate the whole array, it would go worse w=
ith a
> >>>>>>>> filter. Such iterate may need to go twice because you mix
> >>>>>>>> post-processing buffer and decoding buffer(with MV) in the same =
array.
> >>>>>>> Here I don't want to change drivers behavior so I keep the same v=
alue.
> >>>>>>> If it happens that they need more buffers, like for dynamic resol=
ution
> >>>>>>> change
> >>>>>>> feature for Verisilicon VP9 decoder, case by case patches will be=
 needed.
> >>>>>>>
> >>>>>> I just don't like the idea that using a variant length array here.
> >>>>>>
> >>>>> "I don't like" is not an argument. We had a number of arguments for
> >>>>> using a generic helper (originally idr, but later decided to go wit=
h
> >>>>> XArray, because the former is now deprecated) that we pointed out i=
n
> >>>>> our review comments for previous revisions. It wasn't really about =
the
> >>>>> size being variable, but rather avoiding open coding things in vb2 =
and
> >>>>> duplicating what's already implemented in generic code.
> >>>>
> >>>> I just want to say I don't think we need a variable length array to
> >>>> store the buffer here.
> >>>>
> >>>> And the below is the reason that such a case could be avoided in the
> >>>> first place.
> >>>>
> >>>>>
> >>>>>> And I could explain why you won't need so many buffers for the per=
formance
> >>>>>> of decoding.
> >>>>>>
> >>>>>> VP9 could support 10 reference frames in dpb.
> >>>>>>
> >>>>>> Even for those frequent resolution changing test set, it would onl=
y happen
> >>>>>> to two resolutions,
> >>>>>>
> >>>>>> 32 would be enough for 20 buffers of two resolution plus golden fr=
ames. It
> >>>>>> also leaves enough slots for re-order latency.
> >>>>>>
> >>>>>> If your case had more two resolutions, likes low->medium->high.
> >>>>>>
> >>>>>> I would suggest just skip the medium resolutions, just allocate th=
e lower
> >>>>>> one first for fast playback then the highest for all the possible
> >>>>>>
> >>>>>> medium cases. Reallocation happens frequently would only cause mem=
ory
> >>>>>> fragment, nothing benefits your performance.
> >>>>>>
> >>>>> We have mechanisms in the kernel to deal with memory fragmentation
> >>>>> (migration/compaction) and it would still only matters for the
> >>>>> pathologic cases of hardware that require physically contiguous mem=
ory.
> >>>>> Modern hardware with proper DMA capabilities can either scatter-gat=
her
> >>>>> or are equipped with an IOMMU, so the allocation always happens in =
page
> >>>>> granularity and fragmentation is avoided.
> >>>>
> >>>> Unfortunately, there are more devices that didn't have a IOMMU attac=
hed
> >>>> to it, supporting scatter gather is more odd.
> >>>>
> >>>> It would be more likely that IOMMU would be disabled for the perform=
ance
> >>>> reason.
> >>>
> >>> These days IOMMU is totally mandatory if you want to think about
> >>> having any level of security in your system. Sure, there could be som=
e
> >>> systems that are completely isolated from any external environment,
> >>> like some offline industry automation machines, but then arguably
> >>> their running conditions would also be quite static and require very
> >>> little memory re-allocation.
> >> Vendor just decided not to included such hardware.
> >> That is why From ION to DMA-heap, people like to allocate from a cavou=
t
> >> out memory.
> >>>
> >>> I also don't buy the performance reason. CPUs have been behind MMUs
> >>> for ages and nobody is running them with paging disabled for
> >>> performance reasons. Similarly, most of the modern consumer systems
> >> Page lookup would increase the delay. Besides a few upstream devices
> >> prove them only use a level 1 page table without TBL.
> >
> > That's just an excuse for a bad hardware design/implementation. As I
> > said, there are good IOMMU implementations out there that don't suffer
> > from performance issues.
> >
> I could do nothing about that.
> Besides, even with TLB, cache missing could happen frequently,
> especially we need to access many (5~16, 10 usually) buffers and more
> 11MBytes each in a hardware processing.
> You can't have a very large TLB.

Right, but as I wrote in my previous emails, we have the right methods
in the kernel for providing drivers with contiguous memory and those
can be used for those special cases.

> >>> (mobile phones, PCs) run with IOMMUs enabled for pretty much anything
> >>> because of the security reason and they don't seem to be having any
> >> If the page is secure, you can't operate it in a insecure IOMMU or MMU=
.
> >> The most security way here, we should use a dedicated memory(or a zone
> >> in unified memory).
> >
> > You still need something to enforce that the hardware is not accessing
> > memory that it's not supposed to access. How do you do that without an
> > IOMMU?
> >
> If you know the arm security pipeline and security controller, you could
> found we could reserved a range of memory for a security id(devices in
> secure world may be a different security domain).
> Besides, a MMU or security MPU could mark some pages for the secure
> world access only, it doesn't mean the device need an IOMMU to access
> them. The MPU could filter the access through the AXI id.
> >> I believe there are more users in mobile for DMA-heap than kernel's dm=
a
> >> allocation API.
> >
> > Yes, but that's completely separate from whether there is an IOMMU or
> > not. It's just a different allocation API.
> >
> The memory heap would mean a dedicated memory usually(we don't talk
> about system heap or why there are many vendor heaps). Dedicated memory
> means contiguous memory in the most of cases.

No, and no.
First no - DMA-buf heap doesn't imply dedicated memory and usually one
wants to completely avoid carving out memory, because it becomes
useless if specific use case is not active.
Second no - there are ways to provide dedicated memory regions to the
DMA mapping API, such as shared or restricted DMA pool [1].

[1] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree=
/bindings/reserved-memory/shared-dma-pool.yaml

Best regards,
Tomasz

> >>> performance issues. In fact, it can improve the performance, because
> >>> memory allocation is much easier and without contiguous careouts (as
> >>> we used to have long ago on Android devices) the extra memory can be
> >>> used for buffers and caches to improve system performance.
> >>>
> >>> Best regards,
> >>> Tomasz
> >>>
> >>>>
> >>>>>
> >>>>> Best regards,
> >>>>> Tomasz
> >>>>>
> >>>>>>>>> Remove it from the core definitions but keep it for drivers int=
ernal
> >>>>>>>>> needs.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.c=
om>
> >>>>>>>>> ---
> >>>>>>>>>      drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
> >>>>>>>>>      drivers/media/platform/amphion/vdec.c | 1 +
> >>>>>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c |=
 2 ++
> >>>>>>>>>      drivers/media/platform/qcom/venus/hfi.h | 2 ++
> >>>>>>>>>      drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
> >>>>>>>>>      drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
> >>>>>>>>>      include/media/videobuf2-core.h | 1 -
> >>>>>>>>>      include/media/videobuf2-v4l2.h | 4 ----
> >>>>>>>>>      8 files changed, 11 insertions(+), 5 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>>>> index 86e1e926fa45..899783f67580 100644
> >>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>>>> @@ -31,6 +31,8 @@
> >>>>>>>>>
> >>>>>>>>>      #include <trace/events/vb2.h>
> >>>>>>>>>
> >>>>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>>>> +
> >>>>>>>>>      static int debug;
> >>>>>>>>>      module_param(debug, int, 0644);
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
> >>>>>>>>> b/drivers/media/platform/amphion/vdec.c
> >>>>>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
> >>>>>>>>> --- a/drivers/media/platform/amphion/vdec.c
> >>>>>>>>> +++ b/drivers/media/platform/amphion/vdec.c
> >>>>>>>>> @@ -28,6 +28,7 @@
> >>>>>>>>>
> >>>>>>>>>      #define VDEC_MIN_BUFFER_CAP            8
> >>>>>>>>>      #define VDEC_MIN_BUFFER_OUT            8
> >>>>>>>>> +#define VB2_MAX_FRAME                  32
> >>>>>>>>>
> >>>>>>>>>      struct vdec_fs_info {
> >>>>>>>>>             char name[8];
> >>>>>>>>> diff --git
> >>>>>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c
> >>>>>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c
> >>>>>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
> >>>>>>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_=
lat_if.c
> >>>>>>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_=
lat_if.c
> >>>>>>>>> @@ -16,6 +16,8 @@
> >>>>>>>>>      #include "../vdec_drv_if.h"
> >>>>>>>>>      #include "../vdec_vpu_if.h"
> >>>>>>>>>
> >>>>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>>>> +
> >>>>>>>>>      /* reset_frame_context defined in VP9 spec */
> >>>>>>>>>      #define VP9_RESET_FRAME_CONTEXT_NONE0 0
> >>>>>>>>>      #define VP9_RESET_FRAME_CONTEXT_NONE1 1
> >>>>>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>>>> b/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>>>> index f25d412d6553..bd5ca5a8b945 100644
> >>>>>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>>>> @@ -10,6 +10,8 @@
> >>>>>>>>>
> >>>>>>>>>      #include "hfi_helper.h"
> >>>>>>>>>
> >>>>>>>>> +#define VB2_MAX_FRAME                          32
> >>>>>>>>> +
> >>>>>>>>>      #define VIDC_SESSION_TYPE_VPE                  0
> >>>>>>>>>      #define VIDC_SESSION_TYPE_ENC                  1
> >>>>>>>>>      #define VIDC_SESSION_TYPE_DEC                  2
> >>>>>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
> >>>>>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>>>> @@ -15,6 +15,8 @@
> >>>>>>>>>      #include <media/v4l2-vp9.h>
> >>>>>>>>>      #include <media/videobuf2-core.h>
> >>>>>>>>>
> >>>>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>>>> +
> >>>>>>>>>      #define DEC_8190_ALIGN_MASK    0x07U
> >>>>>>>>>
> >>>>>>>>>      #define MB_DIM                 16
> >>>>>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>>>> index e530767e80a5..6627b5c2d4d6 100644
> >>>>>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>>>> @@ -10,6 +10,8 @@
> >>>>>>>>>      #include "ipu3.h"
> >>>>>>>>>      #include "ipu3-dmamap.h"
> >>>>>>>>>
> >>>>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>>>> +
> >>>>>>>>>      /******************** v4l2_subdev_ops ********************=
/
> >>>>>>>>>
> >>>>>>>>>      #define IPU3_RUNNING_MODE_VIDEO                0
> >>>>>>>>> diff --git a/include/media/videobuf2-core.h
> >>>>>>>>> b/include/media/videobuf2-core.h
> >>>>>>>>> index 77921cf894ef..080b783d608d 100644
> >>>>>>>>> --- a/include/media/videobuf2-core.h
> >>>>>>>>> +++ b/include/media/videobuf2-core.h
> >>>>>>>>> @@ -20,7 +20,6 @@
> >>>>>>>>>      #include <media/media-request.h>
> >>>>>>>>>      #include <media/frame_vector.h>
> >>>>>>>>>
> >>>>>>>>> -#define VB2_MAX_FRAME  (32)
> >>>>>>>>>      #define VB2_MAX_PLANES (8)
> >>>>>>>>>
> >>>>>>>>>      /**
> >>>>>>>>> diff --git a/include/media/videobuf2-v4l2.h
> >>>>>>>>> b/include/media/videobuf2-v4l2.h
> >>>>>>>>> index 5a845887850b..88a7a565170e 100644
> >>>>>>>>> --- a/include/media/videobuf2-v4l2.h
> >>>>>>>>> +++ b/include/media/videobuf2-v4l2.h
> >>>>>>>>> @@ -15,10 +15,6 @@
> >>>>>>>>>      #include <linux/videodev2.h>
> >>>>>>>>>      #include <media/videobuf2-core.h>
> >>>>>>>>>
> >>>>>>>>> -#if VB2_MAX_FRAME !=3D VIDEO_MAX_FRAME
> >>>>>>>>> -#error VB2_MAX_FRAME !=3D VIDEO_MAX_FRAME
> >>>>>>>>> -#endif
> >>>>>>>>> -
> >>>>>>>>>      #if VB2_MAX_PLANES !=3D VIDEO_MAX_PLANES
> >>>>>>>>>      #error VB2_MAX_PLANES !=3D VIDEO_MAX_PLANES
> >>>>>>>>>      #endif
> >>>>>>>>> --
> >>>>>>>>> 2.39.2
> >>>>>>>>>
> >>>>>> --
> >>>>>> Hsia-Jun(Randy) Li
> >>>>>>
> >>>> --
> >>>> Hsia-Jun(Randy) Li
> >>>>
> >>
> >> --
> >> Hsia-Jun(Randy) Li
>
> --
> Hsia-Jun(Randy) Li
