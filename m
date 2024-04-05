Return-Path: <linux-kernel+bounces-132780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9AD899A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64701C220F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13316C425;
	Fri,  5 Apr 2024 09:54:46 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30316ABF5;
	Fri,  5 Apr 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310886; cv=none; b=CvEa2DPsnvxJSLe38C6tDNbxCJyJyZ3gXFDeA18TCY50kFMiu4G3gmZQ8+p7KOEx1NT2C1QqjIlodbep5iFi5IHhvVX0Jot2eaJ8IOYb9ZzWSdY8bH/l1AnlixEfm/W1DuTAt99Ju8E8LNCKn6gGF2Gr8YaYvH+hMlzRL9F3doI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310886; c=relaxed/simple;
	bh=euQpmpK7ReuS/moGvTZTFeecDsgmJlRZeUwPBZ9hj2E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQzjWiFFOicHwEc34sVZ4mse3FTdWNO0sGBWQvdkznBXYUYlj+wQ/rLSJpVtQoGyrmbxwB0w1PKt094DOKla+F/lqxqmzShipD5zn29BGooRmxOnUZgapTW9hi4dTMLHbSs9sLZ5iK5vt2MlzGSTp41NTr2o2c0M6uD8iQQwueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9v1r3RCBz6J6j6;
	Fri,  5 Apr 2024 17:53:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C57731400D1;
	Fri,  5 Apr 2024 17:54:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 10:54:42 +0100
Date: Fri, 5 Apr 2024 10:54:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dawei Li <dawei.li@shingroup.cn>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <yury.norov@gmail.com>,
	<linux@rasmusvillemoes.dk>, <xueshuai@linux.alibaba.com>,
	<renyu.zj@linux.alibaba.com>, <yangyicong@hisilicon.com>,
	<andersson@kernel.org>, <konrad.dybcio@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] perf/hisi_uncore: Avoid placing cpumask on the
 stack
Message-ID: <20240405105441.00006f59@Huawei.com>
In-Reply-To: <20240403155950.2068109-9-dawei.li@shingroup.cn>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
	<20240403155950.2068109-9-dawei.li@shingroup.cn>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 23:59:48 +0800
Dawei Li <dawei.li@shingroup.cn> wrote:

> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_any_and_but() to avoid the need for a temporary cpumask on
> the stack.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

