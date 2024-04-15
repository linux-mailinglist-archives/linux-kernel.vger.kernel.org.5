Return-Path: <linux-kernel+bounces-144472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A38A46C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25082B22634
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8FC22616;
	Mon, 15 Apr 2024 02:04:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F0C8E9;
	Mon, 15 Apr 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146642; cv=none; b=koSE50xf8BfXAq3PBLNfepM0oNLnXMEVjyQ2ALl89PVUJESabKXcCRG8FlWJL4P2FzeSkmtXPtcNQkNvZ1VGiIkzayD0d1vfkPImS2fL/BjpO8WYvfyhZ4FBEv1rKCNBU6LCHRDMRO+VdAazGlOog+jOgZt7zpfsUL/nk9zDfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146642; c=relaxed/simple;
	bh=CjdwrTInCWcUtpgHP3gj66h3ZvZGPxrLq2TqXiJ6rpw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=CFdXkVf45X6HvqfMBoaiikljVpz7c0Cx7r4DEY1zWKQkvL6CtXPUMeq32xwrdzkGHTWQZonHHEucl4vPrj7qsL+4rGZx1XSZuJkDVZg3o4CVFM1jctnj7zlf4cHYQJE8RQ3jVGX+gi1Q+dVpamb42MvO/PuD6qCrTv0voRyo1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VHr3m0lTzzXlSr;
	Mon, 15 Apr 2024 10:00:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 616BF140124;
	Mon, 15 Apr 2024 10:03:51 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:03:51 +0800
Message-ID: <f90f269d-0a35-4dfa-9684-8e8f2a767734@huawei.com>
Date: Mon, 15 Apr 2024 10:03:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcachefs: fix error path of __bch2_read_super()
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Brian Foster
	<bfoster@redhat.com>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chao Yu
	<chao@kernel.org>
References: <20240412063638.2068524-1-chao@kernel.org>
 <9ed2e6d6-186c-4b89-9c07-4b004de6bf23@huawei.com>
In-Reply-To: <9ed2e6d6-186c-4b89-9c07-4b004de6bf23@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

This patch fixes the issue with memory reclamation in certain case. May 
be we should use it! 😉

On 2024/4/12 14:53, Hongbo Li wrote:
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
> 
> On 2024/4/12 14:36, Chao Yu wrote:
>> In __bch2_read_super(), if kstrdup() fails, it needs to release memory
>> in sb->holder, fix to call bch2_free_super() in the error path.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - add error message in error path pointed out by Hongbo Li.
>>   fs/bcachefs/super-io.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
>> index ad28e370b640..cc80d7d30b8c 100644
>> --- a/fs/bcachefs/super-io.c
>> +++ b/fs/bcachefs/super-io.c
>> @@ -698,8 +698,11 @@ static int __bch2_read_super(const char *path, 
>> struct bch_opts *opts,
>>           return -ENOMEM;
>>       sb->sb_name = kstrdup(path, GFP_KERNEL);
>> -    if (!sb->sb_name)
>> -        return -ENOMEM;
>> +    if (!sb->sb_name) {
>> +        ret = -ENOMEM;
>> +        prt_printf(&err, "error allocating memory for sb_name");
>> +        goto err;
>> +    }
>>   #ifndef __KERNEL__
>>       if (opt_get(*opts, direct_io) == false)
> 

