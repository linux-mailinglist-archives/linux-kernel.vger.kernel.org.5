Return-Path: <linux-kernel+bounces-91569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478F8713BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE3B23CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89D28E3C;
	Tue,  5 Mar 2024 02:44:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7929425;
	Tue,  5 Mar 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606654; cv=none; b=FZnCKZRhIt2IuZHO2ab+BjaybqFlv0Sc0mZaqKifWJI9ybxsXsAtuYM5Y6oM5M+JY9aFqtbcO2P4GhFqm9VDScDvdffblAmZNompjSPEc7++OU0Z+NoNMaXiPaNGyXrUJ3H6B7W551bLZvLBq7x+aVRqZTf+SDW7U8Ycs2TJnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606654; c=relaxed/simple;
	bh=xtQZj/TLnOzexfc3McXZwu76opW9oPMZb3LK8UeKohw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eV5MMZqYu8CvXqjoJhCjmY8E0tb5GdcY2NIuPhMcsAfyHIrWoKPcP4kE+9RIJaBBzgv+guNRosjzcDY0Itvp6f8X0Y6tOpfufIYBp62RyH3/ZOvhjvo8fD+1h66RYz4k6NS8GOOZGft5IWd136Nu6CM0kg+Tz7kKcN64NpGK5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpfwD1kxKz1h1L5;
	Tue,  5 Mar 2024 10:41:48 +0800 (CST)
Received: from canpemm100001.china.huawei.com (unknown [7.192.105.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 079351A016E;
	Tue,  5 Mar 2024 10:44:08 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100001.china.huawei.com (7.192.105.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:44:07 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:44:07 +0800
Subject: Re: [PATCH v5 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Jack Wang <jinpu.wang@cloud.ionos.com>, "Hannes
 Reinecke" <hare@suse.de>, Xiang Chen <chenxiang66@hisilicon.com>, "Artur
 Paszkiewicz" <artur.paszkiewicz@intel.com>, Bart Van Assche
	<bvanassche@acm.org>
CC: TJ Adams <tadamsjr@google.com>, <linux-ide@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305005103.1849325-1-ipylypiv@google.com>
 <20240305005103.1849325-2-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <d51e1287-6033-56a0-70e7-e166772c81eb@huawei.com>
Date: Tue, 5 Mar 2024 10:44:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305005103.1849325-2-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 8:50, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Acked-by: Damien Le Moal<dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/ata/libata-sata.c | 140 +++++++++++++++++++++++++++-----------
>   include/linux/libata.h    |   6 ++
>   2 files changed, 107 insertions(+), 39 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

