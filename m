Return-Path: <linux-kernel+bounces-164227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259D8B7AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B991C21DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79701172BC6;
	Tue, 30 Apr 2024 15:03:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1C7710C;
	Tue, 30 Apr 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489391; cv=none; b=FPIegBhMZm3yd4l6OdPlhO7xI1uwgn4Jn9FuL2Z0b243zzbWM/KzTmhPEikZuC7BudgkegxWMWtof528x6ulM70a9yxd+OIdbD0fLVTlY/toucUDc2txiGfTQc4dH4A/ryCWsztQD7/EWzHy3RBTrTnUdnH3uRqZCCov9qfrkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489391; c=relaxed/simple;
	bh=a7XKkABB2gMAl6YmsWJisy73NM0mWEPEwg0CoML4T7w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxuE/BfLk6Y+BiwCtT/szmXFAnWvZigbRWEgMTtHQ/8HXWTplnN452VmwF/lrFnm4+B+xhNQ8ZlrhfPaClRVLIUPbxqPxU2GFQjpRRcLEKGq0FShUNQFfKljNSalGx3HaDLeP6a+tUdesH6V4GwCdSCLyzMRgF5HZuK3NDgtpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTNfh4yYxz6GD7C;
	Tue, 30 Apr 2024 23:00:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C296140A08;
	Tue, 30 Apr 2024 23:03:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 16:03:04 +0100
Date: Tue, 30 Apr 2024 16:03:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, kernel test
 robot <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/7] ACPI/NUMA: Squash
 acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Message-ID: <20240430160302.00005fe1@Huawei.com>
In-Reply-To: <20240430092200.2335887-5-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-5-rrichter@amd.com>
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

On Tue, 30 Apr 2024 11:21:57 +0200
Robert Richter <rrichter@amd.com> wrote:

> After removing architectural code the helper function
> acpi_numa_memory_affinity_init() is no longer needed. Squash it into
> acpi_parse_memory_affinity(). No functional changes intended.
> 
> While at it, fixing checkpatch complaints in code moved.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Looks good to me. Printing an SRAT entry we then throw away is a bit
odd but it always did that.


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



