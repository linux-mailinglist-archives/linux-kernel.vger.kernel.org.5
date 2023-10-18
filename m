Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD817CD362
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJRFK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRFKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98528EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697605805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eK2nNxkMGuEaOCz10CMQSeid3C7CG/ufyyCHGPakhRA=;
        b=G35TSFf/aXcOyZEeR2/mnX5ulR7PTf6GcC3vFLjx0o+NCpJTzuw7pkAEw16tizfli5bMAn
        i0HK1VLRI0/YEKQikNuIr+y4WIw53bx70r20dJrbBSDPhSa9I8Lh9rEoLRe8QJ1JcL51Tv
        R7MHBXHH+Dmdyb8ulruvyNEQCYS6MTU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-0pKs6puoPf2nXHionezqKA-1; Wed, 18 Oct 2023 01:10:03 -0400
X-MC-Unique: 0pKs6puoPf2nXHionezqKA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50318e9067eso6110523e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697605802; x=1698210602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK2nNxkMGuEaOCz10CMQSeid3C7CG/ufyyCHGPakhRA=;
        b=raDFQxECKIFtAUAbYgXxcLH0SAIfWOiTGpJzLMF5KNcb+5Vpui6ShH1VN4zljWzDIt
         mWLOopc/lTIIIENGaYjrf4vVmuHGs1+w5tu0s12hO6o0juxXKeyPDaKXshKK0kOLMoXA
         K8RZpWDfpCrE+pKDJfPqA5lLIOIVOIvgcIcyJYvX0/9e9+MqssNCapX/N4sscDjvVcuj
         LkP9vjFnQx3+kk7ZK/NRAWUBveUDGZm1W6cP+hxIYVW0R9EV28JMfEsiu1MDxNsGBroW
         Z3AOfHGGiq8Bsap5AoU+kUU9hhZsspjZ9CpPQLDb/QNlKjtihBTjQKcfDu03k0hWzsqL
         CoRQ==
X-Gm-Message-State: AOJu0YwkkbuVAebo5OLqzHLhN3lcRQhMRtLT8Q7zwXM9Sxv7ZjYAhmug
        Ks6RZUHH2270brwN8E/95UGSyJIXWiolQm2pZPlbDAlRAhxLO5ZlSs1pzOFPO0jnFaHhlRJGYII
        T9AKPb/cp2HzH9SIZqKW7c7MNy1lvXk4luTxMan9d
X-Received: by 2002:ac2:5382:0:b0:503:3700:7ec3 with SMTP id g2-20020ac25382000000b0050337007ec3mr3125202lfh.39.1697605802376;
        Tue, 17 Oct 2023 22:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHq7BHd0w9CIc8EEmu8T/No9/yxl0R3nmQJCM8Fu+V76dMZwXgkytemBCmyei4Vv3uObp77n/Wo1fy4ehbxDA=
X-Received: by 2002:ac2:5382:0:b0:503:3700:7ec3 with SMTP id
 g2-20020ac25382000000b0050337007ec3mr3125107lfh.39.1697605798622; Tue, 17 Oct
 2023 22:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <CACGkMEvJpcsNTLp7e2vuKAyGFRdF4RC34+t=EHUbvFAg8LdfDw@mail.gmail.com>
 <CACLfguXyk7E2z=WM+=uWEd73CCgodyvgQUG0eXvfHP+6UHjx8g@mail.gmail.com>
In-Reply-To: <CACLfguXyk7E2z=WM+=uWEd73CCgodyvgQUG0eXvfHP+6UHjx8g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 13:09:47 +0800
Message-ID: <CACGkMEvikhJ2DA5NX4msmhWz6m47v-YfYwaA2K+A-qtX9xj30A@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] vduse: Reconnection support in vduse
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:52=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Oct 17, 2023 at 10:44=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Here is the reconnect support in vduse,
> > >
> > > The kernel will allocate pages for reconnection
> > > userspace needs to use ioctl VDUSE_GET_RECONNECT_INFO to
> > > get the mmap related infomation and then map these pages
> > > to userspace.
> > > The kernel and userspace will use these pages to sync
> > > the reconnect information
> > >
> > > Tested in vduse + dpdk test-pmd
> >
> > I would like to see the DPDK part as a reference. Would you mind
> > giving me a pointer?
> >
> > Thanks
> >
> sure, Will send the dpdk patch soon
> thanks
> cindy

Btw, I would expect to add the protocol into the VDUSE doc to describe
the exact step for doing reconnection.

Thanks

> > >
> > > Cindy Lu (4):
> > >   vduse: Add function to get/free the pages for reconnection
> > >   vduse: Add file operation for mmap
> > >   vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
> > >   vduse: update the vq_info in ioctl
> > >
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 175 +++++++++++++++++++++++++++=
++
> > >  include/uapi/linux/vduse.h         |  43 +++++++
> > >  2 files changed, 218 insertions(+)
> > >
> > > --
> > > 2.34.3
> > >
> >
>

