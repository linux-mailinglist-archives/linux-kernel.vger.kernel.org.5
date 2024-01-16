Return-Path: <linux-kernel+bounces-27700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8004D82F453
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC41C23822
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D01C6AD;
	Tue, 16 Jan 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBONMbP1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9429AB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430026; cv=none; b=Qa2nz8hp2Aorq1/muYBejf4ojY9ZsD4wd34Fq5eNDpDL5BcGero/ABJnL8BJF55ks/lNHBJaHft88h0b74sPziKwygqSWRDBIGJuFk7TP5cVf7vc/Pk7J3N9SY+zLjj+Ng525TZCOSHX2aKmDBT+I1f2ubN62saO62Ng8cx8wqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430026; c=relaxed/simple;
	bh=P2deU3JZDkvYVtH5GnOFLNknOytS8dMMUCIUQGHAeY4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=KXG3pez2x6jp28pZZJ7glke8seHt6TJVZ+C89bI+hBSYTN/0+tBTgevT2kuFGJF5PQOJyQeTT8aU/gwQkUsgvesQUve4N8YV69STJXWgvYO86hEbDPZdsQ0mNrhRfXl5L/QNo7XvhQxUMoWv0h7rDBUGdkat+PNYEPIiFKK5jEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBONMbP1; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705430024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0IvAnbO55I9U8lmAgynm04Aoyru/cAMqaXR93cb9pg=;
	b=hBONMbP1e0YcukW0VDYfdrJMauM5P5/taWrSoSPBqnGuM7EkUhoO9CQf4Z6ID/O5swxkfv
	sqecNokApVmtNT6EHs16PluOQH7VvIC6sukHLSOO3+p6h+9AUWdjO7soXqYW7eOftk6xSP
	bOVAAAK7khMBUrOEA+CBypmM1aGByLc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-jZVhwcH7NkKezpuNd7J3xQ-1; Tue, 16 Jan 2024 13:33:42 -0500
X-MC-Unique: jZVhwcH7NkKezpuNd7J3xQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5f53b4554b6so158892857b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430021; x=1706034821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0IvAnbO55I9U8lmAgynm04Aoyru/cAMqaXR93cb9pg=;
        b=sqkgoM1l2gHoXKXtoyW+r9htq+n7w02OKgmdKVXtPywk2PRSW0yQLhtZ4pD3j8Qkux
         3YEHzuJX3hwUu7kwRLkHCwXGrJ49UHJtEbodARApcOSM+DcDMMvZciX0VhpxDr1R1XFC
         GkmcJpGzUKSfv5Oa8zUfXe18JyslkyhGb8m6FeThFiDmxj1beU41SgQfYyxkCQYe6BO7
         BE8s5hgHRbuR7SnLYq/yLTb+goYmHgONGEw6Zykm5SzNccJ371c+WymKGuytL+0kLpm/
         tlgL0tAfkobKD82F95n2pbPydg4qcdROezbtjNSnL06gvTBalR0rEejTsOWOVlUP7Cm6
         cNzQ==
X-Gm-Message-State: AOJu0Yy8QOONQEDCIMpIBI+QLXBfaGh2zpgcDZsFvMpkmoGXJuv8uYfc
	hylXDMe5XuW02dx4dDfq1RIgG1Sp12ydboRBNIHndpyOrkoyaSQ16UL0GbQp1Go6xFhl9AxI1R8
	V0ZMpc+EH4CvIpm3Wttgica3+rbQOiS9AQsEuS1rbrcr31DZ0nt9VrB+bmaE=
X-Received: by 2002:a05:690c:38b:b0:5ff:529c:504d with SMTP id bh11-20020a05690c038b00b005ff529c504dmr1236639ywb.79.1705430021693;
        Tue, 16 Jan 2024 10:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc++qjoX9+huuWU6/NpDkmXEUsOis3ggKPAVlpqTbgz16EtjCmi6t0RwzJCBocLX9FFxZVQ5Zt/zYiyEFic64=
X-Received: by 2002:a05:690c:38b:b0:5ff:529c:504d with SMTP id
 bh11-20020a05690c038b00b005ff529c504dmr1236625ywb.79.1705430021375; Tue, 16
 Jan 2024 10:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-10-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-10-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jan 2024 19:33:05 +0100
Message-ID: <CAJaqyWdf5PiDc=WdHXQ485eDA_D00ER3v9rqw9j7XWGggz_Nrg@mail.gmail.com>
Subject: Re: [RFC V1 09/13] vdpa_sim: reset must not run
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
> vdpasim_do_reset sets running to true, which is wrong, as it allows
> vdpasim_kick_vq to post work requests before the device has been
> configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
> is set.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Good catch, thanks! Please send this separately so it can be merged
independently.

Also, the Fixes tag is missing, isn't it?

Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index be2925d0d283..6304cb0b4770 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim,=
 u32 flags)
>                 }
>         }
>
> -       vdpasim->running =3D true;
> +       vdpasim->running =3D false;
>         spin_unlock(&vdpasim->iommu_lock);
>
>         vdpasim->features =3D 0;
> @@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vd=
pa, u8 status)
>
>         mutex_lock(&vdpasim->mutex);
>         vdpasim->status =3D status;
> +       vdpasim->running =3D (status & VIRTIO_CONFIG_S_FEATURES_OK) !=3D =
0;
>         mutex_unlock(&vdpasim->mutex);
>  }
>
> --
> 2.39.3
>


