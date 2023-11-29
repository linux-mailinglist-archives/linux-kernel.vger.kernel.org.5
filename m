Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE97FD23A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjK2JR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjK2JRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:17:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E31FE4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701249423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckwgjfvsxGj0GYdJiZLYltwjMuQpB0mwrwPr8QizCM8=;
        b=N04WPkSzGKRLbebJTu76uaVIx7ebXrq0S1Fjk6rKDSDc81p2bUNFVq8dndf0ct6gAvcCUL
        hbQHEQ77FCwlmv6tww5/NnuKVBGdPCnxgaVgF9avYaEpiLWJ9f6MqORdmzElVwcjjW5yex
        sK3wo8+s39YODl4HorU6uQ8gsHPZpVk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-prII0zWpNl-F0ptRTB_ykw-1; Wed, 29 Nov 2023 04:17:02 -0500
X-MC-Unique: prII0zWpNl-F0ptRTB_ykw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bc71772e2so253939e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249420; x=1701854220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckwgjfvsxGj0GYdJiZLYltwjMuQpB0mwrwPr8QizCM8=;
        b=VpdTBBvygJQxUulk6gYSl2CEGglOcAnWBrlFYmMqrdlHQztrJfZyuwQJME2TH8ncTd
         UaK3dRPraHoAaJ6Z9NktM3keWMd71xBC9wSKc5h93oEIyd/AnW/jwVyuuwBqovu4WDKK
         P2V3PoIgQoICF9F/Banlme0KWw7AIknKoXP9vZWw/lFnmrO8hZywjkI6W+tXuRzOpxku
         +EXirFTiRG5+fuvXeInhP7wnJUnmJwtJjfrUcfwBAjjESrkniMBUW9w4SGtS3Wwzvsmc
         dHYeV76WVv6Vxl9Emu2j4uV4E9tAu1FyIX/PCD3vdLDU5sdDsAUEW2qRJBI51csPjVps
         9rqg==
X-Gm-Message-State: AOJu0YyvDLGr8aKRU384Nq2ELeTJ2dpSMSVHf1ExM8zxa518s3x5IPVE
        XN7CiM8rf2l+bq1kiUqbnjy/F2DQOAiqOxp3v/cLYUwDDyiDlmmdRNlbLO9gTSQae1L6L+v3hSt
        rui34GYhTlv642uQDTnKBKQgpOPoLxKSu2rR+23+1
X-Received: by 2002:a19:671d:0:b0:50b:c08d:69ba with SMTP id b29-20020a19671d000000b0050bc08d69bamr2031912lfc.57.1701249420661;
        Wed, 29 Nov 2023 01:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTpWxMFUv78+9eoh3yywfOCrwElPPyEFR923tcDuFlr5hCVrrpOFJIlTizYOyqCHn5EelCUZdWuJlBEl/NG/Y=
X-Received: by 2002:a19:671d:0:b0:50b:c08d:69ba with SMTP id
 b29-20020a19671d000000b0050bc08d69bamr2031882lfc.57.1701249420311; Wed, 29
 Nov 2023 01:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20230903181338-mutt-send-email-mst@kernel.org> <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
In-Reply-To: <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 29 Nov 2023 17:16:49 +0800
Message-ID: <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 29, 2023 at 5:05=E2=80=AFPM Ning, Hongyu
<hongyu.ning@linux.intel.com> wrote:
>
>
>
> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> > The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0=
bc2c:
> >
> >    Linux 6.5 (2023-08-27 14:49:51 -0700)
> >
> > are available in the Git repository at:
> >
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/f=
or_linus
> >
> > for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab=
:
> >
> >    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09=
-03 18:10:24 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: features
> >
> > a small pull request this time around, mostly because the
> > vduse network got postponed to next relase so we can be sure
> > we got the security store right.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Eugenio P=C3=A9rez (4):
> >        vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
> >        vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feat=
ure
> >        vdpa: add get_backend_features vdpa operation
> >        vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> >
> > Jason Wang (1):
> >        virtio_vdpa: build affinity masks conditionally
> >
> > Xuan Zhuo (12):
> >        virtio_ring: check use_dma_api before unmap desc for indirect
> >        virtio_ring: put mapping error check in vring_map_one_sg
> >        virtio_ring: introduce virtqueue_set_dma_premapped()
> >        virtio_ring: support add premapped buf
> >        virtio_ring: introduce virtqueue_dma_dev()
> >        virtio_ring: skip unmap for premapped
> >        virtio_ring: correct the expression of the description of virtqu=
eue_resize()
> >        virtio_ring: separate the logic of reset/enable from virtqueue_r=
esize
> >        virtio_ring: introduce virtqueue_reset()
> >        virtio_ring: introduce dma map api for virtqueue
> >        virtio_ring: introduce dma sync api for virtqueue
> >        virtio_net: merge dma operations when filling mergeable buffers
>
> Hi,
> above patch (upstream commit 295525e29a5b) seems causing a virtnet
> related Call Trace after WARNING from kernel/dma/debug.c.
>
> details (log and test setup) tracked in
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218204
>
> it's recently noticed in a TDX guest testing since v6.6.0 release cycle
> and can still be reproduced in latest v6.7.0-rc3.
>
> as local bisects results show, above WARNING and Call Trace is linked
> with this patch, do you mind to take a look?

Looks like virtqueue_dma_sync_single_range_for_cpu() use
DMA_BIDIRECTIONAL unconditionally.

We should use dir here.

Mind to try?

Thanks

>
> >
> > Yuan Yao (1):
> >        virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
> >
> > Yue Haibing (1):
> >        vdpa/mlx5: Remove unused function declarations
> >
> >   drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
> >   drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
> >   drivers/vhost/vdpa.c               |  15 +-
> >   drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++=
++++-----
> >   drivers/virtio/virtio_vdpa.c       |  17 +-
> >   include/linux/vdpa.h               |   4 +
> >   include/linux/virtio.h             |  22 ++
> >   include/uapi/linux/vhost_types.h   |   4 +
> >   9 files changed, 625 insertions(+), 90 deletions(-)
> >
>

