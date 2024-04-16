Return-Path: <linux-kernel+bounces-146486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A810A8A65E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60160282302
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB26D1AB;
	Tue, 16 Apr 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXem7K2i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E701E51F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255393; cv=none; b=UHv2Uf+lXut9CcS2UN4AT9g18O+S8Sm+4HaWYppnadr/cK7A7xncjxdTEStJ+UA76XaxDY9LPpSUas1x6ncoSyl6+mnKpFMmgqr3bL90em3KNyrSUcVpREJyABfo4NSTavTdzBHBRWo7z9ChAbg9/XjJA0c/h1W7zpqgmpDtIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255393; c=relaxed/simple;
	bh=4NrddweL3ZdPc38M8w5kzduxNdfS6epsF1Lo1GdnUPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMHNIHbh696nq9CjlWbGKyZaCAMkg89ytpoRcGvdff8LnEGEOTXphKafv4L82Rt2s/TK84vLvn8VyWtX5GMnimOZLVDEanQUZnCykTN7Ev9Oe/LxqUcmyiYEvEwqdZAM2tKA1gYJp05XCXy9nqEt1CFjn1UZniAor0qVAzZl6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXem7K2i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713255388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GjxDFmTv83GTdla1FKDv4tnI7NcoldxshbtNwzLPCnk=;
	b=cXem7K2iGvakJdEfRDky4DDBPoZzcNmPr5pdGqA9oArHshUBkHASQDhIYo66zvV1+3w2aR
	M4CzzeqGwRvA0fSigh2AZxkVNeONRs5VpGK9SG4SIwVIu1SmgpPgq+FugV1UQqzurcneHQ
	oSO3YWRx8bgkeGsZRUrXVVaCYnxL7P4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-GqVeqpoNMvig2nCIi0syNQ-1; Tue, 16 Apr 2024 04:16:26 -0400
X-MC-Unique: GqVeqpoNMvig2nCIi0syNQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-515d139f285so2750077e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255385; x=1713860185;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjxDFmTv83GTdla1FKDv4tnI7NcoldxshbtNwzLPCnk=;
        b=D/ep2+sgcYX+R19ulVYcD0ekUlnd1oCErD2QSSpYIluA8s023OuDSKeAdmwPiYd65y
         icVV6T/Z92pP8KRFS4lMl3c6MXqSl+5dEVbSD1CnXqe1iGn9MfEdhUM6pfzv3P7iqIPx
         KpkZmUtZNmMypYZGubxeZJeBnztIgBn/gtOnl4DZPYwC/vizxA5E0DtSrrO9AcQJQPFg
         X2s+d5H3aMzH7dQESDowNIfG82MKu8ZOyiQOUkjEbBDLl43fmb50kCbYM3x0yZAu4rlE
         YmLxnKcXACiBwAFWOUSbPC8aMdHINqsExt8xMIDjneXlAwgQn9XbsV8XckJgU6MHISVg
         Nynw==
X-Forwarded-Encrypted: i=1; AJvYcCWaeDH6RFKkEbX9Aw2hO6dj3QeST0ENphMpK7i/j7BcAaLVw+YsKcZbTPpuwN5y5hTryVVmqUUsBiUCuXV3VJs9kvsRLv/WBvgaLg2A
X-Gm-Message-State: AOJu0Yxs1cN/dcxPyq/gm33Mvv/3AKGWJpeYfYPHCruR0pBg4vZOqDKc
	Sm7weKzmsT11Yv8BdYjLcW4qQLFMsxfKDNuQVJVyPcYDBDQQ4N0MHk3IWZn/bImuYcgsFPbwysA
	AG63CYeZ+JbwPJO6enI1zDSn4W8CLOvlTtDzQ9qsiePuoc5p9ryHOjxLPjnps9A==
X-Received: by 2002:ac2:46c9:0:b0:516:fe8c:ef9b with SMTP id p9-20020ac246c9000000b00516fe8cef9bmr6936132lfo.57.1713255385070;
        Tue, 16 Apr 2024 01:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8jl71f1UcNhTc3sFovRvdhxM/4PWvun8WCOVeM1+zuNgEVuoagRbMkwsdRpbKFXV8cFEHVw==
X-Received: by 2002:ac2:46c9:0:b0:516:fe8c:ef9b with SMTP id p9-20020ac246c9000000b00516fe8cef9bmr6936114lfo.57.1713255384697;
        Tue, 16 Apr 2024 01:16:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d5388000000b0034335f13570sm14158800wrv.116.2024.04.16.01.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:16:24 -0700 (PDT)
Message-ID: <e959e26b-41c9-47d0-bd74-f6493a354353@redhat.com>
Date: Tue, 16 Apr 2024 10:16:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] mm: correct the docs for thp_fault_alloc and
 thp_fault_fallback
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
 <20240412114858.407208-5-21cnbao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240412114858.407208-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 13:48, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The documentation does not align with the code. In
> __do_huge_pmd_anonymous_page(), THP_FAULT_FALLBACK is incremented when
> mem_cgroup_charge() fails, despite the allocation succeeding, whereas
> THP_FAULT_ALLOC is only incremented after a successful charge.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


