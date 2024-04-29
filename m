Return-Path: <linux-kernel+bounces-162244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940668B5870
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481D22882CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FCC6A33E;
	Mon, 29 Apr 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjBs8T/C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8A548E8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393381; cv=none; b=ercfKVI+hG2L7UMsUZIdvn/I1H7EsgCUnv8NMephCXd1yFfzPSyz6uZ3zIcnn+wfSHbFS6LFcF/UYD/LYelFS5HNN0rk+6jFRNdXVUtPKmb2E9O1jcBGuk0it99r0l8AFINUJOfdOY8zMaKMzONWWdZrIc9dec1RdKu0/mjPQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393381; c=relaxed/simple;
	bh=pp5z7gcrGnaGwKaBRXi44H/aGhRxYMPaPhglBYowj/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEiRMlrhS1gKxVo0lBMSgCTHkgTZ35ZQl7Z4jLqxKmoc4eYlYmx0k87e9h7xo1ywRgctzQ6Rvjb3GCZcZzrpU22+zUCGkJMXfHZMlJpl0FdiONVvQWRILBb8EBvgZ/qj2azpNdzr208a5EdqPTlOtTAKRLCTQW0e6RpSQ8Tp+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjBs8T/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714393379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TXIsKRQbdU0Npd8srku3UtewvoDSpR6hr7lmEACnXD8=;
	b=BjBs8T/C29hURvtJmcG384YhN3vmtfRT7OvocJ54+pYu/EoAITS0lkU+1GgDPISFgeiQIy
	EwSADjguRFD3dLL6245O9KXCjI5TVgtpRzr8B2EYIdTXcXX3SzNDC8y0gJmBRje0MbF2y2
	PlSVRxC12zvz+5ZmM5HZbO0nDW0j7Bs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-HSjpraFuNp63EjhEdOqXqg-1; Mon, 29 Apr 2024 08:22:57 -0400
X-MC-Unique: HSjpraFuNp63EjhEdOqXqg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41c05442f92so7801545e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714393376; x=1714998176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXIsKRQbdU0Npd8srku3UtewvoDSpR6hr7lmEACnXD8=;
        b=sLuGu0OGCGrNf3upCuaL29KqzXrm10OEJd3NR2rxeQnHoPOuFMTtP09gtuA3yAQBfE
         TEgVLVusTOUliMHMiKuUM+96fuMjKHvK4C9X6HRgYg5j7sx3tegprrhlbPQScm2qm4o4
         yjnLW2iZrDp7OXEH56GBVfYEsDexNS1DWoqXwm4r1GMThysGLW5yrwfCwktD2D/JF3Yx
         +wUgW6DDHlIc2BTN4aVIQHKHwnAJJHhFzKwz++C/yFqtxjLQpJ8/HqDVgyxFx3wh6xu6
         /Cc8ZMEpC17L4shQXAJiRLdxLHxP62Tje9Sid3yjmeyT0aEBpEASx2q8BxgSYyHlrCSx
         vMLg==
X-Gm-Message-State: AOJu0Yx4LgMGZUDsXPQ11V1vW25YFRscFf5GQm6k2JOwJDayl3TnlEI8
	yRF4y7jW0W2jz8fCBzg5AVrZz5xe4XbfwkEz3KclBqlRcF+DRU/yzgiKZ3n+Y1v7Jf2Gn6deAaw
	VDBuqw9jg6wMyWMfumfe7Fz81/BkO42N/tygbgyQo05K1ZmzAw5B5Cl1VkBiGWQ==
X-Received: by 2002:a05:600c:4751:b0:41b:eaf2:f7da with SMTP id w17-20020a05600c475100b0041beaf2f7damr4897302wmo.6.1714393376139;
        Mon, 29 Apr 2024 05:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF90uy/1yEHJIMmrMP0gsnV07KdzYkWUQDKGA3y/CKgdvIyoY89+KIPJymJ6auPtsfVnfGsmA==
X-Received: by 2002:a05:600c:4751:b0:41b:eaf2:f7da with SMTP id w17-20020a05600c475100b0041beaf2f7damr4897284wmo.6.1714393375688;
        Mon, 29 Apr 2024 05:22:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:e700:f1c5:285b:72a5:d8c8? (p200300d82f26e700f1c5285b72a5d8c8.dip0.t-ipconnect.de. [2003:d8:2f26:e700:f1c5:285b:72a5:d8c8])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm21226594wrs.108.2024.04.29.05.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:22:55 -0700 (PDT)
Message-ID: <cfc6b006-ef6f-4099-b29a-fba30bdbd74d@redhat.com>
Date: Mon, 29 Apr 2024 14:22:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix uffd-wp confusion in
 pagemap_scan_pmd_entry()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 13:41, Ryan Roberts wrote:
> pagemap_scan_pmd_entry() checks if uffd-wp is set on each pte to avoid
> unnecessary if set. However it was previously checking with
> `pte_uffd_wp(ptep_get(pte))` without first confirming that the pte was
> present. It is only valid to call pte_uffd_wp() for present ptes. For
> swap ptes, pte_swp_uffd_wp() must be called because the uffd-wp bit may
> be kept in a different position, depending on the arch.
> 
> This was leading to test failures in the pagemap_ioctl mm selftest, when
> bringing up uffd-wp support on arm64 due to incorrectly interpretting
> the uffd-wp status of migration entries.
> 
> Let's fix this by using the correct check based on pte_present(). While
> we are at it, let's pass the pte to make_uffd_wp_pte() to avoid the
> pointless extra ptep_get() which can't be optimized out due to
> READ_ONCE() on many arches.
> 
> Closes: https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/
> Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


