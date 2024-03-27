Return-Path: <linux-kernel+bounces-120570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A373E88D980
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE02987D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE536AEE;
	Wed, 27 Mar 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG7s2pVz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318C364BF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529535; cv=none; b=EY/mve6FZ4HXJbD12kCVdJ8+xWNBSE60b1dQuP21tZSSnVrVGMTScwABTI/0EWdqs75KUZc46Qez77gNS0Kg5FZygPNZ7Z37gSn0CqG2Yz8LBdYahu8B7/MOP65xbACrm9U8ubjCqhR0DaIxrDLpe5wNCBBdONU3jykj44kE3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529535; c=relaxed/simple;
	bh=DtFqE1HXPSDGmjmwI113bYZj1hSFY1fHZo2UrLWsI9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+sNDxv9+ZJtTHxl0YpwrBOiMEIzcYs1PVtQ2+HuLO7HAHOViaB8ugQ2uaaH5G4q7Cbw8QqSMyTru7ACi1p18QEGkQCyKz+lZYviLi74WF4xAZaYM8V5BJX4lqxrggP1xJVcC7WyxqvUqjTjrh9kqgkv5Lpoh9nAL48R2UQuV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iG7s2pVz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711529532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=obXCVoONf2iOwvyp8/k3nDQhXlHsxj/jfLxN6UfcAcM=;
	b=iG7s2pVzdk+2b2HUCfa5X24FLvYydmZzAziNOAtKbk6ZeDSs0LVV55uAC+OPL/A1Qe0iAE
	cYNbbZJTPlKiFK1prkEnJ+WuB7Ct5DJiqgp4obmhfq2P5RC4SkAVKNizCy9OpxNgnZdXet
	c9H2dfZfVMz7Gvdf7RzPvCbE4OwxpoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-6TL9LAbENWyfl_GqOhN2kA-1; Wed, 27 Mar 2024 04:52:10 -0400
X-MC-Unique: 6TL9LAbENWyfl_GqOhN2kA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed22facfeso3474296f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529529; x=1712134329;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obXCVoONf2iOwvyp8/k3nDQhXlHsxj/jfLxN6UfcAcM=;
        b=E+f74vzFShCwG8TnickxMXO4nDXaw9n+toF/9v9tkBPGBpznUapFzNur4xUOVPtWBC
         tXE/Tul11fuArdgM1aSNFrlbvjd1+TYhl59+JXxw3Eb6wq5/q0HmAACWjm9xKy5RVU1A
         HEd0HXWH5uPbp0M7St/Aa3cWVpuF2ozrrYf/J7zST4cDpYIlpXZQ7rNSYWuo2Ze/leU3
         pYJihlpwHr7cDrzbxpiC+nBnae+Dii8gagijjUuvGW+oByYAoclcznDrEdWMuFEypq3U
         i4kQKMfy+6fDHOCX/B/lO1QGfaf3VsTBG2NpEHPn9E2bvTUdtaN38vFBUUpP6hHEPoDW
         cXVA==
X-Forwarded-Encrypted: i=1; AJvYcCX92oMpPuDRTd+64ZGGJ6aQAT3VXw9bcg6mKHa6xsIDHUJRfsl6Z6mpKPEUbWbpHewvdhp3lCqOoCcVqN5ShCZlkwLYBgcvl2Xm06ba
X-Gm-Message-State: AOJu0YxBRDbN2PCCtt9s4AOENhlvbhw18oARgN4hAyQYVy0ZyIrtYacf
	QKI2n33oInNTHPbPBIy8JiaG1P9fhPIi2hyRlJ/fISxCiwvTCC/7bCLoufRNBcpF22SDSiemTMo
	PRuCnm0LMfS+Hyu+T/UKkzuu9g4X59ZuNF4fPcAEc79kUgUv39VfYfbSgxBmZTQ==
X-Received: by 2002:a05:600c:35c8:b0:414:9463:d4c3 with SMTP id r8-20020a05600c35c800b004149463d4c3mr803661wmq.0.1711529529541;
        Wed, 27 Mar 2024 01:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPxbwmy8hFNjQk7jFjhX0Tup4NdmtYI9VPBNOD6LwwDuXoAD2+p073nPtr9VCci+k9Qiy6pQ==
X-Received: by 2002:a05:600c:35c8:b0:414:9463:d4c3 with SMTP id r8-20020a05600c35c800b004149463d4c3mr803647wmq.0.1711529529165;
        Wed, 27 Mar 2024 01:52:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c4e5200b0041401eb021asm1483641wmq.24.2024.03.27.01.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:52:08 -0700 (PDT)
Message-ID: <5d2533ef-40a1-4afd-b071-b68022188225@redhat.com>
Date: Wed, 27 Mar 2024 09:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] minor fixes and supplement for ptdesc
Content-Language: en-US
To: Vishal Moola <vishal.moola@gmail.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, hughd@google.com, rppt@kernel.org,
 willy@infradead.org, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
 <ZgMc_e4_lQpkHm1L@fedora>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZgMc_e4_lQpkHm1L@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 20:07, Vishal Moola wrote:
> On Mon, Mar 04, 2024 at 07:07:17PM +0800, Qi Zheng wrote:
>> Hi all,
> 
> Sorry for the late review. Thanks for looking at doing some ptdesc
> conversions. This patchset has the right idea and looks *mostly* fine.
> 
>> In this series, the [PATCH 1/3] and [PATCH 2/3] are fixes for some issues
>> discovered during code inspection.
>>
>> The [PATCH 3/3] is a supplement to ptdesc conversion in s390, I don't know
>> why this is not done in the commit 6326c26c1514 ("s390: convert various pgalloc
>> functions to use ptdescs"), maybe I missed something. And since I don't have an
> 
> It's important to keep in mind the end goal of ptdescs, cleaning up much
> of the struct page field misuse by standardizing their usage. s390 page
> tables and gmap are similar but not the same, so the conversions require
> deeper thought.
> 
> My initial "Split ptdesc from struct page" patchset tried to focus on the
> most straightforward, simple conversions in order to introduce the
> descriptor and lay a foundation for future conversions - you can see some
> more complicated iterations v6 and prior.
> 
> When converting to ptdescs (and any other newer descriptors), we should
> be careful about generating superficial code churn instead of using
> them to solve the problems they are trying to solve.

The gmap shadow pages are page tables that are not linked into the user 
page tables.

I recall I raised in the past that using ptdesc from them is confusing.

-- 
Cheers,

David / dhildenb


