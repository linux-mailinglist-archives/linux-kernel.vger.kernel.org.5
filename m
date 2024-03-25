Return-Path: <linux-kernel+bounces-117603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89C88B23D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767DCB3D00D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67C5C600;
	Mon, 25 Mar 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6f93+Zw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADqaJtST"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A730487AE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387746; cv=none; b=G0UDWbCXsJhsst/Rg2sG+mYQUwlhO1EiFLQvt129iHpaIPkthtJrjjWyiQfK0Uyocg18prpt5lS8/Qc8AkTHLeFwKWAMxPH/MVjQx4AT6MdpYvwEz4iVCWdFEgzbgMLNtF0SX+/mxNhVgIMAOvc0lbksvRnyL1MH4Hm5TMo9VxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387746; c=relaxed/simple;
	bh=AJt1U9vTruj17U/R5Stf0nTDii3e+Z/CWmJMiKxifSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vle6ymo39zSlbLbovgEXUR2HF8Alxh3M6GiHB++UB+81JF4cLB+Xccm79vWAZNiSWKyPAeavXLdPtU6QJBWqp1KN5IzTPfgGRywT2MMHx3xrVO2bVkvWV3by6c7LinwiVBa+SXqrC8juLfajooL0lEHzQ6eFdK9MMRG+n9pO6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6f93+Zw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADqaJtST; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711387743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DK75XUtlMLk9/6ARSoFxcVcx+16IzV8AtSC+x6vyvg0=;
	b=D6f93+ZwVXOucjhz90HFPRG8UrmlmLHw5luAhexA228uzsatRdCZEo6Cf0rgIb3vIf4Yv5
	WBn4yUi8Vs53n1nP2RcYibCv+Ry9Lz56+lIzphC8B1gp+QICHV0oXc+P0gpn4PfZM8ZL/j
	Opsz07yxMw4nNK1+fGJa+XNfvb3C2s6kSoCK329vxCJBdVBPAesaYWUJleFB6NAAbWwviI
	QdqOt5MXbqv3MplJ5ZaQ5hw4BdX6wbibi4eWU9oAXMxw/T8jiN2VFIIjeHgA0g5e0NNuaU
	5sN2nDBcIOa/9Rk60SYId7qHKjaJEMY4wtq1mtTlfo+qKqiYTxNPLAXNdy/3aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711387743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DK75XUtlMLk9/6ARSoFxcVcx+16IzV8AtSC+x6vyvg0=;
	b=ADqaJtSTgua0QpmlQ9S4WNkb+UhTfDqmg9pUgccPc2/fxJseO/HvWkPVtOMfNJ7AGF035A
	VdvNBAQgh8+vNcCQ==
To: Jason Gunthorpe <jgg@ziepe.ca>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>, Bixuan Cui
 <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
In-Reply-To: <20240325134848.GA8419@ziepe.ca>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>
 <20240325134848.GA8419@ziepe.ca>
Date: Mon, 25 Mar 2024 18:29:03 +0100
Message-ID: <87bk72fcf4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25 2024 at 10:48, Jason Gunthorpe wrote:
> On Sun, Mar 24, 2024 at 08:29:00PM +0800, Peng Fan (OSS) wrote:
>> +static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
>> +{
>> +	struct device *dev = smmu->dev;
>> +	struct msi_desc *desc;
>> +	struct msi_msg msg;
>> +
>> +	if (!dev->msi.domain)
>> +		return;
>> +
>> +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
>> +	if (desc) {
>> +		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
>> +		arm_smmu_write_msi_msg(desc, &msg);
>> +	}
>> +
>> +	desc = irq_get_msi_desc(smmu->gerr_irq);
>> +	if (desc) {
>> +		get_cached_msi_msg(smmu->gerr_irq, &msg);
>> +		arm_smmu_write_msi_msg(desc, &msg);
>> +	}
>> +
>> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
>> +		desc = irq_get_msi_desc(smmu->priq.q.irq);
>> +		if (desc) {
>> +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
>> +			arm_smmu_write_msi_msg(desc, &msg);
>> +		}
>> +	}
>> +}
>
> I wonder if this should be done instead by converting the driver away
> from platform MSI to the new MSI mechanism?

There is work in progress for that. Should come around in the next
weeks.

