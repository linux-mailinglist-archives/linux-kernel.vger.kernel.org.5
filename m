Return-Path: <linux-kernel+bounces-70707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100A859B62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FCA1C2146A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2E101D2;
	Mon, 19 Feb 2024 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HiJ84mEA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63022FBE7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316673; cv=none; b=AtWrhqW0VDEvbbatjga1CMRsHRxVNDtuFKcL1Tz4zvtzow3i4O5e/ODWlfJLmfl297RtVCp2a61oFYBPO2HbJ7m/cfWX2wlbfP9QWGnVPueEJEmoXxqz4Pw1WCRQHuKunf15/rNPu/q9wUcGJS5CeqKolpQ7QVXcD/Zdr4JNMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316673; c=relaxed/simple;
	bh=FE0EILapCLyvVGp5OnAstIrCC+u2yV929+hZpgm0nEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPe8FRL9qmrEFTNwCcguE4UGi1giezIIBgbh/TqdprpDCcKKPHwpz+Gjhx9lv7HtQ7GG49b0ME9fq1fUOnfHYoDMwoB1l1YMxbdt6/IAyh11/XD+WX85hvPK3GVY2TW1rvieOMKSIQcLE6wLitj/GB0VyzfmUYxU81rfexnpcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HiJ84mEA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FE0EILapCLyvVGp5OnAstIrCC+u2yV929+hZpgm0nEQ=; b=HiJ84mEAH1xbxVyMEXTEVkNRgd
	Y5ON/fnFA+SAIKTkEx/pkEjmbQFa9vY2YsHIyYNWFhs/0Y8MjBhrWFd8xe/MKlEu880IBYNFZBUoV
	HbV+Uvma92oBuApve1KRymY0LF1efjTT37QTu/cOmjrIUQh3rKyDsrLJ2QJM836LAnuBn2Dg7H1mX
	pRaynmR6T/jLtK/s7swzuxFgeQDC1/9g/OThD7btTqE3SG3Rn4HTkFGiihlKd/t3ATsXcIP1QGVRT
	+qyFdWt32/RuTqBkkYJ4S7E5JxbuzvtIozSUcL4agG1KkK0hxEWMIYX1EvE/37ssyGQBFI7v47URU
	wFgdZTzg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbvCK-0000000Brsb-0Oa1;
	Mon, 19 Feb 2024 04:24:08 +0000
Date: Mon, 19 Feb 2024 04:24:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tkjos@google.com,
	Fangzheng Zhang <fangzheng.zhang1003@gmail.com>,
	Yuming Han <yuming.han@unisoc.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V2 2/2] Documentation: filesystems: introduce
 proc/slabinfo to users
Message-ID: <ZdLX51r1mOEZKUje@casper.infradead.org>
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <20240219031911.10372-3-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219031911.10372-3-fangzheng.zhang@unisoc.com>

On Mon, Feb 19, 2024 at 11:19:11AM +0800, Fangzheng Zhang wrote:
> +Note, <slabreclaim> comes from the collected results in the file
> +/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /proc/slabinfo
> +as deprecated and recommend the use of either sysfs directly or
> +use of the "slabinfo" tool that we have been providing in linux/tools/mm.

Wait, so you're going to all of the trouble of changing the format of
slabinfo (with the associated costs of updating every tool that currently
parses it), only to recommend that we stop using it and start using
tools/mm/slabinfo instead?

How about we simply do nothing?

