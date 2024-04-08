Return-Path: <linux-kernel+bounces-134682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CA89B4EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DFC281338
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35179811;
	Mon,  8 Apr 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="blvMXFRI"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBD620;
	Mon,  8 Apr 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712536244; cv=none; b=E29qOOCK+QsH2NCMq+ALWs1J5i2MqDl6B+wmIvBedYKGNiL4np3SjdrXvv6iEFnpQPaabj5LYZvHNZOAb0emICO8UbbxmH1G4HNddJSXrYz4QgCBpjjaJ8mj5tmRLsm4XKhzsvNrZ3lB65PjIIGqvZDN7xDa6sRvRvvyRvgZlDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712536244; c=relaxed/simple;
	bh=fvvbUGrQhPVX69NX6Z7FD1HYaTvk/q9BPgkGQPm6i1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzFJARv8vPs6esFYr6XG+YfvdCqQNPaoFksGOG9mQ9VAc8ml180iehJDFeYePH75f881ofsCmKprAh6fW6IZHZk+ks0Duik9lWjDKrodf0D2V9eEYJde6VrqLKtm6/HNfnlwGAq081Bt7kyW5q3hW9hXLwoHFjvYq3DZjd+aqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=blvMXFRI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712536239; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CsEb7LZaYg4MvBYaZ0RzWTEBPpTTYm86e4zm7GUtmgg=;
	b=blvMXFRIz1jmEJL6ai8DOJTGnRwdEGw9LnKhSwT8xaThnMpdEep510xFoNPtw1Jla/FeD/kb56jt9UmfjQjwQnQjRg3t+uaorFONDs8IU65u+zkLUszfS2a4NdyFYlMlunQx+4qS6Ct0WEFByDOoiPQMjJxUaS5jEOGaxooFRl4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W41MR8s_1712536237;
Received: from 30.97.56.50(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W41MR8s_1712536237)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 08:30:38 +0800
Message-ID: <62202a1b-0bb8-42f5-8956-cd8ff82b4ff0@linux.alibaba.com>
Date: Mon, 8 Apr 2024 08:30:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] perf/dwc_pcie: Avoid placing cpumask on the
 stack
To: Dawei Li <dawei.li@shingroup.cn>, will@kernel.org, mark.rutland@arm.com,
 yury.norov@gmail.com, linux@rasmusvillemoes.dk
Cc: renyu.zj@linux.alibaba.com, yangyicong@hisilicon.com,
 jonathan.cameron@huawei.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
 <20240403155950.2068109-7-dawei.li@shingroup.cn>
Content-Language: en-US
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240403155950.2068109-7-dawei.li@shingroup.cn>
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

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thank you.

Shuai

