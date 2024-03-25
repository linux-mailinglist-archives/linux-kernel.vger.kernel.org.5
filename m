Return-Path: <linux-kernel+bounces-117615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6888AD41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63B62C71A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36927134420;
	Mon, 25 Mar 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAK6G8El";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHIDaqqo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138A51327FE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388461; cv=none; b=gkm20rAAQd/j4aL2lLRcRCBQ0Im4tYHVQuf0kV7+aotgYzO1+IeWvx3g3sQPiNX/hi26kH+VWPALgsvaP4DUtVpepPMUa9rBxbd9rS85gZm/9VEJPJ/UgPYfDPueiW2HLzLkXyMbm8Ka4CmTMOqjp/B1N6QhEU2aIJQ9aBhQYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388461; c=relaxed/simple;
	bh=pHokYGdGQkEJ9+IjLb+73a4lmnWUxZDuSDnAyDRJASg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DK/TC3BL8z6agj6V3mCrypCF2TkpG+nnvI4w+Uzx2UqIfN+0nW2bbaWX7ZjXRr4bvyCnIjSs2A6aKZAAiQ2s149/8wEASIW3GlEEo3AlcPuYnk33u6QNV1S5FVvEINpJp14Vqz2jVnvGuWYoPJZU2UXQIqSb+pMQgW6eZox2Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aAK6G8El; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHIDaqqo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711388458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xmzb+eW330TUASaWKG2wSZdy0QxEcVUyM2WdEc5Izc0=;
	b=aAK6G8ElBaGz3aXo/UA9razEyWcBZRcJ+5cVa+60XUd4Jkb1/SO8MesWRi1u3xmAl309ZI
	0NBJE+ltFsNrs3dMkvkm4APaoaYtVLekPEE2+/7yjJ4/E6i0MVaVWy3EJt0SgseJ8Py0j1
	CXWms2Gs0CN9cZDUt9yFxlm1OEYGtL3z/wM//Ddld5tJ8jnYhGw4ibN3yDBybuNaFwPe3/
	OoigBJqrDf4ALjtUn/ASohHwFI2GMEcO8bh3w6Sh0/dUcUqHTKfn0BYgNQ7lu6WNHyyOFU
	uYzI3otrMBlSbncKt8Vivbm9WREfdZqGzhBHTd0USBELhvvLAJ9F9m/RFgijpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711388458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xmzb+eW330TUASaWKG2wSZdy0QxEcVUyM2WdEc5Izc0=;
	b=bHIDaqqoMRjarqEGazNFrdIwC2Fqjk3r89j5otyheYgKoAN2/orw+lrQcUqZ92PNtDl84X
	biOkOk8IDzh/E3DA==
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Marc
 Zyngier <maz@kernel.org>
Cc: Bixuan Cui <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] genirq/msi: cache the last msi msg
In-Reply-To: <20240324-smmu-v3-v1-2-11bc96e156a5@nxp.com>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-2-11bc96e156a5@nxp.com>
Date: Mon, 25 Mar 2024 18:40:58 +0100
Message-ID: <878r26fbv9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Mar 24 2024 at 20:28, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Cache the last msi msg which will be used for ARM SMMU V3 resume
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  kernel/irq/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index f90952ebc494..9d7e0a675089 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -617,6 +617,9 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
>  {
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	desc->msg = *msg;
>  	data->chip->irq_write_msi_msg(data, msg);
>  }

This should remove the very same line in the PCI/MSI code, no?

Thanks,

        tglx


