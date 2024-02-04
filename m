Return-Path: <linux-kernel+bounces-51498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C8848BE9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2765E284858
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9AB65E;
	Sun,  4 Feb 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EI/tZZiu"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5088F72
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032911; cv=none; b=uBla3lg/n5wfFy9MJ9e3oF2f/4CCidjkejKcL6SSHZ5Rh7avOkAgpaBqAbv+z1D4wZdPuaSOcs4NsM/QJcAk/Cat0xs3Rs4fUmOPcKoYIVlL/88rF2aUpeKPAntr/buY4sIUi9DEhM5TEYKAGf9dGmCeHCcGSrJISlYkPnxVDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032911; c=relaxed/simple;
	bh=X8FBMStfWNIAGr/K/Lw6nj8iJgQ51dBuJztdUDIjqMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkA1v+pw08bJB1a1SyHi9SDnp3NutdcT3b/WNFDhB843E9+kNGUtqpCodPjx+I7B3gW+rD4XoyFakyBmXV4c0UKrXthG6j+sbHAlT1f5tJjzktEsUDW9EqgC+d3JmYEynyJ2dDudYqf9oNL2oIIU8nATAIBQT9BPAvkiQV0mKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EI/tZZiu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a749cb06-9495-40fc-9192-b019b48eca92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707032906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNLMD4Rtcx6eRP5bHEJyzsY+D9XLppdCBqZ5byzRpFE=;
	b=EI/tZZiuDOweJFlYW4diPs4pBQ63y2hUk42vGWef9+eHlyaClru6292LYvy/Q6sHaPKV0t
	3+jgFeRQmzKm2lS1ZieNP4H99sgmI46hJM0tEUC6rGdWnHGVt2DH4fO0EcAj98gvSlzWFU
	WNmnWcuAEuQSleIKwuO0hcHdPurq+Ig=
Date: Sun, 4 Feb 2024 15:48:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP
 system
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
References: <20240204072525.1986626-1-gang.li@linux.dev>
 <f05f658a-78fa-45cd-ad07-11d87b824702@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <f05f658a-78fa-45cd-ad07-11d87b824702@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/4 15:44, Muchun Song wrote:
> I don't think it is a clear way to fix this. If someone want to
> use PADATA in a non-SMP system, he should be carefully to handle
> the non-SMP case himself. I think the better way is to make PADATA
> handle the non-SMP case, I think it should be easy for it, which
> could just call ->thread_fn() many times instead of creating many
> threads in the non-SMP case.
> 
> Thanks.
>

Sounds good, I'll take a look at padata and send a new patch.

