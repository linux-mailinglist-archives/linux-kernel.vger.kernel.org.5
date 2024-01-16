Return-Path: <linux-kernel+bounces-28279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40382FC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E9FB2117D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4695528E34;
	Tue, 16 Jan 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZD1zCV09"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A128E2E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439047; cv=none; b=n2l4f6FDEnutWS2bMvlEeWffRHoR15+A3B7FfP3/L30+cegvXWeMcGIxEUZxVJB6/g2PLosxBElLkGXvrsbTC8aHkB5EVcf/pJkDNddr1HKdHln6jG8+kYAx86kIs0/tO8FG1+KvKjldV3yhz5W4jreZJ++TTKz+D++Jt/fcDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439047; c=relaxed/simple;
	bh=c4eqrVWav+vUO8xRH/UrscPT4NRVYA62fawyfomcagQ=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=JvPB04slIQLtUYUT/Fx3zi8gMd5414urJljDt1AlV+C6SnKyXCS5CHKKlmfd2t1qS4qpWfhjY8HCg9QgOIU5qPxttPT8yd3t1CXzFHsKVt69QhQJa4K6xk22KCU0+WjgmZj53KMT2XXHxi5lVliPKGyEF5h+rJA0Ibtn7V6zStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZD1zCV09; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aa38REvmK5S3+j3Zy/vUzY/XryNOBNttaU4QwgDik0U=; b=ZD1zCV09Oq+I4rJmtS5wN0PRm0
	fJdNb3aM9r36OOMvAs/5QRE/5R5VZWc8WcrWXNXB+1rD/feUafNjoeT60278cBB2T/W/Kr2EiUt11
	D2iXWz/8ZfP0lmqUMo8xOGNjvC+GalOYOn3N3hA1c9r1pSAfVpnAHYjFFw9z2v7dNaPK4Z06kJRye
	2oPeRc2z/bU6dwFsUnziV3hqKQCrc5mpRYF1pPl6XkNuTB8LHKimYLg6oUADJ3zSuPtreFTGjCz0q
	QHpK+JajFA/UTuV8pjoX/vmdNJ1UgZvhs4E7UBuRlMC7hmmUNZW1CXkFHwtY84I/sp3S8xQ46V2n4
	L/KIfjZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPqb4-00EFWM-Lp; Tue, 16 Jan 2024 21:03:46 +0000
Date: Tue, 16 Jan 2024 21:03:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	akpm@linux-foundation.org, hannes@cmpxchg.org, sjenning@redhat.com,
	ddstreet@ieee.org, vitaly.wool@konsulko.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
Message-ID: <ZabvMpeoKzTMUS2U@casper.infradead.org>
References: <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
 <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
 <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>

On Tue, Jan 16, 2024 at 09:40:05PM +0800, Zhongkun He wrote:
> 2)  __read_swap_cache_async has six parameters, so there is no space to
> add a new one, add_to_lru_head.

That's easy enough.  Define a new set of flags, make one of them the
equivalent of skip_if_exists.  Something like:

typedef unsigned int __bitwise read_swap_t;

#define READ_SWAP_SKIP_EXISTING	((__force read_swap_t)0x00000001)
#define READ_SWAP_ADD_TAIL	((__force read_swap_t)0x00000002)

There's only six callers of __read_swap_cache_async() to convert, so not
really a big deal.


