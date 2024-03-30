Return-Path: <linux-kernel+bounces-125719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367EA892B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FC71C20E07
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D46381AA;
	Sat, 30 Mar 2024 12:01:22 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FB1E896;
	Sat, 30 Mar 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800081; cv=none; b=WJbbV270t/ooVwRu27l3kpbpO/LNp3fBVfRjqDSUiCBL1/yhmqeX05AdQ5vC9vo421dyQlYdRNrAG/3dLmqvHvHH3IOXbqbnkcRGS5ljWtW9WpuJVFyUYBq7iefT2u8Y2EsHJMJjqK0UHGQnJZOlWMwRiKLeHwXjs5A0t2k/zBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800081; c=relaxed/simple;
	bh=fT3FnLwhlqo35Pj+pAK551GXQXi8alEtZAKvfSYeaHU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gysezl9oW2wx2m1NIwuS5aCuwl7HEGn2RtF3oLAyvdICdI9EdoKb99h/KeqXZzq3y49d/36QaSMvGlijVKast3vaki1kT/opXa8XfqWWufE7zSFpHwMOXGVeeMdlmccqp9Eb+dtVlMhV0NpG4fjzqbWHbE5Lf0g0516IE1P/Sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V6G542s8Wz29lQT;
	Sat, 30 Mar 2024 19:58:32 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A15F21A0172;
	Sat, 30 Mar 2024 20:01:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 30 Mar
 2024 20:01:14 +0800
Subject: Re: [PATCH RFC 01/10] mm: Move the page fragment allocator from
 page_alloc into its own file
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells
	<dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
 <20240328133839.13620-2-linyunsheng@huawei.com>
 <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9e03b278-aaeb-d11c-d2e0-d45ca5e97346@huawei.com>
Date: Sat, 30 Mar 2024 20:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/30 1:19, Christophe Leroy wrote:
> 
> 
> Le 28/03/2024 à 14:38, Yunsheng Lin a écrit :
>> Inspired by [1], but use free_unref_page() to replace free_the_page()
>> instead of __free_pages(), use VM_BUG_ON() to catch that we can use
>> free_unref_page() directly, also add its own header file.
>>
>> As the API is only used by the networking, it may make sense to
>> move it to the networking directory like the page_pool does in the
>> future if we can make the free_unref_page() callable outside of the
>> mm subsystem. And we can utilize that to decouple the 'struct page'
>> in the networking subsystem in the future.
> 
> I'm wondering if this page fragment allocator could replace the page 
> fragment allocator used in powerpc to allocate fragment of pages for 
> page tables.

From a quick glance, it seems possible. If there are potential users
other than the networking for this API, we can keep it in mm subsystem
for now as this patch does and see how thing will evolve.

> 
> See arch/powerpc/mm/pgtable-frag.c
> 
> Christophe
> 

