Return-Path: <linux-kernel+bounces-108429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF80880A69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854C228383E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BB14271;
	Wed, 20 Mar 2024 04:40:10 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A95125CE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909610; cv=none; b=JeNnnXtulCUVQJDY5LYJqeXzGyevMaKIMSH+8yCYSGV0+IPgChWH96IQpxaNl9M9BS4GIFw+nwvpdNM7smxME5m75Tytt3PPkSF6vlBLqvEG8aT1pjtFu074+TkWk95t54zUm2dmpjqROZmUWSc853pq3RvPuMWNoX15F+khK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909610; c=relaxed/simple;
	bh=7bQNjax0hyfRA1i5Jf8lHbqNrgSAIppOzgPROaQauPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnJ4K4fJ+3MnEKJnzxwb5CUqi7EZPlo/ckUf/zBd4ll7Q/3ey9rSBXVwCPEqJ0WM54f+jCeDZBDi0/wG//5NEFo0AZjVpSP4ejNBCsqsibUx/+bqhzUXpwNxxlhkv8aAgGdG4mOfLoD+RNW1W+lk1+D27+HZqQoR7Mp6oXJgfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K4e6fk072344;
	Wed, 20 Mar 2024 13:40:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 20 Mar 2024 13:40:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K4e5tH072341
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 13:40:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d82aedb5-9406-4808-96b4-1d9ef63485a3@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 13:40:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-2-osalvador@suse.de>
 <20240319162430.3e76504d06f12edc107029a4@linux-foundation.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240319162430.3e76504d06f12edc107029a4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/20 8:24, Andrew Morton wrote:
> On Tue, 19 Mar 2024 19:32:11 +0100 Oscar Salvador <osalvador@suse.de> wrote:
>> -static void dec_stack_record_count(depot_stack_handle_t handle)
>> +static void dec_stack_record_count(depot_stack_handle_t handle,
>> +				   int nr_base_pages)
>>  {
>>  	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
>>  
>>  	if (stack_record)
>> -		refcount_dec(&stack_record->count);
>> +		refcount_sub_and_test(nr_base_pages, &stack_record->count);
>>  }
> 
> mm/page_owner.c: In function 'dec_stack_record_count':
> mm/page_owner.c:226:17: error: ignoring return value of 'refcount_sub_and_test' declared with attribute 'warn_unused_result' [-Werror=unused-result]
>   226 |                 refcount_sub_and_test(nr_base_pages, &stack_record->count);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 

Hmm, I guess that this is not an expected user of refcount API.
If it is correct behavior that refcount becomes 0 here, you need to explain like

-		refcount_sub_and_test(nr_base_pages, &stack_record->count);
+		if (refcount_sub_and_test(nr_base_pages, &stack_record->count)) {
+			// Explain why nothing to do here, and explain where/how
+			// refcount again becomes positive value using refcount_set().
+		}

or replace refcount_t with atomic_t where it is legal to make refcount positive
without using atomic_set().


