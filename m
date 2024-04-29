Return-Path: <linux-kernel+bounces-163005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A998B634E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5327283489
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665B1411DA;
	Mon, 29 Apr 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrynBSTp"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4611411E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421596; cv=none; b=YGCpPCybq/9MqnizNlDKP+Kjj3AEXRv05+5YM5GcLOdTv9biBnL1VC7A53Bw9P3/U0WEQSzf2xiafqG01LThIr4ujfNXTUBwt+LNV5sqN9lGEXWmrsczJRNMHWgGkgH+DEh/DrAxJz6oFeICI3+AwTTQF4l5K8xigQKaZiSRBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421596; c=relaxed/simple;
	bh=QgerTxy6+NGCL0V2nByCzbiGRtOFxT52kK2sHQmXnxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXLtRlVrov5DLnkiqq02uZu8bT4MP2gpXMCXsejkXa4jZYqh0L/9BKJ/uqsqsT2aBP3u5/p9IFT4+MNxEo8DQ8Qx0an2ipjbviCaIRQ/JtJfJZMu/KL4sJt+1nPLl7iQLWV00qPtt2xE+eMphH9AScK8aVHXgMfNsA3qHbo+mJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrynBSTp; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 13:13:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714421591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpO5NCX7yPwq2W+mZcrPJ8HtJBcgstQPIgknTXB/zH0=;
	b=TrynBSTpKkErpI1SOS8qM8bNSXMhC0m05bv/XRJDKNgYHYo8yr0yAhOhU+1bZld+jm+oIE
	bOQwUobFmJi+1tQ2Evgj9fP8DBYRznWyHkSIVuJC5qxc7RAkgoGKvaTpWZ17/Da+9zTO2z
	4c8OLN+irw+TLW9/EFmUOkCSzQ5Ybws=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <j4dsapl5hu2enzoq5c7y3z2bqksk6fpygkk5t45ok7d5v3gdt2@5ygpjaj2hiva>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-4-shakeel.butt@linux.dev>
 <CABdmKX0Mo74f-AjY46cyPwd2qSpwmj4CLvYVCEywq_PEsVmd9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0Mo74f-AjY46cyPwd2qSpwmj4CLvYVCEywq_PEsVmd9w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 29, 2024 at 10:35:38AM -0700, T.J. Mercier wrote:
> On Fri, Apr 26, 2024 at 5:37 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
[...]
> > +
> > +static const unsigned int memcg_stat_items[] = {
> > +       MEMCG_SWAP,
> > +       MEMCG_SOCK,
> > +       MEMCG_PERCPU_B,
> > +       MEMCG_VMALLOC,
> > +       MEMCG_KMEM,
> > +       MEMCG_ZSWAP_B,
> > +       MEMCG_ZSWAPPED,
> > +};
> 
> Unsigned for these? All the values are positive now, but I don't think
> we'll get a build warning if a negative one ever got added, just a
> crash or corruption. BUG_ON in init_memcg_stats if a
> memcg_stat_items[i] < 0?

We are depending on NR_VM_NODE_STAT_ITEMS to tell the number of elements
for vmstats. So, I think there is an implicit assumption that there are
no negative enums in enum node_stat_item. So, if we want to verify those
assumptions then we should be adding such warnings/build-bugs in vmstat
first.

