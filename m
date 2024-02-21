Return-Path: <linux-kernel+bounces-74376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BDB85D330
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5341C21615
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1A3D0B4;
	Wed, 21 Feb 2024 09:15:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEF3D3A1;
	Wed, 21 Feb 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506931; cv=none; b=hb0cpAWj1gZF2At21bIEbv8X79zxsiJplcUYBxlIhaM8Czh24n4SJyQF5FBit7tM3PXUYQtyfDdbXyJaMoUjiCo4ihRjBq1SHn0hhyti0Lxys4qlDs9I1/a6i+DFRNPXmS9nR1YhYBwp/tbKiCbQuB+uiwlPTSadOIre7kQOFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506931; c=relaxed/simple;
	bh=C+8Mrhn/psZ3+hyYkHIHlWA4K4dU9xwSYMe0Fugwo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsGV/FHJkHsn+qTFYxioZOHmfyvyxyDMeUsOCS1C7/uXXP5FnhiCSe+6MpkVWbIZfCmpR/ln/5F7OdKxU04Zs5mwgCzCCM3DmFqu5whFBzFsDhaZyCIjB8ZKBq4AnwXkcCcasnkDN2NKrHIo+62Zco8BAsutgC+6PhSkmMaBXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TfrGF4lSxz4f3nKT;
	Wed, 21 Feb 2024 17:15:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C1B9D1A0232;
	Wed, 21 Feb 2024 17:15:24 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAXPA8ov9VlI1MVEw--.10393S3;
	Wed, 21 Feb 2024 17:15:24 +0800 (CST)
Message-ID: <5ddce9b8-b6c1-09e2-3450-5119d4282067@huaweicloud.com>
Date: Wed, 21 Feb 2024 17:15:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 0/9] bugfix of MD_CLOSING and clean up md_ioctl()
To: Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc: mariusz.tkaczyk@linux.intel.com, shli@fb.com, neilb@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240206085511.2841555-1-linan666@huaweicloud.com>
 <CAPhsuW49cOvAK2+0c94sp2T3ZLoNf=P89X1tXoq6VNoJWNbv9A@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW49cOvAK2+0c94sp2T3ZLoNf=P89X1tXoq6VNoJWNbv9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXPA8ov9VlI1MVEw--.10393S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw45Cry7XrWxCryxury3urg_yoWDGFX_W3
	yqvr97Gw1xXw42kFs8tF1qvrsrtFW09348A3srCw1Fvw1fX3W8XF48J3sxZ3W3AayS9FnY
	9r1kuay7twsxJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/2/13 7:36, Song Liu 写道:
> Hi Li Nan,
> 
> On Tue, Feb 6, 2024 at 1:00 AM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> Changes in v6:
>>   - in patch 2, return directly.
>>   - in patch 4, return directly in case GET_DISK_INFO and GET_ARRAY_INFO.
>>   - in patch 7, rewrite commit message.
>>   - add patch 8, clean up openers check.
>>
>> Changes in v5:
>>   - add patches 1-4 to clean up md_ioct(), pathc 4 can help us clean up
>>     local variable 'clear_md_closing'.
>>   - in patches 5 and 7, clean up local variable 'clear_md_closing'.
>>
>> By the way, md_ioctl() is not readable now, I wanna to re-write it later
>> to make it only have one 'switch' like other drivers.
> 
> Thanks for the patchset, and sorry for the delay.
> 
> The patchset looks good to me. However, it doesn't apply to md-6.9
> branch. Could you please resend or let me know the base branch/commit
> of the set?
> 
> Thanks,
> Song
> 
> .

Thanks for your review. I will resend it later.

-- 
Thanks,
Nan


