Return-Path: <linux-kernel+bounces-49113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE70D8465FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BEC288F14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CFBE79;
	Fri,  2 Feb 2024 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gCsC0g1f"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950CBA48
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842104; cv=none; b=cDXPy8J9ptQKjQkqlnmmv6tQ1VjZICwkJCgyP5cxllmw4Hz/UEEZXHoPGM6CowHF67cxh1zMVRxmB7mfYGyMak06BPWMRwmq9cD4p+yQrDV5hJ8Tn7tVBgGtSzNBXZk5hzic+/e0bwYtg2uTdKua57BtmvKleucnpDgK3r61M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842104; c=relaxed/simple;
	bh=zIIpUuEoGAvnfSEBReTZfSlHCEQaoLye+kascfFXjWc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RXuphnXFBYWGgq7oCdy7QQ0lZJUxJzQ6vn2yd6BjO2lmZ5mqpRBnBI4ihRrRufBZN6a2kJGDDZWSPfAJbwf9WpN8SQGqfdjXmc19cybDVF86dbwlwJYx6UhQxcc8QuDi0kJxj1FTFcKqyZLVxg9lDSvyS70iYq+99SMd+220wbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gCsC0g1f; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706842099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7FTBqL1wruOvwY0oHy4r35LgNgIlPN2kq6tk9075c=;
	b=gCsC0g1fiYWL4j1hVqwtCkt8EfpdQt6ijcnoO92PxSnEglzx7yCrIFc3n6eJN2tOuoke2G
	U61IE+3Uy4EyKKfFTgPgLCOqUDMVJt4BMFyurzixOAJhSsqBBWYQ/5zFm/zKDFGSVecJ6d
	r9FkbIzxCE5zhXf6+MDWztFcBMV9yR8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
Date: Fri, 2 Feb 2024 10:47:41 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 david@redhat.com,
 willy@infradead.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A7CAA1CD-8BD2-4517-BC37-F13E4D9C00CF@linux.dev>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 1, 2024, at 16:05, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> For kernel PTE page, we do not need to allocate and initialize its split
> ptlock, but as a page table page, it's still necessary to add PG_table
> flag and NR_PAGETABLE statistics for it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


