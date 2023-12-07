Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A980837C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjLGIqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378414AbjLGIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F5D57
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701938794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wa+ZVqhAONpvfJ8gOpR3U5TlBPgIPDBI52ExBUdPgdo=;
        b=V760QoZBMhqvxb/44iHspCUkfFLoM1mTvOyalwrLbWwtDy8hDZRqbVjkbHcoM8XpMFuKN1
        KBuOVpMKdaPw3PqiqIAJnKZMvAKJmmWJ5bH5fxCZioWfXj747oNF4YIQJTge3R+Mx5hD0/
        SMkopyuWAF87IQlnJe5ca/JvfhQYJSQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-4CM8DLDEOa65RPIpIk2nxg-1; Thu, 07 Dec 2023 03:46:33 -0500
X-MC-Unique: 4CM8DLDEOa65RPIpIk2nxg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2888414ac91so596520a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938792; x=1702543592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa+ZVqhAONpvfJ8gOpR3U5TlBPgIPDBI52ExBUdPgdo=;
        b=cY3oHXyVQuWA4p127mbslLem7K3RuDgLaUUJk8f3+KulIhO/I10DbtqHaawtDLrNVF
         I/gaz7LlYfMS+JqGscffEw1tzPaA7Gzcf8T0qj+XgVHr5jeO4kCwBCzeQwPcUOdh9i2X
         qkFqMMlt89C7gDZBRQrwGwpt1MRVNV5Ka12QZK3LHT/oY+fjrwTzjjTUPW7MnWixKbc/
         ILcZNdlJDTAWGBr5kivfykJR7/L0I2TtgK3YbD1V48Rvj76rT8ScrdB8erj+JMYaf1Ge
         0LUuiH9EIyiXmh86+zeP9r4MmOLIyG7TNLDDB8AKdHRc3K9hwbuDAirsNkhMrkhsh6kG
         X7Ew==
X-Gm-Message-State: AOJu0YxcZu3HNLmSYJMKLhy9rbSjQPuvBlbX4jAM+8o0RX+bg+uM/ZXw
        1/WGP5Z2TCLdLjwk+Aa/0AAycIyTtm7ZdZ3zZ+HXfZfcPsKZ2/9a37a0bzIBQW6DF9wjq3xn04y
        GOwO+OJehLMDq6rdgw4Rzhkxq4cIEdVYs/Nia44Tz
X-Received: by 2002:a17:90a:d50b:b0:286:6cc1:5fd7 with SMTP id t11-20020a17090ad50b00b002866cc15fd7mr1867296pju.90.1701938792344;
        Thu, 07 Dec 2023 00:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU8DAGCEIVAnzsf/B9K831lRc8fVUdoRmNxlrRMw91W/IBZBQ0bJzkNeOWVe/uhvJkcJjuv9GbuZ1god9NsD4=
X-Received: by 2002:a17:90a:d50b:b0:286:6cc1:5fd7 with SMTP id
 t11-20020a17090ad50b00b002866cc15fd7mr1867294pju.90.1701938792090; Thu, 07
 Dec 2023 00:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20231205083444.3029239-1-lulu@redhat.com> <20231205083444.3029239-8-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-8-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 16:46:20 +0800
Message-ID: <CACGkMEs+TxTibj8tcvJn9kK2nF5_qUZWBkQTevpU-1_dQDE5yQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] Documentation: Add reconnect process for VDUSE
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 4:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> index bdb880e01132..ec66e573f6da 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,33 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnectoin works
> +----------------
> +0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
> +   If it does not exist, need to create the instance.
> +   If it does exist, it means this is a reconnect and the program procee=
ds to step 3.
> +
> +1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +   /dev/vduse/control.
> +
> +2. When the ioctl(VDUSE_CREATE_DEV) function is called, the kernel alloc=
ates memory
> +   to synchronize the reconnect information.

This is the implementation details and I guess this doc only focuses
on the uAPI. So there's no need to describe it here.


> +
> +3. Userspace App need to mmap the pages to userspace
> +
> +   When connecting for the first time, the userspace app must save the r=
econnect
> +   information (struct vhost_reconnect_data) in mapped pages

This looks vague. We need to describe what kind of information that
needs to be saved and when to save.

Thanks


> +
> +   If this is reconnect,If the purpose is to reconnect, the userspace ap=
plication
> +   must verify if the saved information is suitable for reconnection. Ad=
ditionally,
> +   the userspace application is required to set the "reconnected" bit in=
 the
> +   "struct vhost_reconnect_data" to "VDUSE_RECONNECT". The kernel will u=
se this bit
> +   to identify if the userspace application is reconnect.
> +
> +4. Start the userspace App.
> +   userspace APP will call ioctl VDUSE_VQ_GET_INFO to sync the vq inform=
ation.
> +   Additionally, the APP must save the vq reconnect information (struct =
vdpa_vq_state)
> +   in mapped pages while running.
> +
> +5. When the Userspace App exits, it is necessary to unmap all the reconn=
ect pages.
> --
> 2.34.3
>

