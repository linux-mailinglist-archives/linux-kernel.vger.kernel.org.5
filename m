Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F87D04ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbjJSWjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjJSWjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4BFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697755101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBfQj5Ox1TU1TEGTY2Cw21mMpXWHp3OgPrDutmPfcHw=;
        b=IQBC9XmvFrR9RiAdEl49LmNNn3f5jPF1E/8gFxibOfIrefpUMIOXHiY/g0soD2KUeJcQYr
        J0C28HYOIMZOKvnv0dQAJ2F0665BWDbDt1A411JEdfQcs2pY9wLeAS0wM4vOuZro8Zzvxz
        +p8gmBi6NdUKjsrvSAqrefMFz0yrb9E=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-g9o0-85jOpmV0SJI2zB2cQ-1; Thu, 19 Oct 2023 18:38:03 -0400
X-MC-Unique: g9o0-85jOpmV0SJI2zB2cQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7a25e4045c2so22538639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697755082; x=1698359882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBfQj5Ox1TU1TEGTY2Cw21mMpXWHp3OgPrDutmPfcHw=;
        b=mr8BpfLHmqnXPCTu9CMLs2U5teVacFkY7tf0Kv7O3Jb8incXtMoseTEa1mdTU885fg
         pQp6CJFGPu1w26wr5E7NQM483LprsxEOy0Zr27esd5poWEXKD2/hFhHvQNTPHHsQD3IC
         XUsUgbBToq/OMPnKXjWdMLV2b1Rkow5au0Gfv9alPGDMtobuP+ZY3tfFBTaJES7j1qYi
         0fw7nMukQTjH2rlrofw5W5ea8yGldsDLOkH2Nhr9ByhnnqfCNBPlv1PZI3rrHjOxn4e4
         txRxt2YH1g38NIJ5wSyvnY1FkUkvPsubkmA8LDGGgJTb2k21V+MQn/D/oYhYnlgFntM2
         j2LQ==
X-Gm-Message-State: AOJu0Yx+dDz0t1vU22yy2SR23LETxqfu4HGu5gn1KqMXljF81s9gz4V4
        HOyepaG60/kMeNDPoZBDg0+LIRlXMMXhNh1Xa4U7zLHylFLHYBITqy/3LxvSTLEw6X4yOED+fHd
        Sbud+/vA4a+AvIwq1eR1b0rvm
X-Received: by 2002:a05:6602:3f90:b0:7a6:966b:35a6 with SMTP id fb16-20020a0566023f9000b007a6966b35a6mr417428iob.11.1697755082107;
        Thu, 19 Oct 2023 15:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcTl15nc4rngAzvccONm+kXeFRpU639DoHKSalcQ/LRwlxFUsMmy9vCK/OiIYJ7DF1iTqH6w==
X-Received: by 2002:a05:6602:3f90:b0:7a6:966b:35a6 with SMTP id fb16-20020a0566023f9000b007a6966b35a6mr417408iob.11.1697755081756;
        Thu, 19 Oct 2023 15:38:01 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id b12-20020a6b670c000000b0079f7734a77esm163266ioc.35.2023.10.19.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 15:38:01 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:37:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clegoate@redhat.com>
Cc:     liulongfang <liulongfang@huawei.com>, jgg@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
        bcreeley@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v17 1/2] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <20231019163759.1d567fc5.alex.williamson@redhat.com>
In-Reply-To: <4915e45f-2256-42b5-838c-be2e5eda69ac@redhat.com>
References: <20231013090441.36417-1-liulongfang@huawei.com>
        <20231013090441.36417-2-liulongfang@huawei.com>
        <dee481c3-f6bd-4ba9-a2d4-528dfb668159@redhat.com>
        <d4a2f596-13c9-f3d3-3bbd-ee773f026341@huawei.com>
        <4915e45f-2256-42b5-838c-be2e5eda69ac@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 10:30:53 +0200
C=C3=A9dric Le Goater <clegoate@redhat.com> wrote:

> On 10/19/23 10:03, liulongfang wrote:
> > On 2023/10/16 23:17, C=C3=A9dric Le Goater wrote: =20
> >> Hello Longfang,
> >>
> >> On 10/13/23 11:04, Longfang Liu wrote: =20
> >>> There are multiple devices, software and operational steps involved
> >>> in the process of live migration. An error occurred on any node may
> >>> cause the live migration operation to fail.
> >>> This complex process makes it very difficult to locate and analyze
> >>> the cause when the function fails.
> >>>
> >>> In order to quickly locate the cause of the problem when the
> >>> live migration fails, I added a set of debugfs to the vfio
> >>> live migration driver.
> >>>
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 +------------------------------------------=
-+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 +---+----------------------------+---------=
-+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------+--+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------+=
--+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |src vfio_dev|=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |dst vfio_d=
ev|
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--+---------+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--+-------=
--+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0 +-----------+----+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-----------+----+
> >>>  =C2=A0=C2=A0=C2=A0 |src dev debugfs |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |dst dev debugfs |
> >>>  =C2=A0=C2=A0=C2=A0 +----------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----------------+
> >>>
> >>> The entire debugfs directory will be based on the definition of
> >>> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> >>> interfaces in vfio.h will be empty definitions, and the creation
> >>> and initialization of the debugfs directory will not be executed.
> >>>
> >>>  =C2=A0=C2=A0=C2=A0 vfio
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 +---<dev_name1>
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 +---migration
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +--state
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 +---<dev_name2>
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---migration
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +--state
> >>>
> >>> debugfs will create a public root directory "vfio" file.
> >>> then create a dev_name() file for each live migration device.
> >>> First, create a unified state acquisition file of "migration"
> >>> in this device directory.
> >>> Then, create a public live migration state lookup file "state".
> >>>
> >>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >>> ---
> >>>  =C2=A0 drivers/vfio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++
> >>>  =C2=A0 drivers/vfio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> >>>  =C2=A0 drivers/vfio/debugfs.c=C2=A0=C2=A0=C2=A0 | 90 +++++++++++++++=
++++++++++++++++++++++++
> >>>  =C2=A0 drivers/vfio/vfio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 =
++++++
> >>>  =C2=A0 drivers/vfio/vfio_main.c=C2=A0 | 14 +++++-
> >>>  =C2=A0 include/linux/vfio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 =
+++
> >>>  =C2=A0 include/uapi/linux/vfio.h |=C2=A0 1 +
> >>>  =C2=A0 7 files changed, 135 insertions(+), 2 deletions(-)
> >>>  =C2=A0 create mode 100644 drivers/vfio/debugfs.c
> >>>
> >>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> >>> index 6bda6dbb4878..ceae52fd7586 100644
> >>> --- a/drivers/vfio/Kconfig
> >>> +++ b/drivers/vfio/Kconfig
> >>> @@ -80,6 +80,16 @@ config VFIO_VIRQFD
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select EVENTFD
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default n
> >>>  =C2=A0 +config VFIO_DEBUGFS
> >>> +=C2=A0=C2=A0=C2=A0 bool "Export VFIO internals in DebugFS"
> >>> +=C2=A0=C2=A0=C2=A0 depends on DEBUG_FS
> >>> +=C2=A0=C2=A0=C2=A0 help
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Allows exposure of VFIO device intern=
als. This option enables
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the use of debugfs by VFIO drivers as=
 required. The device can
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cause the VFIO code create a top-leve=
l debug/vfio directory
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 during initialization, and then popul=
ate a subdirectory with
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entries as required.
> >>> +
> >>>  =C2=A0 source "drivers/vfio/pci/Kconfig"
> >>>  =C2=A0 source "drivers/vfio/platform/Kconfig"
> >>>  =C2=A0 source "drivers/vfio/mdev/Kconfig"
> >>> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> >>> index c82ea032d352..d43a699d55b1 100644
> >>> --- a/drivers/vfio/Makefile
> >>> +++ b/drivers/vfio/Makefile
> >>> @@ -8,6 +8,7 @@ vfio-$(CONFIG_VFIO_GROUP) +=3D group.o
> >>>  =C2=A0 vfio-$(CONFIG_IOMMUFD) +=3D iommufd.o
> >>>  =C2=A0 vfio-$(CONFIG_VFIO_CONTAINER) +=3D container.o
> >>>  =C2=A0 vfio-$(CONFIG_VFIO_VIRQFD) +=3D virqfd.o
> >>> +vfio-$(CONFIG_VFIO_DEBUGFS) +=3D debugfs.o
> >>>  =C2=A0 =C2=A0 obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o
> >>>  =C2=A0 obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o
> >>> diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
> >>> new file mode 100644
> >>> index 000000000000..ae53d6110f47
> >>> --- /dev/null
> >>> +++ b/drivers/vfio/debugfs.c
> >>> @@ -0,0 +1,90 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright (c) 2023, HiSilicon Ltd.
> >>> + */
> >>> +
> >>> +#include <linux/device.h>
> >>> +#include <linux/debugfs.h>
> >>> +#include <linux/seq_file.h>
> >>> +#include <linux/vfio.h>
> >>> +#include "vfio.h"
> >>> +
> >>> +static struct dentry *vfio_debugfs_root;
> >>> +
> >>> +static int vfio_device_state_read(struct seq_file *seq, void *data)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 struct device *vf_dev =3D seq->private;
> >>> +=C2=A0=C2=A0=C2=A0 struct vfio_device *vdev =3D container_of(vf_dev,=
 struct vfio_device, device);
> >>> +=C2=A0=C2=A0=C2=A0 enum vfio_device_mig_state state;
> >>> +=C2=A0=C2=A0=C2=A0 int ret;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 BUILD_BUG_ON(VFIO_DEVICE_STATE_NR !=3D
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_DEVICE_STATE_PRE_COP=
Y_P2P + 1);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 ret =3D vdev->mig_ops->migration_get_state(vdev, =
&state);
> >>> +=C2=A0=C2=A0=C2=A0 if (ret)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 switch (state) {
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_ERROR:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
ERROR");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_STOP:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
STOP");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_RUNNING:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
RUNNING");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_STOP_COPY:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
STOP_COPY");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_RESUMING:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
RESUMING");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_RUNNING_P2P:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
RUNNING_P2P");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_PRE_COPY:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
PRE_COPY");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
PRE_COPY_P2P");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> +=C2=A0=C2=A0=C2=A0 default:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(seq, "%s\n", "=
Invalid"); =20
> >>
> >> seq_puts() is more appropriate than seq_printf() above.
> >> =20
> >=20
> > There is no difference between seq_puts() and seq_printf() here,
> > no need to modify it. =20
>=20
> seq_puts is simply preferred for unformatted output.

Agreed, thanks for pointing this out.  I think
Documentation/filesystems/seq_file.rst suggests this as well and it's
also a bit silly anyway to use %s for a fixed string.

> >> I would suggest to add an array or some helper, that the VFIO drivers
> >> could use to debug the migration flow with pr_* primitives. It can be
> >> done later.
> >> =20
> >=20
> > If you want to debug this migration process in the VFIO driver,
> > you can refer to vdev->mig_ops->migration_get_state() to read the statu=
s.
> >  =20
> >> =20
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 return 0;
> >>> +}
> >>> +
> >>> +void vfio_device_debugfs_init(struct vfio_device *vdev)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D &vdev->device;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 vdev->debug_root =3D debugfs_create_dir(dev_name(=
vdev->dev), vfio_debugfs_root);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 if (vdev->mig_ops) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *vfio_dev_m=
igration =3D NULL; =20
> >>
> >> mig_dir maybe ?
> >> =20
> >=20
> > "vfio_dev_migration " will not affect the readability of the code.
> >  =20
> >> It would be easier to understand the nature of the variable IMHO.

I don't know that we need to impose a specific style here, but the
variable has a very limited scope, so it doesn't really need a super
descriptive name.

> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_dev_migration =3D de=
bugfs_create_dir("migration", vdev->debug_root);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debugfs_create_devm_seqfi=
le(dev, "state", vfio_dev_migration,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_device_st=
ate_read);
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +}
> >>> +
> >>> +void vfio_device_debugfs_exit(struct vfio_device *vdev)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 debugfs_remove_recursive(vdev->debug_root);
> >>> +}
> >>> +
> >>> +void vfio_debugfs_create_root(void)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 vfio_debugfs_root =3D debugfs_create_dir("vfio", =
NULL);
> >>> +}
> >>> +
> >>> +void vfio_debugfs_remove_root(void)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 debugfs_remove_recursive(vfio_debugfs_root);
> >>> +=C2=A0=C2=A0=C2=A0 vfio_debugfs_root =3D NULL;
> >>> +}
> >>> +
> >>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> >>> index 307e3f29b527..bde84ad344e5 100644
> >>> --- a/drivers/vfio/vfio.h
> >>> +++ b/drivers/vfio/vfio.h
> >>> @@ -448,4 +448,18 @@ static inline void vfio_device_put_kvm(struct vf=
io_device *device)
> >>>  =C2=A0 }
> >>>  =C2=A0 #endif
> >>>  =C2=A0 +#ifdef CONFIG_VFIO_DEBUGFS
> >>> +void vfio_debugfs_create_root(void);
> >>> +void vfio_debugfs_remove_root(void);
> >>> +
> >>> +void vfio_device_debugfs_init(struct vfio_device *vdev);
> >>> +void vfio_device_debugfs_exit(struct vfio_device *vdev);
> >>> +#else
> >>> +static inline void vfio_debugfs_create_root(void) { }
> >>> +static inline void vfio_debugfs_remove_root(void) { }
> >>> +
> >>> +static inline void vfio_device_debugfs_init(struct vfio_device *vdev=
) { }
> >>> +static inline void vfio_device_debugfs_exit(struct vfio_device *vdev=
) { }
> >>> +#endif /* CONFIG_VFIO_DEBUGFS */
> >>> +
> >>>  =C2=A0 #endif
> >>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> >>> index e31e1952d7b8..9aec4c22f051 100644
> >>> --- a/drivers/vfio/vfio_main.c
> >>> +++ b/drivers/vfio/vfio_main.c
> >>> @@ -309,7 +309,6 @@ static int __vfio_register_dev(struct vfio_device=
 *device,
> >>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Refcounting can't start unt=
il the driver calls register */
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_set(&device->refcount, 1);
> >>> - =20
> >>
> >> superfluous change.
> >> =20
> >=20
> > A blank line here is to separate it from the comment above.
> > Makes it easier to be read.

This sounds more like a justification for keeping the blank line than
for removing it.  The original intent was to provide some logical
separation.  Regardless, introducing unrelated formatting changes while
implementing something else is generally considered poor form.
=20
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_device_group_register(device);
> >>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> @@ -320,7 +319,15 @@ static int __vfio_register_dev(struct vfio_devic=
e *device,
> >>>  =C2=A0 =C2=A0 int vfio_register_group_dev(struct vfio_device *device)
> >>>  =C2=A0 {
> >>> -=C2=A0=C2=A0=C2=A0 return __vfio_register_dev(device, VFIO_IOMMU);
> >>> +=C2=A0=C2=A0=C2=A0 int ret;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 ret =3D __vfio_register_dev(device, VFIO_IOMMU);
> >>> +=C2=A0=C2=A0=C2=A0 if (ret)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 vfio_device_debugfs_init(device); =20
> >>
> >> Can it be called from __vfio_register_dev() instead ? and mdev devices
> >> would get debugfs support also.
> >> =20
> >=20
> > This is for symmetry in function calls.
> > The need for symmetry was mentioned in the previous review. =20
>=20
> yes. But this is also exluding the mdev devices which is a large VFIO fam=
ily.

+1 It needs to support mdev as well.  In fact the previous comments
related to symmetry suggested it be placed at the end of
__vfio_register_dev(), moving it to only cover the VFIO_IOMMU path is a
bug.  Thanks,

Alex


> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 return 0;
> >>>  =C2=A0 }
> >>>  =C2=A0 EXPORT_SYMBOL_GPL(vfio_register_group_dev);
> >>>  =C2=A0 @@ -378,6 +385,7 @@ void vfio_unregister_group_dev(struct vfi=
o_device *device)
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 vfio_device_debugfs_exit(device);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Balances vfio_device_set_group in =
register path */
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_device_remove_group(device);
> >>>  =C2=A0 }
> >>> @@ -1676,6 +1684,7 @@ static int __init vfio_init(void)
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_allo=
c_dev_chrdev;
> >>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 vfio_debugfs_create_root();
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info(DRIVER_DESC " version: " DRIV=
ER_VERSION "\n");
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>>  =C2=A0 @@ -1691,6 +1700,7 @@ static int __init vfio_init(void)
> >>>  =C2=A0 =C2=A0 static void __exit vfio_cleanup(void)
> >>>  =C2=A0 {
> >>> +=C2=A0=C2=A0=C2=A0 vfio_debugfs_remove_root();
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ida_destroy(&vfio.device_ida);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_cdev_cleanup();
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 class_destroy(vfio.device_class);
> >>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> >>> index 454e9295970c..769d7af86225 100644
> >>> --- a/include/linux/vfio.h
> >>> +++ b/include/linux/vfio.h
> >>> @@ -69,6 +69,13 @@ struct vfio_device {
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 iommufd_attached:1;
> >>>  =C2=A0 #endif
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 cdev_opened:1;
> >>> +#ifdef CONFIG_DEBUG_FS
> >>> +=C2=A0=C2=A0=C2=A0 /*
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 * debug_root is a static property of the vf=
io_device
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 * which must be set prior to registering th=
e vfio_device.
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>> +=C2=A0=C2=A0=C2=A0 struct dentry *debug_root;
> >>> +#endif
> >>>  =C2=A0 };
> >>>  =C2=A0 =C2=A0 /**
> >>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>> index 7f5fb010226d..2b68e6cdf190 100644
> >>> --- a/include/uapi/linux/vfio.h
> >>> +++ b/include/uapi/linux/vfio.h
> >>> @@ -1219,6 +1219,7 @@ enum vfio_device_mig_state {
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_DEVICE_STATE_RUNNING_P2P =3D 5,
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_DEVICE_STATE_PRE_COPY =3D 6,
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_DEVICE_STATE_PRE_COPY_P2P =3D 7,
> >>> +=C2=A0=C2=A0=C2=A0 VFIO_DEVICE_STATE_NR,
> >>>  =C2=A0 };
> >>>  =C2=A0 =C2=A0 /** =20
> >>
> >> .
> >> =20
> >  =20
>=20

