Return-Path: <linux-kernel+bounces-15526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD2822D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA11F24331
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5BA199A4;
	Wed,  3 Jan 2024 12:44:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BE19440
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T4qCT52zrzZfPt;
	Wed,  3 Jan 2024 20:43:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 39F7D180076;
	Wed,  3 Jan 2024 20:44:03 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 20:44:02 +0800
Subject: Re: [PATCH RFC 00/17] ubifs: Add filesystem repair support
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: Richard Weinberger <richard@nod.at>
CC: david oberhollenzer <david.oberhollenzer@sigma-star.at>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Sascha Hauer <s.hauer@pengutronix.de>, Tudor
 Ambarus <Tudor.Ambarus@linaro.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
 <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at>
 <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com>
 <642239519.177270.1703884138999.JavaMail.zimbra@nod.at>
 <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com>
 <535616666.192239.1704228332389.JavaMail.zimbra@nod.at>
 <460eb02e-8937-282c-62c5-6ea606324b0e@huawei.com>
Message-ID: <cc6e93a3-3d3c-6bae-51d9-d8cdd8ca0e4c@huawei.com>
Date: Wed, 3 Jan 2024 20:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <460eb02e-8937-282c-62c5-6ea606324b0e@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/1/3 11:18, Zhihao Cheng 写道:
> 在 2024/1/3 4:45, Richard Weinberger 写道:
>> ----- Ursprüngliche Mail -----
>>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>> I come up with another way to implement fsck.ubifs:
>>>
>>> There are three modes:
>>>
>>> 1. common mode(no options): Ask user whether to fix as long as a problem
>>> is detected.
>>
>> Makes sense.
>>
>>> 2. safe mode(-a option): Auto repair as long as no data/files lost(eg.
>>> nlink, isize, xattr_cnt, which can be corrected without dropping nodes),
>>> otherwise returns error code.
>>
>> Makes sense.
>>> 3. dangerous mode(-y option): Fix is always successful, unless
>>> superblock is corrupted. There are 2 situations:
>>
>> Please not use "-y". Usually "-y" stands for "answer yes to all 
>> questions".
>> But selecting names for command line flags is currently my least concern.
>>>    a) TNC is valid: fsck will print which file is dropped and which
>>> file's data is dropped
>>
>> Sounds also good.
>>>    b) TNC is invalid: fsck will scan all nodes without referencing TNC,
>>> same as this patchset does
>>
>> I'd make this a distinct mode.
>> It can be used to rebuild index and LEB property trees.
>> This is basically a "drop trees and rebuild" mode.
>>
> 
> OK, then fsck will have four modes.

How about merging 3(a) and 3(b) as one mode(dangerous mode)? If fsck can 
get a good TNC(all non-leaf index nodes are valid), fsck executes as 
3(a) describes. If fsck cannot find a good TNC, fsck executes as 3(b) 
and reminds user that "TNC is damaged, nodes dropping is not awared".


