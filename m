Return-Path: <linux-kernel+bounces-129984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0AB8972DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14526289B49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819F139D17;
	Wed,  3 Apr 2024 14:41:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAB2F844;
	Wed,  3 Apr 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155274; cv=none; b=QFIzgGP/DwJk24Q67+tIVwaZC3PpQ4tAN0AElW/pwlzckTcsQ8u10onpJGNAj0wqvfdBHeA5JBZIq5zgqH9MpRRhlgMucg14Q74fcISWQP6luqGRfrrcdACsBTV2cmPWxru8NEbz4jExdlgH/TPANdTBnmjO/wAnhWXqQ6ELV10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155274; c=relaxed/simple;
	bh=TizX/0d3kZYQ7oCRlQaPoWdE4T4ZHB1B1W0Y6AmHxnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJy4eSdxhwHzBotoDkh42QBFIYYM1CdIrUH+7C7clrpurHAtRjCqTVO1VCphEDB5skzpyIIoPld2ZDUXcC1tiXKLFFpd2CnO2jQzlxQnLUu0nrL6mN54oZCiWd54mHB2F4MtdPF6ROUa6Gh+4yKXP+1ZPB6QM3DpL0rNgnFfg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D171007;
	Wed,  3 Apr 2024 07:41:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8713F7B4;
	Wed,  3 Apr 2024 07:41:10 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:41:07 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 00/10] perf: Avoid placing cpumask var on stack
Message-ID: <Zg1qgxqrEi3sX3CA@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-1-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:50:59PM +0800, Dawei Li wrote:
> Hi all,

Hi,

> This is v2 of [1] and [2] which basically eliminate cpumask var allocation
> on stack for perf subsystem.
> 
> Change since v1:
> - Change from dynamic allocation to a temporary var free helper:
>   cpumask_any_and_but().	[Mark]
> 
> - Some minor coding style improvements, reverse chrismas tree e.g.
> 
> - For cpumask_any_and_but() itself:
>   - Moved to cpumask.h, just like other helpers.
>   - Return value converted to unsigned int.
>   - Remove EXPORT_SYMBOL, for obvious reason.

Thanks for this!

The logic all looks good; if you can spin a v3 with the updated commit messages
I reckon we can queue this up shortly.

Mark.

> 
> [1]:
> https://lore.kernel.org/lkml/20240402105610.1695644-1-dawei.li@shingroup.cn/
> 
> [2]:
> https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/
> 
> Dawei Li (9):
>   perf/alibaba_uncore_drw: Avoid placing cpumask var on stack
>   perf/arm-cmn: Avoid placing cpumask var on stack
>   perf/arm_cspmu: Avoid placing cpumask var on stack
>   perf/arm_dsu: Avoid placing cpumask var on stack
>   perf/dwc_pcie: Avoid placing cpumask var on stack
>   perf/hisi_pcie: Avoid placing cpumask var on stack
>   perf/hisi_uncore: Avoid placing cpumask var on stack
>   perf/qcom_l2: Avoid placing cpumask var on stack
>   perf/thunderx2: Avoid placing cpumask var on stack
> 
> Mark Rutland (1):
>   cpumask: add cpumask_any_and_but()
> 
>  drivers/perf/alibaba_uncore_drw_pmu.c    | 10 +++-------
>  drivers/perf/arm-cmn.c                   | 10 +++++-----
>  drivers/perf/arm_cspmu/arm_cspmu.c       |  8 +++-----
>  drivers/perf/arm_dsu_pmu.c               | 19 ++++++-------------
>  drivers/perf/dwc_pcie_pmu.c              | 10 ++++------
>  drivers/perf/hisilicon/hisi_pcie_pmu.c   |  9 ++++-----
>  drivers/perf/hisilicon/hisi_uncore_pmu.c |  6 ++----
>  drivers/perf/qcom_l2_pmu.c               |  8 +++-----
>  drivers/perf/thunderx2_pmu.c             | 10 +++-------
>  include/linux/cpumask.h                  | 23 +++++++++++++++++++++++
>  10 files changed, 56 insertions(+), 57 deletions(-)
> 
> Thanks,
> 
>     Dawei
> 
> -- 
> 2.27.0
> 

