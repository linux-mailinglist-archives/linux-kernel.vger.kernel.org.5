Return-Path: <linux-kernel+bounces-135458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3208589C3BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D731F24BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200EF13A864;
	Mon,  8 Apr 2024 13:38:11 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB613A404;
	Mon,  8 Apr 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583490; cv=none; b=PGTGxE+uYV/k6oPWX7LlEoPLmBPn7MTn4T2c4+aLn3tJ7iRX7C15BcffFkthaOctkTzgHUAEizjbmgvk/hA8e1xGQeaZh30bRK4jl+0XFhYkVyfNytFH0LvtJ/LIzTGZoSqSvtjUg5QvrrZLbiBzD8J9+dq4y0E/lkM3Vuhx228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583490; c=relaxed/simple;
	bh=jra87wff/u5f28gozp9iI0Qyvbg4AoiWiWWeYTLbBjA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xtb8HwCU1RvZvKuIEgwTgSrMG5ImCqDy8rcdfD8+dnV3eYi681hfB9onM5DAwtZVJh2Voc6nA27iHzag/EzUgJTkp9CPKV65LhtCjVzhQaukGcoaJrMg2sMTHa70Xpi+ILu7a6TFIZGa1YWV5wf+BVAG1UAndEFcqXI56SWygCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VCqpV4yC6z1hwMm;
	Mon,  8 Apr 2024 21:35:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id BC7621A0172;
	Mon,  8 Apr 2024 21:38:04 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 8 Apr
 2024 21:38:04 +0800
Subject: Re: [PATCH net-next v1 01/12] mm: Move the page fragment allocator
 from page_alloc into its own file
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Howells
	<dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-2-linyunsheng@huawei.com>
 <30a6635dedf305e23e623c501e614e55bca1ab41.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6d6a5225-3c4c-7071-7a9b-8b3706cbdeff@huawei.com>
Date: Mon, 8 Apr 2024 21:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <30a6635dedf305e23e623c501e614e55bca1ab41.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/8 1:42, Alexander H Duyck wrote:
> On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
>> Inspired by [1], but use free_unref_page() to replace free_the_page()
>> instead of __free_pages(), use VM_BUG_ON() to catch that we can use
>> free_unref_page() directly, also add its own header file.
> 
> Instead of doing this all as one patch it would be better to split this
> into 2. Make the refactor first, and then move the code. Don't do it
> all in one patch.

Sure, will split this into 2 patches, thanks.

