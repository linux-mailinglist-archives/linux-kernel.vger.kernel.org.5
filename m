Return-Path: <linux-kernel+bounces-99948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EFA878F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3CF1C215D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D869D08;
	Tue, 12 Mar 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/HgYrYJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44066997E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231754; cv=none; b=KQowZJdMIIlZlr4M8TKQw5yk34JRuFk3SmqL76ZWpfBo22gAQKnXnF/4gAfRB2MIJhUw/DtBiM6Md+HlIeRd8AFzlPoqyVu3xxuowb1Em/yOfB4hhiI/Teev4idlEFCKH5UXOKiryGsGFyf4tSJnIyZGmHORb+6qtkNacDrrt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231754; c=relaxed/simple;
	bh=Js5Y2ruMyrBZCWGdUGX22PYWuOKjgSJ/fC03lSY7p9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8vJWE5ktig30ZIKOApFdWthbxA/LmAAb9CO6QuF9tHqyEKmj1DBPVOQsVlUTXQbQD7wIbQOCDb+fYErs5MP+exwR70W/ZYz0waBY74pA5t+JvyXIl/nbOGdWPKeUVChwpW/g6U/mJrhrj2monBhomGILhZpZFuNhSDc2V/zNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/HgYrYJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710231751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8EDFdCBwmXqN33aqI7afTbviqKeQA7knJzhc/Ir0Ntk=;
	b=P/HgYrYJcw6oecUuTs67tvFrjtRAwHaiGc0ZR1ULWHiWtr7ox4BzbntatzzWykBav+KP70
	ew8M9Hfj2uZlWlkE+R0N72Sn23nqL4j/6vBawnDw6joeSa0wZuDy61nDeHv2i2y6Ycj//U
	krFvB4hIOHgE8AYMh3tGZfFBvBZrB4U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-vw2uHxCsM5GGZxYOwzLzqg-1; Tue, 12 Mar 2024 04:22:29 -0400
X-MC-Unique: vw2uHxCsM5GGZxYOwzLzqg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513b2e92c19so1650092e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710231748; x=1710836548;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EDFdCBwmXqN33aqI7afTbviqKeQA7knJzhc/Ir0Ntk=;
        b=Eo9zhxaUQQhweVRPeH9z1uTYmavUJvN/a8uM83DsX6cl0/KDkNXRkS6hRAvZibgQZq
         HIloKO4N/pt8yR4B7vWtd2F8SgTVmsGVj5FRnuGw8SpMVpJ+uKOtV8EWKm7bzaQohLwB
         6PUZ03/qwAQMe3yTKvorA6Pq4+ieMB3+G4kD9AmTVYH4/tWy8ssEaCuQ76rzL6Tqv6lf
         CgKUPM5+EyjuvonHJGr1Suu5yuYuGjiqw61GxmiXxkFrkpj07TPHSjX3INcNM/hQ3h+T
         nYiZw+s7r9MKFy71hpPU9+bx6l+L3wnDXp9CWuThj15ojEvPbmCtjEW4zdDwPvJBGmgj
         LiYw==
X-Forwarded-Encrypted: i=1; AJvYcCVy/F4txK/yf92tt/HCa13sNWUdNToJTUD1pDRiR57n2Loixips9hnIBgK8y9QmP2BS1A/Q/Rw/WkQ7tKqUgjG8kYZr4JSEuHJbQgI8
X-Gm-Message-State: AOJu0YwnIZ3Am55whvm2BMJMvs9MWn172kB5z3Zdb2Gt65GHriqq97PP
	Vqyb/CrwZhNKn3XbR6STObW+sk/EWwUWZ38CAf3tMRKX09SdLfV3Yf+GvGBaHR/IOvRpN/u08P2
	1FioHnWxrZcl47Vxs6skPEjiyuffmwzgCYz7wlxZjJPHwazOxd+Tg6STeB6j1YQ==
X-Received: by 2002:a19:7414:0:b0:513:2999:5ef3 with SMTP id v20-20020a197414000000b0051329995ef3mr5758194lfe.7.1710231748029;
        Tue, 12 Mar 2024 01:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8YGx+WJAD0pCVdWaPekDiPTo/7mqu5UetkxMBiVYHolzZrxn63T2r8bkPNiS3/cXjBZPNPQ==
X-Received: by 2002:a19:7414:0:b0:513:2999:5ef3 with SMTP id v20-20020a197414000000b0051329995ef3mr5758178lfe.7.1710231747619;
        Tue, 12 Mar 2024 01:22:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4f00:a44a:5ad6:765a:635? (p200300cbc7074f00a44a5ad6765a0635.dip0.t-ipconnect.de. [2003:cb:c707:4f00:a44a:5ad6:765a:635])
        by smtp.gmail.com with ESMTPSA id q11-20020adff94b000000b0033e95bf4796sm4880973wrr.27.2024.03.12.01.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:22:27 -0700 (PDT)
Message-ID: <ff65f353-6aa6-46a0-94fe-892e7b950d35@redhat.com>
Date: Tue, 12 Mar 2024 09:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: adds soft dirty page tracking
To: Shivansh Vij <shivanshvij@outlook.com>
Cc: shivanshvij@loopholelabs.io, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Houghton <jthoughton@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.24 02:16, Shivansh Vij wrote:

Hi,

> Checkpoint-Restore in Userspace (CRIU) needs to be able
> to track a memory page's changes if we want to enable
> pre-dumping, which is important for live migrations.
> 
> The PTE_DIRTY bit (defined in pgtable-prot.h) is already
> used to track software dirty pages, and the PTE_WRITE and
> PTE_READ bits are used to track hardware dirty pages.
> 
> This patch enables full soft dirty page tracking
> (including swap PTE support) for arm64 systems, and is
> based very closely on the x86 implementation.
> 
> It is based on an unfinished patch by
> Bin Lu (bin.lu@arm.com) from 2017
> (https://patchwork.kernel.org/project/linux-arm-kernel/patch/1512029649-61312-1-git-send-email-bin.lu@arm.com/),
> but has been updated for newer 6.x kernels as well as
> tested on various 5.x kernels.

There has also been more recently:

https://lore.kernel.org/lkml/20230703135526.930004-1-npache@redhat.com/#r

I recall that we are short on SW PTE bits:

"
So if you need software dirty, it can only be done with another software
PTE bit. The problem is that we are short of such bits (only one left if
we move PTE_PROT_NONE to a different location). The userfaultfd people
also want such bit.

Personally I'd reuse the four PBHA bits but I keep hearing that they may
be used with some out of tree patches.
"

https://lore.kernel.org/lkml/ZLQIaSMI74KpqsQQ@arm.com/

-- 
Cheers,

David / dhildenb


