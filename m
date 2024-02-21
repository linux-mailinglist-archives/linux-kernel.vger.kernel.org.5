Return-Path: <linux-kernel+bounces-74417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B415D85D3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3FE285637
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280593D0C9;
	Wed, 21 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="sWpRC7IE"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5A3D0B4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508075; cv=none; b=J85zIpNnguNLCGGT1vlpwIBC74Q1esvjzeVDFELjSi9tGrO1WkDXt7vc4a43DRZ6XHC88n64qLSi12zIU5jyzZPYajgSylKHxLExjH/pEtKfwsiU+lvLQAwkEPm+0bEt4NzneulB49J/mJCvTR10WRK70RKPknmrmSyc+2pHZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508075; c=relaxed/simple;
	bh=Rls91y6UPV+YWDL8FUEyuJpOlItoycsKIoJxGHAsgeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikWIxqT8bJYp8Vndhf+8bD9YjUXunYRkQG6d+aJTX48u4/pqsq5oTdCATN0SxNwDCeWi4yzpTgDNfu1K7+UC4gkuqXe/oQJAstIcomUoLmvn/uL70pWol4sF8ElSwy48PANHrUdvIx2ncrTFi9INixW5rDi0m3exvgrIzdfY2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=sWpRC7IE; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 897381C3F50;
	Wed, 21 Feb 2024 10:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708507759;
	bh=Rls91y6UPV+YWDL8FUEyuJpOlItoycsKIoJxGHAsgeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWpRC7IEap2E9/ER45qpgUcGAwrbLMFgX7eTJLeE/l25nQWKXcCqLhciH24bR1LlT
	 uZT1fWJ0M9YTX5RAgZ7vVi+9D6GhWiud2XoTxoGDHGZKlrFTpCSFEP48XD5+a0UJTJ
	 419byr0vFwXEAcUSEAOf2l2PAkI3u/tqJcwSV2YTrWmrdNkRmS01usHAScG5n4T7qu
	 eW2G2085CJT0Zd9FiP8BLacksEupAkElrWQrQN6hKRo51mlRkwWg7nbuEfpY0oTA4n
	 2seTwSfhjvZsovALykmvx7Qj65YLpJg/Z3fjF+z3I3RTWpiI8VePkmSBrKfLxYchSL
	 OcT4F8awP7wiQ==
Date: Wed, 21 Feb 2024 10:29:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] [PULL REQUEST] iommu/vt-d: Fixes for v6.8-rc5
Message-ID: <ZdXCblOVDg0vGDLf@8bytes.org>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>

On Mon, Feb 19, 2024 at 07:15:51PM +0800, Lu Baolu wrote:
> Yi Liu (9):
>   iommu/vt-d: Track nested domains in parent
>   iommu/vt-d: Add __iommu_flush_iotlb_psi()
>   iommu/vt-d: Add missing iotlb flush for parent domain
>   iommu/vt-d: Update iotlb in nested domain attach
>   iommu/vt-d: Add missing device iotlb flush for parent domain
>   iommu/vt-d: Remove domain parameter for
>     intel_pasid_setup_dirty_tracking()
>   iommu/vt-d: Wrap the dirty tracking loop to be a helper
>   iommu/vt-d: Add missing dirty tracking set for parent domain
>   iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking

Applied, thanks Baolu.

