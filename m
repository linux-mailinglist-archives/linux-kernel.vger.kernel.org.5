Return-Path: <linux-kernel+bounces-91574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB08713D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2EA1F22F1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B792941B;
	Tue,  5 Mar 2024 02:46:08 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598628E3C;
	Tue,  5 Mar 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606768; cv=none; b=q1umis/FMQ8v+g6CRejl+zrI2DEiWJHAxnoL7O0YaRJkMY9F38A7OvVhcdLIO4TJGKSMwBHmRreESWQwYZnY8FnRGcyeCcV8VWqiFdnrs26fYwIp9Hu2VUDFfxyZzBtUmFB2YeXTlw4PV8tWm7sKZ15bDb7FrQXcZNXvAl0mSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606768; c=relaxed/simple;
	bh=VyodJ7q46eOqwpnV94G6XT1uJKUYohi9Rth0vngXN5g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GMFdsX+ZbDDcfVgbtLcSekQz80iklg7JM5jliNQEx88LS6Qo8YNaoJVN4/HFKKHZIqHkPbDKvclVcLwJ5MwKzTSIHucEaGt8+cdhOo4xpzXh9NrJBiu3N2WimLv19A/yag7x+4UbpcebImwb9Lv+LQm1mrqYSmPvf7s/mMGUQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpfyR4Djnz2BfBx;
	Tue,  5 Mar 2024 10:43:43 +0800 (CST)
Received: from canpemm500003.china.huawei.com (unknown [7.192.105.39])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BDC21402CE;
	Tue,  5 Mar 2024 10:46:03 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500003.china.huawei.com (7.192.105.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:46:03 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:46:02 +0800
Subject: Re: [PATCH v5 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
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
 <20240305005103.1849325-6-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <c8ee00b0-3c27-7c6b-72c1-b6bfebf69ada@huawei.com>
Date: Tue, 5 Mar 2024 10:46:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305005103.1849325-6-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 8:51, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry<john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

