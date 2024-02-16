Return-Path: <linux-kernel+bounces-68730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C2E857F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5530AB2400C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E012CD85;
	Fri, 16 Feb 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="TxkQXGt1"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FE12C7F6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093057; cv=none; b=C19IDFUB9ULV6394bDNjcS48HkPwXkJlAf1tF3tdu5/baKmR8fJTOJSEtzf6R9Ugdh+/r4UcZjRaXLqeCCYEHgm/sZxKy++Ip/F2GJampYbd69oK18fejNP/oybUGVySDslJfgSdUvo2QHnc7Mca31lXWjbHierXbcrV4jghq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093057; c=relaxed/simple;
	bh=rUlbksHkFMWMaIb6/mVJJ5740ZUFJknjlsFIIw6Nv20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm0VtpQEcHsGtOY3ObdV0D0ElJTgYq+m4/t6zG2L5Uys5L5FhMG16M2Qj/DWpEOqvZoF/d+DRZrSnVSmEsD5LD7A7em/OkiqGg+o8kZqHH1YJMBnYrmfg3XPJKlUSkHwed07Q5AXUeVW7qIMxVJ9AjCnwAErQfR5IFi38bajBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=TxkQXGt1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E820C1C462F;
	Fri, 16 Feb 2024 15:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708093048;
	bh=rUlbksHkFMWMaIb6/mVJJ5740ZUFJknjlsFIIw6Nv20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxkQXGt1DXesw4pEY1OBpMIRB7zLhmn3EVqhCsB3UqY85ieBk4J4WZe9e+EqNujhx
	 02jCsxgiXXboFW/0pGcMODYQIiDcWsZElqdBsaZi2oY+CrmjGT5puLtCrI+/20YLyW
	 VChB1lDK6VHcVwpmxnUBSLBSwq79SABcjX23QWG30SvFVLugFoXGZuA33tHHGL/svJ
	 zXgmInO8MDD4jxRw2Jz28jMMMR8hVd0e0bYLfxHJtl471muX+cpfHLcoDxm6YAeb1D
	 e6JUwmWP1Z8v6XJY52Z3dlsOU4jN8m3aYn6OexHEDgVfYrKOVYqpBSYwQExmP0Sziw
	 rrfB7O9jUPr/w==
Date: Fri, 16 Feb 2024 15:17:26 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Mark interrupt as managed
Message-ID: <Zc9udguUqrWPpTJu@8bytes.org>
References: <20240122233400.1802-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122233400.1802-1-mario.limonciello@amd.com>

On Mon, Jan 22, 2024 at 05:34:00PM -0600, Mario Limonciello wrote:
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html?highlight=_prt#prt-pci-routing-table [1]
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/iommu/amd/init.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.


