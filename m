Return-Path: <linux-kernel+bounces-33813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF075836EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AE52912BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5063404;
	Mon, 22 Jan 2024 17:26:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99263400
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944365; cv=none; b=hAzKWQmLlkQXJAMif4mTiUO6uP1dcAW2kJleTKQf/q49bjUDqh1JYWYYlfq5qxBb9FvsgTccVA2fwb5ngn8u0NtRxFcZjR619eMCUBTMIm+cIPNQl3ZA9ii3Y04S/3ZMF0pu/tGQiCdAGyxVsZHR1z7sLNSRDmb8xlvmjnxEz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944365; c=relaxed/simple;
	bh=jEAwPjrNMM6j6iAOQn2Ez7Kg8sSTiCKpeKjzu7KJIP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1RZlmnX623XA2n6l+9vGuNap9+9AvjBshtT0LyXFGXnTslhiZgwKWyaJ5pbDCfHNCxrkAWO7NlMgZhe/HsyJt9zghJo6Giw5XtcZwfdHWYnWW5vgDK+qtrqayiR3w+/SYPWN/s7xgvGg7xKlZ/tSO/TjsOPCpKLAkN67GYT+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607361FB;
	Mon, 22 Jan 2024 09:26:49 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04EC13F5A1;
	Mon, 22 Jan 2024 09:26:01 -0800 (PST)
Message-ID: <c8763420-69c8-4e22-ab87-ad702d5abb34@arm.com>
Date: Mon, 22 Jan 2024 17:26:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/40] mm/memory: page_remove_rmap() ->
 folio_remove_rmap_pte()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-29-david@redhat.com>
 <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
 <007e83fa-16c7-4700-b326-ee8cb7809f9f@redhat.com>
 <Za6jxXIFjnCnyvPE@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Za6jxXIFjnCnyvPE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 17:20, Matthew Wilcox wrote:
> On Mon, Jan 22, 2024 at 06:01:58PM +0100, David Hildenbrand wrote:
>>> And folio_mark_dirty() is doing more than just setting teh PG_dirty bit. In my
>>> equivalent change, as part of the contpte series, I've swapped set_page_dirty()
>>> for folio_mark_dirty().
>>
>> Good catch, that should be folio_mark_dirty(). Let me send a fixup.
>>
>> (the difference in naming for both functions really is bad)
> 
> It really is, and I don't know what to do about it.
> 
> We need a function that literally just sets the flag.  For every other
> flag, that's folio_set_FLAG.  We can't use __folio_set_flag because that
> means "set the flag non-atomically".
> 
> We need a function that does all of the work involved with tracking
> dirty folios.  I chose folio_mark_dirty() to align with
> folio_mark_uptodate() (ie mark is not just 'set" but also "do some extra
> work").
> 
> But because we're converting from set_page_dirty(), the OBVIOUS rename
> is to folio_set_dirty(), which is WRONG.
> 
> So we're in the part of the design space where the consistent naming and
> the-obvious-thing-to-do-is-wrong are in collision, and I do not have a
> good answer.
> 
> Maybe we can call the first function _folio_set_dirty(), and we don't
> have a folio_set_dirty() at all?  We don't have a folio_set_uptodate(),
> so there's some precedent there.

Is there anything stopping us from renaming set_page_dirty() to
mark_page_dirty() (or page_mark_dirty())? For me the folio naming is consistent,
but the page names suck; presumably PageSetDirty() and set_page_dirty()... yuk.

