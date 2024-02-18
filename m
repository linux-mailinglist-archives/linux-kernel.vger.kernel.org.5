Return-Path: <linux-kernel+bounces-70314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1748595F0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C541C20CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972112B86;
	Sun, 18 Feb 2024 09:23:59 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6070BD52D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248238; cv=none; b=c4Tf7anrls0ZOMzEnRV6cVnTfmC8pdNGpAYdtrC1sDVSMAsEzv9463r+dXIqeaPSqH3DD1GJQlap3VXgpN7SKaqnyDqKEF7Of9gXXxPO4J4XyH5AbRkDdAp2Smk5873MRvgHabSsEb+0hznNiK3j3HJ1tTuTgfwLWdo6bwtSJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248238; c=relaxed/simple;
	bh=RkxEEuAcGz7HmYPDbOec7jZ0vGmJiptdvXmqCAGDlRk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XnO7ZqX7IgLAAlutAfF2MgB/os1lizkIGevo5dymnzsKo/rNFAgsmNYmRmSB8wdWQCfPEcS7Y3hYtFi96sPWoLhyc8Hd03jpIWB1XyLegBC9pFnLrTqlsZuEJ72eHoi50pXbPaNGHf0yoeRuSE9jCfbouCR21QvAjGsP+944v1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Td0Zm6phsz1vtV1;
	Sun, 18 Feb 2024 17:23:12 +0800 (CST)
Received: from kwepemi500023.china.huawei.com (unknown [7.221.188.76])
	by mail.maildlp.com (Postfix) with ESMTPS id C1D89140154;
	Sun, 18 Feb 2024 17:23:45 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 17:23:44 +0800
Subject: Re: [RESEND PATCH] llist: Make llist_del_first return only the first
 node
To: "Huang, Ying" <ying.huang@intel.com>
CC: <akpm@linux-foundation.org>, <paulmck@linux.vnet.ibm.com>,
	<neilb@suse.de>, <chuck.lever@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20240218065750.1241-1-liqiang64@huawei.com>
 <875xymtdy5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <c4c95726-ad43-88d3-186c-28b192f0b9d4@huawei.com>
Date: Sun, 18 Feb 2024 17:23:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <875xymtdy5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500023.china.huawei.com (7.221.188.76)



在 2024/2/18 15:43, Huang, Ying 写道:
> liqiang <liqiang64@huawei.com> writes:
> 
>> Set the next of the returned node of llist_del_first
>> to NULL, which can prevent subsequent nodes in llist
>> from being exposed, and is more consistent with the
>> logic of this interface.
>>
>> Signed-off-by: liqiang <liqiang64@huawei.com>
>> ---
>>  lib/llist.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/llist.c b/lib/llist.c
>> index f21d0cf..c33fff5 100644
>> --- a/lib/llist.c
>> +++ b/lib/llist.c
>> @@ -61,6 +61,7 @@ struct llist_node *llist_del_first(struct llist_head *head)
>>  		next = READ_ONCE(entry->next);
>>  	} while (!try_cmpxchg(&head->first, &entry, next));
>>  
>> +	entry->next = NULL;
>>  	return entry;
>>  }
>>  EXPORT_SYMBOL_GPL(llist_del_first);
> 
> This isn't needed for functionality correctness.  Many users of llist
> ask for performance.  So, it may be better to let the users to decide
> whether to set entry->next to NULL.
> 

Ok, get it, thanks for your reply.

-- 
Best regards,
Li Qiang

