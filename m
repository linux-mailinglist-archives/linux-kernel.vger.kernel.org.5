Return-Path: <linux-kernel+bounces-161859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9D48B5255
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812761C210A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8814005;
	Mon, 29 Apr 2024 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxYPCea8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9E1426E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375703; cv=none; b=hXFzSpWDgSFNzifjhecf7rpfoGv1+DyJvkr1oM8pNql12qTkumDnnyLJ0bafqoZfjzzfyO5fhEDpA9MjfxgFlMZ3rd0T2jd4S3qs7VzV92LbW0/3STzPhQnYFNfBXGJ+bFdFJsjAifeQ5mMU+XdPu26zegyJQwFpKxqlf1bG8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375703; c=relaxed/simple;
	bh=P9Wqx63N5WGuWnF5mf7NUb6zX60Q1nAduw+Zraeyf0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGJBkKGtle5vPMJsAfIFGMSHA7zx4SsYJLr6m6kJ6LSOAaJmuqBAFRdl+SCEx5ENlVN89Nqtfs4yUeNypqq4Ss3BcEcVfdDM0F1VolMu1/Pjc0VwFYtRdFy7JXHgKvCAwfKbD6JCyLC9Lkt5abU55GtayFtISCdm5B35DdhhM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxYPCea8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714375701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cvk/1BQhJGHBnC+9vTgpWzwo2+JxkDT/T0cWgWhwzYE=;
	b=GxYPCea868mHl7v79J/xYCZUNAfqFKOTpUIuWggbvYnN0ilU0XuiwUG87naNZnPLvZY/Af
	qbGcBygNcm7Apvv1CtSTPSkeAWG/AOJ4Zrgu7nmtjw60t31AcBdJfKvbDFoLM44AtTO10g
	0n+/k8TUXrz2GwuauhOw7ytzXt9NI/Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-wtKBQ9tFMuKYVz-GqzYzNA-1; Mon, 29 Apr 2024 03:28:19 -0400
X-MC-Unique: wtKBQ9tFMuKYVz-GqzYzNA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51d43b2d6bbso715159e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714375698; x=1714980498;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cvk/1BQhJGHBnC+9vTgpWzwo2+JxkDT/T0cWgWhwzYE=;
        b=MU/A6T4554TE8ejMlkisc17KhG6Q9ajBd51EUzZlYheCbHrzpEJi9FfFTsRp9YlToD
         5OaYpchZt5kAZukDmLYE/ZurSDT3jzbRSLXfJyvX59HF4515YLFQI1MwwTF0QISyCok/
         knM4+4/+e54LzMZgWUK3w3OQFlBdhFOZL/hEoej8+DpO7xz4EsuqB8T9FMqMrB7Otblp
         lG63yhrRZzZ+ZG4MSGxpMfdc3WwXPd79hetZY+ZGITVmSi2htRxyk7J/PT0DosKX5RfD
         B9C/Rfly25ZI4rMrNxNdKkjX6eb8Y0On4xXPlGhOIjX5nHkpboNe44bz1TPrgsagfYEt
         D6wg==
X-Forwarded-Encrypted: i=1; AJvYcCU1n1yCoa7jcxDvRPu+pPF2XQEXm4DBuesAEEJpUUmQg5rPjinN4vV6J1cEhnKHh0muqkNIpjLxAHS/xfn/70Yexcy9UcczzcTMlKgn
X-Gm-Message-State: AOJu0YxYXJvuwNFuvxlxX7vF3EZtvUJNJlRX4ezABlyqyZ6job1MzhhM
	J6S+kbShCxKDfa5EsAuJQlyYoIrrTkNSjn6KAZ7q6AWA36/dSrcyjzV9wqDgZ2aqVddPZTclEmi
	asudaVOBGhgiUY9FvwFbO5+Mnvrv0nmwDlk6ygCQDbEzJqp9W4F3F9CCv91XRCw==
X-Received: by 2002:ac2:53ae:0:b0:519:8963:c678 with SMTP id j14-20020ac253ae000000b005198963c678mr5286487lfh.23.1714375697985;
        Mon, 29 Apr 2024 00:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2xBqHF+Gm5IgSRk31VB4fk50gTzZMJQYQTFhqjK+hx6dJOKX9z/wYtwrvQUMQQOfFxv83AQ==
X-Received: by 2002:ac2:53ae:0:b0:519:8963:c678 with SMTP id j14-20020ac253ae000000b005198963c678mr5286430lfh.23.1714375696658;
        Mon, 29 Apr 2024 00:28:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:e700:f1c5:285b:72a5:d8c8? (p200300d82f26e700f1c5285b72a5d8c8.dip0.t-ipconnect.de. [2003:d8:2f26:e700:f1c5:285b:72a5:d8c8])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm38203119wms.32.2024.04.29.00.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 00:28:16 -0700 (PDT)
Message-ID: <4171dbb6-81c0-4553-a405-a55f75be4cb7@redhat.com>
Date: Mon, 29 Apr 2024 09:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/selftests: Don't prefault in gup_longterm tests
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Lorenzo Stoakes <lstoakes@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20240428190151.201002-1-peterx@redhat.com>
 <20240428190151.201002-3-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240428190151.201002-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.24 21:01, Peter Xu wrote:
> Prefault, especially with RW, makes the GUP test too easy, and may not yet
> reach the core of the test.
> 
> For example, R/O longterm pins will just hit, pte_write()==true for
> whatever cases, the unsharing logic won't be ever tested.
> 
> This patch remove the prefault.  This tortures more code paths at least to
> cover the unshare care for R/O longterm pins, in which case the first R/O
> GUP attempt will fault in the page R/O first, then the 2nd will go through
> the unshare path, checking whether an unshare is needed.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/gup_longterm.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index ad168d35b23b..488e32186246 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -119,10 +119,16 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   	}
>   
>   	/*
> -	 * Fault in the page writable such that GUP-fast can eventually pin
> -	 * it immediately.
> +	 * Explicitly avoid pre-faulting in the page, this can help testing
> +	 * more code paths.
> +	 *
> +	 * Take example of an upcoming R/O pin test, if we RW prefault the
> +	 * page, such pin will directly skip R/O unsharing and the longterm
> +	 * pin will success mostly always.  When not prefaulted, R/O
> +	 * longterm pin will first fault in a RO page, then the 2nd round
> +	 * it'll go via the unshare check.  Otherwise those paths aren't
> +	 * covered.
>   	 */
This will mean that GUP-fast never succeeds, which removes quite some testing
coverage for most other tests here.

Note that the main motivation of this test was to test gup_fast_folio_allowed(),
where we had issues with GUP-fast during development.

Would the following also get the job done?

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index ad168d35b23b7..e917a7c58d571 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -92,7 +92,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
  {
  	__fsword_t fs_type = get_fs_type(fd);
  	bool should_work;
-	char *mem;
+	char tmp, *mem;
  	int ret;
  
  	if (ftruncate(fd, size)) {
@@ -119,10 +119,19 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
  	}
  
  	/*
-	 * Fault in the page writable such that GUP-fast can eventually pin
-	 * it immediately.
+	 * Fault in the page such that GUP-fast might be able to pin it
+	 * immediately. To cover more cases, don't fault in pages writable when
+	 * R/O pinning.
  	 */
-	memset(mem, 0, size);
+	switch (type) {
+	case TEST_TYPE_RO:
+	case TEST_TYPE_RO_FAST:
+		tmp = *mem;
+		asm volatile("" : "+r" (tmp));
+		break;
+	default:
+		memset(mem, 0, size);
+	};
  
  	switch (type) {
  	case TEST_TYPE_RO:
-- 
2.44.0


-- 
Cheers,

David / dhildenb


