Return-Path: <linux-kernel+bounces-39782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686283D601
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792EF1C267FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBF12AAD5;
	Fri, 26 Jan 2024 08:40:45 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA991BC4C;
	Fri, 26 Jan 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258445; cv=none; b=uLBmEZ0NiAdr6zQ8s6I4B9Attx+0TKWcdz36xMt91FUVljvru5YhqNqIz/T3evwH1romXphpjemDdUuPNjUuRAk6gzTDlRgz1RUgR7xEvhvxHCzOME1hgc0WveJ/34j12Jdju5z7tWP75nvveL7Y/jM3LcW4fQXNf8xK4WOrMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258445; c=relaxed/simple;
	bh=kb9C7u8yTsWsUe5kmCLWQKW96P4fUbGNHwszHARhCe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xo0vcsQ8UjQuQOw8V1iMKUtBiw2uDYdw3VyzkIQCzLFRfnoCzegWmaIWtw2twoi6vaU9YmlOd8wvWDIZeLZhF6BCqATQkAP/d/8isE/voUtfPS85HQAI2YGT41bm2emDwSYfPd2EuQgJBvR8UngDkRW7O4/tni4Iza8KxuIqZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TLrjD6VGwzNlYX;
	Fri, 26 Jan 2024 16:39:44 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id CCC5818001C;
	Fri, 26 Jan 2024 16:40:39 +0800 (CST)
Received: from [10.67.121.42] (10.67.121.42) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:40:39 +0800
Message-ID: <273d30b3-edba-4f4c-8138-fe83dbfd83aa@huawei.com>
Date: Fri, 26 Jan 2024 16:40:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] crypto: hisilicon/sec2 - fix some cleanup issues
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <davem@davemloft.net>, <liulongfang@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20231229064421.16981-1-taoqi10@huawei.com>
 <20231229064421.16981-4-taoqi10@huawei.com>
 <ZbIry8M6yFUAr5oL@gondor.apana.org.au>
From: taoqi <taoqi10@huawei.com>
In-Reply-To: <ZbIry8M6yFUAr5oL@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500001.china.huawei.com (7.185.36.227)

On 2024/1/25 17:37, Herbert Xu wrote:
> On Fri, Dec 29, 2023 at 02:44:20PM +0800, Qi Tao wrote:
>>
>> @@ -1371,7 +1371,7 @@ static int sec_skcipher_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
>>   	sec_sqe3->bd_param = cpu_to_le32(bd_param);
>>   
>>   	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
>> -	sec_sqe3->tag = cpu_to_le64(req);
>> +	sec_sqe3->tag = cpu_to_le64((unsigned long)(uintptr_t)req);
> 
> Please explain why you're casting twice.
> 
> Thanks,

I'm sorry. I made a mistake here. unsigned long and uintptr_t are the 
same data type in linux kernel. The type cast is invalidly repeated 
here. Can I just keep (unsigned long) one cast?



