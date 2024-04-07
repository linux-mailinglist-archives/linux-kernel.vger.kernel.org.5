Return-Path: <linux-kernel+bounces-134155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B689AE53
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793D8B22927
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA177748F;
	Sun,  7 Apr 2024 03:40:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03387460
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712461252; cv=none; b=Pw53jMPUHP6/fvTP7hM5EdlqWmSrnE7fETKu5NpSzzMiCtWdmggEEcQfWiLX5u28qQuoHXnaWk3oCsNWakIUyfZCG3oGUqWI534wFNugj2X+ccmFRXJhpIsR+UYbgQl4zNZi33GvsXpeTCRfFoScCyF8eF/1jLihIGw65nDhYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712461252; c=relaxed/simple;
	bh=+80XGPfOBOGT2Exbt1OJdN8j7y3QHrq8yj1ZlXxqM14=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iADKSvOPUEZpMEJdDh42ZsbOjs/2EZSSF1ZNDtYFry0fniN6zFJGRfvoptgAWzuZdbxJzLTCaYx6SyeIMrgTy2vD2yn7vOzRABqWOy8BdLvN+/wMiTOd/v/Ex51PCz/nM3lrnoL+aa4yZEn2mzJ/p78xgnEMvwwSKLiDIei28ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VBybd3qXSzwRSQ;
	Sun,  7 Apr 2024 11:37:49 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A72A140154;
	Sun,  7 Apr 2024 11:40:41 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 11:40:40 +0800
Subject: Re: [RESPIN PATCH] irqchip/gic-v4.1:Fix VSYNC referencing an unmapped
 VPE
To: Nianyao Tang <tangnianyao@huawei.com>
CC: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<guoyang2@huawei.com>, <wangwudi@hisilicon.com>
References: <20240406022737.3898763-1-tangnianyao@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7eaf81b4-80b3-2728-0588-ecad6c137848@huawei.com>
Date: Sun, 7 Apr 2024 11:40:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240406022737.3898763-1-tangnianyao@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/4/6 10:27, Nianyao Tang wrote:
> As per the GICv4.1 spec (Arm IHI 0069H, 5.3.19):
> 
> "A VMAPP with {V, Alloc}=={0, x} is self-synchronizing, This means the
> ITS command queue does not show the command as consumed until all of
> its effects are completed."
> 
> Furthermore, VSYNC is allowed to deliver an SError when referencing a
> non existent VPE.
> 
> By these definitions, a VMAPP followed by a VSYNC is a bug, as the
> later references a VPE that has been unmapped by the former.
> 
> Fix it by eliding the VSYNC in this scenario.
> 
> Fixes: 64edfaa9a234 ("irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP")
> 
> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks.

