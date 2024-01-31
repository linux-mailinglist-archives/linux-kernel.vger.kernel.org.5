Return-Path: <linux-kernel+bounces-46151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA1843B47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4766A2902D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26667C51;
	Wed, 31 Jan 2024 09:39:19 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3E67A1F;
	Wed, 31 Jan 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693958; cv=none; b=SnSw2oXmHG7wvkKbU2jwYD3QXUyydoM3P1h92WbFFEJtdSTXwZOfg9cccYFKzqZH5AeNEeGMjJDw+itW83vPr4Kgfhaga33HIxSHUxm3h/XCaQIspQLRrlNlcZNfdIVw9fhy/zEi7naIpZMSBLdFslUNK6pISyB8hYRlS+DW1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693958; c=relaxed/simple;
	bh=pposIYrbfP1FjTASnuUOZTLdStEf4fYnOwJN6SZpVBE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NM0EwHcMa1CncQEzNJOyr5JvACtMy57Kg91qxwJRcGO+P8rAHYlzBoIuVIHT69gtDOX4X9Joro2KAmRndpEmi1EEGfG39ILDb6rbZBxUJknTq0INQANstbqC8ZURzaC8OPWudnUGyr+z8T2h1fBDlCEgpfetWSZsRwljyhz7+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TPxlQ4w8jz1Q8FR;
	Wed, 31 Jan 2024 17:37:22 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 65A681A016C;
	Wed, 31 Jan 2024 17:39:13 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 17:39:12 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Restore quirk probing for ACPI-based
 systems
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <stable@vger.kernel.org>
References: <20240127110702.4068488-1-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <08b67af4-22d6-84f3-62ea-90a5e5e1eb25@huawei.com>
Date: Wed, 31 Jan 2024 17:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240127110702.4068488-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/1/27 19:07, Marc Zyngier wrote:
> While refactoring the way the ITSs are probed, the handling of
> quirks applicable to ACPI-based platforms was lost. As a result,
> systems such as HIP07 lose their GICv4 functionnality, and some
> other may even fail to boot, unless they are configured to boot
> with DT.
> 
> Move the enabling of quirks into its_probe_one(), making it
> common to all firmware implementations.
> 
> Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Looks good,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

