Return-Path: <linux-kernel+bounces-32801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC6836033
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981961C23B36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD73A8C3;
	Mon, 22 Jan 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLtYIdOX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635E3A8C0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921180; cv=none; b=UrVZ0rBO2VWQc+dI48mz9hTTrAxu1RD6n2Q2skb8iu8EnYkHN7LJCnsJPZ/yxuibmFHCu6PH3D/752wb7/4XP6u0RhKw5k5cO5fzi0bEuLfg3aMGD+bJ/AkAa+EnX0WnTh62uyG0zGFDlIBj3Gra17iIMJoNDqkS4AXBT+8rFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921180; c=relaxed/simple;
	bh=H8+0oGmT1ftop5dzo+lYC9GZSMNQe7I0qgI7wewaGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuKN0MSBM6ylS32LRYZbRYyDy0LJQ/LNZe4sBO3Xi7Lu6nVHUqM1azowpQAcHi3RVmECVmg8Jj5oyRftSVYmzqdBP9gEhW6gScil37MOszKD2BgY1NdtUZ/OuVsc+A7Z4B6b/kuxLm+jXNLX0POnQF+rSMeWJwwKspG+us5kKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLtYIdOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705921177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+Tgm+6aEKjbLWAfLwkUUYO3Q2T3Jk0qphDX8va9Dlw=;
	b=NLtYIdOX8i1N80DKh0CJN+UfEVJURMKhNt5ZIKGvJxnJf+MT9fPDvf2vqiLD51vSDklkZE
	NYtQY7PSE/Qt0t/iyV7+7CHCk68kIYD5APZqyqgqplJUbehbpHDsCJcmDn1AwT+81MNt/D
	NHHfRdVs7S6ONV4v9ynrnluQDdazEL8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Eya3RBelPqeGUq8My9ZFfg-1; Mon, 22 Jan 2024 05:59:36 -0500
X-MC-Unique: Eya3RBelPqeGUq8My9ZFfg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-429d02a63baso46424971cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921175; x=1706525975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+Tgm+6aEKjbLWAfLwkUUYO3Q2T3Jk0qphDX8va9Dlw=;
        b=vqwlxpZdORAOcjRdHkNyq6WwfFnH971lJhbkhKs5/nPbX61ivr3AJvgCK3Xu4jVLDJ
         lErkd9x5wFfYX4zgyhhkrDJ5Cy8wW6bU01Pru7bD2h6MtOyNuhWAlsjEbGCZAFU6voOl
         qlGYKV+axgBlruQNi4OmehgutMpQOxKO4kYOqTJtPmCUZxVjfbWY37zpTfRv6pgusAuW
         IzTwHEa4HHR0Le04I2NB6R+upFQ4D4diYDe0kY4tqHniQ60jjJIjHUHRi81xAjoy7+yk
         HyE8vk9XMTXsTlSa4/San7Zw8+os4MYgcnkTgM8/7LB5tKkJqP8H4s8PKC7SnGk6eWus
         6w6A==
X-Gm-Message-State: AOJu0YzapP2LOT1h/PrKaBnyotEkWE0b+k8Cxf5aHbSXAnEldkZLJpb3
	tAteOGCf4L6L787SY4oM6ylycevRivcZdu0DOR6TtBhAHTg18hUYnLcr2O9zxf5sIMztSI8hBiL
	7K/nX4Cu5i4A6aj3dRH9lrApDw61ZdGYqQe4a3WjesEk3ffIh+ijgbxNEOQ7atw==
X-Received: by 2002:a0c:ca04:0:b0:685:d875:53ec with SMTP id c4-20020a0cca04000000b00685d87553ecmr3829484qvk.37.1705921175672;
        Mon, 22 Jan 2024 02:59:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQcdIroMe5Yc7Wgv1xTWcJhJLG24bKFVRn4maOUP+8QsosKBW1phA6nNLXjDSDlDYtS+9BMA==
X-Received: by 2002:a0c:ca04:0:b0:685:d875:53ec with SMTP id c4-20020a0cca04000000b00685d87553ecmr3829475qvk.37.1705921175397;
        Mon, 22 Jan 2024 02:59:35 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-71.business.telecomitalia.it. [87.12.25.71])
        by smtp.gmail.com with ESMTPSA id lb25-20020a056214319900b00685ba831e4bsm2035991qvb.118.2024.01.22.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:59:35 -0800 (PST)
Date: Mon, 22 Jan 2024 11:59:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: Re: [PATCH V1] vdpa_sim: reset must not run
Message-ID: <ouq2ntygn4i7gtld5utumipzggcakbqhu2hc5lbznoddhvezkk@jstz4h3vovej>
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
 <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
 <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>

On Mon, Jan 22, 2024 at 11:47:22AM +0100, Eugenio Perez Martin wrote:
>On Mon, Jan 22, 2024 at 11:22 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
>> >vdpasim_do_reset sets running to true, which is wrong, as it allows
>> >vdpasim_kick_vq to post work requests before the device has been
>> >configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
>> >is set.
>> >
>> >Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
>> >Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> >Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>> >---
>> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>> > 1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >index be2925d0d283..6304cb0b4770 100644
>> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
>> >               }
>> >       }
>> >
>> >-      vdpasim->running = true;
>> >+      vdpasim->running = false;
>> >       spin_unlock(&vdpasim->iommu_lock);
>> >
>> >       vdpasim->features = 0;
>> >@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>> >
>> >       mutex_lock(&vdpasim->mutex);
>> >       vdpasim->status = status;
>> >+      vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
>> >       mutex_unlock(&vdpasim->mutex);
>>
>> Should we do something similar also in vdpasim_resume() ?
>>
>> I mean something like this:
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index be2925d0d283..55e4633d5442 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>>          int i;
>>
>>          mutex_lock(&vdpasim->mutex);
>> -       vdpasim->running = true;
>> +       vdpasim->running = (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
>>
>>          if (vdpasim->pending_kick) {
>>                  /* Process pending descriptors */
>>
>> Thanks,
>> Stefano
>>
>
>The suspend and resume operation should not be called before
>DRIVER_OK, so maybe we should add that protection at
>drivers/vhost/vdpa.c actually?

Yeah, I think so!

Anyway, IMHO we should at least return an error in vdpa_sim if 
vdpasim_suspend/resume are called before DRIVER_OK (in another patch of 
course).

Stefano


