Return-Path: <linux-kernel+bounces-91595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE40871410
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C851F2352D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E12941C;
	Tue,  5 Mar 2024 03:00:52 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E91803E;
	Tue,  5 Mar 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607651; cv=none; b=YwGrZeqHaOZ4CArO71O6ZxOTwHNdW2qOel14uQr23LWdzuBW4GPtkqlkMKcnuOA8MRexuF6pxGqXM+XlCxnN1T3Fujf31jJ4CYUAKlSDIHluC7uopceU7EykwKSwyjds5Td48m13hMy28K5JgUsWDnMKirKX2JgUf8eGbHBwBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607651; c=relaxed/simple;
	bh=xk2vWiWpHN3rKQ0Tp/1QPJGkv/RZv4mYOP9Y0+u1lFQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZdqLvkxICLTAClCtoPEw4Oy7NlAs7gDT+9ac2Vj8AARTZdEYpOshCyRU1x6g37tljaxrWTBFfGQWwIZWAcTczACUKjInWoNxLOLnWxa0b8kraFVXs2jpTxlNp3TxXlaqiGmk6CLMfnvzSJAuq3lW/U6O/oJTS1HNy9FyortFtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TpgJG1rrbzNlsR;
	Tue,  5 Mar 2024 10:59:10 +0800 (CST)
Received: from canpemm100001.china.huawei.com (unknown [7.192.105.122])
	by mail.maildlp.com (Postfix) with ESMTPS id F0B5614037B;
	Tue,  5 Mar 2024 11:00:46 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100001.china.huawei.com (7.192.105.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 11:00:46 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 11:00:45 +0800
Subject: Re: [PATCH v2] scsi: libsas: Fix disk not being scanned in after
 being removed
To: Xingui Yang <yangxingui@huawei.com>, <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240227090149.29039-1-yangxingui@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <f52b3c8c-886e-665d-a50d-cba3387d8418@huawei.com>
Date: Tue, 5 Mar 2024 11:00:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240227090149.29039-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/2/27 17:01, Xingui Yang wrote:
> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
> update PHY info"), do discovery will send a new SMP_DISCOVER and update
> phy->phy_change_count. We found that if the disk is reconnected and phy
> change_count changes at this time, the disk scanning process will not be
> triggered.
> 
> So update the PHY info with the last query results.
> 
> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
> Signed-off-by: Xingui Yang<yangxingui@huawei.com>
> ---
> v1 -> v2:
> Use sas_get_phy_discover() instead of sas_get_phy_attached_dev() in
> sas_rediscover_dev() and use disc_resp to update phy info.
> ---
>   drivers/scsi/libsas/sas_expander.c | 37 ++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 9 deletions(-)

Looks good to me:

Reviewed-by: Jason Yan <yanaijie@huawei.com>

