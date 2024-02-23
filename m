Return-Path: <linux-kernel+bounces-78722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0788617CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC4B1C21B16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD084A23;
	Fri, 23 Feb 2024 16:25:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60A7EF06;
	Fri, 23 Feb 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705559; cv=none; b=PjrXHKNt/RVU9Ev8YO3lF6jXnoaiD0Ohkpd7M/Oyi/NN/Z87Nij28MoV9gn0hLDn1ooDrOXpqiMK3B6obZ2RRbicqttr71R4xUKg/AmAQjkyA0yak+itFZv63ZoMPxXtVSU5ZoCuln1MuF6XrQauZrpup/bYrDnLDrKdEFQWBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705559; c=relaxed/simple;
	bh=pcgLlYSZ94N8Z5tjPSaQIgYSm+pxjOpzSlJJCy147m0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dr/4ypPYAvI5XJC3a6WWVwbAu98iHZpg/umh1TUfQhYnj8jSPZPLgVXVm6phxrusUQW4CGekIycT99PFBUptmtDc0dIGqk2myG3puN4CtSmQRC+DexMz7Gdr3hJOQ5SaHrEazQ4ocEN/UhZs386oS9JupJirmzknKANHWewklFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThFd33KWmz6JB2J;
	Sat, 24 Feb 2024 00:21:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51DEA140D30;
	Sat, 24 Feb 2024 00:25:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 16:25:52 +0000
Date: Fri, 23 Feb 2024 16:25:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <tony.luck@intel.com>,
	<Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <naoya.horiguchi@nec.com>, <james.morse@arm.com>,
	<jthoughton@google.com>, <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
	<pgonda@google.com>, <duenwen@google.com>, <mike.malvestuto@intel.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Message-ID: <20240223162551.000013ec@Huawei.com>
In-Reply-To: <20240223154251.GAZdi8--NPaMAK_ZBp@fat_crate.local>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
	<20240223154251.GAZdi8--NPaMAK_ZBp@fat_crate.local>
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

On Fri, 23 Feb 2024 16:42:51 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Feb 23, 2024 at 10:37:11PM +0800, shiju.jose@huawei.com wrote:
> > CXL patrol scrub and DDR5 ECS and ACPI RAS2 HW based memory
> > patrol scrub features are added as use cases for the scrub
> > subsystem to expose the scrub controls to the user.  
> 
> WTH is a RAS2 driver and where is the RAS1 driver?
> 
Odd ACPI naming.  RASF (which is very limited) was replaced by RAS2.

Both are ACPI tables that describe the Platform Communication Channels
(mailbox) + provide a definition of the protocol that is sent over
it in order to control memory scrub.  RAS2 has some other uses this
driver isn't touching on.

So in short, it's an ACPI spec defined interface for controlling 
Memory Scrub engines.

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#acpi-ras2-feature-table-ras2

Jonathan

