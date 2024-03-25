Return-Path: <linux-kernel+bounces-117063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E988A695
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E792E4D63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858413BC30;
	Mon, 25 Mar 2024 12:51:45 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226047A6F;
	Mon, 25 Mar 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371104; cv=none; b=JJbHICv8aPeynWnNO38PWVwcAm0GRt4V2/X4VD2AIAGbBmaEqe13mbjHlITd+nFatvnaCIXP5r9h00vZmWbls+826gLfRKEHH+K7Fe5y3sye2RDHJ3YV5LCOi07GnNlXpKlKOfRI4iQYXa1VZWyaxsIL2wo2QQsQCdAjbDs2B1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371104; c=relaxed/simple;
	bh=ZVogx11ulyTOf9KakHLa9Y+wnnqXepPLDEtt7Xo49Rk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FQPwl3rstC5NwIjtlwmxstjeeglcWY1P2OWwWBa7e/PiPpoRYHFxn0QvR87QlZMOzp8T7SWru4Rpp5OGt7y1hp1YFnk9q7R8Xqxc/D2gtGM9YIe1ndTquDQpXjSSwB4ophHwguwUIgPeFKp4ZUO3VA51d5tjHMHovDYdtN7b9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V3CV71mj4z1GD2P;
	Mon, 25 Mar 2024 20:51:11 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 083661A016C;
	Mon, 25 Mar 2024 20:51:40 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:51:39 +0800
Message-ID: <ed3f0650-1c27-4daf-9f92-0fe0927acea9@huawei.com>
Date: Mon, 25 Mar 2024 20:51:10 +0800
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
Subject: Re: [PATCH V3 net 2/3] net: hns3: fix kernel crash when devlink
 reload during pf initialization
To: Jiri Pirko <jiri@resnulli.us>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-3-shaojijie@huawei.com> <Zfl0Xz3vNNH_3Mfo@nanopsycho>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <Zfl0Xz3vNNH_3Mfo@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/3/19 19:17, Jiri Pirko wrote:
> Mon, Mar 18, 2024 at 02:29:47PM CET, shaojijie@huawei.com wrote:
>> From: Yonglong Liu <liuyonglong@huawei.com>
>>
>> The devlink reload process will access the hardware resources,
>> but the register operation is done before the hardware is initialized.
>> so, if process the devlink reload during initialization, may lead to kernel
>> crash. This patch fixes this by checking whether the NIC is initialized.
> Fix your locking, you should take devl_lock during your init. That would
> disallow reload to race with it.
>
> pw-bot: cr

Thanks，

   We have fixed this in v4.

   Jijie Shao


