Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1857C5222
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbjJKLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbjJKLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589098
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697023876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fI991omayOkhOuUU4+1NG7KE8fGKHPSZ+L0gd5VgqpU=;
        b=G634U//d7R0CckbgFu3XF+N0HAXm0XOdfXYLHQKsSlq+Pja1FsRVe5LWKxrJKkrBHHG1TZ
        y+t65fMlrPKRGoFfVxkA9EOmGAHvoR8I1KuNmpVVUzAguKbUELDtAwDOfdIGNga1FagaRQ
        lCST1TNKljSQ16YD8BmtXRGLJhx/dyo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-x_6KOFkjNv249n9St9K65w-1; Wed, 11 Oct 2023 07:30:47 -0400
X-MC-Unique: x_6KOFkjNv249n9St9K65w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a21c283542so113683697b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023847; x=1697628647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fI991omayOkhOuUU4+1NG7KE8fGKHPSZ+L0gd5VgqpU=;
        b=iQc1jnnSI68WXVJNbpshB9wCML2SKfJsL0f0szA+YktOGaNvl6NhCX3sotqEFFxmKj
         OF9XsYnx1ThMrJnoIT0OoJp7+/73MTvQBwvwfifNw+ep1Pp1tK59HA/D1VCKqGLGhTHx
         fSGjdr62ALCLFPo3bOEQyLH1tCwGXzc4ZrOCe9g2AGEvSFbcqKU+/5cRiLdvpHNZIrlX
         xHwEq/d2KX/Pb2DTEastxw8OAyxUuPFG2bkxdqoqlcVxQMjrFsxNDa0p7XE4I/D2qWzB
         rlhPxroApyy7JWhGYdfqERjfFvegARGswA4GChLqsk+LdEYBBWjeLqGCPSJBgQtR7LGg
         X7HA==
X-Gm-Message-State: AOJu0YzEq114G9QgU02IaZcdrzob81phz2ZBgltbOGuOSj7YDGbpKCuh
        yqw3JoTP5wWmZbWdyBOgvrRV/L45VVgpNXPwd6ydHRQiPC//hUWABuAcsLJj6tOEtfK81sbnqsc
        dQF+NZPnrYsrvtliAHu1Oc8xivkRHk6lBA3Ji9l6D
X-Received: by 2002:a25:418a:0:b0:d7b:97e0:14ab with SMTP id o132-20020a25418a000000b00d7b97e014abmr18313507yba.57.1697023847144;
        Wed, 11 Oct 2023 04:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAR5Hynv3ntT6nfqTquisAVK8rrEHaChqr5QTMVYBVnMeAP4dJEvOd2vHnnQYqXT3mt3eN5FDY5Vo3KSWf15I=
X-Received: by 2002:a25:418a:0:b0:d7b:97e0:14ab with SMTP id
 o132-20020a25418a000000b00d7b97e014abmr18313491yba.57.1697023846878; Wed, 11
 Oct 2023 04:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 11 Oct 2023 13:30:10 +0200
Message-ID: <CAJaqyWfnDXUPZz8Gb=Bkw2CB=w11KCsyT6YWp92GumNwz5_gQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] vdpa: decouple reset of iotlb mapping from device reset
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:05=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
> In order to reduce needlessly high setup and teardown cost
> of iotlb mapping during live migration, it's crucial to
> decouple the vhost-vdpa iotlb abstraction from the virtio
> device life cycle, i.e. iotlb mappings should be left
> intact across virtio device reset [1]. For it to work, the
> on-chip IOMMU parent device could implement a separate
> .reset_map() operation callback to restore 1:1 DMA mapping
> without having to resort to the .reset() callback, the
> latter of which is mainly used to reset virtio device state.
> This new .reset_map() callback will be invoked only before
> the vhost-vdpa driver is to be removed and detached from
> the vdpa bus, such that other vdpa bus drivers, e.g.
> virtio-vdpa, can start with 1:1 DMA mapping when they
> are attached. For the context, those on-chip IOMMU parent
> devices, create the 1:1 DMA mapping at vdpa device creation,
> and they would implicitly destroy the 1:1 mapping when
> the first .set_map or .dma_map callback is invoked.
>
> This patchset is based off of the descriptor group v3 series
> from Dragos. [2]
>
> [1] Reducing vdpa migration downtime because of memory pin / maps
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> [2] [PATCH vhost v3 00/16] vdpa: Add support for vq descriptor mappings
> https://lore.kernel.org/lkml/20231009112401.1060447-1-dtatulea@nvidia.com=
/
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
> v1:
> - rewrote commit messages to include more detailed description and backgr=
ound
> - reword to vendor specific IOMMU implementation from on-chip IOMMU
> - include parent device backend feautres to persistent iotlb precondition
> - reimplement mlx5_vdpa patch on top of descriptor group series
>
> RFC v3:
> - fix missing return due to merge error in patch #4
>
> RFC v2:
> - rebased on top of the "[PATCH RFC v2 0/3] vdpa: dedicated descriptor ta=
ble group" series:
>   https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-emai=
l-si-wei.liu@oracle.com/
>
> ---
>
> Si-Wei Liu (4):
>   vdpa: introduce .reset_map operation callback
>   vhost-vdpa: reset vendor specific mapping to initial state in .release
>   vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
>   vdpa/mlx5: implement .reset_map driver op
>
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>  drivers/vdpa/mlx5/core/mr.c        | 17 +++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 +++++++++++++-----
>  drivers/vhost/vdpa.c               | 31 +++++++++++++++++++++++++++++++
>  include/linux/vdpa.h               | 10 ++++++++++
>  include/uapi/linux/vhost_types.h   |  2 ++
>  6 files changed, 74 insertions(+), 5 deletions(-)
>
> --
> 1.8.3.1
>

