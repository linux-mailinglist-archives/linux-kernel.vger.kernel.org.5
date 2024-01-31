Return-Path: <linux-kernel+bounces-46269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC516843D91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDC0B2F711
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9107995E;
	Wed, 31 Jan 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtJmwmvk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92E7992E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698472; cv=none; b=Kt+8NwKuWacFIBikpVYz+OjLzbZaiwnaai4mSNlWwhVkYb/EN5A0GPdjzRmRy8A5SHocFEYeMGlnvrX+4UKFhDn43SBWT08YODVacK1Jy1CUU28NTZLtLdwAbULEltn4S+rcEyoNkUriYb3JF4+LYm3lMeK38Xk013AtdFmf1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698472; c=relaxed/simple;
	bh=Ccolu4zSU/vB0+tTKps/mS99rTNn/AAMXXNrC6fpKF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDG/jXXhdhbSY2Wj+UcjFcUDuzEAhm/qxfPCF8IqQq0Hjz2p0wGZkWQDvDLDhHbhdAs8X92GKHk6P5zqXX1kLcwuD9cqm5K7C6nghp+sKhz49AWbmKOMoHxt8Loj6ZXi4n0jmyUBWgJcsjdA/oBeYhdmhuSPWxylIDh9MEsQJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtJmwmvk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706698469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0lcPHZKWtAXL83NwfB6OAexbn5EE7CEjKrOypHPp/PY=;
	b=QtJmwmvkj978jC6E4e3ApsNCkznoGLV6WlQLlmyUIzjV/rXir3JNJ4+I5VYqDGAwDxpoM2
	sCxO7cxfDFZb1YnQf5UykNM3dL6O0Ju1wSdmoM9+Kqs24jBKGgZUURiJUx++3faJTn5Sc5
	PnjL4mcdrEyVjIp1Irpc1t/hUeRbt0I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-1X9PFdENNFC2-UWiGbP4JA-1; Wed, 31 Jan 2024 05:54:28 -0500
X-MC-Unique: 1X9PFdENNFC2-UWiGbP4JA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33affa7adf9so314799f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698467; x=1707303267;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lcPHZKWtAXL83NwfB6OAexbn5EE7CEjKrOypHPp/PY=;
        b=N45Ag4cuuCrOXCy6qpvBM+x5NHoqYFoUZGkmyv0BOHNU+bvg8eEQxFbT5EvfJxATik
         vFRTCTfvp8n0AGr+V5ZF7b4u7Y2Oggy83J7Dr2xdzZFfiHBRQdBghHLAzi/ML3rHtvL1
         A+72EMbOeNvAO2HyoDb7VIpLdzcKAdx1g4sPapYU+rttaU2pcfZNZdh/9cKvD+mnMBzD
         nR6nACEx48e2YEDzhWnJSoniAQRphAmWgua6oqWS9qCA1dZPxXhtdkVrH0to7u4hKB8y
         FVA43Coqm7o8Ipe3qhgMozcHArPORMkGr8bHCpESaQdA3R0yq51yXHpts1Z0JZrQExj/
         JGJA==
X-Gm-Message-State: AOJu0YzDXLqV2FBBNr+0p0+nduzt8m4rkpbulF0D1FlCL9GrLvCUJQxa
	ICwFKfSR4NzoYvkCM4MLROtT/1KWWTmFBqLQOIn1zf5sruDTkgMRZ9lQxll+AymKr754Rp8GPLw
	PkAH8+N9sYYia7vduqD4wkC0tb3dF0g5kZ4iiacLfADzw1Prmyzj7T5bzNrQfzg==
X-Received: by 2002:adf:b313:0:b0:33b:32b:92a2 with SMTP id j19-20020adfb313000000b0033b032b92a2mr703619wrd.68.1706698467199;
        Wed, 31 Jan 2024 02:54:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdeeYLOT7GKTNQmJHlf992CU3isCpqZNY8t77NP+gnkl76miesCaqQuJ03Y2SWrgHbeYsb1Q==
X-Received: by 2002:adf:b313:0:b0:33b:32b:92a2 with SMTP id j19-20020adfb313000000b0033b032b92a2mr703606wrd.68.1706698466855;
        Wed, 31 Jan 2024 02:54:26 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b00337d980a68asm10734874wrv.106.2024.01.31.02.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:54:26 -0800 (PST)
Message-ID: <77ace07b-3f84-46ac-8a29-e782d7f60078@redhat.com>
Date: Wed, 31 Jan 2024 11:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel paging
 request in fuse_copy_one in intel-6.8-rc2
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>, rdunlap@infradead.org,
 akpm@linux-foundation.org, heng.su@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lkp@intel.com
References: <ZbmqEy+8iOREMPmU@xpf.sh.intel.com>
 <ff3058bc-e683-4aa6-833e-6dd6aa92d2bf@redhat.com>
 <ZbolZRw9yFk9jLB6@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZbolZRw9yFk9jLB6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 11:48, Mike Rapoport wrote:
> On Wed, Jan 31, 2024 at 10:15:11AM +0100, David Hildenbrand wrote:
>> On 31.01.24 03:01, Pengfei Xu wrote:
>>> Hi Mike,
>>>
>>> Greeting!
>>>
>>> There is "unable to handle kernel paging request in fuse_copy_one" BUG in
>>> intel-6.8-rc2:
>>>
>>> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240130_184751_fuse_copy_one
>>> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.c
>>> Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.prog
>>> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/bisect_info.log
>>> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/41bccc98fb7931d63d03f326a746ac4d429c1dd3_dmesg.log
>>> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240130_184751_fuse_copy_one/bzImage_v6.8-rc2.tar.gz
>>> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/kconfig_origin
>>>
>>> Bisected and found first bad commit is:
>>> b758fe6df50da mm/secretmem: make it on by default
>>
>> Sounds like we manage to access a page that has its direct map removed --
>> either because it's actual secretmem memory, or because we fail to restore
>> the direct map.
> 
> Judging by the repro code and the registers, it's an access to secretmem.
> 
> The call
> syscall(__NR_write, /*fd=*/r[0], /*arg=*/0x20000040ul, /*len=*/0x50ul);
> 
> will eventually get to
> 
> memcpy(0xffff88800e2afa80, 0xffff8880119a5040, 0x0000000000000010)
> 
> and I think that 0x20000040 in repro address space maps to
> 0xffff8880119a5040 in the direct map.
> 
> So it looks like secretmem actually works :)

Good. How can we prevent triggering BUGs? The write system call should 
fail gracefully (and I thought it would).

-- 
Cheers,

David / dhildenb


