Return-Path: <linux-kernel+bounces-116708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2D88ABD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114B1BE33ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90D134C4;
	Mon, 25 Mar 2024 10:28:06 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028413C9BA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356196; cv=none; b=pTKnZKX/QnD2npCc7chQoswqd4lo9P88oP2JNPHiP8iiEbjMWWfR3TLfBV3pDW1SX9vMHCXaYKUKCyVkYiv7YQoWCLfM97FYdvILZtj3ss9wZAvL6cZ8mTnqiNIqGB1l1QBmtnww2bd2/fogk/Cpsh7sCBNznVusPhqaMSVSd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356196; c=relaxed/simple;
	bh=pzbzpSguYIEzkMi8viaS6qMY2ddR/vtNt7Vl1aYuKM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dptBFsh46yC0mOM+kUk0ld1g1e4cDVGzDR49X4PPVy2igu1Hkmu5MKbEaA1LiGmtE7VfzugKHmIDVAMF+qNs6QBizFwDobcQfe42ERIUqt6T/URomhzvMzdnbXllXj9WzjC1mwqeT8+MNOB7cAk+MOHPGMxanaY1TKIKf6pls5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V35wx4MzVzwQ9k;
	Mon, 25 Mar 2024 16:40:33 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 982F018007C;
	Mon, 25 Mar 2024 16:43:11 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 16:43:10 +0800
Message-ID: <bee6e666-8616-517d-8dbd-d62d9b8a2894@huawei.com>
Date: Mon, 25 Mar 2024 16:43:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ubifs: fix incorrect UBIFS_DFS_DIR_LEN macro definition
To: Zhihao Cheng <chengzhihao1@huawei.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>, <ada@thorsis.com>,
	<error27@gmail.com>, <Artem.Bityutskiy@nokia.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240324120333.3837837-1-wangzhaolong1@huawei.com>
 <f14013a4-80f1-4796-9f68-92a032dfdb13@huawei.com>
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <f14013a4-80f1-4796-9f68-92a032dfdb13@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200001.china.huawei.com (7.185.36.224)


Thank you very much for your comments and suggestions.

 >> A previous attempt to fix this issue in commit be076fdf8369 ("ubifs: fix
 >> snprintf() checking") by modifying the snprintf return value check 
range is
 >> insufficient. It avoids the premature function return but does not 
address
 >> the root cause of the problem. If the buffer length is inadequate, 
snprintf
 >> will truncate the output string, resulting in incorrect directory names
 >> during filesystem debugging.
 >>
 >
 > I don't think 'snprintf' ever truncated the output string in 
dbg_debugfs_init_fs(), even before be076fdf8369 ("ubifs: fix snprintf() 
checking"). The 'UBIFS_DFS_DIR_LEN' contains trailing zero byte 
according to the comments, but actually all callers treat it as real 
string length without '\0' terminated(eg. dbg_debugfs_init_fs, 
ubifs_sysfs_register).
 > So there are no actual problems here. The only problem is that the 
comment of 'UBIFS_DFS_DIR_LEN' is not consistent with its' usage, the 
simpliest way is modifying comments. If you still want to cleanup the 
code, please remove the wrong fixing tags.

Regarding my original commit message, I realize that the statement "If 
the buffer length is inadequate, snprintf will truncate the output 
string, resulting in incorrect directory names during filesystem 
debugging." is inaccurate.

`snprintf` does indeed stop writing when it reaches the specified buffer 
size and appends a null character (`'\0'`) after the last character. 
However, since the buffer size passed to `snprintf` is sufficiently 
large, the directory names are not actually truncated in the buffer.

 > If you want to clean up code, modifying sysfs related 
code(ubifs_sysfs_register) is needed too.

That's a good suggestion, I'll go through that part of the code and make
the necessary changes for consistency.

Thanks again for your valuable feedback. I'll take all your suggestions
into consideration and adjust my patch accordingly. I'll resend the
patch once I have an updated version ready.

Best regards,
ZhaoLong Wang

