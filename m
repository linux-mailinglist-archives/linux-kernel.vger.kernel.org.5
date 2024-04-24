Return-Path: <linux-kernel+bounces-156626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7056A8B05EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D59D283146
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3052158D96;
	Wed, 24 Apr 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON0abbo+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CD158A06
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950601; cv=none; b=i/cPzxR6RU3xxg4/XSfHQjKECyo6W5ygzehzjGeFm4E1vqyF3FdRKmnhon5aLbBwqbIndenw+YEJJXcpNgvelBNmJhWkBqSHzs+OBPnSLm/x6vM+B224kLE99pExkkmFE5+HhV5R1ukhLqWrpGiTNSzNBd4GWVLkWB2MVHNsYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950601; c=relaxed/simple;
	bh=HgsUDihNrnZZ0lvjiU2TfgXdFPn79SJQ/G5Q9RLLW5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouKFvoblaD1JPk9ruvGcXkjtYJ/8EWmfYo7NL7EOEJSeY4yEzSDxRfHO2/sqc3DYHrEYJJVfdbVWV88Zf9mLN+3VRElwH1o0/+DrOSAa4wDL2LYkotTmagBqIgJx/1XetnXLS9Zw2Ln0HHhQndUmm5OoaGPMXsqRTsXLpKUozPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ON0abbo+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713950598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AssHIO3VvfTUux2rCuscSCwR8gSBFHOzhHWhVW5L1Nc=;
	b=ON0abbo+U1TLxn0e55LAEsJgHMvOsf2iZhe5o8y68NjZIS/tpuu8zxh7IE3PpNTwqNA8eC
	5+XWIvXTt+xciDTzSr3Rh636t9IWjw0AOAN4o2v6cY0eKPE6TEHTL5hSoP99g3PjM5AOCU
	ZMjb/L68Ycl9yx5TlYszXk8WStj4pLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-zzrc9byxONG8ojK38UppPQ-1; Wed, 24 Apr 2024 05:23:14 -0400
X-MC-Unique: zzrc9byxONG8ojK38UppPQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34b5bece899so1431865f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950594; x=1714555394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AssHIO3VvfTUux2rCuscSCwR8gSBFHOzhHWhVW5L1Nc=;
        b=JHM/y9qKAosCjdbG+x+a5gxdd8Lkvy1ECpwJ6/Qn7qiPWKyJLPlq6Xh+qsekbqf5mX
         Dm7F0trJ0RyBjeVGgQIZe4H6pV4u3tkiLltqlmNkj8NgQ9y57rgJ2ADn3xCfV5oxUNxu
         Qic7DNyMdmbyrNXKiO1KQfXhZJ2u2qLWRbV3GBSqzUXUNK/YEtYjnawldL1ly7mvF9PA
         diQ90CF/C0ar6KT/wh6qZ9BWPj9T/KRWcoyNHC7X05xacKDG7K4S/UP0DLN77EYEWFk0
         eiGRKfJDizmxihgc2YMJTRMmaghWZ6ZDfr3Ap0sq10sNDr6GLzrKJ6hfZO49mnXxS8ZM
         mnXg==
X-Forwarded-Encrypted: i=1; AJvYcCVVa+BLFxy+Wmn7hkBzqvikxHFPX+uobAT97osbDphUENT68TxlGNiLY4wk1MHFouY+5RQBroKX9fDMX3TIYoDZO8yhOk/AYZ/s8yvx
X-Gm-Message-State: AOJu0YwD1OQrsGnAdpIQohcEqHJAQvKj/6Kx85P8KguEgtufyA8kUtNQ
	ouj9l2fV401ISBl0GMq2c4mIV6tLRX5XcRwBxIw4a/iALzcJNj5seArUEVvNtkbKzSw5yVv4rcM
	7E9MwckDArwtLahAn/Ti/nOFfiRil0mBfQfsQxB6eHAyj7ykbl/0tRUlAr1Hl0A==
X-Received: by 2002:a5d:5581:0:b0:346:305c:b0eb with SMTP id i1-20020a5d5581000000b00346305cb0ebmr1232545wrv.22.1713950593767;
        Wed, 24 Apr 2024 02:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZI0XljlkmGfMm6bHycu8l8UnnsK6poVO81jpHTyzkE/qoi5wGjXy4wj72Gwrz6+jCvRQTVw==
X-Received: by 2002:a5d:5581:0:b0:346:305c:b0eb with SMTP id i1-20020a5d5581000000b00346305cb0ebmr1232518wrv.22.1713950593363;
        Wed, 24 Apr 2024 02:23:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b0034335e47102sm16556281wrv.113.2024.04.24.02.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:23:12 -0700 (PDT)
Message-ID: <49d85e19-feac-417b-9640-ff8059bc8b0b@redhat.com>
Date: Wed, 24 Apr 2024 11:23:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,swap: cleanup VMA based swap readahead window
 calculation
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Alistair Popple <apopple@nvidia.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Minchan Kim <minchan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 Kairui Song <kasong@tencent.com>, Barry Song <v-songbaohua@oppo.com>,
 Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>
References: <20240424063042.665018-1-ying.huang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240424063042.665018-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 08:30, Huang Ying wrote:
> When VMA based swap readahead is introduced in commit
> ec560175c0b6 ("mm, swap: VMA based swap readahead"), "struct
> vma_swap_readahead" is defined to describe the readahead window.
> Because we wanted to save the PTE entries in the struct at that time.
> But after commit 4f8fcf4ced0b ("mm/swap: swap_vma_readahead() do the
> pte_offset_map()"), we no longer save PTE entries in the struct.  The
> size of the struct becomes so small, that it's better to use the
> fields of the struct directly.  This can simplify the code to improve
> the code readability.  The line number of source code reduces too.
> 
> No functionality change is expected in this patch.

 From a quick scan, you perform quite some unrelated changes that make 
the code harder to review than it should be. Consider separating any 
cleanups from the core change of removing the struct.

-- 
Cheers,

David / dhildenb


