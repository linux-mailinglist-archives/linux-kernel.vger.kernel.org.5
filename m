Return-Path: <linux-kernel+bounces-149703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE418A94C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C971C20A43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F689145FE3;
	Thu, 18 Apr 2024 08:16:46 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907E14037F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428203; cv=none; b=bnpolcuHChCC/VmXHOEcr/9VWp4KZePaG7PvEJekZCA08O7ytGuPVoTSnEeXUV1nFv1vx+fIQC6NIDHkrsUlGuL+jHKFVsEt24QtXZ4FkNQE+Co8sUg4YlQibM95TUT7Fs7PEmAWMwprTHY1gP5WGYk2q30XALpG/8/WKtEyK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428203; c=relaxed/simple;
	bh=OvDJREwhCD1/pDuG7e5gFbgVRnC6NYV1EeoZGrcVAGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qP6MFfgGUP4DqSjFEQ0ae/PUI56iaT/MVGawQ0Fh5kbonSbZMLd353go9sDZahPaFAK3EzLF6Gc/RAzmdVZXAvkZKzm/ZDHyBOWFaf87i1CDTjr9yFaThMiGFqFoV039bBm5tksGDMlTJBRH0ZyHo/juVSZrzQG/ixu4+/3q76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VKrBp38mxz1R8ZS;
	Thu, 18 Apr 2024 16:13:38 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 01E07180073;
	Thu, 18 Apr 2024 16:16:32 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 16:16:31 +0800
Message-ID: <bd839e9f-d3f2-f99d-34f7-e819a84c51cf@huawei.com>
Date: Thu, 18 Apr 2024 16:16:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>,
	<xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
References: <20240417065513.3409744-1-libaokun1@huawei.com>
 <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
 <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
 <fb65c7d0-c348-409e-b977-07616d28b279@linux.alibaba.com>
 <48b21671-19ae-0dbd-96cd-7300fd600c9b@huawei.com> <ZiDQgmN0hC2uIiPA@debian>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZiDQgmN0hC2uIiPA@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/4/18 15:49, Gao Xiang wrote:
> Hi,
>
> On Thu, Apr 18, 2024 at 02:12:39PM +0800, Baokun Li wrote:
>> On 2024/4/18 13:50, Jingbo Xu wrote:
>>> On 4/18/24 11:36 AM, Baokun Li wrote:
>>>> On 2024/4/18 10:16, Jingbo Xu wrote:
>>>>> Hi Baokun,
>>>>>
>>>>> Thanks for catching this and move forward fixing this!
>>>> Hi Jingbo，
>>>>
>>>> Thanks for your review！
>>>>
>>>>> On 4/17/24 2:55 PM, Baokun Li wrote:

SNIP

>>>>>
>>>>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>>>>> during erofs_get_tree() and ensure that erofs can always have the info
>>>>> available during erofs_kill_sb().
>>>>> I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
>>>>> be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
>>>>> another potential advantage of doing this way is that erofs_fs_context
>>>>> is not needed anymore and we can use sbi directly.
>>>> Yes, except for some extra memory usage when remounting,
>>>> this idea sounds great. Let me send a version of v3 to get rid
>>>> of erofs_fs_context.
>>> I'm not sure if Gao Xaing also prefers this.  I think it would be better
>>> to wait and listen for his thoughts before we sending v3.
>>   Okay, there's no rush on this.
> I checked days ago, for example, XFS is also worked in this way.
> And .reconfigure() needs to be carefully handled too.

Ok, I'll implement it in the next iteration.

>>>>>> +static void erofs_ctx_to_info(struct fs_context *fc)
>>>>>>     {
>>>>>>         struct erofs_fs_context *ctx = fc->fs_private;
>>>>>> +    struct erofs_sb_info *sbi = fc->s_fs_info;
>>>>>> +
>>>>>> +    sbi->opt = ctx->opt;
>>>>>> +    sbi->devs = ctx->devs;
>>>>>> +    ctx->devs = NULL;
>>>>>> +    sbi->fsid = ctx->fsid;
>>>>>> +    ctx->fsid = NULL;
>>>>>> +    sbi->domain_id = ctx->domain_id;
>>>>>> +    ctx->domain_id = NULL;
>>>>>> +}
>>>>> I'm not sure if abstracting this logic into a seperate helper really
>>>>> helps understanding the code as the logic itself is quite simple and
>>>>> easy to be understood. Usually it's a hint of over-abstraction when a
>>>>> simple helper has only one caller.
>>>>>
>>>> Static functions that have only one caller are compiled inline, so we
>>>> don't have to worry about how that affects the code.
>>>>
>>>> The reason these codes are encapsulated in a separate function is so
>>>> that the code reader understands that these codes are integrated
>>>> as a whole, and that we shouldn't have to move one or two of these
>>>> lines individually.
>>>>
>>>> But after we get rid of erofs_fs_context, those won't be needed
>>>> anymore.
>>> Yeah, I understand. It's only coding style concerns.
>>>
>>>
>>>
>> Okay, thanks！
> I'm fine to get rid of those (erofs_fs_context) as long as the codebase
> is more clearer and simple.  BTW, for the current codebase, I also think
> it's unneeded to have a separate helper called once without extra actual
> meaning...
>
> Thanks,
> Gao Xiang
>
Ok, this helper function will be gone in the next iteration.

Thanks for the review!
-- 
With Best Regards,
Baokun Li

