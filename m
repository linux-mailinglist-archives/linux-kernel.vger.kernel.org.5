Return-Path: <linux-kernel+bounces-132776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC968999FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3151C221E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5416191B;
	Fri,  5 Apr 2024 09:53:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BE160881;
	Fri,  5 Apr 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310812; cv=none; b=ewChJ+jkml61w61W2JJLnTK4L98YZdgZdxIv1ncUdB8ANEyIaQawHH/qCEK1HUY4RKnbZ/rt0ZXQErToOXP8AW8ESOS7PRkb7Jl2N2fxj3yKtLssn4nDLlmxn2sph7evvWrEeet94gUmrWVoL2NAY6v1+UAcFEJlIjpaNlBuzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310812; c=relaxed/simple;
	bh=ZoMTR/2rQ3ZrsE0cvluxJAts9LL6fCAjxYu8JLJ+bjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWvg60tRFb1v2u+Q63eMaFJtKSPjcWldjr/yQgJsRMV6e21WCyxam/JbVJ6C8I4xwkCxmjyAsNNVZ7sRErha6nvhd0yRQuYylb4quvvfeGC1x4g10Zvt4o1EVHZRmLwHkKgmzPdcIuBsjFz6qglXXpL2Oka03pSudZ+xfbKPHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9v0P2GBxz6J6c8;
	Fri,  5 Apr 2024 17:52:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 963691400D1;
	Fri,  5 Apr 2024 17:53:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 10:53:27 +0100
Date: Fri, 5 Apr 2024 10:53:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: Dawei Li <dawei.li@shingroup.cn>, <will@kernel.org>,
	<yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>,
	<yangyicong@hisilicon.com>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] perf/hisi_uncore: Avoid placing cpumask var on
 stack
Message-ID: <20240405105326.000039e2@Huawei.com>
In-Reply-To: <Zg1pQ_rnYyZe40_n@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
	<20240403125109.2054881-9-dawei.li@shingroup.cn>
	<Zg1pQ_rnYyZe40_n@FVFF77S0Q05N>
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

On Wed, 3 Apr 2024 15:35:47 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Apr 03, 2024 at 08:51:07PM +0800, Dawei Li wrote:
> > For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> > 
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> > 
> > But dynamic allocation in cpuhp's teardown callback is somewhat problematic
> > for if allocation fails(which is unlikely but still possible):
> > - If -ENOMEM is returned to caller, kernel crashes for non-bringup
> >   teardown;
> > - If callback pretends nothing happened and returns 0 to caller, it may
> >   trap system into an in-consisitent/compromised state;
> > 
> > Use newly-introduced cpumask_any_and_but() to address all issues above.
> > It eliminates usage of temporary cpumask var in generic way, no matter how
> > the cpumask var is allocated.
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>  
> 
> The logic looks good to me, but I'd like the commit message updated the same as
> per my comment on patch 2.
> 
> With that commit message:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


