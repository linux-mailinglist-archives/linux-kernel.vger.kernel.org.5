Return-Path: <linux-kernel+bounces-52440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD1849828
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D35B267AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8405E175A5;
	Mon,  5 Feb 2024 10:56:12 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B931758F;
	Mon,  5 Feb 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130572; cv=none; b=V5NtjQzaYDgRUhnuAYo0sWYD6epQEXpj5G8n3d2txCcyB1/YvotZ3iODImxC+oCUkVR+TZmJ/RBlhrX39P+j3ZW83YDAQe0Mnkzlm4VU3nDsEs+4GFGBJf/3WCQsnP/gRxQCRb34HzAVjYIuYLAYIsG8RGGvlb/1onz6w7SVZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130572; c=relaxed/simple;
	bh=oRvBm9nh5zhoHBy90FmSGP1rxQpWRExwh5iQCVgboqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuUvsYPZ557J11XkwG7x8zRDK9HDOUvzHcAfRJMN7ajX4hT+tyBwM0eeSRad1F65jLXUUMBwsGvU61TWkoBQz4KEzbtQYycAbTNV/OmV3uMVnPucNhcQCz4qNG+tjuSZTZZZclz0qVy6+ec3pqdAa2fA9muTqext6pUSaH7Wi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT3BG5Pbhz6K9LR;
	Mon,  5 Feb 2024 18:52:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 48F7C140D1A;
	Mon,  5 Feb 2024 18:56:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 10:56:07 +0000
Date: Mon, 5 Feb 2024 10:56:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 0/2] Add cond_guard() to conditional guards
Message-ID: <20240205105606.00000546@Huawei.com>
In-Reply-To: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun,  4 Feb 2024 18:31:03 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

> Add cond_guard() macro to conditional guards and use it to replace an
> open-coded up_read() in show_targetN().
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Change log since RFC v5?

> 
> Fabio M. De Francesco (2):
>   cleanup: Add cond_guard() to conditional guards
>   cxl/region: Use cond_guard() in show_targetN()
> 
>  drivers/cxl/core/region.c | 16 ++++------------
>  include/linux/cleanup.h   | 14 ++++++++++++++
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 


