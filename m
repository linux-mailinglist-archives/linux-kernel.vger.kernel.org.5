Return-Path: <linux-kernel+bounces-59564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E084F8FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2425A1F218C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527347603D;
	Fri,  9 Feb 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DiQKMWQp"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0307A6BFD6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494191; cv=none; b=iHxRQc+7mzvHv8wx8+9x96cvc4+os4OILp68UTaCVGvXa5ByFhJjkSEdV8ccez5Kbn7V35uqkDVs7Lgg8RMKkqMMEqC7BC6WKFSu0yk9JZJqH07CTToahume814S4orhKtulNpmz5oNacWs9XzQbans8QMFFhoA4c020C8EsdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494191; c=relaxed/simple;
	bh=sGILdJRtb5NyY9Li4DGYYluQKKKhedmvl7EZSiazdsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjNTBWVc+LlrfNXQcSMn9l8x9V62lC06EyHuUYTQnOBxDu2LngBdFMI2M5sSkoE7U6Z/mCuwjdzIhJn93DN/qc5p4v2rniK3Q/N6QP++AeHK3BNOTN96oYWDr+yuEocZ5/pPHQSjyBPAJE9+VMe2oed31G4URYrZOvE2S+nFtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DiQKMWQp; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B77C91C3252;
	Fri,  9 Feb 2024 16:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1707494187;
	bh=sGILdJRtb5NyY9Li4DGYYluQKKKhedmvl7EZSiazdsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiQKMWQpATASJ0cWeF2J7gdSiaFg0O0rHT36+2hnCGXylpYLAJD9+Hereh9DOzf1r
	 q8oXLjQPxvkLVhz1cVXah/tDcz8JbxNuPqVxQO4Z2eMWUjeScRkprGKImaroPHlJ4m
	 V1fJBrm3/rLuSehmvc7egjm/CaI70FFw127fPpZ4ZSo/v9+07RGpP3BrgBwSTGVN4/
	 HiZldgyKS3O3hqNDQXSwFNqoxCXKYr/6FiUQBJXku0vSi4sFqGkWh1l25UkWi6Uecl
	 Sc5RDqERWMUSPQilthUpHsr7l1vZ+5kqQwU5KUmLlzacwf8L7IwxcYdRuMM+M3HC/U
	 58qlf1ImrSCrQ==
Date: Fri, 9 Feb 2024 16:56:26 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Mark interrupt as managed
Message-ID: <ZcZLKtFrbLax9lYP@8bytes.org>
References: <20240122233400.1802-1-mario.limonciello@amd.com>
 <de66890b-a42c-4d8b-8079-fcfff0007aeb@amd.com>
 <ZcXhMNZDOHstOP5k@8bytes.org>
 <23361410-3b56-42fb-aea8-3be53bfe5ae1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23361410-3b56-42fb-aea8-3be53bfe5ae1@amd.com>

On Fri, Feb 09, 2024 at 09:48:57AM -0600, Mario Limonciello wrote:
> Thanks!  This problem should go all the way to when MSI support was
> introduced (2.6.28):
> 
> a80dc3e0e0dc ("AMD IOMMU: add MSI interrupt support")

That makes most sense to me, also if it only uncovers with ...

> 
> But I don't think that's a correct fixes tag because
> irq_managed wasn't introduced until 3.19:
> 
> cffe0a2b5a34 ("x86, irq: Keep balance of IOAPIC pin reference count")

This one.

> But then I tried to go off the original introduction of the error message,
> but that's quite ancient.
> 
> 1da177e4c3f4 ("Linux-2.6.12-rc2")

That is not relevant, as the first AMD IOMMU driver was only merged for
2.6.27 :)

> Cc: stable@vger.kernel.org # 3.19+

That makes sense too.

Regards,

	Joerg


