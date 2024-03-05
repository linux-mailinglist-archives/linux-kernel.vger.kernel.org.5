Return-Path: <linux-kernel+bounces-91961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A887190F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7604B1F23067
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E750248;
	Tue,  5 Mar 2024 09:08:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E250A60
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629698; cv=none; b=U+YNF0KPQoPLlQi46gyC00creHJe8Sw476FxZ9yHmvQrVqMOsod3Ji6DM6h4nTPxjDpZJiagxTxMezpEJQcFufl4MeJzUp6b3TEsucpJfIdpHwvC2MGabar6t4UDZeX2CMQCXbgsv6AYcZBp5yhdHhzQYnMkxFUBbxo9XmR83ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629698; c=relaxed/simple;
	bh=V6enSNG5S4Ac6DTmQkbJL3q6wOC+k2MTupNQ4UWKnOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adXL9GLKzuQmgofzh2drxZX/AH6LP/f4ksnvuwUd7OgiXfNYcjcPOoTY8nVB3rQVTM3Pi1FCvVcQPSEPkpBWcQotOLjxIByZsZ4CHHprfMFSA1H4XeJQDDmj3XEo/e84Jul2Ux2vmzHnaDpb3amsm6ydtiEGBUakla9/aXHbyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7271FB;
	Tue,  5 Mar 2024 01:08:53 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6D43F762;
	Tue,  5 Mar 2024 01:08:14 -0800 (PST)
Message-ID: <6c16c7c5-8cf4-4c30-b3a5-a9ab55b21114@arm.com>
Date: Tue, 5 Mar 2024 09:08:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com,
 chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, xiang@kernel.org,
 mhocko@suse.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
 Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
References: <20240304103757.235352-1-21cnbao@gmail.com>
 <878r2x9ly3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4yKhoztyA1cuSjGEeVwJfNdhNPNidrX-D_dRazRL7D5hg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4yKhoztyA1cuSjGEeVwJfNdhNPNidrX-D_dRazRL7D5hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 08:56, Barry Song wrote:
> are writing pte to zero(break) before writing a new value(make). while

As an aside, "break-before-make" as defined in the Arm architecture would also
require a TLBI, which usually isn't done for these
write-0-modify-prots-write-back operations. Arm doesn't require
"break-before-make" in these situations so its legal (as long as only certain
bits are changed). To my understanding purpose of doing this is to avoid races
with HW access/dirty flag updates; if the MMU wants to set either flag and finds
the PTE is 0 (invalid) it will cause an exception which will be queued waiting
for the PTL.

So I don't think you really mean break-before-make here.

> this behavior is within PTL in another thread,  page_vma_mapped_walk()
> of try_to_unmap_one thread won't take PTL till it meets a present PTE.
> for example, if another threads are modifying nr_pages PTEs under PTL,
> but we don't hold PTL, we might skip one or two PTEs at the beginning of
> a large folio.
> For a large folio, after try_to_unmap_one(), we may result in PTE0 and PTE1
> untouched but PTE2~nr_pages-1 are set to swap entries.
> 
> by holding PTL from PTE0 for large folios, we won't get these intermediate
> values. At the moment we get PTL, other threads have done.


