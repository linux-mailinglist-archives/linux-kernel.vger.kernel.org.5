Return-Path: <linux-kernel+bounces-98520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF669877B61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11961C20D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8812B70;
	Mon, 11 Mar 2024 07:35:35 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E511721;
	Mon, 11 Mar 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710142535; cv=none; b=HPmCWDfxsB0KN9FIXTb/pSgqT1MSmdOvtY9PkZsdAqudTDwLVif83tAyxuHcCBsB92U882eH9wJw+e++DwxiKsjCS2QBKp7ISJ2D1TPwjLN4RT0cBiDhOcnCgq+0xGSM57T2fJRRPpAx/ie+IT9RYVTeEUpqMmul5aTIChvZLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710142535; c=relaxed/simple;
	bh=7LH2wzc/LZb2FQlVliTCF9VhxXEg9MBUThqc0qpE1JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y6a4986lCTsrM4Gb8M9Ncon8mlkQZb8p632ReX0wAF/PCQH07Sbc+Iqvv6+b5E2XQLG/+HlldcDGUmojJShpvqbbkW+DhoB3DDVuJ9+L+PDZ8IIJNP+sS9gLWlinpebLc50aIHKblvZ1EnSCEo/Q4SeRIIi6qUS+EZZy13CwW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TtT5X5yK0z1h1rl;
	Mon, 11 Mar 2024 15:33:04 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BEDD14038F;
	Mon, 11 Mar 2024 15:35:30 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 11 Mar 2024 15:35:29 +0800
Message-ID: <b2762a93-c8e3-f467-aed6-37c7e124f7c8@huawei.com>
Date: Mon, 11 Mar 2024 15:35:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 1/3] scsi: libsas: Allow smp_execute_task() arguments
 to be on the stack
Content-Language: en-CA
To: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	<john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <0cf17536-beba-4a8f-836b-553a9e0d1046@moroto.mountain>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <0cf17536-beba-4a8f-836b-553a9e0d1046@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpemm500024.china.huawei.com (7.185.36.203) To
 dggpemd100001.china.huawei.com (7.185.36.94)



On 2024/3/11 13:42, Dan Carpenter wrote:
> Hi Xingui,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xingui-Yang/scsi-libsas-Allow-smp_execute_task-arguments-to-be-on-the-stack/20240307-174215
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
> patch link:    https://lore.kernel.org/r/20240307093733.41222-2-yangxingui%40huawei.com
> patch subject: [PATCH v3 1/3] scsi: libsas: Allow smp_execute_task() arguments to be on the stack
> config: i386-randconfig-141-20240308 (https://download.01.org/0day-ci/archive/20240310/202403102353.jUPi6fOP-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202403102353.jUPi6fOP-lkp@intel.com/
> 
> New smatch warnings:
> drivers/scsi/libsas/sas_expander.c:148 smp_execute_task() warn: possible memory leak of '_req'
> 
> vim +/_req +148 drivers/scsi/libsas/sas_expander.c
> 
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  138  static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  139  			    void *resp, int resp_size)
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  140  {
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  141  	struct scatterlist req_sg;
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  142  	struct scatterlist resp_sg;
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  143  	void *_req = kmemdup(req, req_size, GFP_KERNEL);
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  144  	void *_resp = alloc_smp_resp(resp_size);
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  145  	int ret;
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  146
> adfd2325dfc5cf6 Xingui Yang     2024-03-07  147  	if (!_req || !resp)
> adfd2325dfc5cf6 Xingui Yang     2024-03-07 @148  		return -ENOMEM;
> 
> I haven't looked at the callers so I don't know how likely it is for one
> of the allocations to fail and the other succeed...  But it seems
> possible.

Yes, it's possible. This patch has been canceled in v4. Based on John's 
suggestion, if there are plans to resubmit modifications , we will pay 
attention to this, thank you.

Thanks,
Xingui

