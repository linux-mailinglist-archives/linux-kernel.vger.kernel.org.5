Return-Path: <linux-kernel+bounces-118705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16888BE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F342E106E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897B679E1;
	Tue, 26 Mar 2024 09:43:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE41B960
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446226; cv=none; b=gpUyhX5EY/bQe6flr7co68qkF4LSFifImKcHniN3JhhmOhmMQKCRSkvjiSPzswE6ndXuCMYd2sPEk2IWDt/pVoZhXHHLNVMQSxsgbMpfJ+N9pP1zLAdYA9Z49vI0OGbkWT+B3XsMD/66TtdKz1lBQLmM/7X9/t1UYuvWmgLd8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446226; c=relaxed/simple;
	bh=wipVMc+NlSaL82f8xhMlxm/RnK5hF4qw47WslRc5PQw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aZXCuFhOFOOeLt06/3G3pdD74YdDLUKI9snL3oi7oXFllrkS5tW3r4hKGIdqafgEfbTcdnORdQ/7NcSxvPsIiZeSpDaN9aAfZqeveEIokeKCOqDFiaYIU9A/VjsCNtHH+h4nAVkq2D/2BfgrEm/ZcBeXHlvgAcNRZEalaUZA7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V3lGK1tszzRjmh;
	Tue, 26 Mar 2024 17:42:49 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 99F091402CB;
	Tue, 26 Mar 2024 17:43:40 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 17:43:39 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix double free on error
To: huangguanrui.hgr <huangguanrui.hgr@alibaba-inc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<maz@kernel.org>, <shannon.zhao@linux.alibaba.com>, <tglx@linutronix.de>
References: <aac642a4-85a1-6df4-1192-638ce0d5086e@huawei.com>
 <20240322023810.62914-1-huangguanrui.hgr@alibaba-inc.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <661a577c-b4bb-e438-6ba5-6ed90b08649f@huawei.com>
Date: Tue, 26 Mar 2024 17:43:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240322023810.62914-1-huangguanrui.hgr@alibaba-inc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/3/22 10:38, huangguanrui.hgr wrote:
> We notice that:
> In its_vpe_irq_domain_alloc, its_vm is from args, But in its_vpe_irq_domain_free,
> its_vm is from domain->host_data.

They *should* point to the same its_vm structure.

> Will these two values be different? For example, when other bugs occur?

Of course they can be different if there are *bugs* but I guess you
won't get any further (e.g., you hit BUG_ON(vm != vpe->its_vm) in
its_vpe_irq_domain_free()). The right thing to do is fixing the bug
rather than papering over it.

Zenghui

