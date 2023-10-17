Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02C77CB890
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJQCxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQCxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E493
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697511142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u5DJtrDTtf0VuzZlAsLp9Cvkz3rQFo/ykyqIRgS708=;
        b=BXoBfeIYlc0rF5UjysDDhhKvIxc08xiDrlF8aLTGTNn6zsQjogSH0DipZ57jZx5Mq2odDx
        WlDWR6U8e04PH7U4pwgFXE5VQZD8ojsWl7Kpdp6qckHvLxxVVuyglK6xXly/Dgk+X4T+AQ
        HwRaDLeASl1oi3H6Wym7P19yhrSUa9g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-zkGjY_8hM0mr2CC6SrOPCA-1; Mon, 16 Oct 2023 22:52:11 -0400
X-MC-Unique: zkGjY_8hM0mr2CC6SrOPCA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507a0904cdbso2870217e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697511130; x=1698115930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u5DJtrDTtf0VuzZlAsLp9Cvkz3rQFo/ykyqIRgS708=;
        b=ZAnqwZJ8ZwpTMEuNsaSCcNSI7nQVGvunJ40ZAIBNEQ6cCKmkQSBynIgT4p1joZNqvO
         sceKzrhjWa/QFcHfKpfDK1egL9iptPYi/mtE0Ths7XtuKVGGgN7hrgnT6jZnNnznjXZW
         bwpHUZyAXbWYki1paCUsJFoKbQ3XFTGtiOJaMEHfzCZzGo3NBRp8UWsEcg0emezBEOw3
         QwGX6uGGbStcuk3Nwa25ryAP0zduout6/Kxo3hyMqgdBJq1Vqh+DPGnxB3beMBzG7zoI
         jdLDNEIyrAUQnIvlS7MnPhdxrqdnjsaMyzU0EnJ61uaYqxZJzTPzZvi7EwRHdcdGq5Qi
         w0xA==
X-Gm-Message-State: AOJu0YzpvRxuZqy4IxVaA4upJLz1mqQ9B+iB3zeJBTHoTnjG2IB2EA2u
        vdoOYVAH6NleQ7klLtK/7tyZmC6mhbY0+Dpv83E6zTghrWIuO2qws+zXnTHaEqoxwLjRl+uKN7z
        6wEEjLF+shIZ7F64zWmPAwxfvJd3JzD42IAXS+iKJ
X-Received: by 2002:a05:6512:612:b0:4ff:7004:545e with SMTP id b18-20020a056512061200b004ff7004545emr868679lfe.4.1697511129816;
        Mon, 16 Oct 2023 19:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6nJkmN8VrQrzD1tdTOQdDNidtu/wOZVzo6wJifFOM7zRitc93vgWAXX1Crk0UEFB/Xi/rOu5Jrje4++fnJJA=
X-Received: by 2002:a05:6512:612:b0:4ff:7004:545e with SMTP id
 b18-20020a056512061200b004ff7004545emr868672lfe.4.1697511129507; Mon, 16 Oct
 2023 19:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <CACGkMEvJpcsNTLp7e2vuKAyGFRdF4RC34+t=EHUbvFAg8LdfDw@mail.gmail.com>
In-Reply-To: <CACGkMEvJpcsNTLp7e2vuKAyGFRdF4RC34+t=EHUbvFAg8LdfDw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 17 Oct 2023 10:51:31 +0800
Message-ID: <CACLfguXyk7E2z=WM+=uWEd73CCgodyvgQUG0eXvfHP+6UHjx8g@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] vduse: Reconnection support in vduse
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
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

On Tue, Oct 17, 2023 at 10:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Here is the reconnect support in vduse,
> >
> > The kernel will allocate pages for reconnection
> > userspace needs to use ioctl VDUSE_GET_RECONNECT_INFO to
> > get the mmap related infomation and then map these pages
> > to userspace.
> > The kernel and userspace will use these pages to sync
> > the reconnect information
> >
> > Tested in vduse + dpdk test-pmd
>
> I would like to see the DPDK part as a reference. Would you mind
> giving me a pointer?
>
> Thanks
>
sure, Will send the dpdk patch soon
thanks
cindy
> >
> > Cindy Lu (4):
> >   vduse: Add function to get/free the pages for reconnection
> >   vduse: Add file operation for mmap
> >   vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
> >   vduse: update the vq_info in ioctl
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 175 +++++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h         |  43 +++++++
> >  2 files changed, 218 insertions(+)
> >
> > --
> > 2.34.3
> >
>

