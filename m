Return-Path: <linux-kernel+bounces-101272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B887A4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DECEB220CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A0220B02;
	Wed, 13 Mar 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp56jKTB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B11BF3D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321754; cv=none; b=gpp2uX4uNJgFJvmoBBcQn03GUbPmpa5FCILaO7xgI+kFd1Jj1nyile5tVWCPmVefgA0CyBjQ+gfDySE+5+3/1AFlQaXKbZaDK5J/Lgqp8Vppi19kS8IhxP1iZJdEJSxxhJN/54zdHNZs8uTW1cbnXRsu+r5ODbaSRf5O9oS1R9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321754; c=relaxed/simple;
	bh=EyaLSVcIXXWnvSkVYARWcTCW+gvGwvDE8EIysEfSH0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnoWtVHYvk1s4tlUN4kRLgfZlu0pwpKOkp1hUsLeMjhHR+OVLhpMeh4YOQeCz2gyERA+Og/fzo3GvfeJpZOP41tOrf42Rp15fnwxugbzZi6kZnUXyBVwwO6iycOBGvrUhrL6t0XTecT0p/23A7zS1hiupPhK46punXKp0d7mPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp56jKTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710321752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6dhNLbrqvyHao9UMo5ZEqs5wtUpqp6cJIpzfbYovH1o=;
	b=Zp56jKTBKNxmEjYCJ07MwV/7O/UFRsE0AWJwryvS5UGJT4VigTVz5Ij5duSyuRsNxP9duO
	Hcf0xljflA7QwiwNtFVq9EIVLxu/iI0Kek3hX2tF/s3H/mnxJv8FdmmxV3xap+ADLL3S3Z
	3fzcyW9I0sMCLAipx07MKp1ugFkQcEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-9KNQP9ZoMiCZnMY12ma0xA-1; Wed, 13 Mar 2024 05:22:30 -0400
X-MC-Unique: 9KNQP9ZoMiCZnMY12ma0xA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e7ffdf5c1so2924529f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321749; x=1710926549;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dhNLbrqvyHao9UMo5ZEqs5wtUpqp6cJIpzfbYovH1o=;
        b=u1LMKjgzhQuNwRxHBbyHAyoIerejgC6fPnSkFfbqmCbG/P2viD7F9Aewzc0pVAIGNg
         o8xjb6DSoqIzCZplf4sN6GlxyTgegLDDMxkFSYLz5/sSe1J2aD2Uvaqi2kBXEDUdQoSh
         oMp/S/EGP1s5kHpTWmS2VCX4eHXEhuWe1qNoBsKYtpVxBX9Z/+cvmT7EuqoN1VEWvhs/
         YYCIPWcruOlxQzntF5j1C7+KxreuPTormxzsXSJvg6mwk/hJCTx2YSvhbS1Eq+1Lo3yP
         9TscneAQt2pBlvU6qpaiE8Q0os3YllaW9TEd/pXi4HrKwcTAx6/oyGnpe4hHOf2oYlsU
         F2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW8cX3RIJuy4NtnMl1jNvvPEruR3N8Zy2YgEpwvD/1Tc3LTw9fC2wS0zsR/lorgWd907y/98TQJHR2/WEeMCeJ19wDCfS/aJFd4eK1U
X-Gm-Message-State: AOJu0YwuOe53Cjwg/Hbak3hFFZaQq3cySLwDA13jOME3tAhg+izOSbuJ
	QpH2hEjmgWTvrKgT39RyJErO01iOwvGu2l4/PZzgh3qDTC2fYrtQCJ3+XTn0R/b3eVMu/1sk8D/
	Yy1cdg4N9O6hJruPYkNMiltX8FFV5p/Twj2f09nHywcQsRNhfjR9Z+zWek/l6Rw==
X-Received: by 2002:a05:600c:4991:b0:413:194d:12c6 with SMTP id h17-20020a05600c499100b00413194d12c6mr8688153wmp.23.1710321749125;
        Wed, 13 Mar 2024 02:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg/KCDj9dD/X+HQ6eebUcX+Z/rEVbnMlvD52tp1aTDegDCBNCprJPBHfo+UdMJl/8wjIWcIw==
X-Received: by 2002:a05:600c:4991:b0:413:194d:12c6 with SMTP id h17-20020a05600c499100b00413194d12c6mr8688133wmp.23.1710321748715;
        Wed, 13 Mar 2024 02:22:28 -0700 (PDT)
Received: from [10.32.64.142] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b00413eac2e806sm1082049wmq.29.2024.03.13.02.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:22:28 -0700 (PDT)
Message-ID: <2e48b457-6500-47a3-9902-7177646eb765@redhat.com>
Date: Wed, 13 Mar 2024 10:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] filemap: replace pte_offset_map() with
 pte_offset_map_nolock()
Content-Language: en-US
To: Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, willy@infradead.org, ying.huang@intel.com,
 fengwei.yin@intel.com, aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
 hughd@google.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20240313012913.2395414-1-zhangpeng362@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240313012913.2395414-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.24 02:29, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
> handle_pte_fault(). But at the same time, we did a pte_unmap(vmf->pte).
> After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
> may be racily changed and vmf->ptl maybe fails to protect the actual
> page table.
> Fix this by replacing pte_offset_map() with pte_offset_map_nolock().
> 
> Fixes: 58f327f2ce80 ("filemap: avoid unnecessary major faults in filemap_fault()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/filemap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 31ab455c4537..222adac7c9c5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>   	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
>   		return 0;
>   
> -	ptep = pte_offset_map(vmf->pmd, vmf->address);
> +	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
> +				     &vmf->ptl);
>   	if (unlikely(!ptep))
>   		return VM_FAULT_NOPAGE;
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


