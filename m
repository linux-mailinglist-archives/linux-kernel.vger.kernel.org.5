Return-Path: <linux-kernel+bounces-37932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE183B878
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A50284925
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41D79EA;
	Thu, 25 Jan 2024 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXcbujLs"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6367483
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154448; cv=none; b=TzUfQuWO6Prulbsp+tj5UdU3Cut6vsXQ7bSYvmyAnaqD7vmOlwS92bg2GKotWZrRxv7Tmyn+HgAT/eQWZeayg0IV83DztY0XL6W3SrloSoPRpw6MfIziSkDE8NVznicIDPR1to+JL/6D1Nd9MrM8slEDhSBlyL7yoPRvEJkWhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154448; c=relaxed/simple;
	bh=2ElEB8I6WzTnUnBwHCpJN3sKxBykUjjuo1Vg60yz6bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0GbTUaTBp31yHf3IIRZjElHyN6A+0tot+B1PtjP7APFLBTBKFiMrz0Jz6bqRDJbgShyKaMa5i8UlTTKykPOJbuQHwCNdHizlGAbbO0yRUJZgpkKak+MY37mPmvo89NeKyqueiMEF0GIwgmRIRFXil225ogUcJa/H+C8M/JIsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXcbujLs; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0489686-bc3d-4804-8f77-7eda6f15e80f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706154443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOoOdUJo1huUen/y64xRpLVbbujcz3fDWbUxW/OLp0A=;
	b=FXcbujLsZdfVMVp/Xp8DDLyICRgwQkcD86dpIKe0KHoucd+1myjtkC4r4Oo2mYFV6jTL//
	J8Trf/J2JjScuwJCeT1Z6l553CCc904gECGjgmGMQAyOddbJowWirge3pswea9VvPEk83K
	jEH2r920OoV6DtSqPniV0RD53qH/CAY=
Date: Thu, 25 Jan 2024 11:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/7] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: David Rientjes <rientjes@google.com>
Cc: Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com, David Hildenbrand <david@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Tim Chen <tim.c.chen@linux.intel.com>
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

On 2024/1/25 10:48, Muchun Song wrote:>>>>         12t        1G 
  77000         18300   76.23%
> 
> I am curious how many NUMA nodes does this system have? I suspect
> it should not be one.
> 

Hi David Rientjes,

I'm also curious. Can you show us some details about this machine?
Such as `lscpu`.

Thanks!

