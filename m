Return-Path: <linux-kernel+bounces-153751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AC8AD2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D012F1C20BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA3153833;
	Mon, 22 Apr 2024 16:50:01 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3D2EB11;
	Mon, 22 Apr 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804601; cv=none; b=MIcBZgY/9MLAqiHtqoZI2drSLdcjoIaqnRrUh68/Mj4u7iuPZG+itO1aozqI7gvPr0lmHfJLs1bfwtbooaEvzR5Wjl8A91NjM4vtfbJdlcMoQKCUtOj1zm4nh8UWvNqUR7Q2qsAZKJBS8x8ePCHax2ITSocDlrS5XOEqW5en8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804601; c=relaxed/simple;
	bh=3jw9zw9ovhzT/Oxx246JhjNsIkrLzJLY0YlsQAw3PGI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP2BRMovsDgfAZ3MGzLIllORWc5VF8ljt9+GRE8JlKQlbLTM2HG5sTGZwKybO8qan6Z0L76jAsNDocfbR0hkYsFjU5tx/o+1kwXczPCGI7xX5nwMiAmJHGL0DQ3DEZo5ebIhHpCTROF3IkrVHXJqLAuOMaaqEht8ovfqm3x508c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWSb2YLwz67cSV;
	Tue, 23 Apr 2024 00:49:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B78B140736;
	Tue, 23 Apr 2024 00:49:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 17:49:56 +0100
Date: Mon, 22 Apr 2024 17:49:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v3 4/5] ACPI/NUMA: Squash acpi_numa_slit_init() into
 acpi_parse_slit()
Message-ID: <20240422174956.00002a36@Huawei.com>
In-Reply-To: <20240419140203.1996635-5-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
	<20240419140203.1996635-5-rrichter@amd.com>
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

On Fri, 19 Apr 2024 16:02:02 +0200
Robert Richter <rrichter@amd.com> wrote:

> After removing architectural code the helper function
> acpi_numa_slit_init() is no longer needed. Squash it into
> acpi_parse_slit(). No functional changes intended.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

