Return-Path: <linux-kernel+bounces-120126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386388D2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31531F3CD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB713E416;
	Tue, 26 Mar 2024 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SezgEI9o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B313E031
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494902; cv=none; b=uRay6kQUBB20FFQ6u+lrW7Q1Mjj2Y4trdAlTNJwLD9qbQBV9QWxnwn+kkegHWGZCHXoJZeLKWx7ZAgit9JYdajkDkQUMrj6S18emiy1FpeDLU7DVNv2Qvcv4Xw/W5rH5W8zcTl5M2+jf6/pT90l+BZduZMQCV+aMp4OKNV0S2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494902; c=relaxed/simple;
	bh=gSKaYFfv4cMNoB/Xn0Tfp61c93C2qN7CcfMYY8i+xOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEdjkPpxXvK7/h+PNpRsy4VfTkhQvOEXR1NO3zfTF19Kk35I1oGdpQDcPbmxnIMWeNMhGTjFUJgrp3OlqefZMXzIclblBO37P88FZWeu5e9NaeFYqt3wLHIx5OCb1sfvO91BUn/QTHFlXmFjiqde3YoquzMXO5rF0T1Egc4Y/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SezgEI9o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711494899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mQCN5HobjN2Q/dtCo4+7FNCVXz9DGDP5AkWFtGzZjc=;
	b=SezgEI9otM7MOqkq3QMijSGK9QdaTG3NiqSUoaudrF8U3o2/tea33GLGONoM4ugfqsbZ8K
	YNoaZJBfhf9CNEOXH7IwCQ3iFJnEfdxdTzjsAyTusGky49HRnkVQfGMgVWYuELffgeW6oA
	70rVd1fYPPtA1WlFBHk6b9j+Ut+7DgM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-5wObMGolNqmixMftohw8jw-1; Tue, 26 Mar 2024 19:14:58 -0400
X-MC-Unique: 5wObMGolNqmixMftohw8jw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29de3646c56so4536598a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494897; x=1712099697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQCN5HobjN2Q/dtCo4+7FNCVXz9DGDP5AkWFtGzZjc=;
        b=FyfDmBwBmZjZgisqXPVGjuiwPUMJevv7TZoMhCkBYU7uwD3bt0I928225y7LaNj/N7
         18Rl2Kwvsv8Y3ZoL+gMb9W5e9QKI5U2gzkHcFbhLIuIYyTh7QZpLqaZvECL2mkot4qRv
         P9VN/Dk6eekzAzt+4vgksAx1eKJgaUVaIRJEi5xV4Oz/HjDc/G+iOzA4YoLHj9XVf9GL
         8IZtJYVrsndIjNUtXMYqrE1Z9F/AXkDULicQGU+cLFd7EPq+BwdyiIIhMQmCNnX83ZYT
         HXn63zJ+15lZAVE4b8ln/cLAnoWb7qbYUMX9eqGu1qqsya3xl9bSusGg8A9zKch+OPO2
         PpDA==
X-Forwarded-Encrypted: i=1; AJvYcCUT4V1bCnl+JCeA7yZQ1KIDAexLGSjbuhKXImYE660ogCIAOFCC89LUZcyjz31yb4SKmCD3xA/rZsAJbmYTeKysXHBSa0cE1qFoQorf
X-Gm-Message-State: AOJu0Yyt17PC4i9Q7bo5yuYPmrmNugdjKklK9sEpLpVHZE20E9CAbRRb
	kkTBelA2pvljIbuzNbguBOmqSnnC6jvevKQLXGB+7LyToKqlHMyfOM8/5MefNbVS9DE63FOFsuL
	z3HQ/1ZDsE3CA1BpksGJ50Rf8CaJ2Bx5de/l6b4EwNqGeaCCFfKC/kN/jp6cpHQ==
X-Received: by 2002:a17:90a:9606:b0:2a0:50ce:aa95 with SMTP id v6-20020a17090a960600b002a050ceaa95mr8314401pjo.21.1711494897373;
        Tue, 26 Mar 2024 16:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaigOMr/7CiLFK70hJIs+MvOMb27KbuLh6qIXIIew+T0XDmdil0bNWD2Rq0OI35ubw/SLB0g==
X-Received: by 2002:a17:90a:9606:b0:2a0:50ce:aa95 with SMTP id v6-20020a17090a960600b002a050ceaa95mr8314380pjo.21.1711494897036;
        Tue, 26 Mar 2024 16:14:57 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090abb0e00b0029c49ed3974sm154556pjr.37.2024.03.26.16.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 16:14:54 -0700 (PDT)
Message-ID: <6bdf2884-852e-42d3-9e67-c9d5aa7d932a@redhat.com>
Date: Wed, 27 Mar 2024 09:14:47 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
To: Will Deacon <will@kernel.org>, Keir Fraser <keirf@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org> <ZgKXr8IQ51xBECuP@google.com>
 <20240326114313.GA9482@willie-the-truck>
 <20240326154628.GA9613@willie-the-truck>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240326154628.GA9613@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/27/24 01:46, Will Deacon wrote:
> On Tue, Mar 26, 2024 at 11:43:13AM +0000, Will Deacon wrote:
> 
> Ok, long shot after eyeballing the vhost code, but does the diff below
> help at all? It looks like vhost_vq_avail_empty() can advance the value
> saved in 'vq->avail_idx' but without the read barrier, possibly confusing
> vhost_get_vq_desc() in polling mode.
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..87bff710331a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2801,6 +2801,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                  return false;
>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>   
> +       smp_rmb();
>          return vq->avail_idx == vq->last_avail_idx;
>   }
>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
> 

Thanks, Will. I already noticed smp_rmb() has been missed in vhost_vq_avail_empty().
The issue still exists after smp_rmb() is added here. However, I'm inspired by your
suggestion and recheck the code again. It seems another smp_rmb() has been missed
in vhost_enable_notify().

With smp_rmb() added to vhost_vq_avail_empty() and vhost_enable_notify(), I'm unable
to hit the issue. I will try for more times to make sure the issue is really resolved.
After that, I will post formal patches for review.

Thanks,
Gavin


