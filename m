Return-Path: <linux-kernel+bounces-136220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB70689D15F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F74A1F25A12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35455E40;
	Tue,  9 Apr 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7V/RhbC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8454F95
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712635186; cv=none; b=Hq1TbQp7CNmy1HH4sD/d7AFsm2b9/HdVPcCzkNiVDHqWqYuV9fw2oMjhddFu1jtGNNj1mBu2VLF8wpRC/zqO2w8GL+ca42tneP60CZU5LDR2edAhi2svSD9LFpgoU6FxQnR69GjOO4+7o5TYxD1bEYkk4omf0A1EFPLPH90QJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712635186; c=relaxed/simple;
	bh=5FLP6vOlq11TgvbsYHRDLMLdOdFYzw0JyC9A9ixaDnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DylfhIh+I4QfFuJw3kMYz/3OpkDFAVIRbrsVwqIist7tQE4GC4+2QJiE3MPEI9UC3kmvxtBtpRTmkuXcjffTqo22dMxjY3FAH/RIHOQdTHumz4ecr976WWfSpquxG0g9tJZv4tBEKW8srchWmEGaYlbYN+4ybQ3qxM7jWteBdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7V/RhbC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712635183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESFjxmFELRVs+AuzBBwmEdBOCmT+SzELHtnXjIlCRYE=;
	b=N7V/RhbC2Lbrt6SwZyhAqPBRgEJ0IQbkLsV6z05tobwv51ACbjEDrJlkwUXa82fSLt81uw
	jqVpiVys6kz/ft9HcXBbBD+5+0t5E/MyhPpnudT/HwyumFSbS2Kpsk0MSlg13xce5wFeDp
	NWD9ipnI8BFD+A0zGk/sCxhdRL3qZbc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-pen0b92YPu2eAGZASWd3qg-1; Mon, 08 Apr 2024 23:59:41 -0400
X-MC-Unique: pen0b92YPu2eAGZASWd3qg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e3c14a60e3so29286025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712635180; x=1713239980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESFjxmFELRVs+AuzBBwmEdBOCmT+SzELHtnXjIlCRYE=;
        b=S0BL30QYVpaW4moRaGe4O231IO+YreWc4WwVLHXc1NNetzCfb5Oe8Z7xv6O40O0SlL
         cwq1Ilzayy0ARBZ/R56B1FJjJo1IeLBAGP/OvVT0BvUV+NqbgD2EwxWr4CKU44A1GA1Z
         nLxFvVY7nP4cYuUwymT5FTnVHNCsqHZKmUwXouT2RW/YEil+4PQZaDCi6Hajn9xwJfJQ
         7eslZWyjs7Jrmt4tAN1Hj5znZ1gpa1SfHyPDezDuaT+vlMsCwuCmv+p8vXUGy3bHCDHz
         fwSbslUbnHn30d+aRzmxKrsYxhameqHc6ZzMvZUhh6fiUT6dY173mALRZ4b8+UGRZ9Sk
         p6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW9AtvdjYQeeSALogGcFPcMS9xQtebjZAxnJRfunb3wb4HUqvEv7iOrjW9TTbcjxMKMMx4wGozUrmtBs7y52utElnBsbjFqPmSRUJX0
X-Gm-Message-State: AOJu0YzciQdTwHojjOdeFEKVf7zRC0klEKxx6BMw+faF8DC9WgYgEOQj
	/OODaV7q2ctNyUeAOLAUdFZDL545QibF593Laqw0mWZo6fNy+4QNPORidwZjHo99Co0oR84J02i
	2DPJSFcNJQpY6+Mc+vNv0fsEeHujtbIOqiN4lL0slaobrtLqqou039YiR75Moru5TtT4YR6i7sU
	RkFsXGNyokpWnqbVkKmW1NGkZLy0bB3Ou2S0k9
X-Received: by 2002:a17:902:dac8:b0:1e2:8c12:aac0 with SMTP id q8-20020a170902dac800b001e28c12aac0mr13713177plx.28.1712635180671;
        Mon, 08 Apr 2024 20:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9tu59WVehtU2mwCb0UaP2HnkqkQT/cJ0414esrTrtY6twmt+l2HIit7o5pyDKqDNa5/emeNwsfHJU5mgffHY=
X-Received: by 2002:a17:902:dac8:b0:1e2:8c12:aac0 with SMTP id
 q8-20020a170902dac800b001e28c12aac0mr13713164plx.28.1712635180313; Mon, 08
 Apr 2024 20:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408170252.13566-1-ni_liqiang@126.com>
In-Reply-To: <20240408170252.13566-1-ni_liqiang@126.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 11:59:29 +0800
Message-ID: <CACGkMEub7vekopiQ1jdh_tHyjOXCADZsouJevioLHEBU1VFOEg@mail.gmail.com>
Subject: Re: [PATCH] drivers/virtio: delayed configuration descriptor flags
To: "ni.liqiang" <ni_liqiang@126.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"jin . qi" <jin.qi@zte.com.cn>, "ni . liqiang" <ni.liqiang@zte.com.cn>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:27=E2=80=AFAM ni.liqiang <ni_liqiang@126.com> wrot=
e:
>
> In our testing of the virtio hardware accelerator, we found that
> configuring the flags of the descriptor after addr and len,
> as implemented in DPDK, seems to be more friendly to the hardware.
>
> In our Virtio hardware implementation tests, using the default
> open-source code, the hardware's bulk reads ensure performance
> but correctness is compromised. If we refer to the implementation code
> of DPDK, placing the flags configuration of the descriptor
> after addr and len, virtio backend can function properly based on
> our hardware accelerator.
>
> I am somewhat puzzled by this. From a software process perspective,
> it seems that there should be no difference whether
> the flags configuration of the descriptor is before or after addr and len=
.
> However, this is not the case according to experimental test results.
> We would like to know if such a change in the configuration order
> is reasonable and acceptable?

Harmless but a hint that there's a bug in your hardware?

More below

>
> Thanks.
>
> Signed-off-by: ni.liqiang <ni_liqiang@126.com>
> Reviewed-by: jin.qi <jin.qi@zte.com.cn>
> Tested-by: jin.qi <jin.qi@zte.com.cn>
> Cc: ni.liqiang <ni.liqiang@zte.com.cn>
> ---
>  drivers/virtio/virtio_ring.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..bea2c2fb084e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1472,15 +1472,16 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
>                                     (++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT) |
>                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE=
));
> -                       if (i =3D=3D head)
> -                               head_flags =3D flags;
> -                       else
> -                               desc[i].flags =3D flags;
>
>                         desc[i].addr =3D cpu_to_le64(addr);
>                         desc[i].len =3D cpu_to_le32(sg->length);
>                         desc[i].id =3D cpu_to_le16(id);
>
> +                       if (i =3D=3D head)
> +                               head_flags =3D flags;
> +                       else
> +                               desc[i].flags =3D flags;
> +

The head_flags are not updated at this time, so descriptors are not
available, the device should not start to read the chain:

        /*
         * A driver MUST NOT make the first descriptor in the list
         * available before all subsequent descriptors comprising
         * the list are made available.
         */
        virtio_wmb(vq->weak_barriers);
        vq->packed.vring.desc[head].flags =3D head_flags;
        vq->num_added +=3D descs_used;

It looks like your device does speculation reading on the descriptors
that are not available?

Thanks

>                         if (unlikely(vq->use_dma_api)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> --
> 2.34.1
>
>


