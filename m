Return-Path: <linux-kernel+bounces-50929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF788483E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A4D2891FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9210A13;
	Sat,  3 Feb 2024 05:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kSRMPD0r"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92943F9F5
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 05:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936995; cv=none; b=aBFfuCrRNZsfogCWH4C4LrkydFfsKmy/O7f20ps/UJatEWXoUuy4ybFLpbie4yKDQkku0Nd/s8tfT/x7vsETY2/ahomPeiaXLt0KwHk0EEfpFkHGUIkDxpx2OuakkFOR8TLGzutrBG/uE70zMRnOHpHmwYKw7SI5K5zX47T3YD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936995; c=relaxed/simple;
	bh=qezGF2VBInM9Bz+XV2maPK0/yPRHwebJ149w6bqgpm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gihtf9gY6II1quZDPrxL7zZmg3rircyKnbgrMaWlrGOLL7LeAIt1wqgyDIW/+DkMIGm2cXiPA1lp+IFW9t/zjf/r3JKURBi57/mXmltSRowmxbxrUk4Si/yGMZNVw2qdaObOccLarx1jyUbiNn7Imxlgv5UZ0Zy3MlKDKsrFjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kSRMPD0r; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290fb65531eso2171034a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 21:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706936991; x=1707541791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmu0vpvqC5Lai0mTFBcrp18f/81rnOKK+LVNmR+nrhI=;
        b=kSRMPD0rzWo+xfuQs/izzISgzpqFqtzzyS6q3xD6f7mLT2YrsqJLekvZFOVVPoDuFc
         f3+rdaEZXuMhNDWu9WoSse+8VUU2QTj/rhRfmETM9gkTl4g5Gi0wwL6s9xUZry6YBPPD
         CYK0EEIfA+MsJJ5QOkp5l5mQPAQyHybc/Duyb0HviQbHmr9MYuTUEm6XiR6xQBmmfvYg
         5yXmzVGA7UZ0DWMPS67NWtraR3b3sMoleHp3u1XBlH/T4KeUvT2WCDciE8lMZPmxI5De
         SjhcNqn8QCvd2D6V0Z0sE/ZNUf8OUgAEbSvQEwMWm60FxEwLLZTt6bpMezImuDbWgZQ0
         lxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706936991; x=1707541791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmu0vpvqC5Lai0mTFBcrp18f/81rnOKK+LVNmR+nrhI=;
        b=rXqgZYoWbNai5JDkZJi9p6S+nPHBA00lPaDwXPiGR8ccn2IIZqpGgYKLjRZyvizYM+
         41RjR2Bnaz007iVUbS+qFVHc2uNVe1ZhggRMcZIGry9/E8UCj/el+53Li27NdXWOIPBE
         AOnTBgf43anRF/2kO1+m8EULE5O2kkE7zGDsgiX0/J99kCRx+8EAf0m9drP8La/EVmXa
         dAeumpPQcRbG9Qk4bX0D72mGq2N2QsDYaTBj4HEXkcG1eWhBcDgrcNLnpU7SMXNPw/oP
         Ts6hZ+WpxZmGo3g/2qChSz+WU3Ph65X3I+senkZNdPYGlbi/9RJcCDs1HssgTWGZQzIW
         z0dw==
X-Gm-Message-State: AOJu0Yzus4k6Nwzjg50+yKaBQMzvpnbBw86KvABHLdP6WdJ2H7pNuM6P
	9FlTUkpuGYOXeCAdVNvy1reFoah2g5eALV3bn5mrIi/lYjk6mtRX73e6HwjaeRI=
X-Google-Smtp-Source: AGHT+IEgQJ6wiMQz4b0H0J2ytFxo0Wr/pgHZeyut0e5YLIK++zDDoPa+veu0Wo5vwp//4ugD7FsBgg==
X-Received: by 2002:a17:90a:fa8f:b0:296:6229:aa41 with SMTP id cu15-20020a17090afa8f00b002966229aa41mr1024126pjb.2.1706936991571;
        Fri, 02 Feb 2024 21:09:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQLXbkQlA+wwYDgyyy1Ilfi0sg0IXHZ6Hir8OqaDzNjK7+6sX4fmiwiOAOZILsqi3+tjtCnrI+uShzhkM1GWPEPOhB6tXIpG0J9ACNVFwqQ9Y0NOc2qqbo4eA4cwA3ZNcjdF7/PYLxI9b4hd+w52XwCOxcd6KiIEYhJYvLG4yPQ3iSwtiJjUX1B+xCcAxirGOf2Q==
Received: from [10.4.12.121] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id qn14-20020a17090b3d4e00b0028c89122f8asm950351pjb.6.2024.02.02.21.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 21:09:51 -0800 (PST)
Message-ID: <10f4fb80-a385-4c1e-974b-24057922ca62@bytedance.com>
Date: Sat, 3 Feb 2024 13:09:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
 <CAKEwX=MOcmUjtrYOJCwh3unRT7OKdrvtR-FFdSevNf5i7z=Q=A@mail.gmail.com>
 <CAJD7tkb9q5FQqwUTH3kJtEcWB57Kua_RJ7zmDdq9KXgVegs=XQ@mail.gmail.com>
 <CAKEwX=P0Mov3Aqazy8eLkC23wxpocVDf5oyQ6gJA1sK-Zv-BMw@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=P0Mov3Aqazy8eLkC23wxpocVDf5oyQ6gJA1sK-Zv-BMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/3 06:44, Nhat Pham wrote:
> On Fri, Feb 2, 2024 at 2:37 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Fri, Feb 2, 2024 at 2:33 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>>
>>> On Thu, Feb 1, 2024 at 7:50 AM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> Since we don't need to leave zswap entry on the zswap tree anymore,
>>>> we should remove it from tree once we find it from the tree.
>>>>
>>>> Then after using it, we can directly free it, no concurrent path
>>>> can find it from tree. Only the shrinker can see it from lru list,
>>>> which will also double check under tree lock, so no race problem.
>>>>
>>>> So we don't need refcount in zswap entry anymore and don't need to
>>>> take the spinlock for the second time to invalidate it.
>>>>
>>>> The side effect is that zswap_entry_free() maybe not happen in tree
>>>> spinlock, but it's ok since nothing need to be protected by the lock.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> Oh this is sweet! Fewer things to keep in mind.
>>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>>>
>>>> ---
>>>>  mm/zswap.c | 63 +++++++++++---------------------------------------------------
>>>>  1 file changed, 11 insertions(+), 52 deletions(-)
>>>>
>>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>>> index cbf379abb6c7..cd67f7f6b302 100644
>>>> --- a/mm/zswap.c
>>>> +++ b/mm/zswap.c
>>>> @@ -193,12 +193,6 @@ struct zswap_pool {
>>>>   *
>>>>   * rbnode - links the entry into red-black tree for the appropriate swap type
>>>>   * swpentry - associated swap entry, the offset indexes into the red-black tree
>>>> - * refcount - the number of outstanding reference to the entry. This is needed
>>>> - *            to protect against premature freeing of the entry by code
>>>> - *            concurrent calls to load, invalidate, and writeback.  The lock
>>>> - *            for the zswap_tree structure that contains the entry must
>>>> - *            be held while changing the refcount.  Since the lock must
>>>> - *            be held, there is no reason to also make refcount atomic.
>>>>   * length - the length in bytes of the compressed page data.  Needed during
>>>>   *          decompression. For a same value filled page length is 0, and both
>>>>   *          pool and lru are invalid and must be ignored.
>>>> @@ -211,7 +205,6 @@ struct zswap_pool {
>>>>  struct zswap_entry {
>>>>         struct rb_node rbnode;
>>>>         swp_entry_t swpentry;
>>>> -       int refcount;
>>>
>>> Hah this should even make zswap a bit more space-efficient. IIRC Yosry
>>> has some analysis regarding how much less efficient zswap will be
>>> every time we add a new field to zswap entry - this should go in the
>>> opposite direction :)
>>
>> Unfortunately in this specific case I think it won't change the size
>> of the allocation for struct zswap_entry anyway, but it is a step
>> nonetheless :)
> 
> Ah, is it because of the field alignment requirement? But yeah, one
> day we will remove enough of them :)

Yeah, the zswap_entry size is not changed :)

If later xarray conversion land in, the rb_node would be gone, so
one cacheline will be enough.

struct zswap_entry {
	struct rb_node             rbnode __attribute__((__aligned__(8))); /*     0    24 */
	swp_entry_t                swpentry;             /*    24     8 */
	unsigned int               length;               /*    32     4 */

	/* XXX 4 bytes hole, try to pack */

	struct zswap_pool *        pool;                 /*    40     8 */
	union {
		long unsigned int  handle;               /*    48     8 */
		long unsigned int  value;                /*    48     8 */
	};                                               /*    48     8 */
	struct obj_cgroup *        objcg;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct list_head           lru;                  /*    64    16 */

	/* size: 80, cachelines: 2, members: 7 */
	/* sum members: 76, holes: 1, sum holes: 4 */
	/* forced alignments: 1 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));

