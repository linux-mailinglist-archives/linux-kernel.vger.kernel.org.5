Return-Path: <linux-kernel+bounces-122716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FEB88FBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217B91C2B176
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E19F657A3;
	Thu, 28 Mar 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbHa/c5G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE941C62
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619308; cv=none; b=Ay8UiFJqt5VaXl2KclzvMiZc/2KVAm4zQN4uWTd5F2jGIUrOk9YDo3p8+0kAe4BcMP5CdDBCotsaQC4Gg2Dr8ECV9rakGA37lu2CTEIloyUufsrsuzZ9MrN/BKDvZPbMO66wJenvWhy1tUFOw/7Zy011L4fh9NwJKi2miYj9nsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619308; c=relaxed/simple;
	bh=9vnJI+0gpz+i/GYyu2HPCOAIRPNpTxit1kEdQXpnsP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTxA3e+cFTEgq8Z0kqzlz6H4215+Z/tQnkW3qNSVu30dd8Pmw+RoVoYE2QJUC4WSmlzAM8OmSw5dI2rPD486K+vpOQPLy7F0w7Dd81t0mGhJnrST0GdLBcnQzWukNk8qDiTCBob20SSmnKUyhAGh1Wg4vvBXVyuZqF3pTCK+QHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbHa/c5G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711619306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJEzAodsfnEL0K0FhCD5vo7II0EhJAX4+qdJjboZa+Y=;
	b=TbHa/c5GPWgM5fMt6EwT8SHwLUvQI1uE98XopdS2C8qAQzNptffeajOLtNmO23cBraKW13
	LgjIgucFcbYhFEEryM1ABbBRmbprh377vwtlN8COvi2ghKFp1HShVTP/mXgsx1wxQmGMUH
	uLdtM8z8m6f1YLOzuX5hy6NEU2RTQkE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-I_AMSvXFOBC0Lis4zCCnxQ-1; Thu, 28 Mar 2024 05:48:24 -0400
X-MC-Unique: I_AMSvXFOBC0Lis4zCCnxQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d6f7def478so6608081fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619303; x=1712224103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJEzAodsfnEL0K0FhCD5vo7II0EhJAX4+qdJjboZa+Y=;
        b=CfE8owiLQXbGDYGD3mbdUSGm3g+xoEKMW3sJxM59wXZ4nkc5IB2S/SQcz3BsJhDVD+
         5xuo7IrJtwoMSc/UTLwV6drKRerG/XavzFX0WN2XrdED3AaJCFoMJwPzrcrg6JRtAYjH
         wf+Xq38tNOLvthrPFI875KlXSc4YJ/w6tnV27H6XnDQkQ25W1BwEa7EQ1RjZbeDQbIaZ
         amstVXXixwNR0uZmxWNKTfR5asvwR7jLnE5UU97vWw9x+bo3Clx7Fzwr8e71iv1Cn4g2
         X9LJ8mWZd9ksc/2OWa49xx8YKVfn1Xhi0kmX1aFKwKm7DzOygDDvD1qVOIsOqWy5oHaA
         a+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ncn1lrkTkD3nkRykI11XzbSuO66+x42tZd5QzGTvUmmEzun4dtQ4pORF/SIUuOgaWuXPt1tgFBPEGUGTwIXjRNHy5t2DUysLC5ZR
X-Gm-Message-State: AOJu0YzlLYVMD0IwzP0cvnPP3IStXV3wg3qQyU3nxvUpO69ZT96fmild
	/KrAmwS3w1jUP6Wvvowr8FQujo/2AYF2HCX7cF8tw6LKI5BMv0du1UV4gRNMcNFT8AkXlHiM/MQ
	WrF94WT0dAVhVKDEV678xzxrAhqksfXsfxnhhXK5Nokzw1nn+nazJkiEHfxaZCA==
X-Received: by 2002:a2e:3005:0:b0:2d4:a8cf:e798 with SMTP id w5-20020a2e3005000000b002d4a8cfe798mr2029991ljw.14.1711619303295;
        Thu, 28 Mar 2024 02:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlr8XFRSqwaakS5+LO2iJaNYyntFn/LVoEhKaEqAKjIjW0cL05vZPccbrBZ3Q4IxQ5b5nPZA==
X-Received: by 2002:a2e:3005:0:b0:2d4:a8cf:e798 with SMTP id w5-20020a2e3005000000b002d4a8cfe798mr2029979ljw.14.1711619302927;
        Thu, 28 Mar 2024 02:48:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id fm26-20020a05600c0c1a00b0041547fef66dsm871554wmb.15.2024.03.28.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:48:22 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:48:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, will@kernel.org, davem@davemloft.net, 
	stefanha@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 2/3] vhost: Add smp_rmb() in vhost_enable_notify()
Message-ID: <yt64yc2lawevdw3ptgt4nkaqub5kzvh75ch2ertchcx7ubzmgw@k2mkbsfsjehy>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-3-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240328002149.1141302-3-gshan@redhat.com>

On Thu, Mar 28, 2024 at 10:21:48AM +1000, Gavin Shan wrote:
>A smp_rmb() has been missed in vhost_enable_notify(), inspired by
>Will. Otherwise, it's not ensured the available ring entries pushed
>by guest can be observed by vhost in time, leading to stale available
>ring entries fetched by vhost in vhost_get_vq_desc(), as reported by
>Yihuang Yu on NVidia's grace-hopper (ARM64) platform.
>
>  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>  -accel kvm -machine virt,gic-version=host -cpu host          \
>  -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>  -m 4096M,slots=16,maxmem=64G                                 \
>  -object memory-backend-ram,id=mem0,size=4096M                \
>   :                                                           \
>  -netdev tap,id=vnet0,vhost=true                              \
>  -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>   :
>  guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>  virtio_net virtio0: output.0:id 100 is not a head!
>
>Add the missed smp_rmb() in vhost_enable_notify(). When it returns true,
>it means there's still pending tx buffers. Since it might read indices,
>so it still can bypass the smp_rmb() in vhost_get_vq_desc(). Note that
>it should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
>("vhost: cache avail index in vhost_enable_notify()").
>
>Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
>Cc: <stable@kernel.org> # v5.18+
>Reported-by: Yihuang Yu <yihyu@redhat.com>
>Suggested-by: Will Deacon <will@kernel.org>
>Signed-off-by: Gavin Shan <gshan@redhat.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/vhost.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)

Thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 29df65b2ebf2..32686c79c41d 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2848,9 +2848,19 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> 		       &vq->avail->idx, r);
> 		return false;
> 	}
>+
> 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>+	if (vq->avail_idx != vq->last_avail_idx) {
>+		/* Since we have updated avail_idx, the following
>+		 * call to vhost_get_vq_desc() will read available
>+		 * ring entries. Make sure that read happens after
>+		 * the avail_idx read.
>+		 */
>+		smp_rmb();
>+		return true;
>+	}
>
>-	return vq->avail_idx != vq->last_avail_idx;
>+	return false;
> }
> EXPORT_SYMBOL_GPL(vhost_enable_notify);
>
>-- 
>2.44.0
>


