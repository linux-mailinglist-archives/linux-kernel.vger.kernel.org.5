Return-Path: <linux-kernel+bounces-99937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45735878F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8CE281B46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7EF69D3E;
	Tue, 12 Mar 2024 08:05:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00569973
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230729; cv=none; b=TvgoxQTWTmIN6cf49HFwxXGnPIe489DlRDhxzFz4ixYlKF1n7EfqBJW/DX6BuPMoHUTDKtHfeV5OlcmnLaMmT8PVPDyoQyzCCXM3lR77ZyKwc3dpU4/oDxDBCT5ZCnstdSt2aD/4/gA0u/sq17gWx6YJy6f7O5YMUNoscy8dBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230729; c=relaxed/simple;
	bh=bl6AfL2X8NIjP+96i5PQItkn9CCWuVzDqSvid1nmuvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nx3VIINUpcCnfSZUm0YDQMxYp+UD7MwqX/rMY2STHUapz2VJTg8XlOqlc7IzH6ZxFTI+akwkeZDfoR5yzOco3rfCCiY4PR6nu6i8/F+a0cTMGr2VPppMgizYLWsSPw0qXE1Wm57LZHwOVr8WCVTGSsoBf4u/pFaMBLnYzzTZpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A041007;
	Tue, 12 Mar 2024 01:06:03 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8433F73F;
	Tue, 12 Mar 2024 01:05:24 -0700 (PDT)
Message-ID: <e3e14098-eade-483e-a459-e43200b87941@arm.com>
Date: Tue, 12 Mar 2024 08:05:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Ze_P6xagdTbcu1Kz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 03:45, Matthew Wilcox wrote:
> On Mon, Mar 11, 2024 at 03:58:48PM -0400, Zi Yan wrote:
>> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>  		folio_lock(src);
>>  	}
>>  	locked = true;
>> +	if (folio_test_large_rmappable(src) &&

I think you also need to check that the order > 1, now that we support order-1
pagecache folios? _deferred_list only exists if order > 1.

>> +		!list_empty(&src->_deferred_list)) {
>> +		struct deferred_split *ds_queue = get_deferred_split_queue(src);
>> +
>> +		spin_lock(&ds_queue->split_queue_lock);
>> +		ds_queue->split_queue_len--;
>> +		list_del_init(&src->_deferred_list);
>> +		spin_unlock(&ds_queue->split_queue_lock);
>> +		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
>> +	}
> 
> I have a few problems with this ...
> 
> Trivial: your whitespace is utterly broken.  You can't use a single tab
> for both indicating control flow change and for line-too-long.
> 
> Slightly more important: You're checking list_empty outside the lock
> (which is fine in order to avoid unnecessarily acquiring the lock),
> but you need to re-check it inside the lock in case of a race.  And you
> didn't mark it as data_race(), so KMSAN will whinge.

I've seen data_race() used around list_empty() without the lock held
inconsistently (see deferred_split_folio()). What are the rules? Given that we
are not doing a memory access here, I don't really understand why it is needed?
list_empty() uses READ_ONCE() which I thought would be sufficient? (I've just
added a similar lockless check in my swap-out series - will add data_race() if
needed, but previously concluded it's not).

> 
> Much more important: You're doing this with a positive refcount, which
> breaks the (undocumented) logic in deferred_split_scan() that a folio
> with a positive refcount will not be removed from the list.
> 
> Maximally important: Wer shouldn't be doing any of this!  This folio is
> on the deferred split list.  We shouldn't be migrating it as a single
> entity; we should be splitting it now that we're in a context where we
> can do the right thing and split it.  Documentation/mm/transhuge.rst
> is clear that we don't split it straight away due to locking context.
> Splitting it on migration is clearly the right thing to do.
> 
> If splitting fails, we should just fail the migration; splitting fails
> due to excess references, and if the source folio has excess references,
> then migration would fail too.

This comment makes me wonder what we do in split_huge_page_to_list_to_order() if
the target order is greater than 1 and the input folio is on the deferred split
list. Looks like we currently just remove it from the deferred list. Is there a
case for putting any output folios that are still partially mapped back on the
deferred list, or splitting them to a lower order such that all output folios
are fully mapped, and all unmapped portions are freed?



