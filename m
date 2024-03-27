Return-Path: <linux-kernel+bounces-120149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B188D2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79582E47DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2851E878;
	Wed, 27 Mar 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwJ1r8zR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAB18E11
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497712; cv=none; b=YumFB3i68vPJBXrsOKzSaddq7z12hTLIuhFunh3d0phzBjsWzOi3b81klRI760xpc+H0Bv2VKi68sE2Rg6YPMNgrhcwUtCmKePd6mkRtysXAdme2H0UjNDeARwYUfkdNvrE7VAPnB/6iWwSR3ct6XsLHrg26qloTFj171SqR1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497712; c=relaxed/simple;
	bh=0uXCRp7jIQ/kQh2MkanVPzFrIyX5rDpcmB3AhOYTIiM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XGNJd88y+ouYdu2kHJ4ci4ZjnPC2+HAsR4XNLEGumyoQChCBIKM+QwIgv9njw+KGsYIqVfZgUtrK7delTX9lu4tP8o71fjGGq9bXciGDo/whBzTfVwsAqXIRTUmr//PfNonSvxCJ8he993MV8utJ5UjEQVDaVurFnXL8AmlitAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwJ1r8zR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711497708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVjfoltGFq6MrU7C6LO1jQFHwqgg6xkJxfUpaB5Bw1k=;
	b=KwJ1r8zR0pw1r9IlOKVxy+GNdgtLFnuGCB/zYdw0GWCfzH4pK5UeNY9xFXW+FlAVIyxJx7
	1gkTIAb6vqZxcmrGCuBCdp4i64ZBxjU+dgaNL2V4PNc7tF3UiWOYRs2VWg5PNgUVSkqDvj
	9puyMzTDJE6jZ0kDHap9PmUskavSeu4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-N2_JyVYMORuwW3J27XEZLg-1; Tue, 26 Mar 2024 20:01:45 -0400
X-MC-Unique: N2_JyVYMORuwW3J27XEZLg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6eaad4ed2e7so2438635b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711497704; x=1712102504;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVjfoltGFq6MrU7C6LO1jQFHwqgg6xkJxfUpaB5Bw1k=;
        b=nSagEL5EKZfPtVNpXDX5StMyFgAb6/DqzGMjixr4br/RjoD1VTdozF6zVXSLDdxYye
         iY8ENAApHCH0h3TSqQSZRIgH3fh4gTg1XDYGbYgrQMfP2wty+Q9gkR9lkXJQ9dgIF44E
         N5OcWdoX/IqlFcHZzt/UMV+AvlbFbWkTBZ8H3muWenJaFeT9PFe2G4/RkR9RLawTNDfZ
         xs8AgK1IFkL7YSSPardHwtrB9Dp687MLankWNlPVOfEK56S2FjB+/81dK3qESV1AJkpr
         qUSOcE+hgUNuCkN+n9+3ENtdcPV6hKCRQ9XBowWE8gOg3u3urOwTAH8Je9UixyhaHhMT
         czHw==
X-Forwarded-Encrypted: i=1; AJvYcCWhC0MzcAKI/inCo8+Gp9pmIuRvSSVvbKY7i6/XJT2w1FLIextHy3BtWG+flGcccCwi2/Ujrhe7Lf4aIPGr9TkXusfcDlAtKTv3STZi
X-Gm-Message-State: AOJu0YzZbIIZrTPZEK6Z9kTWULP/rzd8smnFEIU7BeVU8Hw6sa9hP5sj
	0AYV3Mrk/rHAqd8rM+myzRTiMPzQeByKAkhoP6sj1WrVMl8QfwEQ7JxIQr/yaHICvKZd97EYa7M
	mMdMfSmfsbkbMnAGGuUnefcpL93KLBd0vrjOE8hZR2nYOeSnAJb2JRiyKzL/HTQ==
X-Received: by 2002:a05:6a00:3a2a:b0:6ea:c4e5:a0b2 with SMTP id fj42-20020a056a003a2a00b006eac4e5a0b2mr1483110pfb.13.1711497703990;
        Tue, 26 Mar 2024 17:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUWocj3Qa/NlxAuJhM1KtqiSZe13LpGj7Sz7fbC2Z4fKrvyngbjb3cau9/aMUwg15ldTH/1w==
X-Received: by 2002:a05:6a00:3a2a:b0:6ea:c4e5:a0b2 with SMTP id fj42-20020a056a003a2a00b006eac4e5a0b2mr1483095pfb.13.1711497703646;
        Tue, 26 Mar 2024 17:01:43 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id fj11-20020a056a003a0b00b006eab7ca005esm2415729pfb.18.2024.03.26.17.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 17:01:42 -0700 (PDT)
Message-ID: <50d6fec8-708b-4174-b6d4-388083312bb8@redhat.com>
Date: Wed, 27 Mar 2024 10:01:35 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
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
 <6bdf2884-852e-42d3-9e67-c9d5aa7d932a@redhat.com>
In-Reply-To: <6bdf2884-852e-42d3-9e67-c9d5aa7d932a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/27/24 09:14, Gavin Shan wrote:
> On 3/27/24 01:46, Will Deacon wrote:
>> On Tue, Mar 26, 2024 at 11:43:13AM +0000, Will Deacon wrote:
>>
>> Ok, long shot after eyeballing the vhost code, but does the diff below
>> help at all? It looks like vhost_vq_avail_empty() can advance the value
>> saved in 'vq->avail_idx' but without the read barrier, possibly confusing
>> vhost_get_vq_desc() in polling mode.
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 045f666b4f12..87bff710331a 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2801,6 +2801,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>                  return false;
>>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> +       smp_rmb();
>>          return vq->avail_idx == vq->last_avail_idx;
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>>
> 
> Thanks, Will. I already noticed smp_rmb() has been missed in vhost_vq_avail_empty().
> The issue still exists after smp_rmb() is added here. However, I'm inspired by your
> suggestion and recheck the code again. It seems another smp_rmb() has been missed
> in vhost_enable_notify().
> 
> With smp_rmb() added to vhost_vq_avail_empty() and vhost_enable_notify(), I'm unable
> to hit the issue. I will try for more times to make sure the issue is really resolved.
> After that, I will post formal patches for review.
> 

Thanks again, Will. The formal patches have been sent for review.

https://lkml.org/lkml/2024/3/27/40

Thanks,
Gavin


