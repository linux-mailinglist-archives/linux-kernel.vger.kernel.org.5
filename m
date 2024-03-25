Return-Path: <linux-kernel+bounces-117066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04188A6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E938129C045
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF7B433CA;
	Mon, 25 Mar 2024 12:56:02 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053B38DFB;
	Mon, 25 Mar 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371361; cv=none; b=fm/Eaf2mIb+83nvpsMqp5Uwcc7JSajtKpKDKYoNkmKp68DXBkFlSsqLpC1FGGx26Xk/dDnTln4CsYPQ1LOTkIg7zDYuPrAiA96TkqPT50Ixn/wJj6kSpp4FVJ06w2WluQoIqYZHPIIWLHZFwdcghtnBm5ZMO2eBjTd6gM9w+V3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371361; c=relaxed/simple;
	bh=c4xZArgJXXwnnTGel36776VcScv+UvXSaPw/bNb3bmc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NMpJnrblZEqWIs59NPDC9rFJdZgNa7XPx81nuXYRp/8/fUDn89OTpViyHy5XX/q5hb6zqhykRP5AkgXM8XosLSousdJFDzDgI2yKnzPw3uemMET/xLNwpcV28awLIbu7WS1v7/XM+Xc/6qjs9dU/voZxFks6Ri6ylccVgTMCjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V3Cb508ktz1GD2K;
	Mon, 25 Mar 2024 20:55:29 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id C53121400D4;
	Mon, 25 Mar 2024 20:55:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:55:56 +0800
Message-ID: <fd2ff9ce-077e-4632-b515-f4b4c46b596a@huawei.com>
Date: Mon, 25 Mar 2024 20:55:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.kubiak@intel.com>,
	<rkannoth@marvell.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net 1/3] net: hns3: fix index limit to support all
 queue stats
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-2-shaojijie@huawei.com>
 <CAH-L+nPtgMUXve82iVq_q8yTpzDuwR4bHyz+Tv_xb9tYGR=83Q@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAH-L+nPtgMUXve82iVq_q8yTpzDuwR4bHyz+Tv_xb9tYGR=83Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/18 22:36, Kalesh Anakkur Purayil wrote:
> On Mon, Mar 18, 2024 at 7:05 PM Jijie Shao <shaojijie@huawei.com> wrote:
>> From: Jie Wang <wangjie125@huawei.com>
>>
>> Currently, hns hardware supports more than 512 queues and the index limit
>> in hclge_comm_tqps_update_stats is wrong. So this patch removes it.
>>
>> Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs for PF and VF reuse")
>> Signed-off-by: Jie Wang <wangjie125@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Only question I have is whether this is a fix or an enhancement.
> Nevertheless changes look good to me.

Actually, it's a fix. The capability of supporting more than 512 queues 
was not implemented by modifying this statistics. this bug prevents us 
from querying the statistics of more than 512 queues.


