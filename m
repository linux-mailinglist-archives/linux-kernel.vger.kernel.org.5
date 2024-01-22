Return-Path: <linux-kernel+bounces-32726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56E835F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E211F212F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707073A1B4;
	Mon, 22 Jan 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0yEfhLN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B783A1A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918922; cv=none; b=jVGwNmVC3GbIcdLZ2J9g/xJ4T07Q4yzD2yZuXa+2M3UYukKhSjkBzOXoey+mQB0NcCRF/rRv0+hfpNal+bOEI8tflcue8xpJ6myQE4s0XFcm2htYhOivO6U7rfFcC7lX/kKHV0uW65yAL6zRS8N7hyDrr9y2BOEKhDcvirCo5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918922; c=relaxed/simple;
	bh=bWDVLHiEXkota/aGMAny+2TNqX/Ql+/MLRYCOPs96YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwnZCy7OWQmbf4wM8JSB9bRM+dypOJ0IHCJxXE4RawUbyCNN9P6YFl/MtqZ+ycgwY8gvMxVqz+OrXXMPENFi2b/xi57gTvgK2VAo1wXzgpjQjOaFCp5dCJuJd/F6OZHltdhQQXl9tC4qSbAzlTAzZH3oWCarwe+nVislIpMIzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0yEfhLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705918920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwPGvN028Z5tPxDaLaEbu18L6ma6HHW3iDZUupdgZD0=;
	b=D0yEfhLNmLkIS9pBhAHV+zHFwoUqQbOMl7zs1YyVLrXdlibNSABMVKluFgr0UUoD6DtENw
	h/BX/GBYKSKoy1MiaBjk+pZTSBev0gh2cDuvukmuxGuVCre0L7j62UDg9JJF/mtYVSQCop
	1vBZpFbbUVB4Geuf1YLVRn0X0TktxrY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-DYLsgKJTOfaY0mAXqRBldQ-1; Mon, 22 Jan 2024 05:21:55 -0500
X-MC-Unique: DYLsgKJTOfaY0mAXqRBldQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e7ddf4dacso2133782e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918913; x=1706523713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwPGvN028Z5tPxDaLaEbu18L6ma6HHW3iDZUupdgZD0=;
        b=j7EcRTi7Xr2jfOU10IWyTV2S+QJJVoH1yfA1WJH4yJtj5dkGOs/6HDaznEFauqsrzH
         bRLB24F2k9ssb69q/mntg19BmoRzvKFi4ArkDttzwbrHXxiUcq8sBLeXuBxYoBDjxnwI
         F/C5TVpqqwor3fP54Tymk1EpEPtYBIlTnopJnpFhWrJsgiWYtcPcVlg7QoBQN6ZCyNZB
         6XxXToS3Wu4eYpzZYKHRr6ruiBDTVZrfdIHf7fTYfNMhdVl858JUXisfv2iwr/gxqYHL
         9bUFHbbZBIVYAaMk85M0y42+AtO7QEbKJZ/bzuevvp/E/g7ywH6e7n7OmkZ9uyCccRVb
         qt6A==
X-Gm-Message-State: AOJu0YzXY2OpvbypUlarXhRjW7+fvuyNIBKak+Ragg5s3YFq/C6rwN94
	P0v9JLGe+JxtPY3Z7RXayv0bycRIuoiaQtlFaqiNAXnKodVZiqpsnbLUNWhSTkg37DSxmciY9JV
	MDt0Zq3vrFys4t6Z0NCLEdnOKFX5YPXtiewVyEGrACCNswhCPOFSCVvQa+1345A==
X-Received: by 2002:ac2:5ff0:0:b0:50e:efc4:a318 with SMTP id s16-20020ac25ff0000000b0050eefc4a318mr1261143lfg.64.1705918913697;
        Mon, 22 Jan 2024 02:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi1995SJjifeXa2VfBTVYgXMiN3lDe07cDVtgpWOi5nt1c/FA3p+x4EsTfhyhrn/vLVrIFhw==
X-Received: by 2002:ac2:5ff0:0:b0:50e:efc4:a318 with SMTP id s16-20020ac25ff0000000b0050eefc4a318mr1261135lfg.64.1705918913380;
        Mon, 22 Jan 2024 02:21:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-71.business.telecomitalia.it. [87.12.25.71])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7d449000000b0055a898c3156sm2930603edr.11.2024.01.22.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:21:52 -0800 (PST)
Date: Mon, 22 Jan 2024 11:21:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
Message-ID: <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>

On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
>vdpasim_do_reset sets running to true, which is wrong, as it allows
>vdpasim_kick_vq to post work requests before the device has been
>configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
>is set.
>
>Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index be2925d0d283..6304cb0b4770 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
> 		}
> 	}
>
>-	vdpasim->running = true;
>+	vdpasim->running = false;
> 	spin_unlock(&vdpasim->iommu_lock);
>
> 	vdpasim->features = 0;
>@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>
> 	mutex_lock(&vdpasim->mutex);
> 	vdpasim->status = status;
>+	vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
> 	mutex_unlock(&vdpasim->mutex);

Should we do something similar also in vdpasim_resume() ?

I mean something like this:

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..55e4633d5442 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
         int i;

         mutex_lock(&vdpasim->mutex);
-       vdpasim->running = true;
+       vdpasim->running = (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;

         if (vdpasim->pending_kick) {
                 /* Process pending descriptors */

Thanks,
Stefano


