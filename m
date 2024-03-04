Return-Path: <linux-kernel+bounces-90342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22686FDED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEBD1C22487
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A5210F8;
	Mon,  4 Mar 2024 09:47:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CF1B819;
	Mon,  4 Mar 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545675; cv=none; b=IVLrt/F8f2Y3BFoyQ/s18pRkVoo9J6kuKRTtwIHQwKLntYjq1YELVoewfv+1g7vD4Lq9/P9cDRQ0/fiBFEXNbvFrdrPx8avXx2EVDloKAiZP58w9IKGwE6bn5qZjdpIuvurR9nUBsEca98592mdhGu1Peo/Sdjcj8gf1ycXs+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545675; c=relaxed/simple;
	bh=1+BaANjFRse1vGdsqvAOD3WKOHIrG01YneoKjzaNY78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=moT5Y0gGnVglyuKYh6XFL/yayil42EjrcwD2vzqUmWFRmVjEbByjXXnr6cwZTQRuRuX/lITGkVLDy7zn/vy00B2G+LOY5Hi05GZg4TvF6YoeJGOzkBe2pCKi+Gk8PIZblGpu9PTRYmAq5pt+ko27uFiHHUaaXP/H4IxnFfBI4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpDMY0VBxz1h1HM;
	Mon,  4 Mar 2024 17:45:29 +0800 (CST)
Received: from kwepemd100008.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 369B01A016C;
	Mon,  4 Mar 2024 17:47:48 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (7.221.188.25) by
 kwepemd100008.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 17:47:47 +0800
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 17:47:47 +0800
Message-ID: <f472dffa-d888-1566-e1e2-313f4eb842c2@huawei.com>
Date: Mon, 4 Mar 2024 17:47:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] bcachefs: Fix null-ptr-deref in bch2_fs_alloc()
Content-Language: en-US
To: Su Yue <l@damenly.org>
CC: <kent.overstreet@linux.dev>, <bfoster@redhat.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240304032203.3480001-1-lizetao1@huawei.com>
 <frx6edjh.fsf@damenly.org>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <frx6edjh.fsf@damenly.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500009.china.huawei.com (7.185.36.209) To
 kwepemd500012.china.huawei.com (7.221.188.25)



On 2024/3/4 13:12, Su Yue wrote:
> 
> On Mon 04 Mar 2024 at 11:22, Li Zetao <lizetao1@huawei.com> wrote:
> 
>> There is a null-ptr-deref issue reported by kasan:
>>
>>   KASAN: null-ptr-deref in range   
>> [0x0000000000000000-0x0000000000000007]
>>   Call Trace:
>>     <TASK>
>>     bch2_fs_alloc+0x1092/0x2170 [bcachefs]
>>     bch2_fs_open+0x683/0xe10 [bcachefs]
>>     ...
>>
>> When initializing the name of bch_fs, it needs to dynamically alloc 
>> memory
>> to meet the length of the name. However, when name allocation failed, it
>> will cause a null-ptr-deref access exception in subsequent string copy.
>>
> bch2_printbuf_make_room() does return -ENOMEM but
> bch2_prt_printf() doesn't check the return code. And there are too many
> callers of bch2_prt_printf() don't check allocation_failure.
Indeed, too many callers do not check whether name allocation is 
successful, which may cause hidden dangers. Maybe it is neccssary to use 
somethings like __GFP_NOFAIL flag here?
> 
>> Fix this issue by checking if name allocation is successful.
>>
>> Fixes: 401ec4db6308 ("bcachefs: Printbuf rework")
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>  fs/bcachefs/super.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
>> index 6b23e11825e6..24fa41bbe7e3 100644
>> --- a/fs/bcachefs/super.c
>> +++ b/fs/bcachefs/super.c
>> @@ -818,13 +818,13 @@ static struct bch_fs *bch2_fs_alloc(struct 
>> bch_sb *sb, struct bch_opts opts)
>>          goto err;
>>
>>      pr_uuid(&name, c->sb.user_uuid.b);
>> -    strscpy(c->name, name.buf, sizeof(c->name));
>> -    printbuf_exit(&name);
>> -
>>      ret = name.allocation_failure ? -BCH_ERR_ENOMEM_fs_name_alloc  : 0;
>>      if (ret)
>>          goto err;
>>
> IIRC, krealloc() doesn't free old pointer if new-size allocation failed.
> There is no printbuf_exit called in label err then memory leak happens.
> 
Here krealloc() is a bit complicated:
1.if name allocation failure happens on the first time, the old pointer 
will be NULL, which cause a null-ptr-deref issue.
2.if name allocation failure don't happens on the first time, the old 
pointer will be available and need to free.

So the correct modification should be something like this:
     pr_uuid(&name, c->sb.user_uuid.b);
     if (unlikely(!name.buf)) {
         ret = -BCH_ERR_ENOMEM_fs_name_alloc;
         goto err;
     }

     strscpy(c->name, name.buf, sizeof(c->name));
     printbuf_exit(&name);

     ret = name.allocation_failure ? -BCH_ERR_ENOMEM_fs_name_alloc  : 0;
     if (ret)
         goto err;
> -- 
> Su
>>
>> +    strscpy(c->name, name.buf, sizeof(c->name));
>> +    printbuf_exit(&name);
>> +
>>      /* Compat: */
>>      if (le16_to_cpu(sb->version) <= 
>>  bcachefs_metadata_version_inode_v2 &&
>>          !BCH_SB_JOURNAL_FLUSH_DELAY(sb))

Best regards,
--
Li Zetao

