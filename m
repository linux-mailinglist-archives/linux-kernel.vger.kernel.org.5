Return-Path: <linux-kernel+bounces-98591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37881877C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FC7B21015
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313BA182A1;
	Mon, 11 Mar 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfrQxIV6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9117BD9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148500; cv=none; b=sAyeu79p2R/AMxcL1VGBGfbXM/r+Z3U8Ix/fcIE0aPp33s3ux1hskHpr0HpZ8Q+8o6UZj0OeCSkNDg5HL9aAjHXoYfav/GIMxJdmeJgk0Z2/pdYsnFpjQN9U9YqVMk9sQz3wktHO8/nRcM6VJ8L01H98ca5jZ66B+ua1iNL0kdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148500; c=relaxed/simple;
	bh=dTmP7n59FaCUQQ3ImK3x9jf1hCqcfHxKJ2ZB9x5NqCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAkyDsNDvL7phQZrO03D2NZg1x3R1Z9zNFnfgodSWoRjgL4gxMz3s8iAUqraRV3NsKRzyplS6nJmq4K/xBfalIlkdKTsc9b2Q8fUNazBACYHTezLNgq7jcWEnyO/womeR73iw4uY00cCSYaX7OUaTczQoYE16e0IlM3lrCY0QDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfrQxIV6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710148497;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k643lTHeRSqr4QYf+RtUFasbXAmnhk9kZSa7ujrmtgQ=;
	b=BfrQxIV6nxtbCHttEkuCPaG3AUuI6wiKCZRp6fWzDTmGfBjq0IQVWKXRORRWeKUEFoQCCA
	QKUoYA9qBfgrV1JPb16oIP3upsAtS3WlfZNOcDIexBAF/IbB9jYLJxFEqpP4F26QAQENu3
	U6kIGRFNVIRgexg5xQf5K8DEu3XXzDE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-tGPwdM0uOt203koiR2ddqA-1; Mon, 11 Mar 2024 05:14:54 -0400
X-MC-Unique: tGPwdM0uOt203koiR2ddqA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33e6d36db5dso2222614f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148493; x=1710753293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k643lTHeRSqr4QYf+RtUFasbXAmnhk9kZSa7ujrmtgQ=;
        b=S5v1Td7YVSBn9weBzwI2kKwjrqFs1we81EWM8gD7OZbfuiRuuH/+hLxVGUQptbKbCX
         hJf2RrIM9VhMXx5D3C02fFE1hLVUhWo8bEgCo+Ood/V1nJOsY+MAujwLBQvW1z+7xQmD
         6qe2ovlpsGBKvVd4vVgGTT95NEWdPkKI/aMxCV3Pr+NtnRgqsiJu4ZXzbJCTC9U1E5cX
         gl86rNtL66RjT5U4Rdt7ApE00bp8uRYrV/7h01wJAHHQ0wXTnXZxHtbflSo3uvGVEn/5
         pOg49iM7K58GTf7pKC0Z8XpYq39wqN4YUoibE74m/7eEKLDrkhShz0YQciOJFIJiK1/M
         pgjg==
X-Forwarded-Encrypted: i=1; AJvYcCWDnufOIqkXP8wp4WR0/PgXmWeyEgMqV68PLHv3cHMjiFSs0liujHbVCgVevnxag9TSFNURnPMyU9FK97q38GKK/S4oFLbGORMhb2+4
X-Gm-Message-State: AOJu0YynshEKBpcARy4z7FkMDMIq/sE/OBFApeRFtYrWhihauLIihlR9
	iAiKBQyBqg1BxeJChQSgowEnpnsPleqnGEfKjVHW8gFnecakGiB+4/y4ebQ+rqIQ1z1Ad8MB/+x
	l3HB89ndjjjIuc7UwnX6lqD4LIR4SsNFZ2okPnWw+gxxNt0rfOdyqrYMynUT9QA==
X-Received: by 2002:a05:600c:3ac9:b0:413:2ab0:8305 with SMTP id d9-20020a05600c3ac900b004132ab08305mr974920wms.13.1710148493516;
        Mon, 11 Mar 2024 02:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrobxE7nSHH4f78nQxa+KpCMwCWrli005wc4GIi67hGLEZz82HkSrLQfxBBbBqOHWRKOZGFQ==
X-Received: by 2002:a05:600c:3ac9:b0:413:2ab0:8305 with SMTP id d9-20020a05600c3ac900b004132ab08305mr974909wms.13.1710148493278;
        Mon, 11 Mar 2024 02:14:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm14934328wmq.21.2024.03.11.02.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:14:52 -0700 (PDT)
Message-ID: <e14204f8-5c25-4130-952b-d5a31edc015f@redhat.com>
Date: Mon, 11 Mar 2024 10:14:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 3/7] vfio: Introduce interface to flush virqfd inject
 workqueue
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, clg@redhat.com, reinette.chatre@intel.com,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com
References: <20240308230557.805580-1-alex.williamson@redhat.com>
 <20240308230557.805580-4-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240308230557.805580-4-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/9/24 00:05, Alex Williamson wrote:
> In order to synchronize changes that can affect the thread callback,
> introduce an interface to force a flush of the inject workqueue.  The
> irqfd pointer is only valid under spinlock, but the workqueue cannot
> be flushed under spinlock.  Therefore the flush work for the irqfd is
> queued under spinlock.  The vfio_irqfd_cleanup_wq workqueue is re-used
> for queuing this work such that flushing the workqueue is also ordered
> relative to shutdown.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/virqfd.c | 21 +++++++++++++++++++++
>  include/linux/vfio.h  |  2 ++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
> index 29c564b7a6e1..532269133801 100644
> --- a/drivers/vfio/virqfd.c
> +++ b/drivers/vfio/virqfd.c
> @@ -101,6 +101,13 @@ static void virqfd_inject(struct work_struct *work)
>  		virqfd->thread(virqfd->opaque, virqfd->data);
>  }
>  
> +static void virqfd_flush_inject(struct work_struct *work)
> +{
> +	struct virqfd *virqfd = container_of(work, struct virqfd, flush_inject);
> +
> +	flush_work(&virqfd->inject);
> +}
> +
>  int vfio_virqfd_enable(void *opaque,
>  		       int (*handler)(void *, void *),
>  		       void (*thread)(void *, void *),
> @@ -124,6 +131,7 @@ int vfio_virqfd_enable(void *opaque,
>  
>  	INIT_WORK(&virqfd->shutdown, virqfd_shutdown);
>  	INIT_WORK(&virqfd->inject, virqfd_inject);
> +	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
>  
>  	irqfd = fdget(fd);
>  	if (!irqfd.file) {
> @@ -213,3 +221,16 @@ void vfio_virqfd_disable(struct virqfd **pvirqfd)
>  	flush_workqueue(vfio_irqfd_cleanup_wq);
>  }
>  EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
> +
> +void vfio_virqfd_flush_thread(struct virqfd **pvirqfd)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&virqfd_lock, flags);
> +	if (*pvirqfd && (*pvirqfd)->thread)
> +		queue_work(vfio_irqfd_cleanup_wq, &(*pvirqfd)->flush_inject);
> +	spin_unlock_irqrestore(&virqfd_lock, flags);
> +
> +	flush_workqueue(vfio_irqfd_cleanup_wq);
> +}
> +EXPORT_SYMBOL_GPL(vfio_virqfd_flush_thread);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 89b265bc6ec3..8b1a29820409 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -356,6 +356,7 @@ struct virqfd {
>  	wait_queue_entry_t		wait;
>  	poll_table		pt;
>  	struct work_struct	shutdown;
> +	struct work_struct	flush_inject;
>  	struct virqfd		**pvirqfd;
>  };
>  
> @@ -363,5 +364,6 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
>  		       void (*thread)(void *, void *), void *data,
>  		       struct virqfd **pvirqfd, int fd);
>  void vfio_virqfd_disable(struct virqfd **pvirqfd);
> +void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
>  
>  #endif /* VFIO_H */


