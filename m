Return-Path: <linux-kernel+bounces-118422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71AF88BA87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209971C2E8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D339823BF;
	Tue, 26 Mar 2024 06:37:38 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AC54BFF;
	Tue, 26 Mar 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435057; cv=none; b=XL856bQL7jJPkbIlrpwwaGYX64Mobhw1J5DlLBqDcd9+ZRxD0h/0BzAA6aV+JBwsZYCCeKPhw9hH5sSfEBlnBBvl9QCNtb/5hnx+5tVXFCcVa7BykqbAObovn8FbU0JsymeMWXnYK91zgInghVFWUigAlMbicM0tMOPQs8kfLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435057; c=relaxed/simple;
	bh=u2y+vtRSLyiyZLwEmdo24Sm096aRMYJD9m5vspSuB8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pw49hkmhqSXU5YfJWt3TEH/ZipjQjPJCe0liN9iDmtlGSqmPd7NBLa282zRn2vHVrAjDdqe2WNayiC9a5rvUEfQXvWbYgcC0jAHQ304yLsKP/uMZbtGOS5wwtm7+ag2wWRbrtiIYi01PjkbJ0T9yHA6cWs4iKDOvTJRed5kgNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V3g5M727Xz1h3fb;
	Tue, 26 Mar 2024 14:34:47 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DB4E18002F;
	Tue, 26 Mar 2024 14:37:26 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 14:37:25 +0800
Message-ID: <267c4355-e930-4439-9239-bc78e7ab316d@huawei.com>
Date: Tue, 26 Mar 2024 14:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] SCSI: Fix issues between removing device and error
 handle
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <louhongxiang@huawei.com>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20240307144311.73735-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/3/7 22:43, Wenchao Hao wrote:
> I am testing SCSI error handle with my previous scsi_debug error
> injection patches, and found some issues when removing device and
> error handler happened together.
> 
> These issues are triggered because devices in removing would be skipped
> when calling shost_for_each_device().
> 

Ping...

> The issues are found:
> 1. statistic info printed at beginning of scsi_error_handler is wrong
> 2. device reset is not triggered
> 
> V4:
>   - Remove the forth patch which fix IO hang when device removing
>     becaust the issue is fixed by commit '6df0e077d76bd (scsi: core:
>     Kick the requeue list after inserting when flushing)'
> 
> V3:
>    - Update patch description
>    - Update comments of functions added
> 
> V2:
>    - Fix IO hang by run all devices' queue after error handler
>    - Do not modify shost_for_each_device() directly but add a new
>      helper to iterate devices but do not skip devices in removing
> 
> Wenchao Hao (3):
>    scsi: core: Add new helper to iterate all devices of host
>    scsi: scsi_error: Fix wrong statistic when print error info
>    scsi: scsi_error: Fix device reset is not triggered
> 
>   drivers/scsi/scsi.c        | 46 ++++++++++++++++++++++++++------------
>   drivers/scsi/scsi_error.c  |  4 ++--
>   include/scsi/scsi_device.h | 25 ++++++++++++++++++---
>   3 files changed, 56 insertions(+), 19 deletions(-)
> 


