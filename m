Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3587DD585
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376464AbjJaRxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbjJaRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640EF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JiBQgapXFQfoour8NRSPRcoo4HDysBjciUG+BLpDfpk=;
        b=Gy3ZN2szb7RH97fdrwejKSpAoSzimgp8VJiLAXUQY8cu1MNN4wV7YgBLqc2I75k414Co9U
        mBI29yamU2HLcETOegNBFbO7mkyRytOtsv3PyB/qynevAyjA4x0+GTD3OiEMZ+WM5nr+BH
        Qp3xe3YWW28b6GuDdmzsT71wD9XVe/w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-DE_GBTUhNzm-f1Bok4mB1g-1; Tue, 31 Oct 2023 13:51:59 -0400
X-MC-Unique: DE_GBTUhNzm-f1Bok4mB1g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5a7c97d5d5aso70070997b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774719; x=1699379519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiBQgapXFQfoour8NRSPRcoo4HDysBjciUG+BLpDfpk=;
        b=ZqANSeG8+vFYJJuH8ufdA4Q78JV69nr7oIV7RI39vr6Iyf/7JBbeDrjYuVGUk/jvtL
         DQIl8uAl4B0l3XIhnQU7IrMhDXXnbOawdQh+8Fz6evtNmMS+RCNtbmef1OMKw+VtdS4M
         Jo5ilrBSf9Mf2ObSk+hFJyY+L8KDb+6NFftuMolbi94u02+iwGIDuoSwHCBM+mIgn2zI
         Be//Vg8HOG3nWrNVGGvd4rosxEfBZfv6JcC/NqyV4CEjIP8nE0sn5YfkJ9SKB5lJ3DxG
         gV8qiTYm7HoDr2NkPd7liHeWf7gbHF9eHbX8ksdFhLLbmotypeAYKUlEzdU8EEfAB8pl
         yl8g==
X-Gm-Message-State: AOJu0YzzfvOAbKH2NCNKuY5z79VzUBBwXCIjSYszN9HBzZZ1v2i230dF
        xvurOwpPfUTFMvFMoGNQ99rzJY6IAYaXwOQESk0HAlyRD4jbv2DaMtlAKjv5JLdV3I9fns8fVmX
        hoAvS82Y7xp0SaMjf1Ejw0RzdoGD8NGgDSH9EkREH
X-Received: by 2002:a81:c946:0:b0:5a7:b464:ff1a with SMTP id c6-20020a81c946000000b005a7b464ff1amr13260744ywl.6.1698774718809;
        Tue, 31 Oct 2023 10:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpyd5UuoJZhDSyJz62BuM8WGy64dORcaXjgDDTBdYN6Y/kC0zq6u0JzoBXj8CQkvjTEKb048eWzWcDOcSuMik=
X-Received: by 2002:a81:c946:0:b0:5a7:b464:ff1a with SMTP id
 c6-20020a81c946000000b005a7b464ff1amr13260726ywl.6.1698774718519; Tue, 31 Oct
 2023 10:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231031144339.121453-1-sgarzare@redhat.com>
In-Reply-To: <20231031144339.121453-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 31 Oct 2023 18:51:22 +0100
Message-ID: <CAJaqyWfr123zWdM8E+H4bnfrdvv-KEvZ7r5eN+fY428G6v95Hg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: allocate the buffer zeroed
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Qing Wang <qinwang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 3:44=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Deleting and recreating a device can lead to having the same
> content as the old device, so let's always allocate buffers
> completely zeroed out.
>
> Fixes: abebb16254b3 ("vdpa_sim_blk: support shared backend")
> Suggested-by: Qing Wang <qinwang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index b3a3cb165795..b137f3679343 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -437,7 +437,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *=
mdev, const char *name,
>         if (blk->shared_backend) {
>                 blk->buffer =3D shared_buffer;
>         } else {
> -               blk->buffer =3D kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_S=
HIFT,
> +               blk->buffer =3D kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_S=
HIFT,
>                                        GFP_KERNEL);
>                 if (!blk->buffer) {
>                         ret =3D -ENOMEM;
> @@ -495,7 +495,7 @@ static int __init vdpasim_blk_init(void)
>                 goto parent_err;
>
>         if (shared_backend) {
> -               shared_buffer =3D kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR=
_SHIFT,
> +               shared_buffer =3D kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR=
_SHIFT,
>                                          GFP_KERNEL);
>                 if (!shared_buffer) {
>                         ret =3D -ENOMEM;
> --
> 2.41.0
>

