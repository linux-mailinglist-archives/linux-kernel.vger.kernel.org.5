Return-Path: <linux-kernel+bounces-27722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00682F4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD3528538D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499571D548;
	Tue, 16 Jan 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnh5b9lJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B91D545
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431519; cv=none; b=fPLP4yV5fbQQS+KZ1FM5ZXzJaiW8/FWXNK8CpCslrIdrSVXzNImiVHSpiy84nN0MYIaeJ+wX1eMasFRM+h/rwbruT8kF607jIQARdX+NGhPevTJ7lAnCVlDqB8a/HsGOReN8oqkR1hO4dBdMVd+S4gg2jG9AiNm3Zn/feYBjMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431519; c=relaxed/simple;
	bh=Sh+VUyorUwfwt3DtfokrDMEMXGc/bg5xuZ8tbxNpivs=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=IClnlg6O96n9B8TRuowGr4gLEfrHvqWa0QwSa5jyTbNugU5vS7b9hklWPfsPdKh1NF43NSU/25Xfb5BA54RmD6yvFQpw5I83WhS6FbsaMM6wFr2a8jQElXkAELLGRiPLAN80VWP91MMwzN3YMcmFFGDQqqNB7Mod0LjrmV+r/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hnh5b9lJ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705431516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGtxsaBcIsbwgFk8xTkmWG+OKYIfaAELOe769Qye7L0=;
	b=Hnh5b9lJ4yJevc8/Hgt8DRorItP0gegf29xgGgh/8UJo2dR1ILH4ovroAUirOXmV4wprRw
	QPR4uwpYLXU8yrLeO4zAo9C3vxQ8AGtdxwmzaSehnh+kv3WgYmLkx1lUAPyEHEcHSrI2Mk
	nE6Htz37Se1DceJ/TuXXr+aoONTKQcI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-c_qwqBxlPbGj40TnpBCD4A-1; Tue, 16 Jan 2024 13:58:32 -0500
X-MC-Unique: c_qwqBxlPbGj40TnpBCD4A-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5e617562a65so183024737b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431512; x=1706036312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGtxsaBcIsbwgFk8xTkmWG+OKYIfaAELOe769Qye7L0=;
        b=W4vNzKAMXkq2HDOzUiEmA20f9MkO98Kw9VoaV1Yoq9h5EojbtvKHlqOiGBzJ0pw3bw
         iBvR4nDzWyoBx5LcZtcr/EVwFqMxYy8ZzypsuEfbwVq4jUrpP+QFrD7UAuKQr5bCCEGw
         qpnyw+65FmRWZ2D840EHLaZLq0zOpNcP5Wf8m1MxM56Ci9QXtYqe56+H6L86MQNJqrpI
         7o1VI4PlVbqVlmFZiYSYG3/aq8M5S6CmrCakJUrLjihUis4DuiRgouzRHNPWiB5y8Lc0
         cncM/30xQTrRx3S8dBGGTwb/8uYnKnfBBeiWGnF1IBruTnxbEWbM8u+Q3g6W+3Xa9CI8
         Fxcg==
X-Gm-Message-State: AOJu0YyTS22Xgzrl3Rq5HVMzheJ/lzHO76lhWqO/mIx62SGZHgrB/ejz
	/TALzV+R3MFWZz14aEHMQXly5248TSA4OSaBHuaTUyNFpUwK2W6ET9F6/24rfIZT88afbgQxT+k
	7WWetUfHmv8T3y/yKx5QN6HWNW5CK5k57VJ2kZG+Akc+y/vwm
X-Received: by 2002:a81:e60c:0:b0:5f8:1f59:fd02 with SMTP id u12-20020a81e60c000000b005f81f59fd02mr5347973ywl.13.1705431512154;
        Tue, 16 Jan 2024 10:58:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2FPqlLgrZtRGp97ysG2vhyXsVT8O2mzxPiCpvhJ9h+PAjf/LwrYSrPudl/CHkL3IjaTeEoBHWECQld7EHMaw=
X-Received: by 2002:a81:e60c:0:b0:5f8:1f59:fd02 with SMTP id
 u12-20020a81e60c000000b005f81f59fd02mr5347964ywl.13.1705431511935; Tue, 16
 Jan 2024 10:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-11-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-11-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jan 2024 19:57:56 +0100
Message-ID: <CAJaqyWdTBexyY-ra=UkUfUU75YS2Zncm5-9iHv-0Rqa3_mD=9A@mail.gmail.com>
Subject: Re: [RFC V1 10/13] vdpa_sim: flush workers on suspend
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
> To pass ownership of a live vdpa device to a new process, the user
> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
> mm.  Flush workers in suspend to guarantee that no worker sees the new
> mm and old VA in between.
>

The worker should already be stopped by the end of the suspend ioctl,
so maybe we can consider this a fix?

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 6304cb0b4770..8734834983cb 100644
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
> +       kthread_queue_work(vdpasim->worker, &work);
> +       kthread_flush_work(&work);

Wouldn't it be better to cancel the work with kthread_cancel_work_sync here=
?

> +}
> +
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
>         return container_of(vdpa, struct vdpasim, vdpa);
> @@ -512,6 +523,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         vdpasim->running =3D false;
>         mutex_unlock(&vdpasim->mutex);
>
> +       vdpasim_flush_work(vdpasim);
> +
>         return 0;
>  }
>
> --
> 2.39.3
>


