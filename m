Return-Path: <linux-kernel+bounces-71352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0B85A3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8C5284832
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066AF2EB1C;
	Mon, 19 Feb 2024 12:53:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB62E835;
	Mon, 19 Feb 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347221; cv=none; b=U+459p/B507NLsNxyf0D1Qnwa/lKvyicMAM1znfGafD2WNVI/NonylSVlbAPstg0HDj6dEkVgD0ZRqBc3XLckON6nQdKz4Tq9xSt3Upn50UP8lzU9LG5SoRUh+ZA0uXShYccXihlsNfJgnIu7pLdf8Qyz6f/QT46fWZErGPvqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347221; c=relaxed/simple;
	bh=zbwGpXT5xkTmS6Rpg+489aV9VmgzsWnZ5SCdCsy9epM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT8B9StzD9qCdqP7DVJBHZBiEpwn60Nm4IbpP0hqNZdqioB10kWBKfOoJdqwIi32XFJWZ/0aV3YQpzYjbGA9DlWjc5QypFYn3Sc7cPdMzpCjjhIC0eu7rRWhqhGGzq83uwzSeetvdXPNi1otJGI/GJgKP3Gp5SAtAwQ+/rSRnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdj6W6YJJz6K63b;
	Mon, 19 Feb 2024 20:49:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 55327140B38;
	Mon, 19 Feb 2024 20:53:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 12:53:35 +0000
Date: Mon, 19 Feb 2024 12:53:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>, kernel test robot
	<lkp@intel.com>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<oe-kbuild-all@lists.linux.dev>, Linux Memory Management List
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v5] lib/firmware_table: Provide buffer length argument
 to cdat_table_parse()
Message-ID: <20240219125334.000036cd@Huawei.com>
In-Reply-To: <ZdEnopFO0Tl3t2O1@rric.localdomain>
References: <20240216155844.406996-4-rrichter@amd.com>
	<202402171817.i0WShbft-lkp@intel.com>
	<ZdEnopFO0Tl3t2O1@rric.localdomain>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 17 Feb 2024 22:39:46 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 17.02.24 18:43:37, kernel test robot wrote:
> > Hi Robert,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on 6be99530c92c6b8ff7a01903edc42393575ad63b]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/cxl-pci-Rename-DOE-mailbox-handle-to-doe_mb/20240217-000206
> > base:   6be99530c92c6b8ff7a01903edc42393575ad63b
> > patch link:    https://lore.kernel.org/r/20240216155844.406996-4-rrichter%40amd.com
> > patch subject: [PATCH v4 3/3] lib/firmware_table: Provide buffer length argument to cdat_table_parse()
> > config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240217/202402171817.i0WShbft-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171817.i0WShbft-lkp@intel.com/reproduce)  
> 
> >    In file included from include/linux/device.h:15,
> >                     from drivers/cxl/core/pci.c:5:
> >    drivers/cxl/core/pci.c: In function 'read_cdat_data':  
> > >> drivers/cxl/core/pci.c:672:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]  
> >      672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
> >          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> 
> Fix below, it basically uses %zu for both format strings.
> 
> -Robert
> 
> 
> From 08685053a91e370fd1263b921aa3e8942025c4e4 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Date: Sun, 7 Jan 2024 18:13:16 +0100
> Subject: [PATCH v5] lib/firmware_table: Provide buffer length argument to
>  cdat_table_parse()
> 
> There exist card implementations with a CDAT table using a fixed size
> buffer, but with entries filled in that do not fill the whole table
> length size. Then, the last entry in the CDAT table may not mark the
> end of the CDAT table buffer specified by the length field in the CDAT
> header. It can be shorter with trailing unused (zero'ed) data. The
> actual table length is determined while reading all CDAT entries of
> the table with DOE.
> 
> If the table is greater than expected (containing zero'ed trailing
> data), the CDAT parser fails with:
> 
>  [   48.691717] Malformed DSMAS table length: (24:0)
>  [   48.702084] [CDAT:0x00] Invalid zero length
>  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> 
> In addition, a check of the table buffer length is missing to prevent
> an out-of-bound access then parsing the CDAT table.
> 
> Hardening code against device returning borked table. Fix that by
> providing an optional buffer length argument to
> acpi_parse_entries_array() that can be used by cdat_table_parse() to
> propagate the buffer size down to its users to check the buffer
> length. This also prevents a possible out-of-bound access mentioned.
> 
> Add a check to warn about a malformed CDAT table length.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



