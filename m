Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866FE7FD3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjK2KUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjK2KUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3DE1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701253246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eOgmnDcAOuHVjx4FQ/wfnS7taAjkRaDPrb33RzRzvo=;
        b=RoKAa9thTFudFZum+4f7YUA5OukHa+eTRJugicXcCy6glBn8fn3JA63nEzPbCHQ86/0bOg
        R5xoyghtTj6QC5vsQ1s4Rl5WS1VwgmQG0BXmHybUfpp/XJO4TqnS4Je+iGrwyGW6wf2Uvp
        LnHM26UMvzM3v7LUJ06xSMVscBoSTM8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-U3niIxJDP_e_MGmo-gGWOg-1; Wed, 29 Nov 2023 05:20:44 -0500
X-MC-Unique: U3niIxJDP_e_MGmo-gGWOg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c737d1ba09so50700521fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701253243; x=1701858043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eOgmnDcAOuHVjx4FQ/wfnS7taAjkRaDPrb33RzRzvo=;
        b=o4ml8acpM/dzXkbO1Gmc9cxEB+pcVJWsbAvIB2U8w81lpUVIwG4JiFiKW6Mmpi1HKR
         UlPG73R0HJI6OVxiuqjK4ZUppdGjkQjkxLeDZ+FDvVPIy7lfMDOHdWkrb9JZQlsw78Hl
         sDFD/qx4GIPTyU0MPUrF+NiftmCk7gEEUTi8VU0YgskTPnGBVaZRQM6gsSmk/aW7xswI
         y5SvdFfYW6jtZaYDEFrbLeeWl55VqSRpeFOQS7cgW/zb4T8SKXXnqWwv/IpxkmHpoYvQ
         AxG4eJBLVnUD7YeQn9othgb7kYT5NLgr9n1fRXLPKh8v1FqwUe4Ugpxce0jGacMrHWWa
         gqPQ==
X-Gm-Message-State: AOJu0Yyij4YPmFQiVlJwab3FyIQfHw4dlImehswefENP4uBH+E4reKLp
        CkEW+YPwMtknn1oVnzTSSucbTx2hFS6dgNu2C2bpQ1mXXeM8bi1UL8/daRbH73lpjCaY0BzDyMl
        7a0Jb67VtjZM7P3EHoq3zegCFlQvQmnayZIdKZCXa
X-Received: by 2002:a05:6512:220a:b0:507:cb04:59d4 with SMTP id h10-20020a056512220a00b00507cb0459d4mr12336123lfu.8.1701253243246;
        Wed, 29 Nov 2023 02:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo6suNvwReIN0wIUEmAKInanQPmGpK3eFZ68I+bpu7dfH9YCETv8WG6Wc9xZCDDfErzyYtBX/TPf0eCASyd2Y=
X-Received: by 2002:a05:6512:220a:b0:507:cb04:59d4 with SMTP id
 h10-20020a056512220a00b00507cb0459d4mr12336107lfu.8.1701253242868; Wed, 29
 Nov 2023 02:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com> <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
 <6f84bbad-62f9-43df-8134-a6836cc3b66c@linux.intel.com>
In-Reply-To: <6f84bbad-62f9-43df-8134-a6836cc3b66c@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 29 Nov 2023 18:20:31 +0800
Message-ID: <CACGkMEvtus2BseZec8at6YORO=As1v9r9p=xtZjE1e2i=uhwhA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features
To:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, shannon.nelson@amd.com,
        yuanyaogoog@chromium.org, yuehaibing@huawei.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com
Content-Type: multipart/mixed; boundary="0000000000003705f2060b47e303"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003705f2060b47e303
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:12=E2=80=AFPM Ning, Hongyu
<hongyu.ning@linux.intel.com> wrote:
>
>
> On 2023/11/29 17:16, Jason Wang wrote:
> > On Wed, Nov 29, 2023 at 5:05=E2=80=AFPM Ning, Hongyu
> > <hongyu.ning@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> >>> The following changes since commit 2dde18cd1d8fac735875f2e4987f11817c=
c0bc2c:
> >>>
> >>>     Linux 6.5 (2023-08-27 14:49:51 -0700)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>     https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tag=
s/for_linus
> >>>
> >>> for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9=
ab:
> >>>
> >>>     virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023=
-09-03 18:10:24 -0400)
> >>>
> >>> ----------------------------------------------------------------
> >>> virtio: features
> >>>
> >>> a small pull request this time around, mostly because the
> >>> vduse network got postponed to next relase so we can be sure
> >>> we got the security store right.
> >>>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>
> >>> ----------------------------------------------------------------
> >>> Eugenio P=C3=A9rez (4):
> >>>         vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
> >>>         vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend f=
eature
> >>>         vdpa: add get_backend_features vdpa operation
> >>>         vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> >>>
> >>> Jason Wang (1):
> >>>         virtio_vdpa: build affinity masks conditionally
> >>>
> >>> Xuan Zhuo (12):
> >>>         virtio_ring: check use_dma_api before unmap desc for indirect
> >>>         virtio_ring: put mapping error check in vring_map_one_sg
> >>>         virtio_ring: introduce virtqueue_set_dma_premapped()
> >>>         virtio_ring: support add premapped buf
> >>>         virtio_ring: introduce virtqueue_dma_dev()
> >>>         virtio_ring: skip unmap for premapped
> >>>         virtio_ring: correct the expression of the description of vir=
tqueue_resize()
> >>>         virtio_ring: separate the logic of reset/enable from virtqueu=
e_resize
> >>>         virtio_ring: introduce virtqueue_reset()
> >>>         virtio_ring: introduce dma map api for virtqueue
> >>>         virtio_ring: introduce dma sync api for virtqueue
> >>>         virtio_net: merge dma operations when filling mergeable buffe=
rs
> >>
> >> Hi,
> >> above patch (upstream commit 295525e29a5b) seems causing a virtnet
> >> related Call Trace after WARNING from kernel/dma/debug.c.
> >>
> >> details (log and test setup) tracked in
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D218204
> >>
> >> it's recently noticed in a TDX guest testing since v6.6.0 release cycl=
e
> >> and can still be reproduced in latest v6.7.0-rc3.
> >>
> >> as local bisects results show, above WARNING and Call Trace is linked
> >> with this patch, do you mind to take a look?
> >
> > Looks like virtqueue_dma_sync_single_range_for_cpu() use
> > DMA_BIDIRECTIONAL unconditionally.
> >
> > We should use dir here.
> >
> > Mind to try?
> >
> > Thanks
> >
>
> sure, but what I see in the code
> virtqueue_dma_sync_single_range_for_cpu() is using DMA_FROM_DEVICE,
> probably I misunderstood your point?
>
> Please let me know any patch/setting to try here.

Something like attached.  (Not even compiling test).

Thanks

>
>
> >>
> >>>
> >>> Yuan Yao (1):
> >>>         virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
> >>>
> >>> Yue Haibing (1):
> >>>         vdpa/mlx5: Remove unused function declarations
> >>>
> >>>    drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
> >>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
> >>>    drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
> >>>    drivers/vhost/vdpa.c               |  15 +-
> >>>    drivers/virtio/virtio_ring.c       | 412 +++++++++++++++++++++++++=
+++++++-----
> >>>    drivers/virtio/virtio_vdpa.c       |  17 +-
> >>>    include/linux/vdpa.h               |   4 +
> >>>    include/linux/virtio.h             |  22 ++
> >>>    include/uapi/linux/vhost_types.h   |   4 +
> >>>    9 files changed, 625 insertions(+), 90 deletions(-)
> >>>
> >>
> >
>

--0000000000003705f2060b47e303
Content-Type: application/octet-stream; 
	name="0001-virtio_ring-fix-DMA-dir-during-sync.patch"
Content-Disposition: attachment; 
	filename="0001-virtio_ring-fix-DMA-dir-during-sync.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpjm8ipj0>
X-Attachment-Id: f_lpjm8ipj0

RnJvbSBmZjVhNTQwMmExMjA5Y2FjNzNhNGIwZTdjMTkzNzM3ODhiNDE3N2Y5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBXZWQsIDI5IE5vdiAyMDIzIDE3OjE0OjE1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gdmlydGlv
X3Jpbmc6IGZpeCBETUEgZGlyIGR1cmluZyBzeW5jCkNvbnRlbnQtdHlwZTogdGV4dC9wbGFpbgoK
U2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KLS0tCiBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKaW5kZXggODFlY2IyOWM4OGYx
Li45MWQ4Njk4MTQzNzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwpAQCAtMzIyMCw3ICszMjIwLDcgQEAg
dm9pZCB2aXJ0cXVldWVfZG1hX3N5bmNfc2luZ2xlX3JhbmdlX2Zvcl9jcHUoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxLAogCQlyZXR1cm47CiAKIAlkbWFfc3luY19zaW5nbGVfcmFuZ2VfZm9yX2NwdShk
ZXYsIGFkZHIsIG9mZnNldCwgc2l6ZSwKLQkJCQkgICAgICBETUFfQklESVJFQ1RJT05BTCk7CisJ
CQkJICAgICAgZGlyKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9kbWFfc3luY19z
aW5nbGVfcmFuZ2VfZm9yX2NwdSk7CiAKLS0gCjIuNDIuMAoK
--0000000000003705f2060b47e303--

