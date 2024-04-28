Return-Path: <linux-kernel+bounces-161222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDA8B4934
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24734282023
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365110FF;
	Sun, 28 Apr 2024 02:19:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0BEC3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714270775; cv=none; b=MCu8uvu2iNlDuMl5xf4CJYSOy0RTHKugWSWOfFyURDZlByji7I6eU9xGA9OxAAi+Z2d3+pSx8EUIOz0dH7MuhfKnl3J+2Z0zYLNt1CUT1VQYbdY59qoPbCsv7xFeRdYw1Xm/zy7D6Avn7wNPPdlpEyNlz2cBWkgAowtWpus643I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714270775; c=relaxed/simple;
	bh=tuczu2NeyudK1aZ8g+d3ndX+N2EeGuqQz9kCkH5dAjE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MijaV2Flm0racR1umI1poluchpSEhTky8AexhY0DfZSwb2aDbuvL67SoTmZwcv691UwmZ3Wff8ve8nRRmJX5xSyDtm+4j+4olOkAhVHg1ruDGqpmW566iCt32EUJkUe4ioD691l2rldwv2F4KoLIke3ffZOajwNwtsVS1UHsWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VRqsM4zCBz4f3m7P
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:19:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1374C1A017A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:19:29 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBEusi1mIt2dLA--.32197S3;
	Sun, 28 Apr 2024 10:19:28 +0800 (CST)
Subject: Re: [PATCH V3 1/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
To: Tanmay Jagdale <tanmay@marvell.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
 mshavit@google.com, baolu.lu@linux.intel.com, thunder.leizhen@huawei.com,
 set_pte_at@outlook.com, smostafa@google.com
Cc: sgoutham@marvell.com, gcherian@marvell.com, jcm@jonmasters.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240425144152.52352-1-tanmay@marvell.com>
 <20240425144152.52352-2-tanmay@marvell.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <85f8d4df-4e4b-0460-4e34-d38588f18639@huaweicloud.com>
Date: Sun, 28 Apr 2024 10:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240425144152.52352-2-tanmay@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnOBEusi1mIt2dLA--.32197S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13CF47GrW7Kry3XrW3GFg_yoW8Xrykpr
	93Ka9rJFy8tF1xZw1FqF1UXF15tw1UJ3W8Gr4UGF93Xw18C34xur4UGw4Fy347Jry7Jr47
	C34jqasrua1DJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUo0eHDUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/4/25 22:41, Tanmay Jagdale wrote:
> +static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
> +{
> +	int ret, cpu;
> +	u32 i, nump, numq, gap;
> +	u32 reg, shift_increment;
> +	u64 offset;
> +	void __iomem *cp_regs, *cp_base;
> +
> +	/* IDR6 */
> +	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
> +	nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
> +	numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
> +	smmu->nr_ecmdq = nump * numq;
> +	gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
> +
> +	cp_regs = ioremap(smmu->iobase + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
> +	if (!cp_regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nump; i++) {
> +		u64 val, pre_addr = 0;

This is my mistake. The 'pre_addr' should be defined out of this 'for' loop. Or, you
can remove all 'pre_addr' related statements, commercially available chips that have
been tested cannot have such errors.

> +
> +		val = readq_relaxed(cp_regs + 32 * i);
> +		if (!(val & ECMDQ_CP_PRESET)) {
> +			iounmap(cp_regs);
> +			dev_err(smmu->dev, "ecmdq control page %u is memory mode\n", i);
> +			return -EFAULT;
> +		}
> +

                                                     <---------------------------------------------
> +		if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {           |
> +			iounmap(cp_regs);                                                          |
> +			dev_err(smmu->dev, "ecmdq_cp memory region is not contiguous\n");          |
> +			return -EFAULT;                                                            |
> +		}                                                                                  |
> +                                                                                                |
> +		pre_addr = val & ECMDQ_CP_ADDR;                                                    |
                                                      <--------------------------------------------   feel free remove these
> +	}

-- 
Regards,
  Zhen Lei


