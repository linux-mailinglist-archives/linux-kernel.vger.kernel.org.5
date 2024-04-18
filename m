Return-Path: <linux-kernel+bounces-149625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D78A9399
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC652838A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E83BB22;
	Thu, 18 Apr 2024 06:57:07 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6136AFB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423427; cv=none; b=sNPPZQdzPTMwwlnGKfLwcJvZdrE7rrNbwiGm5hYAGVgtCGEt1cI0a4mdkDGrgFlVnG3fWRxUKBJaeh4e9WRqBerL5/sH5J8BDNhba8I8NMkrLygRec6LRGZjB3xVmsYEP7OZiAoHnRydknufbBha3gKqXbmM9lLoA2556MYCbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423427; c=relaxed/simple;
	bh=KTV9d9m5ULqWdRsCWhcbktq4be9k6Rcu75frTwGa6cI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TN9ka/JAI25I23sH85P1FDur9QH1yENQpVSSrjkKTOTAJDLjWMmNHf8Sc7B3agzMCwXhOvBUE8e8hSIe7XrZMRe3GYJBIhoPAM8r+grdg+mtzqrY8TwNKUAwjXKMpw91qNXkAxl4n4JnRT6/V/Z/c7ouIKzd2rTEhOvqjwSwS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VKpRd2KT1z1xv5q;
	Thu, 18 Apr 2024 14:54:37 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A3CF1400D4;
	Thu, 18 Apr 2024 14:57:01 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:57:00 +0800
Subject: Re: [PATCH v5 2/2] irqchip/gic-v3-its: remove BUG_ON in
 its_vpe_irq_domain_alloc
To: Guanrui Huang <guanrui.huang@linux.alibaba.com>
CC: <maz@kernel.org>, <Markus.Elfring@web.de>,
	<shannon.zhao@linux.alibaba.com>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240418061053.96803-1-guanrui.huang@linux.alibaba.com>
 <20240418061053.96803-3-guanrui.huang@linux.alibaba.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d22e706c-b964-ee5a-4930-25f22586f7d3@huawei.com>
Date: Thu, 18 Apr 2024 14:56:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418061053.96803-3-guanrui.huang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/4/18 14:10, Guanrui Huang wrote:
> This BUG_ON() is useless, because the same effect will be obtained
> by letting the code run its course and vm being dereferenced,
> triggering an exception.
> 
> So just remove this check.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

