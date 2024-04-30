Return-Path: <linux-kernel+bounces-164204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08C8B7AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE20D2823E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F977111;
	Tue, 30 Apr 2024 14:54:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCE1527B9;
	Tue, 30 Apr 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488888; cv=none; b=JrZcudjMICSf5dhlZR2oPuchNhji5ZgfHRKAMR/IjRHa0aEnQui+vCHD1/TB6y2rCbmk0eVYjz34NUzupx6cYGsMeoiCd9wlP3K18EH8RXnrEr0/T1Gz1nY4xX+w9lz1ni7q9Crs/RjH0C0BSpbsrrA8D8LLI7hrHaQs3Nd4F0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488888; c=relaxed/simple;
	bh=3Lt9XPr9+FuMVN/dVwlzh6HYffNyZClxagW4eWzhaqQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMExWoU4ckgj6g60pq6K1xW8hw2s19+YmbHmFDRbXuPbmPW4bXwlQzNfOxiwTWzE2tz/2KYyGTguh00Ms+vuhY4gzw85gXCqSrytGHbDHkRyB51OJsPgjBOfLvaBdfEckWkeDRwrX9SHvW20JA2BkeR7bYlHboEonv6xV1scj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTNWk2LrNz6DB5d;
	Tue, 30 Apr 2024 22:54:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 68E80140A86;
	Tue, 30 Apr 2024 22:54:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 15:54:43 +0100
Date: Tue, 30 Apr 2024 15:54:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 3/7] ACPI/NUMA: Squash acpi_numa_slit_init() into
 acpi_parse_slit()
Message-ID: <20240430155442.000070ce@Huawei.com>
In-Reply-To: <20240430092200.2335887-4-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-4-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:21:56 +0200
Robert Richter <rrichter@amd.com> wrote:

> After removing architectural code the helper function
> acpi_numa_slit_init() is no longer needed. Squash it into
> acpi_parse_slit(). No functional changes intended.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Make sense
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

