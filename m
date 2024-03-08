Return-Path: <linux-kernel+bounces-96755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6387610C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090731F22D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F7535D3;
	Fri,  8 Mar 2024 09:38:29 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F752F7F;
	Fri,  8 Mar 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890709; cv=none; b=Jpk7fJHp2waAcG4l3IDLgjsp6pchJ1rlQpSi8cxKluLqHrTHmJOccQyMaZgda8AnZnFFxNGDDw76HWN2YHYS/ojNTY1RAXzELDnpU2u2XjNkvgtXdYkz09oyTq7XxBL6Zd+e9nlAOR60s9JUJ+wOhW8jGDAyUguEm3Mnn+K1Lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890709; c=relaxed/simple;
	bh=NBM3HX/hK8juwoAhjLMl+cACL+7l+tnUbk6HIlPOyd8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dXIA+ZyyKZiCjLzK1CXzj667BWS/Cx+5gYsM/vQGS4G23QS0qTvmGNrVw9yQd0tMKrqdlhrmSnriRkYJqyf3xRIV4IAPoYUhcfMCk8oq4UUAy9PY3GX0Jjdn4Ii1aI6Kvia9ZvKi/2p6eRomdB1C8OfINyz9j//Vf9+9SM4Ma7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Trgyd0q6Sz1Z1MQ;
	Fri,  8 Mar 2024 17:35:53 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CE271A0172;
	Fri,  8 Mar 2024 17:38:16 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 17:38:15 +0800
Message-ID: <447cb805-9ad0-4e08-8038-45e3cb8c81fe@huawei.com>
Date: Fri, 8 Mar 2024 17:38:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>,
	"wangjie125@huawei.com" <wangjie125@huawei.com>, "liuyonglong@huawei.com"
	<liuyonglong@huawei.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 6/8] net: hns3: fix reset timeout under full functions
 and queues
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>, "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
References: <20240307010115.3054770-1-shaojijie@huawei.com>
 <20240307010115.3054770-7-shaojijie@huawei.com>
 <BY3PR18MB4737FA1796C8BC8180296BE8C6202@BY3PR18MB4737.namprd18.prod.outlook.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <BY3PR18MB4737FA1796C8BC8180296BE8C6202@BY3PR18MB4737.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/7 19:24, Sunil Kovvuri Goutham wrote:
>> In order to avoid the above extreme situations, the driver extends the reset
>> timeout to 1 second.
>>
> Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
>
> But one observation, loop of udelay(1) for 1sec seems a lot, probably better to use usleep_range().

but this is protected by splock, so cannot use usleep_range().


