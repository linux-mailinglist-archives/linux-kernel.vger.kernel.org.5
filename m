Return-Path: <linux-kernel+bounces-94855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49E8745F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876DCB21131
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4676139;
	Thu,  7 Mar 2024 02:13:40 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1346AF;
	Thu,  7 Mar 2024 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777619; cv=none; b=IrKeF5RvzRikLZXYEXIn3i80+mT3XasqkZhmhkvIIm1kfbm4Y1yjS9FavmaNcNXBmEYEXAeRlRyAzI89s6hV31/QLwbj9tw5wkybrNrWdzQI9lAACXz4EnzHgdhJizTbDLSSLUTygCi8i4vaeQ/LxMQi6UM0hUXa1C+9VwCKaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777619; c=relaxed/simple;
	bh=NYvLwxW5+Yk03IExklIdt8oNDuILP24XEPQPGfITePk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kkR0zB1Ymk+7dHNVkEX2nx9M2zh3iNe8kq0LbH46UmaIS45gA9lGvnp6v0L9jM5f5QnVWMZ54hlEPr03gEq4m3oSGGcDKgWLarzZ9KK5MQrZRhtDH0IPB+rICB3JSZgY8R57EE5+L2itPrLwboaNr0ZDDYzMqxMV6mQA7b+vcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tqt805Lxxz1Q9f8;
	Thu,  7 Mar 2024 10:11:12 +0800 (CST)
Received: from canpemm100005.china.huawei.com (unknown [7.192.105.21])
	by mail.maildlp.com (Postfix) with ESMTPS id C4F8E140155;
	Thu,  7 Mar 2024 10:13:34 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 10:13:34 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 10:13:33 +0800
Subject: Re: [PATCH v2] scsi: libsas: Fix disk not being scanned in after
 being removed
To: John Garry <john.g.garry@oracle.com>, Xingui Yang <yangxingui@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240227090149.29039-1-yangxingui@huawei.com>
 <f8de67cb-8d0c-475d-b3f3-bc38ff097823@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <4067aa2d-838d-5cd8-5e93-c9c4ade995fc@huawei.com>
Date: Thu, 7 Mar 2024 10:13:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f8de67cb-8d0c-475d-b3f3-bc38ff097823@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/7 2:43, John Garry wrote:
> As an aside, could libsas - and your changes here - be simpler if we 
> changed smp_execute_task() like this:
> 
> static int smp_execute_task(struct domain_device *dev, void *req /* can 
> be on the stack */, int req_size,
>                  void *resp /* can be on the stack */, int resp_size)
> {
>      struct scatterlist req_sg;
>      struct scatterlist resp_sg;
>      int ret;
>      void *_req = kmemdup(req, req_size, GFP_KERNEL);
>      void *_resp = alloc_smp_resp(resp_size);
>      if (!_req || !resp)
>          return -ENOMEM;
> 
>      sg_init_one(&req_sg, _req, req_size);
>      sg_init_one(&resp_sg, _resp, resp_size);
>      ret = smp_execute_task_sg(dev, &req_sg, &resp_sg);
>      memcpy(resp, _resp, resp_size);
>      kfree(_req);
>      kfree(_resp);
>      return ret;
> }
> 
> We need to use alloc_smp_resp() and alloc_smp_req() as we can't allocate 
> these memories on the stack for calling sg_init_one(). But if we changed 
> smp_execute_task() to memcpy from/to data on the stack, it might make 
> callers simpler. I'm not sure.

Maybe simpler. I have not check all the length of these buffers, but 
there is still a risk of stack overflow if the buffer on stack is too 
large.

Thanks,
Jason

