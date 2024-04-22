Return-Path: <linux-kernel+bounces-153757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA978AD2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557AF1F219C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E47153BEF;
	Mon, 22 Apr 2024 16:54:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519A15382C;
	Mon, 22 Apr 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804856; cv=none; b=F7/a3tzcAM1OfytyhX2B0TKe6WxEPv51PzNJSivdiJYw84KZ9kg1nDw/xDtv6RasU+qYR/LphEQ3t7X6YKiCRfrL5fX4T3BeA+NoCcv7kBIerTmvmHxXG1QPTcSpyACCX6FFsRUv+bp/e9sAy4yaIew3CvwyopjmdJOsgetFvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804856; c=relaxed/simple;
	bh=nUsS2aPYb6hVOs6HmGjLKNoFV5z+/jwQdERmaZ3jxjs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zy1qjuDlCpZzwjd+Lza+RrT2w93RYB/HVf1W1/I+yvAjmgwbovGJLHF53UJOk+Cfl2oFsM0N3+WBo8wOPG5JpIe81G5170Kyk3w9UI8Zvkz8fXq1iV0o4yNzNvxbKiugz5E+nPJhqPfN/ilxn29qpd1h75LmBIfr4Y8iIHabPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWVz2s8Hz6K6HD;
	Tue, 23 Apr 2024 00:51:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E3F140B35;
	Tue, 23 Apr 2024 00:54:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 17:54:11 +0100
Date: Mon, 22 Apr 2024 17:54:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, kernel test
 robot <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 5/5] ACPI/NUMA: Squash
 acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Message-ID: <20240422175410.0000033a@Huawei.com>
In-Reply-To: <20240419140203.1996635-6-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
	<20240419140203.1996635-6-rrichter@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 19 Apr 2024 16:02:03 +0200
Robert Richter <rrichter@amd.com> wrote:

> After removing architectural code the helper function
> acpi_numa_memory_affinity_init() is no longer needed. Squash it into
> acpi_parse_memory_affinity(). No functional changes intended.
> 
> While at it, fixing checkpatch complaints in code moved.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

