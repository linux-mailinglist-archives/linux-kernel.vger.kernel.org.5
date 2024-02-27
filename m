Return-Path: <linux-kernel+bounces-82983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BE0868C91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B831C21412
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2E1369BF;
	Tue, 27 Feb 2024 09:42:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69A15D0;
	Tue, 27 Feb 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026966; cv=none; b=l+30gk9VpXQbzOGwfuMWgwZ5pD9pAEfVNXCJIB3eej9CRzaIXkZ07bU/MvvopjJBCex/9IkIZOKOpxlUesfg0d3fPuesbxq977NAHGRWLmPZuGiy1onuj8mGplbLcy516VwlfELMKuSxlfBfJ2cyhRtsGBB/Rj61FChCONh0NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026966; c=relaxed/simple;
	bh=NltuXZkeIhA7SW+L8lNtMeXkelidiUwx3+LJjumtTHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l6wVw3Gb2Hh7euwn3C+5DS0fXK6I5he2IA3oFarwrvQqi6YPacuEhcdAUPTKXj/OSQiMsWr1+uokN9Zmrx5NQxMUBqKt222EirZShf5KMxkK68N4YsSl6cP+0sZOPitg6uXXhIyFrAkd4DhhDzlmq46kOcqrllTmBSGk2qzyVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkXTM4tntz1b13f;
	Tue, 27 Feb 2024 17:37:43 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id CD70B1A016C;
	Tue, 27 Feb 2024 17:42:41 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 17:42:41 +0800
Message-ID: <e95993da-db88-5db2-0aa8-f0c7589ce902@huawei.com>
Date: Tue, 27 Feb 2024 17:42:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
 <cdf241a7-8504-5b87-2d18-d2a971f6ebb9@huawei.com>
 <8dc34f04-943b-26fd-01bc-34fb98803503@huawei.com>
 <b2ab5439-361b-4160-4e73-171026ecc486@huawei.com>
 <8138ab55-1c43-8df1-dafd-95b16b7b3ce4@huawei.com>
 <7d132b63-7336-4f59-a5f0-5ec37c3c34d3@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <7d132b63-7336-4f59-a5f0-5ec37c3c34d3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpemm100006.china.huawei.com (7.185.36.196) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi John,

On 2024/2/27 17:06, John Garry wrote:
> On 27/02/2024 07:16, Jason Yan wrote:
>>>>
>>>> Can we directly set phy->negotiated_linkrate = SAS_PHY_DISABLED 
>>>> here? For an empty PHY the other variables means nothing, so why 
>>>> bother get and update them?
>>> The value of the negotiated link rate has two possible values ​​in 
>>> the current processing branch: SAS_LINK_RATE_UNKNOWN and 
>>> SAS_PHY_DISABLED, and both come from disc_resp. If we do not use 
>>> disc_resp, but set a fixed value SAS_PHY_DISABLED for it, it may not 
>>> be appropriate.
> 
> But we know that the phy is disabled, right? It's our phy, isn't it?
Yes, just like the previous submission, if we disable phy ourselves 
through the sysfs node, we can configure the negotiation rate to 
SAS_PHY_DISABLED by setting phy->phy->enable to 0. It might be better to 
use sas_set_ex_phy() as you described before, it will refresh other phy 
information synchronously, such as sas_address, device_type, 
target_protocols, etc. If we only update the negotiation rate and 
maintain the old information, is it because it is special? Is it better 
to update phy information uniformly?

Thanks,
Xingui

