Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9F7AE3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjIZCsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjIZCsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9293A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695696428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbkEy7nXr1l5VA1EBNnZyo/vTZ0cPvoDisYtJVR0B78=;
        b=LoKi+dsMjd/hRh/rWGKH++5GB1vbdVqxAo8s/Eyj1PvCwtxsAkAa94aPLrjqUAtR6fG6E2
        N6QS7Q2K93s3FgQgSAvrZDtwiLavLnZtt1KY6Cx9B35zstZYnRcXtJtVAJukW8qTyc0JDO
        wCSEBUy6ABQOvlNUe0MCrfrr+FhxTj0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-4oczJn2lNwCvcii4lHh1Tw-1; Mon, 25 Sep 2023 22:47:07 -0400
X-MC-Unique: 4oczJn2lNwCvcii4lHh1Tw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-503269edbb3so10663976e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696425; x=1696301225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbkEy7nXr1l5VA1EBNnZyo/vTZ0cPvoDisYtJVR0B78=;
        b=ivb2RKtVcARh9AKGccBba8itX7Sc4plGmROGxdvcGzCw4dt8Xtz38qYg88ffkGZsaz
         lFby7c9D7yeytU26ptxdWzlLrxmKdABRz8NoBV/iW8yzQ8kri1vp9i6mn5uuEs3dTsRo
         WDLT5yQORWqItj1RzOFt8tQo+xSNexbfZ928vvNv+/UN5EVZkrqgheNe5oghJGHMnBNW
         meI012035FESzYt3465N3FoCV/YGo+RJwx2ISwY6qSQdRCYg1T/NmFdfysFWQffzlo7x
         Nai4rSkY6K9o1biueZ4lhG0NrV0KNLpee59kN2iIv9zbeCDS7MhtZYRp11qJfBYdWWai
         4IMA==
X-Gm-Message-State: AOJu0Yw4PRYe0yeMZKgKavdIuvwLlrwz+d2tUHmyrdBGjejLuXh7R4CU
        g5uNb/EF27naykODKeopK8sLT9pXOUGFjCV1UFoHKE77wCG/kcUYRkK/khdqhgZhY5c3mIkKQS9
        Ewt4C9hesSXPG7R/GPokK6/D7V3zDQJ863YtD8Zaz
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id k42-20020a0565123daa00b005031adfb4d5mr8558584lfv.52.1695696425631;
        Mon, 25 Sep 2023 19:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCEVaBqO/+URj99AR2MxQjceBS7mj2Mlw1O/b53LZJbHeEMTYn3ctrlVFyFihUW9jZ0zcY9enbbfrCL1KLUJg=
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8558574lfv.52.1695696425334; Mon, 25
 Sep 2023 19:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 10:46:54 +0800
Message-ID: <CACGkMEvx5V8+-LZa8-G4VCXYiJVm0DL8pu_Ao0rvPtK48-FTDQ@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 1:05=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Hi All
> Really apologize for the delay, this is the draft RFC for
> iommufd support for vdpa, This code provides the basic function
> for iommufd support
>
> The code was tested and passed in device vdpa_sim_net
> The qemu code is
> https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
>
> ToDo
> 1. this code is out of date and needs to clean and rebase on the latest c=
ode
> 2. this code has some workaround, I Skip the check for
> iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> mutex for iommfd operations
> 3. only test in emulated device, other modes not tested yet
>
> After addressed these problems I will send out a new version for RFC. I w=
ill
> provide the code in 3 weeks

Something more needs to be done after a quick glance at the codes.

1) The support for device with platform IOMMU support
2) The support for multiple ASes per device

...

Thanks

>
> Thanks
> Cindy
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> The test step is
> 1. create vdpa_sim device
> ...
> vdpa dev add name vdpa15 mgmtdev vdpasim_net
> ...
> 2. load the VM with the command
>   -object iommufd,id=3Diommufd0 \
>   -device virtio-net-pci,netdev=3Dvhost-vdpa1,disable-legacy=3Don,disable=
-modern=3Doff\
>   -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa1=
,iommufd=3Diommufd0\
>
> 3. in guest VM you can find the vdpa_sim port works well.
> [root@ubuntunew ~]# ifconfig eth0
> eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet6 fe80::5054:ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
>         ether 52:54:00:12:34:56  txqueuelen 1000  (Ethernet)
>         RX packets 53  bytes 9108 (8.8 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 53  bytes 9108 (8.8 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> [root@ubuntunew ~]# ./test.sh eth0
> [  172.815279] pktgen: Packet Generator for packet performance testing. V=
ersion: 2.75
> Adding queue 0 of eth0
> Configuring devices eth0@0
> Running... ctrl^C to stop
>
> [root@ubuntunew ~]# ifconfig eth0
> eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet6 fe80::5054:ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
>         ether 52:54:00:12:34:56  txqueuelen 1000  (Ethernet)
>         RX packets 183455  bytes 11748533 (11.2 MiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 183473  bytes 11749685 (11.2 MiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> Cindy Lu (7):
>   vhost/iommufd: Add the functions support iommufd
>   Kconfig: Add the new file vhost/iommufd
>   vhost: Add 3 new uapi to support iommufd
>   vdpa: change the map/unmap process to support iommufd
>   vdpa: Add new vdpa_config_ops
>   vdpa_sim :Add support for iommufd
>   iommufd: Skip the CACHE_COHERENCY and iommu group check
>
>  drivers/iommu/iommufd/device.c   |   6 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c |   8 ++
>  drivers/vhost/Kconfig            |   1 +
>  drivers/vhost/Makefile           |   1 +
>  drivers/vhost/iommufd.c          | 151 +++++++++++++++++++++++
>  drivers/vhost/vdpa.c             | 201 +++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h            |  21 ++++
>  include/linux/vdpa.h             |  34 +++++-
>  include/uapi/linux/vhost.h       |  71 +++++++++++
>  9 files changed, 490 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/vhost/iommufd.c
>
> --
> 2.34.3
>

