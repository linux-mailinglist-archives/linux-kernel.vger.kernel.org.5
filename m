Return-Path: <linux-kernel+bounces-95713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A28751A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22501C23DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C812DD9C;
	Thu,  7 Mar 2024 14:17:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68351D699;
	Thu,  7 Mar 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821054; cv=none; b=L1bo+EfCTH/joU8jlCf5KbOtAMQECHxTPYtUtpKEqd6/sMD06vTqa7BB3XMSQlp6LEPYK5XKOBlm8BgozypFdznDkr/E9rmekUvdDUADt9OJxuEnqT8TlArF7GP8xgtwGZ33JXEixNRi3m7CvR75+T79RERUi+uABk9BIfORg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821054; c=relaxed/simple;
	bh=S+Lk8cgQNJ1J514ZKuPD0P9IeeMhDUgmPT9fj7UAJDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AcYRNd4PjZ5EOEr0+/Z0dSgh41qmPbuIjzjgqVbZYvDv4Kt8lHWHBY3D/BWv5XQOR+F9ShPQmmalSPCsNcKGb3ZFcMz2c0jnNkbMtN9oIHEGZVrbLy0r9WFSEwhzJJn99G2Pi8MTLb1Ht9Aozi1J8I8275P0t1SGR9osPaPI3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TrBD72hn8z1xnfc;
	Thu,  7 Mar 2024 22:15:51 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 564E5140336;
	Thu,  7 Mar 2024 22:17:30 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 22:17:30 +0800
Message-ID: <20979c45-fd36-cc52-8ed1-33750ce68333@huawei.com>
Date: Thu, 7 Mar 2024 22:17:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 3/3] scsi: libsas: Fix disk not being scanned in after
 being removed
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240307093733.41222-1-yangxingui@huawei.com>
 <20240307093733.41222-4-yangxingui@huawei.com>
 <b105b26c-9c0b-4315-beeb-7879de85d240@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <b105b26c-9c0b-4315-beeb-7879de85d240@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpemm100005.china.huawei.com (7.185.36.231) To
 dggpemd100001.china.huawei.com (7.185.36.94)


Hi John,
On 2024/3/7 18:08, John Garry wrote:
> On 07/03/2024 09:37, Xingui Yang wrote:
>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
>> update PHY info"), do discovery will send a new SMP_DISCOVER and update
>> phy->phy_change_count. We found that if the disk is reconnected and phy
>> change_count changes at this time, the disk scanning process will not be
>> triggered.
>>
>> Therefore, call sas_set_ex_phy() to update the PHY info with the 
>> results of
>> the last query. And because the previous phy info will be used when 
>> calling
>> sas_unregister_devs_sas_addr(), sas_unregister_devs_sas_addr() should be
>> called before sas_set_ex_phy().
>>
>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>> update PHY info")
>> Signed-off-by: Xingui Yang<yangxingui@huawei.com>
> 
> I am also ok with a change to revert to allocating the resp memory with 
> alloc_smp_resp(), but make the changes neat please:
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> .

Thanks for your review, I have updated the version.

Thanks,
Xingui

