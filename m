Return-Path: <linux-kernel+bounces-134681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D2689B4ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EEEB20EB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273D7EC;
	Mon,  8 Apr 2024 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DDXSdAPJ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DE364;
	Mon,  8 Apr 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712536118; cv=none; b=Q74Cg3as6grDnorPf2W0OqihU5/quQ6jzw94kEIb/RV81eLLPzTuNpfnjDljv/Ve3g/tAN3BqaSgoiueuu5wCv5Y8pmfAyG1SBC+pysqiUpT0FyXh7hMzJbUPv7pi7rXuxmnnY5rfHT2T/amLV9VhbP0s8bw0zJDoWb4LUym4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712536118; c=relaxed/simple;
	bh=PWUWT3Cy1pXstOUwy3idqJ/nQJr36qAG8Fm86pboPmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxO3X4u/qM7HOT/rL0L8v4eCYxXF5jWsrAzReEOcKPZTR08pfZI8Db/DdLWhKn8UT1N1jt2/RfuHULg66GxVK0r6q/9Zf3aV+mn3chie13XIJuKSO12Dfv57Eg+ASIXucKHbyHpgrJjGfl3XFV453+r5VWQJHaLY0fGzHUKbW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DDXSdAPJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712536112; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jn1TtkykRBXTanm0VcQoas0+0sEdF3G3DjSyEmfOcyw=;
	b=DDXSdAPJ79jhkUt1HrV5DqG66SW6BYQXuz13Di0E+nVfQMKA3UrQZSgOi0WKftCd8jPnGtZIWohD3UG8PPzH4rTKWUu9R+24J9uafMwXCrZWfmX3BqB0vvWJrA53joCmnwzt9+VC0LDvbPZgUrcZnNEueME+eSg2U7J44M/XL8M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W41MQQQ_1712536110;
Received: from 30.97.56.50(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W41MQQQ_1712536110)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 08:28:31 +0800
Message-ID: <8490280b-2ae2-4a0f-a13b-c2afc9e2b2ed@linux.alibaba.com>
Date: Mon, 8 Apr 2024 08:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] perf/alibaba_uncore_drw: Avoid placing cpumask
 on the stack
To: Dawei Li <dawei.li@shingroup.cn>, will@kernel.org, mark.rutland@arm.com,
 yury.norov@gmail.com, linux@rasmusvillemoes.dk
Cc: renyu.zj@linux.alibaba.com, yangyicong@hisilicon.com,
 jonathan.cameron@huawei.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
 <20240403155950.2068109-3-dawei.li@shingroup.cn>
Content-Language: en-US
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240403155950.2068109-3-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/3 23:59, Dawei Li wrote:
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
> ---

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

