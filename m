Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F66766498
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjG1G6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1G6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:58:10 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49090198A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:58:08 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63ce8bea776so11477156d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690527486; x=1691132286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJWRF/nguMqHhP6pCj/oy6RKbdRAQZsjUlzFM95hJj4=;
        b=Xam3KBBamtSSSxMiNjem3Sk7BFMuCxsW7s3JVNAAwt3gJhR8tAoUJxJuIncsbOIEip
         8p3n2il1m4KEnLOO9eNX6z+HV5+l4KPL2OMnOSPCuxBJjHeJaLrLzaXoK0+/BcRxaQFZ
         47tvu+5mG+bCsc6fqZ2j2Ddd6sMjw3rl4dvT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527486; x=1691132286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJWRF/nguMqHhP6pCj/oy6RKbdRAQZsjUlzFM95hJj4=;
        b=iUU7q6w/Rb0gDAwhTa0pW6OL9RT6c287Z+f9073l+KlJHykU6eXQVX1cMDTYcqr7ND
         Gkj7ZOXM2vYzozQciwZv4xKZ74RnoPeVWHWRRaENDBtxB2kBJTufytR1ScP4cRkFWXsf
         cykZcH9VMfEj/p5l/fDJtcnYnk9oO9qq3Xtb5j3pYryXkfFA54+bOlzm7eWs3Xv+bi1s
         vBtuO/GmGqm0RWC2ieFEzCJzSO0mBUHEHOcpp3Zx8GMF1TOqEAA8yC/y07lAk/4osSaC
         Lrb+ynY9k+R0hQvTQ73nkouU4j3G5Nil0Bdh72+vfg0EeAob7+TvE6gpazk+RXLHoEh8
         hnTw==
X-Gm-Message-State: ABy/qLYSJk2uUqwRlg72FK+tVC4kbb4XTQDdOo98MSA0LxwOg4Us4sRT
        tsrMTyEPjp0xiBHEqCkafsee4VdsEe/GTZ389h+VWcPQ
X-Google-Smtp-Source: APBJJlGoVfs655yNbdgTXpXRs2JHev1hjLRoi0ztQ/QXgAV9T3O5AoPRHk5+8biKEnKkB/Iuk2jNdA==
X-Received: by 2002:a05:6214:164e:b0:621:48be:baa8 with SMTP id f14-20020a056214164e00b0062148bebaa8mr1260625qvw.48.1690527486542;
        Thu, 27 Jul 2023 23:58:06 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id i6-20020a0cab46000000b0063cdcd5699csm1012482qvb.118.2023.07.27.23.58.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 23:58:06 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-635f293884cso11310176d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:58:05 -0700 (PDT)
X-Received: by 2002:ad4:410a:0:b0:637:2235:4a29 with SMTP id
 i10-20020ad4410a000000b0063722354a29mr1482697qvp.30.1690527485500; Thu, 27
 Jul 2023 23:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-11-benjamin.gaignard@collabora.com>
 <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com> <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
 <3b22fda9-4a0e-2c03-2f12-19e5e3239235@synaptics.com> <54833256-7d88-9316-4f0f-b8c57552cd7b@synaptics.com>
 <20230713090944.3gxrxt7lqnozhu7r@chromium.org> <e4bb9520-489f-2bb3-4a17-668c3f448668@synaptics.com>
In-Reply-To: <e4bb9520-489f-2bb3-4a17-668c3f448668@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 28 Jul 2023 15:57:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D8bTdqT4tS5R4P60+T+qLcqQ-JMeA3vSN6TRLQXCazWw@mail.gmail.com>
Message-ID: <CAAFQd5D8bTdqT4tS5R4P60+T+qLcqQ-JMeA3vSN6TRLQXCazWw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, ming.qian@nxp.com,
        hverkuil-cisco@xs4all.nl, gregkh@linuxfoundation.org,
        ezequiel@vanguardiasur.com.ar,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, nicolas.dufresne@collabora.com,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        ayaka <ayaka@soulik.info>
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

On Mon, Jul 17, 2023 at 11:17=E2=80=AFAM Hsia-Jun Li <Randy.Li@synaptics.co=
m> wrote:
>
>
> On 7/13/23 17:09, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Fri, Jun 30, 2023 at 05:43:51PM +0800, Hsia-Jun Li wrote:
> >> On 6/27/23 16:47, Hsia-Jun Li wrote:
> >>> CAUTION: Email originated externally, do not click links or open
> >>> attachments unless you recognize the sender and know the content is
> >>> safe.
> >>>
> >>>
> >>> On 6/27/23 16:43, Benjamin Gaignard wrote:
> >>>> CAUTION: Email originated externally, do not click links or open
> >>>> attachments unless you recognize the sender and know the content is
> >>>> safe.
> >>>>
> >>>>
> >>>> Le 27/06/2023 =C3=A0 09:30, Hsia-Jun Li a =C3=A9crit :
> >>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
> >>>>>> CAUTION: Email originated externally, do not click links or open
> >>>>>> attachments unless you recognize the sender and know the content i=
s
> >>>>>> safe.
> >>>>>>
> >>>>>>
> >>>>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
> >>>>>>
> >>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>>>>> ---
> >>>>>>    .../userspace-api/media/v4l/user-func.rst     |  1 +
> >>>>>>    .../media/v4l/vidioc-delete-buf.rst           | 51
> >>>>>> +++++++++++++++++++
> >>>>>>    .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
> >>>>>>    .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
> >>>>>>    drivers/media/v4l2-core/v4l2-dev.c            |  1 +
> >>>>>>    drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
> >>>>>>    include/media/v4l2-ioctl.h                    |  4 ++
> >>>>>>    include/media/videobuf2-core.h                |  9 ++++
> >>>>>>    include/media/videobuf2-v4l2.h                | 11 ++++
> >>>>>>    include/uapi/linux/videodev2.h                |  2 +
> >>>>>>    10 files changed, 128 insertions(+)
> >>>>>>    create mode 100644
> >>>>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> >>>>>>
> >>>>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
> >>>>>> b/Documentation/userspace-api/media/v4l/user-func.rst
> >>>>>> index 15ff0bf7bbe6..8c74016e12fd 100644
> >>>>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
> >>>>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
> >>>>>> @@ -17,6 +17,7 @@ Function Reference
> >>>>>>        vidioc-dbg-g-chip-info
> >>>>>>        vidioc-dbg-g-register
> >>>>>>        vidioc-decoder-cmd
> >>>>>> +    vidioc-delete-buf
> >>>>>>        vidioc-dqevent
> >>>>>>        vidioc-dv-timings-cap
> >>>>>>        vidioc-encoder-cmd
> >>>>>> diff --git
> >>>>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> >>>>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..0e7ce58f91bc
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> >>>>>> @@ -0,0 +1,51 @@
> >>>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> >>>>>> +.. c:namespace:: V4L
> >>>>>> +
> >>>>>> +.. _VIDIOC_DELETE_BUF:
> >>>>>> +
> >>>>>> +************************
> >>>>>> +ioctl VIDIOC_DELETE_BUF
> >>>>>> +************************
> >>>>>> +
> >>>>>> +Name
> >>>>>> +=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
> >>>>>> +
> >>>>>> +Synopsis
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +.. c:macro:: VIDIOC_DELETE_BUF
> >>>>>> +
> >>>>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)`=
`
> >>>>>> +
> >>>>>> +Arguments
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +``fd``
> >>>>>> +    File descriptor returned by :c:func:`open()`.
> >>>>>> +
> >>>>>> +``argp``
> >>>>>> +    Pointer to struct :c:type:`v4l2_buffer`.
> >>>>>> +
> >>>>>> +Description
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +Applications can optionally call the
> >>>>>> :ref:`VIDIOC_DELETE_BUF` ioctl to
> >>>>>> +delete a buffer from a queue.
> >>>>>> +
> >>>>>> +The struct :c:type:`v4l2_buffer` structure is specified in
> >>>>>> +:ref:`buffer`.
> >>>>>> +
> >>>>>> +Return Value
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +On success 0 is returned, on error -1 and the ``errno`` variable =
is
> >>>>>> set
> >>>>>> +appropriately. The generic error codes are described at the
> >>>>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
> >>>>>> +
> >>>>>> +EBUSY
> >>>>>> +    File I/O is in progress.
> >>>>>> +
> >>>>>> +EINVAL
> >>>>>> +    The buffer ``index`` doesn't exist in the queue.
> >>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>> index 899783f67580..aa546c972c3d 100644
> >>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *=
q,
> >>>>>> unsigned int index, void *pb)
> >>>>>>    }
> >>>>>>    EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
> >>>>>>
> >>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
> >>>>>> +{
> >>>>>> +       struct vb2_buffer *vb;
> >>>>>> +
> >>>>>> +       vb =3D vb2_get_buffer(q, index);
> >>>>>> +       if (!vb) {
> >>>>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
> >>>>>> +               return -EINVAL;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       if (vb->state !=3D VB2_BUF_STATE_DEQUEUED) {
> >>>>>> +               dprintk(q, 1, "can't delete non dequeued buffer in=
dex
> >>>>>> %d\n", index);
> >>>>>> +               return -EINVAL;
> >>>>>> +       }
> >>>>>> +
> >>>>> I know the driver could implement its own
> >>>>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
> >>>>> used by the hardware as a future reference frame.
> >>>>> But I think we need a flag to let the user know which buffer is sti=
ll
> >>>>> used by the hardware.
> >>>>> Alternative ref case is safe, we only know it's existing when it is
> >>>>> dequeued in current V4L2 buffer mechanism.
> >>>>> While the Golden reference frame, such long term reference frame co=
uld
> >>>>> last much longer.
> >>>> It is up to userland stack to know frames life time, it got the
> >>>> information for that.
> >>> That is true for the stateless codec driver.
> >>>
> >>> While application for stateful decoder could never do that. It also
> >>> breaks what the document said:
> >>>
> >>> "The backing memory of |CAPTURE| buffers that are used as reference
> >>> frames by the stream may be read by the hardware even after they are
> >>> dequeued. Consequently, the client should avoid writing into this mem=
ory
> >>> while the |CAPTURE| queue is streaming. Failure to observe this may
> >>> result in corruption of decoded frames."
> >>>
> >>>>>> +       if (vb->planes[0].mem_priv)
> >>>>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
> >>>>>> +
> >>>>>> +       /* Free MMAP buffers or release USERPTR buffers */
> >>>>>> +       if (q->memory =3D=3D VB2_MEMORY_MMAP)
> >>>>>> +               __vb2_buf_mem_free(vb);
> >> Here is another problem for the existing application, the mmap() from =
the
> >> mmap offset or exportbuffer fd would not create a reference to buffer =
in
> >> this step(while the exportbuffer would create one itself).
> >>
> >> When you delete a buffer, you may not release it from its virtual memo=
ry
> >> space, leaving a corrupted virtual memory space.
> > What do you mean? __vb2_buf_mem_free() doesn't unconditionally free the
> > memory, it just decrements a reference counter.
>
> struct dma_buf_ops->mmap() may not increase a reference to its buffer.

Both V4L2 mmap() and DMA-buf mmap() of buffers exported from V4L2
would increase a reference to the buffer. They both lead to
vb2_{dc,sg,vmalloc}_mmap() which open the VMA, which in turn calls
vb2_common_vm_open() that increases the buffer refcount.

Best regards,
Tomasz

>
> While struct vb2_mem_ops->get_dmabuf() would.
>
> > The VMA holds its own,
> > so the buffer is only fully released when the application calls
> > munmap().
>
> DELETE_BUF ioctl() didn't answer to this problem. Should the DELETE_BUF
> ioctl() make the no other user could access to this.
>
> >
> > Best regards,
> > Tomasz
> >
> >> Also this behavior is
> >> right, because mmap(2) says:
> >>
> >> "After  the  mmap()  call has returned, the file descriptor, fd, can b=
e
> >> closed immediately without invalidating the map=E2=80=90ping."
> >>
> >>>>>> +       else if (q->memory =3D=3D VB2_MEMORY_DMABUF)
> >>>>>> +               __vb2_buf_dmabuf_put(vb);
> >>>>>> +       else
> >>>>>> +               __vb2_buf_userptr_put(vb);
> >>>>>> +
> >>>>>> +       vb2_queue_remove_buffer(q, vb);
> >>>>>> +       kfree(vb);
> >>>>>> +
> >>>>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>>    /*
> >>>>>>     * vb2_start_streaming() - Attempt to start streaming.
> >>>>>>     * @q:         videobuf2 queue
> >>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>>>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>>>>> index 724135d41f7f..cea666c17b41 100644
> >>>>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >>>>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, stru=
ct
> >>>>>> media_device *mdev,
> >>>>>>    }
> >>>>>>    EXPORT_SYMBOL_GPL(vb2_prepare_buf);
> >>>>>>
> >>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
> >>>>>> +{
> >>>>>> +       return vb2_core_delete_buf(q, b->index);
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
> >>>>>> +
> >>>>>>    int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buf=
fers
> >>>>>> *create)
> >>>>>>    {
> >>>>>>           unsigned requested_planes =3D 1;
> >>>>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
> >>>>>> b/drivers/media/v4l2-core/v4l2-dev.c
> >>>>>> index f81279492682..80ace2e1e932 100644
> >>>>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
> >>>>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> >>>>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
> >>>>>> video_device *vdev)
> >>>>>>                   SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
> >>>>>> vidioc_prepare_buf);
> >>>>>>                   SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
> >>>>>> vidioc_streamon);
> >>>>>>                   SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
> >>>>>> vidioc_streamoff);
> >>>>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
> >>>>>> vidioc_delete_buf);
> >>>>>>           }
> >>>>>>
> >>>>>>           if (is_vid || is_vbi || is_meta) {
> >>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>>>> index a858acea6547..1c737279d3ef 100644
> >>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
> >>>>>> v4l2_ioctl_ops *ops,
> >>>>>>           return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
> >>>>>>    }
> >>>>>>
> >>>>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
> >>>>>> +                         struct file *file, void *fh, void *arg)
> >>>>>> +{
> >>>>>> +       struct v4l2_buffer *b =3D arg;
> >>>>>> +       int ret =3D check_fmt(file, b->type);
> >>>>>> +
> >>>>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
> >>>>>> +}
> >>>>>> +
> >>>>>>    static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
> >>>>>>                                   struct file *file, void *fh, voi=
d
> >>>>>> *arg)
> >>>>>>    {
> >>>>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
> >>>>>> v4l2_ioctls[] =3D {
> >>>>>>           IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
> >>>>>> v4l_print_freq_band, 0),
> >>>>>>           IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
> >>>>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match))=
,
> >>>>>>           IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
> >>>>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
> >>>>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
> >>>>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
> >>>>>> v4l_print_buffer, INFO_FL_QUEUE),
> >>>>>>    };
> >>>>>>    #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
> >>>>>>
> >>>>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl=
.h
> >>>>>> index edb733f21604..2f232ed884c7 100644
> >>>>>> --- a/include/media/v4l2-ioctl.h
> >>>>>> +++ b/include/media/v4l2-ioctl.h
> >>>>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
> >>>>>>     *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
> >>>>>>     * @vidioc_prepare_buf: pointer to the function that implements
> >>>>>>     *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
> >>>>>> + * @vidioc_delete_buf: pointer to the function that implements
> >>>>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
> >>>>>>     * @vidioc_overlay: pointer to the function that implements
> >>>>>>     *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
> >>>>>>     * @vidioc_g_fbuf: pointer to the function that implements
> >>>>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
> >>>>>>                                     struct v4l2_create_buffers *b)=
;
> >>>>>>           int (*vidioc_prepare_buf)(struct file *file, void *fh,
> >>>>>>                                     struct v4l2_buffer *b);
> >>>>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
> >>>>>> +                                struct v4l2_buffer *b);
> >>>>>>
> >>>>>>           int (*vidioc_overlay)(struct file *file, void *fh, unsig=
ned
> >>>>>> int i);
> >>>>>>           int (*vidioc_g_fbuf)(struct file *file, void *fh,
> >>>>>> diff --git a/include/media/videobuf2-core.h
> >>>>>> b/include/media/videobuf2-core.h
> >>>>>> index 080b783d608d..0f9e68f76b77 100644
> >>>>>> --- a/include/media/videobuf2-core.h
> >>>>>> +++ b/include/media/videobuf2-core.h
> >>>>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
> >>>>>> enum vb2_memory memory,
> >>>>>>     */
> >>>>>>    int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int inde=
x,
> >>>>>> void *pb);
> >>>>>>
> >>>>>> +/**
> >>>>>> + * vb2_core_delete_buf() -
> >>>>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
> >>>>>> + * @index:     id number of the buffer.
> >>>>>> + *
> >>>>>> + *  Return: returns zero on success; an error code otherwise.
> >>>>>> + */
> >>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
> >>>>>> +
> >>>>>>    /**
> >>>>>>     * vb2_core_qbuf() - Queue a buffer from userspace
> >>>>>>     *
> >>>>>> diff --git a/include/media/videobuf2-v4l2.h
> >>>>>> b/include/media/videobuf2-v4l2.h
> >>>>>> index 88a7a565170e..3beeb4c735f0 100644
> >>>>>> --- a/include/media/videobuf2-v4l2.h
> >>>>>> +++ b/include/media/videobuf2-v4l2.h
> >>>>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, stru=
ct
> >>>>>> v4l2_create_buffers *create);
> >>>>>>     */
> >>>>>>    int vb2_prepare_buf(struct vb2_queue *q, struct media_device *m=
dev,
> >>>>>>                       struct v4l2_buffer *b);
> >>>>>> +/**
> >>>>>> + * vb2_delete_buf() - Delete the buffer from the queue
> >>>>>> + *
> >>>>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
> >>>>>> + * @b:         buffer structure passed from userspace to
> >>>>>> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driv=
er
> >>>>>> + *
> >>>>>> + * The return values from this function are intended to be direct=
ly
> >>>>>> returned
> >>>>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
> >>>>>> + */
> >>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
> >>>>>>
> >>>>>>    /**
> >>>>>>     * vb2_qbuf() - Queue a buffer from userspace
> >>>>>> diff --git a/include/uapi/linux/videodev2.h
> >>>>>> b/include/uapi/linux/videodev2.h
> >>>>>> index aee75eb9e686..31bba1915642 100644
> >>>>>> --- a/include/uapi/linux/videodev2.h
> >>>>>> +++ b/include/uapi/linux/videodev2.h
> >>>>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
> >>>>>>    #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
> >>>>>> v4l2_dbg_chip_info)
> >>>>>>
> >>>>>>    #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
> >>>>>> v4l2_query_ext_ctrl)
> >>>>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer=
)
> >>>>>> +
> >>>>>>
> >>>>>>    /* Reminder: when adding new ioctls please add support for them=
 to
> >>>>>>       drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
> >>>>>> --
> >>>>>> 2.39.2
> >>>>>>
> >>> --
> >>> Hsia-Jun(Randy) Li
> >>>
> >> --
> >> Hsia-Jun(Randy) Li
> >>
> --
> Hsia-Jun(Randy) Li
>
