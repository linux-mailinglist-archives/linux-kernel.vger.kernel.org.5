Return-Path: <linux-kernel+bounces-37938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21F83B884
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724FA28692A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5DF7464;
	Thu, 25 Jan 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WqgOG0dd"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A76FC3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155000; cv=none; b=ttI6WVKuH39b9+m1VX4jbK7krFWR6mbxWwG6mTi3mJTNI83ZOryU2+/KzkF0LFc7bZnoL+YXTHZtrmwyKvRzAXGCg1jqUwdrVY3UHs93f0yTJVMvXO4HRcQbmuw6KNldzKSkocpLCwh/zW9LHIcaTkeS32/Ikj765HRkk0WPK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155000; c=relaxed/simple;
	bh=T0c9gH8I9bbYuL1Ug/M2YdZmyYOX5MRcwZvrNy4XHv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lv1FBXDsnQ/l5XUZQy6fatTZnW5RODdzrqEUOI4DjIzKUqeys+qvETuInyRriv+Fvp50pXySkn4X50YQVJJB7jFoAwbvaYQwxhdwjXh/IwB73NGKZCnnorhmNyhTlwV4Z88H6Zo7aXgqQmD7/zxOnK/ujSLLK1s+6Rwsf3ONTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WqgOG0dd; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd483e40-f6ad-4fc2-bfc8-468d93e07ea9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706154995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ejp8VHBDj1AdDFZcvCgj41MZXiNxrrGKntHro4P/XIo=;
	b=WqgOG0ddtuHTY4S6GoOjGtCQZGFrbdA9VvHCzPJ55YfdomgXf1qpZwrd+/+TL9PlS+yjVb
	ZC+j2DJ8pJN9A0Qj1HgSeYui6DLTjjhuAkRVOIm+bgBvggQ4ccDFXCYVSmrqbk5155GUc3
	8+8AtsWFKJ7U44LJ//wlxhSkBcXzS9I=
Date: Thu, 25 Jan 2024 11:56:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/7] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-8-gang.li@linux.dev>
 <da1258e3-f828-4bbc-a2c2-8fe1ef808c9a@linux.dev>
 <ef5b09e9-8cfb-4e74-89d4-5ebde12361cf@linux.dev>
 <15E775EC-8E4B-4145-8931-067DF60E55F1@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <15E775EC-8E4B-4145-8931-067DF60E55F1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/25 10:48, Muchun Song wrote:
>>>> +    if (huge_boot_pages[0].next == NULL) {
>>> It it not intuitive. I'd like to use a 'initialied' variable
>>
>> Would it make the code look a bit redundant?
> 
> What is redundant?
> 

I was thinking of adding a global variable at first, but it's possible
to add a local static variable, which is more concise.

