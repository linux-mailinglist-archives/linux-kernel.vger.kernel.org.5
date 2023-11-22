Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FC7F3E15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjKVGXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:23:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB8BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700634215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNG6k+KGe/EFM4+bavCchY0Mfcn7/06XpFcPsjQPAH8=;
        b=My4vfjBmbpd2wqqAZDeWCwF7bj30Zj9TwjmQ7DifAf17EzdTj7RMXKerp3wBHK40f4pDvx
        2YnregUW67JRMhlNi1f2cSMnWFhWh30vHJCBkdzWGpwqFhE6bNiutfq9PSjYDmeYI12zQh
        IU5JX6+6Ls8H48bzLPvExTL/cM/DYGs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-mTV4w14cPJiNkwuPFKXckg-1; Wed, 22 Nov 2023 01:23:31 -0500
X-MC-Unique: mTV4w14cPJiNkwuPFKXckg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507cafb69e8so6265026e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700634210; x=1701239010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNG6k+KGe/EFM4+bavCchY0Mfcn7/06XpFcPsjQPAH8=;
        b=kyAQjfH3SyX4e4mW1AOZwPaPIJQvR+e287H6Y59H9n11UC6R0DDcJZoAK/dme1P/g9
         o7BTwXTwOoX50YuqjrTmV1oa5pNlf9rjjPhUWBuWCrONDgY8Rh25dkcE/Oilv0+n0l4l
         ZPu6SU+Bx/dPTvB+r58/C1nSLHx93XoYbQyi8jEXGWCISn5kzUKCo9xm+G60gAvorHlx
         +mrKC7FO3WcWnMu/Qc05wC5sQHhYBJpmE0qSxteciacsZNHrons6D3Y/cQhooUO/wbIU
         lkJc6iifL6HBlGEuvNGbrMkcpY7QcdycTC0xZ+h021vVRQ0S3CiTUwucG44gfYm/zy65
         lpXw==
X-Gm-Message-State: AOJu0YwYlD+P1UMgwdlJF5VOi1nOZEHRYBTosMJrAHk/6TVePDUIOAzC
        d29zrMbgPmxifG7nj/byVBzII+xbT7AibTLDT506efsYIcvm7YEuv6CkJF1K9EFNOK/MJsTcOxI
        seJjMu2HoE0WSk4h6gx+KbZSYmaoGFKbnpegQ8s06
X-Received: by 2002:a05:6512:2f6:b0:509:7141:fec with SMTP id m22-20020a05651202f600b0050971410fecmr901017lfq.48.1700634209958;
        Tue, 21 Nov 2023 22:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO1LgwOBX1vo65gE4qlvwyyTTvEIgNedSt5OXRNMNGVmHp2AlBR9Gg3AI5Or6oWbQsUGE2cV29ypEW8zdDw/U=
X-Received: by 2002:a05:6512:2f6:b0:509:7141:fec with SMTP id
 m22-20020a05651202f600b0050971410fecmr901007lfq.48.1700634209611; Tue, 21 Nov
 2023 22:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-2-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-2-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Nov 2023 14:23:18 +0800
Message-ID: <CACGkMEsC-8tW30pDR4NcqP1gfK8dWpbVwE5KV4Q9nkQuXFYhdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Add function to get/free the pages for reconnection
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

On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function vduse_alloc_reconnnect_info_mem
> and vduse_alloc_reconnnect_info_mem
> In this 2 function, vduse will get/free (vq_num + 1)*page
> Page 0 will be used to save the reconnection information, The
> Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> the reconnection information for vqs.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 80 ++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 26b7e29cb900..6209e2f00278 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -41,6 +41,16 @@
>  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +/* struct vdpa_reconnect_info saved the alloc pages info
> + * these pages will mmaped to userspace for reconnection
> + */
> +struct vdpa_reconnect_info {
> +       /* Offset (within vm_file) in PAGE_SIZE */
> +       u32 index;

Is index ever used in this series?

> +       /* virtual address for this page*/
> +       unsigned long vaddr;
> +};
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -57,6 +67,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       struct vdpa_reconnect_info reconnect_info;
>  };
>
>  struct vduse_dev;
> @@ -106,6 +117,7 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       struct vdpa_reconnect_info reconnect_info;
>  };
>
>  struct vduse_dev_msg {
> @@ -1030,6 +1042,64 @@ static int vduse_dev_reg_umem(struct vduse_dev *de=
v,
>         return ret;
>  }
>
> +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +       struct vdpa_reconnect_info *info;
> +       struct vduse_virtqueue *vq;
> +
> +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> +               if (i =3D=3D 0) {
> +                       /*page 0 is use to save status,Userland APP will =
use this to
> +                        *save the information needed in reconnection,
> +                        *kernel don't need to maintain this

Please tweak the case here and to make sure the series can pass checkpatch.

> +                        */
> +                       info =3D &dev->reconnect_info;
> +                       info->vaddr =3D get_zeroed_page(GFP_KERNEL);
> +                       if (info->vaddr =3D=3D 0)
> +                               return -ENOMEM;
> +                       /* index is vm Offset in PAGE_SIZE */

The case seems odd but anyhow this has been explained in the uAPI file?

Thanks

