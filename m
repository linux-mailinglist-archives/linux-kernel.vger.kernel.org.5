Return-Path: <linux-kernel+bounces-71253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DE85A282
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AFB1C20E16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349752E40A;
	Mon, 19 Feb 2024 11:52:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF12E3EB;
	Mon, 19 Feb 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343574; cv=none; b=DBtWaW3ZoCsQkr9OPg0EL4R7EkN2gxQQ4UbsJymfrdCGB3T9bpLJx5fYGQE73+mf7mf4l8IfimnPEesOey1Bos0jhId5mw2kzDhLG7OeF4v0xQFKZBceEV4vUs4U+Vks4m36Xe0n/XEetsjljqt4zzRpFrm1T2zzRiJhguqCONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343574; c=relaxed/simple;
	bh=fyhYnzmCxnUGFyoUnOzjkFIRTTVgFqvaB5JpETxx/6E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiuJ0qqaYJceTLZ8OSXiHd53k2sLvNpKZyj7Mqh9Nghp6DaFkOepp9CNjptrTbWguHtVUInJP8HxShsdY3ECif1ib4GjBvu0qi0irJ5WELIi/Kpux6ijA0q54KSlQCWJMxyhB6BGPQa0Qc9bnvIgzqEM/qch0Cbx71CmZADvM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdgms2cjFz6K9BL;
	Mon, 19 Feb 2024 19:49:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 79419140EDF;
	Mon, 19 Feb 2024 19:52:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:52:50 +0000
Date: Mon, 19 Feb 2024 11:52:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3 v5] cxl/memdev: Use cond_guard() in
 cxl_inject_poison()
Message-ID: <20240219115249.00007691@Huawei.com>
In-Reply-To: <20240217105904.1912368-4-fabio.maria.de.francesco@linux.intel.com>
References: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
	<20240217105904.1912368-4-fabio.maria.de.francesco@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 17 Feb 2024 11:59:04 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

> Use cond_guard() in cxl_inject_poison() to not open code two up_write()
> in an 'out' block. If the down_read_interruptible() fail, the statements
> passed as the second argument of cond_guard() return -EINTR.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

