Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5257E1958
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFENF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjKFEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:13:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F8BF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 20:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699243910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHrLb4zEBqMuGuzN6XAqFfCIg5Eok44Njld/JJN4sJk=;
        b=SMtkO0YURk7J7s+Z0AtondWtRVTosyWmns7DbnAMRSXfpJV1U+yE8D7Ww/HgefzsMGT2QM
        vPxCwGYJJ0yaxjYG9aQln3+DExq8M5dGM4dk8WDFJcfJI96kWpo5uRn/3GgIadhoOpHUB+
        0qYOEUGleVlQwgyba2j3X35LQoOZC70=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-5VoToPSCP9uNunmKqWD1jg-1; Sun, 05 Nov 2023 23:11:48 -0500
X-MC-Unique: 5VoToPSCP9uNunmKqWD1jg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5094998f7e8so4374241e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 20:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699243907; x=1699848707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHrLb4zEBqMuGuzN6XAqFfCIg5Eok44Njld/JJN4sJk=;
        b=BThWnERu2Kz2UW8nf6Do7lVrtqtPpiLTbZXkCJcEVk7pkSIwiLy0756JmhaOrD/xiH
         R/TtQI99dFw1Pqcre93J8+ihW4at/wLIcdn1a5dK1u/xTMdBFX2TfhJ7jplanYq45UHd
         ToGt4IDTAgdycv0E3iaGIppcf/0ueqz8DagOuT09GwzJ4zPM1aSa9FSNd7QcCoeWkCpS
         1/29eDXP1bRidzxRgRzciztLwGgA4lFQfHG1ed8V51e1W9P7ThwiCA4XZoFmeX1FLJxf
         2E/PnIEU9nki/5JkIv9OhVehaCE90unpU8mFlmkwFwZeRPmwuiAwCYZWI6BpucxOTRhB
         CyVg==
X-Gm-Message-State: AOJu0Yx0kYGFQsXHoxMsuQLn/YYCH4RjdiiQRY24nE5GYhbANhTnl0Ne
        bQz1PCaH5BVBMXCELxuodrKb+fWp/PeEYI9ctsrbyesg5hs4bcCw0y/Kr+PvBrS615OWzDzw9T7
        oytwJT/uQanEJbDWiQ/zdy9OAa8ls16GsCfWLqvq8
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id y10-20020a19914a000000b0050797012700mr21479172lfj.20.1699243907017;
        Sun, 05 Nov 2023 20:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUWUi5tZ6aymenvsU8IcDkUX50MvzvLjsi++9vXhsqQouRpjAkVN6Zt+HPX/ts88NcBPPpX+/TSiAt8ldNrfw=
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id
 y10-20020a19914a000000b0050797012700mr21479160lfj.20.1699243906677; Sun, 05
 Nov 2023 20:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Nov 2023 12:11:35 +0800
Message-ID: <CACGkMEvaKw9g0EmNdFh3=iZm3rD-mo_BtaBA3F5bwqNq4NV3Dw@mail.gmail.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 1:16=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
>
> Hi All
> This code provides the iommufd support for vdpa device
> This code fixes the bugs from the last version and also add the asid supp=
ort. rebase on kernel
> v6,6-rc3
> Test passed in the physical device (vp_vdpa), but  there are still some p=
roblems in the emulated device (vdpa_sim_net),
> I will continue working on it
>
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

It would be better to have a change summary here.

Thanks

>
>
> Cindy Lu (8):
>   vhost/iommufd: Add the functions support iommufd
>   Kconfig: Add the new file vhost/iommufd
>   vhost: Add 3 new uapi to support iommufd
>   vdpa: Add new vdpa_config_ops to support iommufd
>   vdpa_sim :Add support for iommufd
>   vdpa: change the map/unmap process to support iommufd
>   vp_vdpa::Add support for iommufd
>   iommu: expose the function iommu_device_use_default_domain
>
>  drivers/iommu/iommu.c             |   2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
>  drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
>  drivers/vhost/Kconfig             |   1 +
>  drivers/vhost/Makefile            |   1 +
>  drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
>  drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
>  drivers/vhost/vhost.h             |  21 +++
>  include/linux/vdpa.h              |  38 +++++-
>  include/uapi/linux/vhost.h        |  66 ++++++++++
>  10 files changed, 525 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/vhost/iommufd.c
>
> --
> 2.34.3
>

