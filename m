Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54C37F3DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjKVGLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CD19E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700633498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBi45Jo+f5FW2MEv7EbEoU6NDdVpVbHkcnkMKfTV49E=;
        b=iG4Nu3sh29WFX3UoJyNcTPn+ldalACHzuv/v7B5ITYROf3S6VuL41lt5ZIlhxbXYGo63AH
        eqFC+jlVs6z1ws1n1vetv/nfA/CEhuhfRYVvG4RtyUhLYFwIoEW/yYWz1w8yB/3GKDDL8D
        ANojm6bWgQYGjy3WFdkRxh/Ov2uXzNE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-E67q55P4MWCuN-xmDx4Avg-1; Wed, 22 Nov 2023 01:11:37 -0500
X-MC-Unique: E67q55P4MWCuN-xmDx4Avg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso5874721e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700633496; x=1701238296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBi45Jo+f5FW2MEv7EbEoU6NDdVpVbHkcnkMKfTV49E=;
        b=u9v+TwirrVtvkqvdgtY6R3o/kzmRAkSZ+OTaQUSHfVIin4B4swGIrRxjbvJ9Wb2Trc
         LAqDAVpSwSg7SQLrHTvQOABQGAK9hw/lsG1zmAG7nGTS5DyB6zqh4AxM7vfOo/Uuq7q6
         107uI4ERiGH4O3Cuxx6M/ylI7fck/isg0cotATsbycORvbaW+CNuX1viMQXhXfyO+PdC
         +/jyXs3xc054BJilX6y6puF6jMRC0SA87AnYUCrFTlQx2ECNbqX5oXRLD25QI+FuuKh4
         +gRsBb34AxbnK+BngDg2HLut6tGVd+hLGArOvuvHmYvw966MAT/SwNkth68Hi9Q9EM/S
         /cSg==
X-Gm-Message-State: AOJu0Yy78QvmCPMnr5hDbMgU/1QeNsC8pxUs5FmBe8vO1RQgYPiDeFnN
        cgDg8mBIXrnPlHBX1iAbAZvV7hfWI0lwtJFJqXAo2OOVqww2KFW1ddq8rd6vudIUrMmF2tzYEHZ
        o0tfrTT63BKUk4JTZDxPROSnlbp2Taa+BqrzxQQEd
X-Received: by 2002:ac2:4ac9:0:b0:500:9a45:62f with SMTP id m9-20020ac24ac9000000b005009a45062fmr1025781lfp.8.1700633496074;
        Tue, 21 Nov 2023 22:11:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/PhTVG/y4mNniHfZfy32Kziiq9ZwT7ETZ80E3qrhT3ZHXSzZNHmQyvSI9DnajcGrni/Ij56gB5Q2rG8bnFfk=
X-Received: by 2002:ac2:4ac9:0:b0:500:9a45:62f with SMTP id
 m9-20020ac24ac9000000b005009a45062fmr1025768lfp.8.1700633495744; Tue, 21 Nov
 2023 22:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Nov 2023 14:11:24 +0800
Message-ID: <CACGkMEsMrsdJiTHhfbMuj3naacMVXPeTtWnEWtRUcwcPQP3yMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] vduse: Add support for reconnection
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:30=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Here is the reconnect support in vduse,
>
> kernel will allocted pages for reconnection
> userspace need use ioctl VDUSE_GET_RECONNECT_INFO to
> get the mmap related information and then mapping these pages
> to userspace.
> kernel and userspace will use these pages to sync
> the reconnect information
> kernel will use VDUSE_VQ_GET_INFO to sync the information
> userspace App  will call during the "user_app_dev_start()".

It would be better to describe the uAPI instead of duplicating the
logic of the codes.

>
> change in V2
> 1. Address the comments from v1

It's better to be more verbose here, people can easily forget the
comments since V1.

Thanks

> 2. Add the document for reconnect process
>
> Cindy Lu (5):
>   vduse: Add function to get/free the pages for reconnection
>   vduse: Add file operation for mmap
>   vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
>   vduse: update the vq_info in ioctl
>   Documentation: Add reconnect process for VDUSE
>
>  Documentation/userspace-api/vduse.rst |  29 ++++
>  drivers/vdpa/vdpa_user/vduse_dev.c    | 198 +++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h            |  50 +++++++
>  3 files changed, 276 insertions(+), 1 deletion(-)
>
> --
> 2.34.3
>

