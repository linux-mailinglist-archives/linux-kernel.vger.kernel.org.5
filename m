Return-Path: <linux-kernel+bounces-111890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19A788723B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4259D1F21F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E260B81;
	Fri, 22 Mar 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4+DXiRZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AC60898
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130103; cv=none; b=mEu5jabzbJEfFECs/4z84VW0bjmAvQbcBEeQS3W26INwwf8b5d3vRXOrhS/T1hsuqFU6C5rEIkPjQwEqIf+RgtChgndzef+Xp7ehlxztm3bqSpCjInrB2axP1OH2jNMq6VFLogSdLBqEg57WykiZ7JqC3esfPtu9DYxAMLoIy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130103; c=relaxed/simple;
	bh=jacSXxd4+PQh90z3ZdhMrF6sKCnxSt8KJchtgsTt90E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=os6ZlfrOvl5+p58pBn69fOULWYqCBYz3AeP+R//y5R74j8/YNAx+2gKJqj6ea0KV03Wxk/g4EYmtJuA6JTeZULayCHNTa833kmpLYXOUkulmEqSjujW5Gjp2LmtnD+VlS9vCQq7OvDUL6pP/UDL32HKpZZmZMC5SxzV1KkSgmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4+DXiRZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711130098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QWtlMLncVgXdNdQuKDFm1Nwigzs6rR7s8i+ituIt+FE=;
	b=g4+DXiRZWdJGkxga47Qxd3xRZ1MAiSIWMMvibWU0yz+rY5pVRbSTBp31qGgNTyA7aQz7u2
	BDNR0rHofkK2j7BzyjRxTaDJPhxeuP/OpbPQcrCBzdU22FUH9dLjCmnfJvjHQbf39+H3BN
	Yi1oxSQReE9ZmNFcVtvLIrAW6oMwOCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-KzgXkWMMN5ypLSM-NPkxcw-1; Fri, 22 Mar 2024 13:54:56 -0400
X-MC-Unique: KzgXkWMMN5ypLSM-NPkxcw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4140cc9cdcfso12560405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711130094; x=1711734894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWtlMLncVgXdNdQuKDFm1Nwigzs6rR7s8i+ituIt+FE=;
        b=mKpi3Gtm/jBZGG3FvvY9cGepMaG4X2TSMhNypsbOS6Fy1pLjFmltSgLkt3bdOEqeJ6
         ahlGpLfo/NrpZZ6LTObp3zzWE/HiF6VZYESROr+w7SnJs1C1LfM/TMl4GlrqzIqAsBWO
         0yvWYf8Dq/omgrOMVka7Y9WAFUxi8eehL5drqcGtUY45aG0FQXhvk+DB6W5ndssef+1N
         bc3mJ7/56b2YlX3MFD5FvWjr5QdSfQkDOBYO0XCXX6YIenoF6pK1c9dJoq1JDrdIz9sX
         09bvdeiFgmcGaSBGFY0yfsiLAQCUMPwvCtAURZ2sGk5A3YtaYTEZNBOaOqcmq+zu6M9+
         RdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW28IXjj1SLfw1sD+y86C1iooVbOGQx7iq9yBHATKHe4xrojf5NNh9agc2oGesl5zF1EqvvXn5N+I8pffJDWs5gYplChlulHA2WSh0b
X-Gm-Message-State: AOJu0YybcSlAqfg5sFfuDKyJxASVf23smU21HVyhA3XOmeVW8LABn9RA
	BhGakGBGAz0R4jo5XYus5QwW4ulO7ij9R+WT1pQxhTHtKuJkizWkJUjAzlK6iUegiyyYKRM/RIK
	xBo5XxQbB4mLfjBoKBysU0a/H2xRigo8pAQMIYSejuFRVAmN6zfWT8tZV/vDWUg==
X-Received: by 2002:a05:600c:1c85:b0:414:1400:9773 with SMTP id k5-20020a05600c1c8500b0041414009773mr99201wms.0.1711130093941;
        Fri, 22 Mar 2024 10:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNQk/EOefQ86FNN4PieH3ofB9n0kL7Srb8t2pN+EiepxOCaLSJapVrlFGd2PN9WhVtkuvEzg==
X-Received: by 2002:a05:600c:1c85:b0:414:1400:9773 with SMTP id k5-20020a05600c1c8500b0041414009773mr99179wms.0.1711130093526;
        Fri, 22 Mar 2024 10:54:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id l15-20020adfa38f000000b0033e03a6b1ecsm2571021wrb.18.2024.03.22.10.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 10:54:53 -0700 (PDT)
Message-ID: <14c72ad9-d05c-4b77-b1e8-a8b4a454f977@redhat.com>
Date: Fri, 22 Mar 2024 18:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: Fix hugetlb mem size
 calculation
Content-Language: en-US
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Nico Pache <npache@redhat.com>, Muchun Song <muchun.song@linux.dev>
References: <20240321215047.678172-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240321215047.678172-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.24 22:50, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The script calculates a mininum required size of hugetlb memories, but
> it'll stop working with <1MB huge page sizes, reporting all zeros even if
> huge pages are available.
> 
> In reality, the calculation doesn't really need to be as comlicated either.
> Make it simpler and work for KB-level hugepages too.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index c2c542fe7b17..b1b78e45d613 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -152,9 +152,13 @@ done < /proc/meminfo
>   # both of these requirements into account and attempt to increase
>   # number of huge pages available.
>   nr_cpus=$(nproc)
> -hpgsize_MB=$((hpgsize_KB / 1024))
> -half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
> -needmem_KB=$((half_ufd_size_MB * 2 * 1024))
> +uffd_min_KB=$((hpgsize_KB * nr_cpus * 2))
> +hugetlb_min_KB=$((256 * 1024))
> +if [[ $uffd_min_KB -gt $hugetlb_min_KB ]]; then
> +	needmem_KB=$uffd_min_KB
> +else
> +	needmem_KB=$hugetlb_min_KB
> +fi
>   
>   # set proper nr_hugepages
>   if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


