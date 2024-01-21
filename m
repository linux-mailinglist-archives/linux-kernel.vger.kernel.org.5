Return-Path: <linux-kernel+bounces-32112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77878356A1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CCB2169D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD789381AA;
	Sun, 21 Jan 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYnCihpF"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A2381A2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854072; cv=none; b=DbduyxNClfEvzTNjiFIvqZu0uJxoDLLDS6ygKNpycV4ldcBovmx2QwPUqkKYUdNYBK+OSpq9S6XXNV/+Z/7rKfbvCVJQtXrO2/u46BHp0xC6jviDy2eaxhff0UEp2b38JZd+dpqCyA6NaTtCC6xgR+7mc1jQbfQ3aHdMpZfDkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854072; c=relaxed/simple;
	bh=yDdC5tBAxvzcikBB9KG2F8MDWDYpBOZB8Jo/oIKCNuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKmmyYfEwI67PgcI6vfp/PAGhk2qyFVKN8JwL/xISfxshj/HOawj4tQGpgSPicyM3rhQuDaleWHBYTqv3jGlNo+OW957eLgttbhU5JA0XX+ydVjowJi/3neGPZoON9nEn6ABVKAw/fr0VJuKDE4KjYXGqVLJx8i23Qi1yPGOJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYnCihpF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Jan 2024 11:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705854068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ts6kn1ch6u/0ir7Mzbe1G7MWZ+8nRG72MIJ86Jeik=;
	b=KYnCihpFTfCsgFhHdxx/J8lV5FP+ligV+ws6saJxJOqBolHl83FMgwseDT26tN1g/SadEL
	do0v9oaqcP41dg1KkXfFVxm3cvHBWeT5c9UBGKUbP9iEp93gtFE8KCu1UW/YvDbw3O1fIg
	2zpUL4X4fQ2AzFfJjgbSrbw5FSP4F8Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, bfoster@redhat.com, jserv@ccns.ncku.edu.tw, 
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 0/5] Optimize number of comparisons for heap/heapsort
 implementaion
Message-ID: <nl6kvjxg4gia5pbfb4jibxusvavmlwumrvy3swfs33ciub32wt@2kmeqnqycxxh>
References: <20240121153649.2733274-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121153649.2733274-1-visitorckw@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 21, 2024 at 11:36:44PM +0800, Kuan-Wei Chiu wrote:
> Hello,
> 
> The existing implementations of heap/heapsort follow the conventional
> textbook approach, where each heapify operation requires approximately
> 2*log2(n) comparisons. In this series, I introduce a bottom-up variant
> that reduces the number of comparisons during heapify operations to
> approximately log2(n), while maintaining the same number of swap
> operations.
> 
> Thanks,
> Kuan-Wei
> 
> Kuan-Wei Chiu (5):
>   bcachefs: Optimize eytzinger0_sort() using bottom-up heapsort
>   bcachefs: Introduce parent function for sort_cmp_size()
>   bcachefs: Optimize sort_cmp_size() using bottom-up heapsort
>   bcachefs: Optimize number of comparisons in heap_sift_down
>   bcache: Optimize number of comparisons in heap_sift
> 
>  drivers/md/bcache/util.h |  23 +++++----
>  fs/bcachefs/util.c       | 109 ++++++++++++++++++++++++++-------------
>  fs/bcachefs/util.h       |  23 +++++----
>  3 files changed, 98 insertions(+), 57 deletions(-)

Good stuff

While we're looking at this code, we should be doing some cleanup too -
there's no reason for the heap code to be duplicated in bcache and
bcachefs anymore, and it'd also be nice to get fs/bcachefs/eytzinger.h
moved to include/linux and bcache converted to use it.

I also would not be surprised if there's another heap implementation in
include/linux; we'll want to check for that and if there is decide which
is worth keeping.

Would you or Coli be interested in taking that on as well?

