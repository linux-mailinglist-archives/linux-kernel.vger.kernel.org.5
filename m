Return-Path: <linux-kernel+bounces-122551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF888F950
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AC61C29E12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AC53E36;
	Thu, 28 Mar 2024 08:00:56 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE84F8BB;
	Thu, 28 Mar 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612856; cv=none; b=qrzlrHCVc/nX4NqH7w+QlqVGPfjBK/VUFwv9JzfcduaMiN0WRPgEXGS81kCI2vBwFAnjIMn5aK5IHtYguwFzTIPBrDr0tbAO/wk9+6+SNW3Mdvt3DWXfxRPM6YLXbTeFWEKFPCkdowkFogONNbMZYa8cZdK9z5wMlKTG+dlD2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612856; c=relaxed/simple;
	bh=KqfMhfcyKl9MR7FT4u8aDUFTZmjcq2Pn0uZW9tDQ3mE=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dl3Z/XWs3C5N4LPCf5P4eOS7PgxDAh8T6JA3SiE1TaJREVD0xFsiJLyqsE2sMy1r7BsNWGiNsHQyswbFZXwLK/INlHHlyyBr0Kett2boWWH9/tRa46ehPdhNdX2hwC0xtrAI8fJfOq3uvIslzl47xwEYnkjCD+zHOmQ7+bJGQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V4wsP49hTz1xsdh;
	Thu, 28 Mar 2024 15:58:49 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 02AC61A0172;
	Thu, 28 Mar 2024 16:00:51 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 16:00:50 +0800
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
 <ZgUPpwhkE9bRwHec@infradead.org>
 <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
 <03ed6449-eb57-4a55-b2bf-ecbb9787feca@kernel.org>
 <ZgUcTLQnoLuqhOxO@infradead.org>
 <ba7d201b-3746-4ee1-9574-5782cccbc88e@kernel.org>
 <ZgUgMcOC8DKbOVsN@infradead.org>
CC: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@huawei.com>, <yangxingui@huawei.com>, <liyihang9@huawei.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <964862d3-ebb2-59ff-8414-6fd650e421cc@huawei.com>
Date: Thu, 28 Mar 2024 16:00:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgUgMcOC8DKbOVsN@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/3/28 15:45, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 04:36:12PM +0900, Damien Le Moal wrote:
>> My bad: it is kmalloc() that can return something aligned to 8B...
> 
> Yes, that's new on arm64, and possibly soon riscv.

Thanks for the discussion, I will still aligned to ARCH_DMA_MINALIGN in v4.


