Return-Path: <linux-kernel+bounces-122483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38D88F84E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7A51F26BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C45026A;
	Thu, 28 Mar 2024 06:59:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30541225CF;
	Thu, 28 Mar 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609186; cv=none; b=kC74k4sV22l/7pEpNNDZX0BKO038tXSy1L0H/DZqUD2/dgUQ/eHUFeqTYBL2UcDxwLQT2T/hb3ryVMqAL9GviDOrqHPPkpY6f1itREu/1IC00zVTA6uGfjwWHmRBcf5mOwbhGOs3KAjuBpb7m/3FtOUMRRNoU7IXb1q4cZ6x0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609186; c=relaxed/simple;
	bh=8EOC3gIs1H1Fv4kQsmqyl1qx9sszyhnJYRFryGPcoAM=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qBnPq3yPaa7reVfHfZiilQmXEfbt1VuT4P0CkvP3AUj+bWcbCoSsOkLiQ9zGxKbF0wSJ06n9D4qv2dv3GdWXldtHCSJ7rBgYBwjpoNm5zdum7AiTkfau5HYLdzbJxVbEg3RzyIVHDOHSrq1gU9FdQuqTzfcuGq8H0gge2vWzHbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V4vX92ZmrzPpZt;
	Thu, 28 Mar 2024 14:58:49 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C1B01400CD;
	Thu, 28 Mar 2024 14:59:41 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 14:59:40 +0800
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Christoph Hellwig <hch@infradead.org>, John Garry
	<john.g.garry@oracle.com>
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
 <ZgUPpwhkE9bRwHec@infradead.org>
CC: Damien Le Moal <dlemoal@kernel.org>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@huawei.com>, <yangxingui@huawei.com>, <liyihang9@huawei.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
Date: Thu, 28 Mar 2024 14:59:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgUPpwhkE9bRwHec@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/3/28 14:35, Christoph Hellwig wrote:
> On Tue, Mar 26, 2024 at 01:32:09PM +0000, John Garry wrote:
>>>> +	u8 *p;
>>>> +
>>>> +	size = ALIGN(size, ARCH_DMA_MINALIGN);
>>
>>
>> If this is a hisi_sas requirement, then why use ARCH_DMA_MINALIGN and not
>> 16B as minimum alignment?
>>
>> Or are we really talking about an arch requirement?
> 
> One thing is that we should never allocate unaligned memory for
> anything DMA mapped, or data will be corrupted by non-coherent DMA.
> So ARCH_DMA_MINALIGN needs to be here.  If specific hardware has
> further requirements we'll need to communicated it through a field
> or op vector.

Got it. Looks like it's still going to be aligned to ARCH_DMA_MINALIGN.

Thanks,
Yihang

> 
> 
> .
> 

