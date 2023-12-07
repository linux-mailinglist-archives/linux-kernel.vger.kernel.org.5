Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7DF80837B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjLGIqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378394AbjLGIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9019A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701938792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEejCQBe0JpA/tNNsAza2pPtF0USzloo/HRlTyZ5Xy4=;
        b=aTkiVFZsHRPNZUhFFmz+heBAlELItVXLXqQwfIDE7VHESboWfzsL1q1WYTQT+uSS1H1J43
        0+SEslzJ0b0Dzi2qW5Bv6gX7LgVm1JyiGE9KtZgLzosku5HkwYa+hzK9vkJwVjHTH+STOg
        gA1nmt+IZm4SX5koNeWGEz8iZa98sS4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-tJobi6UHONaNN0aqdf-qrw-1; Thu, 07 Dec 2023 03:46:30 -0500
X-MC-Unique: tJobi6UHONaNN0aqdf-qrw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-286d700f702so560767a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938790; x=1702543590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEejCQBe0JpA/tNNsAza2pPtF0USzloo/HRlTyZ5Xy4=;
        b=egBk64ReA2HDc5h/bWxcUV+xO8aYeQiErW/az10f86/qNGM6xcGRBFgG0BYVgsDrwR
         +RDZ2Z+1aITxVa/hLOMWnMJwSnARRGdRGwa30xuWySH9+26egSIwg3lCQUMBWyzkBGUc
         vhw8d/Iz/YSabr2gC68eVHSu2XUHyDMrCmfPCkc7PiPlYUCWJWZZeMAoxjo27fIGZDGl
         o3ocB2XoYHs2YNBHOJVZx0qnvMdzh3js+rUUdbxSWNpQDYOoQkuSMdRDiysBfj3baV58
         UtntgAsQ49szdR18bp/vy0aYImicOAYm0cAoY7vktwys2ywt2K5IApjYNmyPPIg+z0lr
         rHng==
X-Gm-Message-State: AOJu0YzUG6bAVXsiPRT5+5sew9bnw5Gc8X46GiG//Uk/t5U4ewivS310
        soHInww9K1+ACOpUFUKIciY5lp4QXr1ez2xMU+4wX/jx5hp6kBWDsdJNhgVTa5BdUb4txuYHoCY
        VRHp4XizFBQHQ1C2tVBcrQ7CQgDjoO0YDGac8l0e2
X-Received: by 2002:a17:90b:4ac7:b0:286:a9a4:9622 with SMTP id mh7-20020a17090b4ac700b00286a9a49622mr1857199pjb.16.1701938789700;
        Thu, 07 Dec 2023 00:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrKBBpBMdCmmK/AHdieKoV5iLskU9S7/rTabXBcdkwFMoSUxgv/HM5r8pjBgeHjzCnCTcD865cgl25v0Z2UC8=
X-Received: by 2002:a17:90b:4ac7:b0:286:a9a4:9622 with SMTP id
 mh7-20020a17090b4ac700b00286a9a49622mr1857192pjb.16.1701938789421; Thu, 07
 Dec 2023 00:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20231205083444.3029239-1-lulu@redhat.com> <20231205083444.3029239-3-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-3-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 16:46:18 +0800
Message-ID: <CACGkMEt26rDCQAH8Oh-pnEDFb-ShAMhL3kyejWGEkw_Sdo4OUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] vduse: Add new uAPI for vduse reconnection
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 4:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> To synchronize the information for reconnection, add a new structure
> struct vduse_dev_reconnect_data to save the device-related information,
> Add the VDUSE_RECONNCT_MMAP_SIZE for the size of mapped memory for each v=
q
> and device status.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  include/uapi/linux/vduse.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 11bd48c72c6c..c22838247814 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -350,4 +350,26 @@ struct vduse_dev_response {
>         };
>  };
>
> +/**
> + * struct vduse_dev_reconnect_data - saved the reconnect info for device
> + * @version; version for userspace APP

I guess it should be the version of the reconnection protocol not the
userspace application.

> + * @reconnected: indetify if this is reconnected.userspace APP needs set=
 this
> + *                to VDUSE_RECONNECT, while reconnecting.kernel will use=
 this
> + *                to indetify if this is reconnect

Typos, I think checkpatch may help or you can tweak your editor to
enable spell checkings.

> + * @features; Device features negotiated in the last connect.

This seems to cause confusion, let's use driver_features instead.

But can't we just get driver_features via VDUSE_DEV_GET_FEATURES?

> + * @status; Device status in last reconnect
> + */
> +
> +struct vduse_dev_reconnect_data {
> +       __u32 version;
> +#define VDUSE_RECONNECT 1
> +#define VDUSE_NOT_RECONNECT 0
> +       __u32 reconnected;
> +       __u64 features;
> +       __u8 status;
> +};

For status, VDUSE currently forwards the request to the userspace:

static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
{
        struct vduse_dev_msg msg =3D { 0 };

        msg.req.type =3D VDUSE_SET_STATUS;
        msg.req.s.status =3D status;

        return vduse_dev_msg_sync(dev, &msg);
}

Do we need to handle the case where the user space crashes when
dealing with this message? For example, driver set DRIVER_OK but VDUSE
application crashes when dealing with DRIVER_OK.

At the uAPI level, it probably requires to fetch inflight VDUSE
requests. It may help for the case where dealing with crash at feature
negotiation and configuration space access.

> +
> +/* the reconnection mmap size for each VQ and dev status */
> +#define VDUSE_RECONNCT_MMAP_SIZE PAGE_SIZE

PAGE_SIZE should not belong to uAPI. Userspace can query it via e.g sysconf=
 etc.

Btw, what is the virtqueue part for this? I'd expect there should be
at least the part of inflight descriptors?




> +
>  #endif /* _UAPI_VDUSE_H_ */
> --
> 2.34.3
>

