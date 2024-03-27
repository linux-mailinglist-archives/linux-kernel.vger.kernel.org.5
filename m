Return-Path: <linux-kernel+bounces-120818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F35F88DE38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FC01C277C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144D137744;
	Wed, 27 Mar 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdKI/vtX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67903136E23
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541292; cv=none; b=Syk2gRoUWNAka5VlhSX3bPSgYPhJww1Bq+qGNP4vSwmJfKB6/zQtZo1lUlaB2MWnMu44JkGL3nXYUN0sN9qc2HtbJtoyUMCJ//N6JAJ6r2mDmbI9eiVxPZzxgBDr/EirWSr5WOWaxPKRugmcnO9P6OHyIacFuRPKp69t7JDkEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541292; c=relaxed/simple;
	bh=lKLG3UiaMdK6ulFJvlHav6o8D9DIxUzc0+qtoqM54VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu9rVwQ8LEhiT2lbM3yiPrbOqG/RlOJwVvPO/rCt6OYuGhHFmb+L63wVIzkjCt3DIL/3njV/aX7DoLD5G3nmD34wtfw7gEIZWKaMpcoj13EEQHdYKSTUiERnhAeAoFX4kWNjv/HCGQD8+7qxB8rtu07dsKWYEKcZwsCqXJFHuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdKI/vtX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711541289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bi+ZQnYSyNBVd43PK67DW5yA3+DYZIo1uqQGHuPLUr4=;
	b=gdKI/vtXNdsI3E7mAPUDDOPoD/GKcLdm8ZZz2lBq9UKwSD4W4T1pKmxTRIJuOXhL7f8b6O
	pHz9634JY7Ulwt8y0J5lnnqk+XLNy+4a1PKjy52+dwFkjnH1/BT/HM1UGmnTBQr9ZDWyj/
	+x00QlbGWNlHTM//2AV/zzE2kHL4x1s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-7GoXqCoIOHemIBzDgUYfWQ-1; Wed, 27 Mar 2024 08:08:08 -0400
X-MC-Unique: 7GoXqCoIOHemIBzDgUYfWQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4148a697e35so13057175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711541287; x=1712146087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi+ZQnYSyNBVd43PK67DW5yA3+DYZIo1uqQGHuPLUr4=;
        b=B/+dC2ff7Zf/U//UVo+rljKp610JMXmUgPDu2no6SArV+OICnDV743DODHJS7Yt9rE
         tiLVvZFfVS35fvN2E4iN1sBtgg1badmwjdj5Ovy4N3xwwe+CWMcLILhrr7wppTF49isN
         3ZNMhsCZLP8KVOi8SLyZFPmyxGCUhY4Pz/e/sL4oLkAiv1vqg79HcQmY0sCPrOt+5t/5
         jhLunx9Vb5anMnlJmaitd9wnptDSNR3FgPYQzF4gkSTCULGssDSZS9TzawAj4F0phPIu
         Y8Ibp7b9kn3JeXe8gsHKeCYyoq8xaYFY67TYGrKGGpVTCM0ptswNfmjXO9y7M/cp8lof
         Mmbw==
X-Forwarded-Encrypted: i=1; AJvYcCVW8BPYm7aANJOQKKEgNnlm5BE4diog6X+evq46H47oJi2LIiXRj1wtTFXkaZz4iu4638DlGXkQHQxv0iZa7V83VP7BND/zxLBoIXWB
X-Gm-Message-State: AOJu0YxKi2n6xsUTCky4XObvWMfRACYGrWObpPXTp9K2jEjOE5p2Pllg
	uf0Gggf/4Mk/KU04cL7LspISOPeLVCkjQuYmImvgHJfc6XXLDFBmJp457tyEI3pcH2SakJllHx0
	qe11kJlfCwV79efLmwDbJ18im8ngbAUZcwuj+gWahCybNCEgAAErEvjRtBZp33Q==
X-Received: by 2002:a05:600c:5716:b0:413:f7c4:f4fc with SMTP id jv22-20020a05600c571600b00413f7c4f4fcmr1708273wmb.15.1711541286787;
        Wed, 27 Mar 2024 05:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrGIPFjXov8faB+sPfLv/7odN1taQWiMTqh1DDC2SOAY/ynb3YOFq7GV+r4op9aeSbHg+BTA==
X-Received: by 2002:a05:600c:5716:b0:413:f7c4:f4fc with SMTP id jv22-20020a05600c571600b00413f7c4f4fcmr1708253wmb.15.1711541286235;
        Wed, 27 Mar 2024 05:08:06 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b00414928360bbsm2000995wmp.6.2024.03.27.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:08:05 -0700 (PDT)
Date: Wed, 27 Mar 2024 08:07:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, davem@davemloft.net, stefanha@redhat.com,
	sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Message-ID: <20240327075940-mutt-send-email-mst@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-2-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326233846.1086253-2-gshan@redhat.com>

On Wed, Mar 27, 2024 at 09:38:45AM +1000, Gavin Shan wrote:
> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> available ring entries pushed by guest can be observed by vhost
> in time, leading to stale available ring entries fetched by vhost
> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> grace-hopper (ARM64) platform.
> 
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>   -accel kvm -machine virt,gic-version=host -cpu host          \
>   -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>   -m 4096M,slots=16,maxmem=64G                                 \
>   -object memory-backend-ram,id=mem0,size=4096M                \
>    :                                                           \
>   -netdev tap,id=vnet0,vhost=true                              \
>   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>    :
>   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>   virtio_net virtio0: output.0:id 100 is not a head!
> 
> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> should be safe until vq->avail_idx is changed by commit 275bf960ac697
> ("vhost: better detection of available buffers").
> 
> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
> Cc: <stable@kernel.org> # v4.11+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..00445ab172b3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	r = vhost_get_avail_idx(vq, &avail_idx);
>  	if (unlikely(r))
>  		return false;
> +
>  	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> +	if (vq->avail_idx != vq->last_avail_idx) {
> +		/* Similar to what's done in vhost_get_vq_desc(), we need
> +		 * to ensure the available ring entries have been exposed
> +		 * by guest.
> +		 */

A slightly clearer comment:

/* Since we have updated avail_idx, the following call to
 * vhost_get_vq_desc will read available ring entries.
 * Make sure that read happens after the avail_idx read.
 */

Pls repost with that, and I will apply.

Also add suggested-by for will.


> +		smp_rmb();
> +		return false;
> +	}
>  
> -	return vq->avail_idx == vq->last_avail_idx;
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);

As a follow-up patch, we should clean out code duplication that
accumulated with 3 places reading avail idx in essentially
the same way - this duplication is what causes the mess in
the 1st place.






> -- 
> 2.44.0


