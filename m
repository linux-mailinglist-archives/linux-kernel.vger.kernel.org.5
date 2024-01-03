Return-Path: <linux-kernel+bounces-15487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E56822C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89C91C2310C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C618EA0;
	Wed,  3 Jan 2024 12:04:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC45018EAA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B176C15;
	Wed,  3 Jan 2024 04:05:03 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49BD33F64C;
	Wed,  3 Jan 2024 04:04:16 -0800 (PST)
Message-ID: <2f4a5ea1-daa2-4ede-bdc0-6692d7d52e8c@arm.com>
Date: Wed, 3 Jan 2024 13:04:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] list: Add hlist_count_nodes()
To: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20240103090241.164817-1-pierre.gondois@arm.com>
 <CANpmjNPsBUJy6tkOdRSJyWrS9CMUOQhQyb7_hwmw68pjjiEDWQ@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CANpmjNPsBUJy6tkOdRSJyWrS9CMUOQhQyb7_hwmw68pjjiEDWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marco,

On 1/3/24 12:25, Marco Elver wrote:
> On Wed, 3 Jan 2024 at 10:02, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Add a function to count nodes in a hlist. hlist_count_nodes()
>> is similar to list_count_nodes().
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> Is this patch part of another patch series? As-is, this will be dead
> code, and there's no guarantee someone will just go and delete it in
> future. Although this function looks useful, we also should avoid
> adding new dead code.

The function is indeed not used in the project right now. I needed
it for a private module. If it helps integrating the function and
not make it dead code, maybe I could add usages at the following
places:
- drivers/gpu/drm/drm_hashtab.c::print_binder_node_nilocked()
- drivers/md/bcache/sysfs.c::bch_cache_max_chain()

Regards,
Pierre

> 
>> ---
>>   include/linux/list.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/include/linux/list.h b/include/linux/list.h
>> index 1837caedf723..0f1b1d4a2e2e 100644
>> --- a/include/linux/list.h
>> +++ b/include/linux/list.h
>> @@ -1175,4 +1175,19 @@ static inline void hlist_move_list(struct hlist_head *old,
>>               pos && ({ n = pos->member.next; 1; });                     \
>>               pos = hlist_entry_safe(n, typeof(*pos), member))
>>
>> +/**
>> + * hlist_count_nodes - count nodes in the hlist
>> + * @head:      the head for your hlist.
>> + */
>> +static inline size_t hlist_count_nodes(struct hlist_head *head)
>> +{
>> +       struct hlist_node *pos;
>> +       size_t count = 0;
>> +
>> +       hlist_for_each(pos, head)
>> +               count++;
>> +
>> +       return count;
>> +}
>> +
>>   #endif
>> --
>> 2.25.1
>>

