Return-Path: <linux-kernel+bounces-145418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8008A55EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B29280C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B8D762D2;
	Mon, 15 Apr 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeVGYfBY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDA71B3B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193470; cv=none; b=FGDiviB34Yz3wh5PW70UJwJvQZH/TjBjJtYt4sNPyF6+JBRsQTmiSTQHAjvSHxvkkUPTOu1LgMJPLznorRFhJkLZ+D9mfoHHizzG8oT+Cv0IbKtfmKbnciYHIcpqxetQco3RBTz//Nf+sFxhce50krTHG/Z3UvVQ7KLUhd8OPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193470; c=relaxed/simple;
	bh=qV66wvvmOe5Fbswwf7hLeYtfxUDbv3GqqcFIcO2m1Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCERyarFsyq9X0XohvpZ1MW5xP3WSdMU2p/EIFZ0KpI2VdBtu7CNQnRwEjumJI8L54HaLSL/y500cPwULKn4QEXX508NM7OWL+ULvZPiB5nequdg0uqYkod2SZ8SWpP+tcIGbBCaSXwd+v8876Wif5opUN4OOsKJKGMalaq5yQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeVGYfBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OnKKU4w8pIiCL4LleAZ3lUokUgFM4I1C3sXlHP3921Y=;
	b=UeVGYfBYgQETqq1MsNLj+lWR9sOIAS9stV48RNcjB6kkZBRRX0GNcqHFFaCQ0G9MianTmS
	C0X4OOJttL+0UyJUAK+morCxYaVHM1oMb4q40fLL1ZMLEJ2JBC8QlK1RomRa2q9EU5WwsZ
	saXP7k01F4jrOgycrVPhhOxNZLb93fY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-qFH_el_UMbGyX7GhHUuYsg-1; Mon, 15 Apr 2024 11:04:25 -0400
X-MC-Unique: qFH_el_UMbGyX7GhHUuYsg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416a844695dso15874605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193464; x=1713798264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnKKU4w8pIiCL4LleAZ3lUokUgFM4I1C3sXlHP3921Y=;
        b=Sup3En7qLo0264gkOzIA0ULY1ff+DxmYBSdKLwazAuQbVZcGMTdRJaJRT73p/EI29W
         anRxrtsFLkt7COnL1K5hmwne++k6PqxTqg0cKQRd/THNnsboLRkyir4sg7xhaxGxXkfG
         C60/xyyHYAO8kpY0tW4BLpkirr9EnjNREGljKfhTFncauebDZ865fucr8dT0I7UWOtkN
         l2OiL9gnwiPSP3n/C/C6MdEWQY6RZ7FNF+aYr/efKzYb9mK2/MlCZjOeVK7OYpLHf1SY
         IoPSQy2ZXuDYaSc/XtBk9yzlR5gzp0iSfFNXrnmLreHFGoMHTL03Z3UDqoltVzXVIciV
         8aUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg61yG4r+bU/7u+/XZ6pQSVyhvS+dI05Vd+YxldSA76m+ysFygaicDIsUZfDavOazoLrJs1thwMwlLWNZIHG+L6usDd/UYp5mkKhgk
X-Gm-Message-State: AOJu0YzGUOie/5Fr9aBw0uvSvvQH9XIfmlRt8aLuUBwGC8BafAuAaV8q
	MxCgDHfNmMkPHQe872S3jKNV9IeUoXxIuwx+h3oQF7BSumxzGsrAPjI5SA7ox+N8yCP07EjRPJ5
	06+EKIiKqQY9Ha3vJCFgnh94HWJ8xJSNM/umbUeCZv2llWMGqqeGzDTxp37K0rw==
X-Received: by 2002:a05:600c:3d08:b0:418:7e61:762f with SMTP id bh8-20020a05600c3d0800b004187e61762fmr744181wmb.26.1713193464153;
        Mon, 15 Apr 2024 08:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLydcIkZiRaJCv52H2BR/Q3j6VmgZyP5JqyGLevERU0MOjR72uKIXKgdzGwrFjquGYcc9npg==
X-Received: by 2002:a05:600c:3d08:b0:418:7e61:762f with SMTP id bh8-20020a05600c3d0800b004187e61762fmr744155wmb.26.1713193463683;
        Mon, 15 Apr 2024 08:04:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b00417ee886977sm14329551wmo.4.2024.04.15.08.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:04:23 -0700 (PDT)
Message-ID: <9d13bfa5-cbdb-4942-937b-1793aaa85c58@redhat.com>
Date: Mon, 15 Apr 2024 17:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] virtio_balloon: introduce oom-kill invocations
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
 <20240415084113.1203428-2-pizhenwei@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240415084113.1203428-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.24 10:41, zhenwei pi wrote:
> When the guest OS runs under critical memory pressure, the guest
> starts to kill processes. A guest monitor agent may scan 'oom_kill'
> from /proc/vmstat, and reports the OOM KILL event. However, the agent
> may be killed and we will loss this critical event(and the later
> events).
> 
> For now we can also grep for magic words in guest kernel log from host
> side. Rather than this unstable way, virtio balloon reports OOM-KILL
> invocations instead.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/virtio/virtio_balloon.c     | 2 ++
>   include/uapi/linux/virtio_balloon.h | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1f5b3dd31fcf..fd8daa742734 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -352,6 +352,8 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   				pages_to_bytes(available));
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
>   				pages_to_bytes(caches));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL,
> +				events[OOM_KILL]);
>   
>   	return idx;
>   }
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..cde5547e64a7 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -71,7 +71,8 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>   #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
>   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
> -#define VIRTIO_BALLOON_S_NR       10
> +#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
> +#define VIRTIO_BALLOON_S_NR       11
>   
>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> @@ -83,7 +84,8 @@ struct virtio_balloon_config {
>   	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill" \

"oom-kills"

-- 
Cheers,

David / dhildenb


