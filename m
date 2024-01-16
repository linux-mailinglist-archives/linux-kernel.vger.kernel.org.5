Return-Path: <linux-kernel+bounces-27670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8F82F3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C34E285B30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4541CF80;
	Tue, 16 Jan 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlD2B4fN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C31CF89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428909; cv=none; b=i77fKBENPQtjqVWDhxwJ7b7w8ADQ1GtfJa28Uz24Up6yh1yN858WSFOdvtkzUPecX81p9aI5zL/dVcpnDzZgCZ9wc23ueQx1xpFaAiVS2eE8OcdoK/6OaEQvuczrfKBi0yMaosgb9jGrwzH7oDCv9T+/cqsXLFdwfD1M6Q2H/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428909; c=relaxed/simple;
	bh=3zlBGl5VpWKn0Q0H4wPH6FO7Ud1zlBJ5F2g6/4S4edA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=B+OMwRSsZ3dWafniaBYUwyiPLnaTytnOHYelaybxhUe+0IbHcDAKtqFeIikV558HF7W1/SAFHyoAKIvcdw6LzpG3XgyIOQr+UqYv+E3X7unk5KKZu1P8R1pIlHMdtowDmfVCttmhp8wP+YK/6isYUeaxjNqGhvVfqC/VVzUJwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlD2B4fN; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WbXw4cXFD9BqB4vMNoNua9qjVvWa2/XOALDuoMj2c0=;
	b=SlD2B4fNz3FaZymp1Om6MNEpmfSM84eqBZFjZcV09h3iYc9b/UY3dMxnbL3yVoBQXpdB8Z
	XL/d7MxjiryQHOjpzmbMsZlVnR9WOqsEdor1whV/hMxtqyyEDmL4a0QfY8W1ueWK8fPLq1
	hxZtiFXhs3HT1ndw/t/lKAncv9GhEWI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-8cASJv7uNfeiA2GSGzAESg-1; Tue, 16 Jan 2024 13:15:05 -0500
X-MC-Unique: 8cASJv7uNfeiA2GSGzAESg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5e9a02c6d49so194531617b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428904; x=1706033704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WbXw4cXFD9BqB4vMNoNua9qjVvWa2/XOALDuoMj2c0=;
        b=mfbQJ7vsGkWjDTOU6kEaFmOyTmw6YkJQDC2cWzGiW6+osMUPYj4OTj9Y8LHZydfrfk
         8FITDkVzErGGx7IQe9aV993NjoRSnZB1IiRxg6Vsl/s2XJIs+/UW+bVi0c9daWiN0p0B
         EQn1cVLsGH8ud1As7ox0//lxNlJ0yRJ24hC75GvsbNRc0nQUOipaghkLzPSrSXW6HobL
         29zwFuv11GD0/QYmFKn8UZMuY4YL6g2efpSXILHpi/eHo8Vdbx87Q+q93PsxNNfe1hTw
         4wgP4Dhq5WFDEuKSRyKMkxZ1YV9ScLbH91bO0Y7lsMj88O+P0jLrIRxPajoRxz4YCZqg
         Uf2A==
X-Gm-Message-State: AOJu0YyHjNrEHW5cBxDnoePWym5OxSDUTdyl++lC3TIhJjG2y3U+9M2l
	pOEIpmv00gr4j6GU+Ev7+7fExRJLdbDOoJhMYGWWhgucumHCgQiHVe8efQoOz7pSfaSPTJ60K1l
	bdmCidrPtbYQdPCwQcBedptF3YBGvLPc0ltSia70Iu/xB4mSU
X-Received: by 2002:a25:8a01:0:b0:dbd:d617:7f14 with SMTP id g1-20020a258a01000000b00dbdd6177f14mr3940604ybl.10.1705428903855;
        Tue, 16 Jan 2024 10:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjjSfieogeLmsO2hkJG2Ph0p7ONMonI8rw73F9+m+gs8kSmgBZf3/0NFA73MJK+nfFRY6rQ9rqfgEIhZUhCjc=
X-Received: by 2002:a25:8a01:0:b0:dbd:d617:7f14 with SMTP id
 g1-20020a258a01000000b00dbdd6177f14mr3940587ybl.10.1705428903474; Tue, 16 Jan
 2024 10:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jan 2024 19:14:27 +0100
Message-ID: <CAJaqyWc+nSMPv7248x2QWOgAPOjwZ2BJ52LrOhKUu51t+3QViw@mail.gmail.com>
Subject: Re: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Eli Cohen <elic@nvidia.com>, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:40=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> When device ownership is passed to a new process via VHOST_NEW_OWNER,
> some devices need to know the new userland addresses of the dma mappings.
> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
> of a mapping.  The new uaddr must address the same memory object as
> originally mapped.
>

I think this new ioctl is very interesting, and can be used to
optimize some parts of live migration with shadow virtqueue if it
allows to actually replace the uaddr. Would you be interested in that
capability?

> The user must suspend the device before the old address is invalidated,
> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
> requirement is not enforced by the API.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c             | 34 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost_types.h | 11 ++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index faed6471934a..ec5ca20bd47d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>
>  }
>
> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> +                                         struct vhost_iotlb *iotlb,
> +                                         struct vhost_iotlb_msg *msg)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +       u32 asid =3D iotlb_to_asid(iotlb);
> +       u64 start =3D msg->iova;
> +       u64 last =3D start + msg->size - 1;
> +       struct vhost_iotlb_map *map;
> +       int r =3D 0;
> +
> +       if (msg->perm || !msg->size)
> +               return -EINVAL;
> +
> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> +       if (!map)
> +               return -ENOENT;
> +
> +       if (map->start !=3D start || map->last !=3D last)
> +               return -EINVAL;
> +
> +       /* batch will finish with remap.  non-batch must do it now. */
> +       if (!v->in_batch)
> +               r =3D ops->set_map(vdpa, asid, iotlb);

I'm missing how these cases are handled:
* The device does not expose set_map but dma_map / dma_unmap (you can
check this case with the simulator)
* The device uses platform iommu (!set_map && !dma_unmap vdpa_ops).

> +       if (!r)
> +               map->addr =3D msg->uaddr;
> +
> +       return r;
> +}
> +
>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>                                            struct vhost_iotlb *iotlb,
>                                            struct vhost_iotlb_msg *msg)
> @@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev, u32 asid,
>                         ops->set_map(vdpa, asid, iotlb);
>                 v->in_batch =3D false;
>                 break;
> +       case VHOST_IOTLB_REMAP:
> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> +               break;
>         default:
>                 r =3D -EINVAL;
>                 break;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 9177843951e9..35908315ff55 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>  /*
>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>   * multiple mappings in one go: beginning with
> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP =
or
>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>   * When one of these two values is used as the message type, the rest
>   * of the fields in the message are ignored. There's no guarantee that
> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>   */
>  #define VHOST_IOTLB_BATCH_BEGIN    5
>  #define VHOST_IOTLB_BATCH_END      6
> +
> +/*
> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at i=
ova.
> + * The new uaddr must address the same memory object as originally mappe=
d.
> + * Failure to do so will result in user memory corruption and/or device
> + * misbehavior.  iova and size must match the arguments used to create t=
he
> + * an existing mapping.  Protection is not changed, and perm must be 0.
> + */
> +#define VHOST_IOTLB_REMAP          7
>         __u8 type;
>  };
>
> --
> 2.39.3
>


