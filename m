Return-Path: <linux-kernel+bounces-132778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC41899A09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975AA284FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743816ABC0;
	Fri,  5 Apr 2024 09:54:27 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CA1607BC;
	Fri,  5 Apr 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310867; cv=none; b=PPiP7e7rFxfq6snZFkWB6k6I+J1LLt9UtE06YVnMWDy07YctysMCkpC87b/PmbqfL/4rSS17BA1lj7KrdgXv+FV+nkDrlbV48OBuKDX+bOvg4XCZDS5iPT+Z5CAjonoqW/TvoVCrQlkeHQbslHo1i/zffjr3xiKMv/DY7LArFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310867; c=relaxed/simple;
	bh=96UWtBYZsjWfBGux12qXUOnJhFQRp0u97ffHumiMS/4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Anr6r6t5bIQ3wzcgnhDBZAXVxVsomOSvVHEnzBswE7FrOsCozBkwBy6vsaSwIlDli2Sps1EbPx3laJIhxr4JmIe/shO5Py+Ldq/LEHi5VfdEvW8e60Yyxhm1TMuhGvwfnWLaQDppy6bbDjXf2ynS+ktMicUu5Yq4hbhTxZ/urxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9v1T1LWRz6J6d5;
	Fri,  5 Apr 2024 17:53:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 81C15141546;
	Fri,  5 Apr 2024 17:54:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 10:54:23 +0100
Date: Fri, 5 Apr 2024 10:54:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dawei Li <dawei.li@shingroup.cn>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <yury.norov@gmail.com>,
	<linux@rasmusvillemoes.dk>, <xueshuai@linux.alibaba.com>,
	<renyu.zj@linux.alibaba.com>, <yangyicong@hisilicon.com>,
	<andersson@kernel.org>, <konrad.dybcio@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] perf/hisi_pcie: Avoid placing cpumask on the
 stack
Message-ID: <20240405105422.00006352@Huawei.com>
In-Reply-To: <20240403155950.2068109-8-dawei.li@shingroup.cn>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
	<20240403155950.2068109-8-dawei.li@shingroup.cn>
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

On Wed, 3 Apr 2024 23:59:47 +0800
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

