Return-Path: <linux-kernel+bounces-104418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B387CD80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FECF283F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB028E23;
	Fri, 15 Mar 2024 12:58:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079F288CF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507520; cv=none; b=IPtQy0EJJzbgU4UxBlWXCkOsssRE1h9Vvmpa1HNFm4Kv+RQayxmSOXofipncXvUxntJK8+Is7tQy+0jP7rct2Bv/PLjw+hpCQyhWRWHWBFDMixL7xXj8dplUWMNs7pemF0OahECBV2xgOJz0+3dnoxuQwRls4XtfQ+7O6OL8oDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507520; c=relaxed/simple;
	bh=doKKCEW0xAcyKzV3gycR+dcCOcAuhLAAPj+/A0V/+YI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UGyiZtrbPl9enxSxOMtsDZIyPXwMv9UYlL1QjfmoJSAPtyWe2tzesIV2/SNbLT9CqgFWZE58uMx0893GCqVpykKq2ph5D3Sd0mG06HP6LnucxUhR5kxsycPENw34dYSfW0+H8Z+luqWchDfjJfNUMPLDWo6NM50hFfcIEgpyvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tx46p4dRSz1FMCq;
	Fri, 15 Mar 2024 20:58:10 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 945701402CC;
	Fri, 15 Mar 2024 20:58:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 20:58:27 +0800
Subject: Re: [RFC PATCH] jffs2: fix recursive fs_reclaim deadlock
To: Qingfang Deng <dqfext@gmail.com>
CC: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger
	<richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240315075946.587679-1-dqfext@gmail.com>
 <ff19df82-3fd4-9098-667c-0502b2452334@huawei.com>
 <CALW65jbKBUDN8ybE1oqrNW5VK1QGpZ1RmnFCCzxjQCo4obaA4A@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e5c2c285-0b10-0d23-2c02-7582c026dbfd@huawei.com>
Date: Fri, 15 Mar 2024 20:58:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALW65jbKBUDN8ybE1oqrNW5VK1QGpZ1RmnFCCzxjQCo4obaA4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/15 20:19, Qingfang Deng 写道:
> Hi Zhihao,
> 
> On Fri, Mar 15, 2024 at 7:19 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> I think it's a false positive warning. Jffs2 is trying to get root inode
>> in process '#1', which means that the filesystem is not mounted
>> yet(Because d_make_root is after jffs2_iget(sb,1), there is no way to
>> access other inodes.), so it is impossible that jffs2 inode is being
>> evicted in '#0'.
>>
> 
> You're right that process '#1' is getting the root inode. However,
> lockdep only records the stack of the first unique lock ordering (see
> https://docs.kernel.org/locking/lockdep-design.html#performance ), and
> there are many occasions where GFP_KERNEL is used inside a
> jffs2_inode_info::sem 's critical section.
> .
> 
Allocating memory without GFP_NOFS flags under sleeping lock is a normal 
thing. The vfs_write is an example(eg. ext4), page is allocated with 
FGP_WRITEBEGIN flag(no FGP_NOFS) when holding inode lock.

