Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC77F8C32
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjKYP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjKYP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A662EA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700927776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITUkrmkbZWcZNgsW2eehSenWGBo+lAyWapOpmCpE3O0=;
        b=WLNgD9e1kJ7Me6SS2trRl0ueWtx1V93a9qMZjhASYEcucqJTX9qt8wEXocq44MeAVYZP4B
        Xsjj6XG0D3v7muU386a28e6aRC9rBxvyNeSsMzzPqID43ANukGpG9p+0hVoTsRHoNUuUVO
        nQMCMTwZPhc8Qk2Dl0lTIYL+8EgWW1A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-ww3KlR8YMH6fPWGnN4hzTw-1; Sat, 25 Nov 2023 10:56:14 -0500
X-MC-Unique: ww3KlR8YMH6fPWGnN4hzTw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a03337f7851so203999866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700927773; x=1701532573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITUkrmkbZWcZNgsW2eehSenWGBo+lAyWapOpmCpE3O0=;
        b=I840b1i39Q1Bru9RIQjIT0zYYtO8kdW4Vhs7x7SSI+y/8PHqtic075Dz3ffHG3Zg0p
         DBVtGwcRW1KWSH1UidOAoEK37+i/C0UJE244EzKqNV9AiO66hpj+yXE3UWmt4pEb+Aah
         7/tNr8V7b+KYEBC4yGfQujIECdUJLtCkE9aJclKDVuEBBrhAeAJySkzcsvq6eKrXV6hG
         0hPuZ07KeAWmSeGA8ow7P0noky+eba1f1H5ic/AAtDj6+7DaQ8XlL6sE4nB3d92QfDRE
         xelUJ2pD5q19ruBOUt7Pf1bC+Oxdx5DCyhlShgd1Gi1nunRMc076PycaallZyocLusNe
         0LBw==
X-Gm-Message-State: AOJu0Yx0/lTp387Hq18XMq/TEYNh/jDXtBlb6XyexpyoNgw0H7z0xMKy
        55xD6kJHuNQB5IQRbWkajiNriLsOfS5Cj/aoLsUZ/ZF5ibfAetK9vIAXkFvr7jgUe5BXRITEeo9
        em9kwJPlat2cNoVmaHyMStCGnUdJIySFDHy0WBF3z
X-Received: by 2002:a17:907:9728:b0:9be:7b67:1673 with SMTP id jg40-20020a170907972800b009be7b671673mr5812017ejc.1.1700927773553;
        Sat, 25 Nov 2023 07:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+w0C0QWUOFt7UII/N9FYxYRxiO1aOaT1XrsHqWuv4ah0omYiWJqDmS1f+sPVYoRPxtOwfQosm/woMDVmBHFU=
X-Received: by 2002:a17:907:9728:b0:9be:7b67:1673 with SMTP id
 jg40-20020a170907972800b009be7b671673mr5812009ejc.1.1700927773307; Sat, 25
 Nov 2023 07:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <CACGkMEsMrsdJiTHhfbMuj3naacMVXPeTtWnEWtRUcwcPQP3yMA@mail.gmail.com>
In-Reply-To: <CACGkMEsMrsdJiTHhfbMuj3naacMVXPeTtWnEWtRUcwcPQP3yMA@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 25 Nov 2023 23:55:36 +0800
Message-ID: <CACLfguUZR9gw6gZVKOBE1b+ZAOuSWLO8yTULqQfCzJZc8yZHAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] vduse: Add support for reconnection
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 2:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 21, 2023 at 3:30=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Here is the reconnect support in vduse,
> >
> > kernel will allocted pages for reconnection
> > userspace need use ioctl VDUSE_GET_RECONNECT_INFO to
> > get the mmap related information and then mapping these pages
> > to userspace.
> > kernel and userspace will use these pages to sync
> > the reconnect information
> > kernel will use VDUSE_VQ_GET_INFO to sync the information
> > userspace App  will call during the "user_app_dev_start()".
>
> It would be better to describe the uAPI instead of duplicating the
> logic of the codes.
>
sure will rewrite this part
> >
> > change in V2
> > 1. Address the comments from v1
>
> It's better to be more verbose here, people can easily forget the
> comments since V1.
>
will fix this problem

> Thanks
>
> > 2. Add the document for reconnect process
> >
> > Cindy Lu (5):
> >   vduse: Add function to get/free the pages for reconnection
> >   vduse: Add file operation for mmap
> >   vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
> >   vduse: update the vq_info in ioctl
> >   Documentation: Add reconnect process for VDUSE
> >
> >  Documentation/userspace-api/vduse.rst |  29 ++++
> >  drivers/vdpa/vdpa_user/vduse_dev.c    | 198 +++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h            |  50 +++++++
> >  3 files changed, 276 insertions(+), 1 deletion(-)
> >
> > --
> > 2.34.3
> >
>

