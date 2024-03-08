Return-Path: <linux-kernel+bounces-96623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CE875F06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5921C2236C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C050251;
	Fri,  8 Mar 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="qjXbB9GG"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A21481DC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885047; cv=none; b=gCXDsgFFnoOoL9SvSpntLf6SRmOWYKgLClzKyE7egABxDJW7r/6/FJTrhoHvDDYaoEo+jzW+WNTdtSugKtLGipyNJPlZHyh4aN9/xpxUwLuYtdTmJNn7tWW/Fd/wUV8MaToLZWsXeYHInWJaRdwnKEKiJXDJewevN3BYkRHDTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885047; c=relaxed/simple;
	bh=Tj4ofHFYwxwXdYplFbwJR6NlSCiyaY/WYzQGImhj/E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsFRkClADnKLRWYa/NRcarSxSaAvPGfcerN++XQCuWOCWQX4yKtEHISt7quVJp0sAGxiZq1d5SdUPhzRJhECSv0Y5kdzSAkol1I90HKVnKNtVxuL47dMfDmlU1yKkTkQPhHj3FzWMp4CVAXK7R0LNH0e+m5qQ5/2giYzrAlsBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=qjXbB9GG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 43EAE1C6B16;
	Fri,  8 Mar 2024 09:04:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709885044;
	bh=Tj4ofHFYwxwXdYplFbwJR6NlSCiyaY/WYzQGImhj/E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjXbB9GGNNZAGoD6g7hZm5Mi3G3zLWkDtmsVpEpf0UC/YPExJNRJcxlrvd0oFU2Id
	 szKHpjohvlSZGrvaiKQG3J4/cW5Zr78Wu+2B4Lw0o2fMmW2JzG7JUf+lBHz09+N9L2
	 AEPR8rcjeqjVgPuCvfdZU/oiLKnWilwVa1lc5Qwo8NO+O7VQSzGUkeNSI+awHzkfVS
	 GJLUfly0n1smrZ4lhDNmGVdFWKBtedpllMlxLsfC9iweZbIvId6yR1HSrV543PEcNJ
	 tC5ySal5KzMnk6LcARVPVeQOMp65yu+3IvvzFha1NTk4WQSGzapY5fZ08Ss/GXBDeL
	 /aimzch0lWIaw==
Date: Fri, 8 Mar 2024 09:04:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, haifeng.zhao@linux.intel.com,
	iommu@lists.linux.dev, jgg@ziepe.ca, jiaqing.huang@intel.com,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH] iommu: fix compilation without CONFIG_IOMMU_INTEL
Message-ID: <ZerGcst7kcfrtvop@8bytes.org>
References: <20240307194419.15801-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307194419.15801-1-spasswolf@web.de>

On Thu, Mar 07, 2024 at 08:44:19PM +0100, Bert Karwatzki wrote:
> When the kernel is comiled with CONFIG_IRQ_REMAP=y but without
> CONFIG_IOMMU_INTEL compilation fails since commit def054b01a8678 with an
> undefined reference to device_rbtree_find(). This patch makes sure that
> intel specific code is only compiled with CONFIG_IOMMU_INTEL=y.
> 
> Fixes: def054b01a8678 ("iommu/vt-d: Use device rbtree in iopf reporting path")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/iommu/Kconfig         | 2 +-
>  drivers/iommu/intel/Makefile  | 2 ++
>  drivers/iommu/irq_remapping.c | 3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

