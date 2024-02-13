Return-Path: <linux-kernel+bounces-63869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2ED8535B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2035E1F23AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231795F845;
	Tue, 13 Feb 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVdQOYNB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2B5F467
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840696; cv=none; b=r7bvZifQsefXpZhJXi0n7ZeiryRcHm4PrRRGiAZYm7L2hdKF7x1FrA58VSpt6SW4ku6N8bjGh5/WHYGN2JOEJTgsLCAsuExZ4lucmRiDplMxLJt6M9P3wxGwzIrLpJP2uNkYbC5L47QpUsdEvoK1ZRQDU04cyedAG4i3vIvHjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840696; c=relaxed/simple;
	bh=VoOeDgSa64KkhnhvOm5mPt1ULNJKW9NflDqchznUV1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqG/f8xSuX40XtHCyo1oNInXpKo2TSBncuGGY9HQEE1m17TXkgwgusYT/IrgfH95VXhlY3ofw4sP7wDtxkHl1kP199xssrfRAG+QQfT6y1Wsatrha0MXthDFlU7nEb1w55Rwbc/Qp+pzMdc6ZvGeiYKWBV2y9yEjyvAguewyESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVdQOYNB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707840693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOO48zwMIpqvH6d2VO+rX4+pzNniWF/xW4lFJmdRjuY=;
	b=TVdQOYNB/4R9c0PcDz4mjanHa3fVxWfX0pXyDkZDcLBOPNZSi2pZWTIhOjkHtzeDSejLRn
	JDdXBydl5+aaVSRtfFPuXWZoKCkmFNEzl7OHvteBjZRQyFp2sY1TVVKMCrvgvb5nYDKMFa
	FRSphkYvXQcoD3a0XNjO8naDnI1LlHk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-6uMDil7CMYy-USxQL4TiJA-1; Tue, 13 Feb 2024 11:11:31 -0500
X-MC-Unique: 6uMDil7CMYy-USxQL4TiJA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6077f931442so17408557b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840691; x=1708445491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOO48zwMIpqvH6d2VO+rX4+pzNniWF/xW4lFJmdRjuY=;
        b=RhNj1koPVXldiV9zFebK0TlRNWy/IKpM03V6DczKHOlEDYLQX67NMNq9pM/fVip2/v
         V1fdFwSjaJj+kpT+hnGsEqQxwF9DSQDzqSkaRpbULH/twWCbu03g+LY5vWs9FPOLKlfr
         B4F9V6SXTm5VMQtk5URzA8qSn9z58RSg0AHRGkS+jx/vjyGT5wuhaVW/0CaIs3JrXGsa
         dIrFr+qP/wMGgjEkvDY+35bNEpZCiFroHB20MNaVKCGIVAXrKjLSDzNnDLPTmxXT8/iO
         xBbUnlVsjmjHa6fn4ABKdCVEntRH9FOMulNi8cQoi7iXL752idsH3D0bXmWxwWa735w6
         zFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDdRwuG02Aio9T81xZl+iUAP+5rM8VVVu83D8eREFMX+pGXeBr7xt1hKYn3zkTLgT9JoLoHYM7kw4WwC1Ada0eMFSXOLjcU/uQ5R5E
X-Gm-Message-State: AOJu0Yz5xrAsEtWrjW2Hbvjws+O6y2pdnRKvN7+PFQUGt7svWH2CjvtX
	B5QBH7rSk9F23WVXafjs+ehDKBjuS9PxtmuPIPX0dLZ7X9sExE9/mcVill2LyYowGIjgHdssSap
	OXz7mxmrOCFMWls8lRo1ECxT9AgVIg9m15s4n0DCnInhNRMSFZsXk7DV0xMFkO+1KE2anFse2Zo
	48uIXk/h9HuS6VmiCe/rRHjHAKYYac8MRhluWp
X-Received: by 2002:a25:bd6:0:b0:dcc:9dcc:a433 with SMTP id 205-20020a250bd6000000b00dcc9dcca433mr1677715ybl.54.1707840690929;
        Tue, 13 Feb 2024 08:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtEOPL7MgovsHCMvEwZ4Qv6yCwv5MrDUiGRYjX+jOxtdnpt5umBWg0M4QrhM0gY/KgJHeUZZAxtThzuTs6nnQ=
X-Received: by 2002:a25:bd6:0:b0:dcc:9dcc:a433 with SMTP id
 205-20020a250bd6000000b00dcc9dcca433mr1677699ybl.54.1707840690691; Tue, 13
 Feb 2024 08:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com> <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 17:10:54 +0100
Message-ID: <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Flush to guarantee no workers are running when suspend returns.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index be2925d0d283..a662b90357c3 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpas=
im *vdpasim,
>         kthread_flush_work(work);
>  }
>
> +static void flush_work_fn(struct kthread_work *work) {}
> +
> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
> +{
> +       struct kthread_work work;
> +
> +       kthread_init_work(&work, flush_work_fn);

If the work is already queued, doesn't it break the linked list
because of the memset in kthread_init_work?

> +       kthread_queue_work(vdpasim->worker, &work);
> +       kthread_flush_work(&work);
> +}
> +
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
>         return container_of(vdpa, struct vdpasim, vdpa);
> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         vdpasim->running =3D false;
>         mutex_unlock(&vdpasim->mutex);
>
> +       vdpasim_flush_work(vdpasim);

Do we need to protect the case where vdpasim_kick_vq and
vdpasim_suspend are called "at the same time"? Correct userland should
not be doing it but buggy or mailious could be. Just calling
vdpasim_flush_work with the mutex acquired would solve the issue,
doesn't it?

Thanks!

> +
>         return 0;
>  }
>
> --
> 2.39.3
>


