Return-Path: <linux-kernel+bounces-133854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBB589A9BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87BC1F21A19
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBDC200D2;
	Sat,  6 Apr 2024 08:17:20 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF12901
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712391440; cv=none; b=nZ+UgXDWfzrdY/UHX/Exo5e+sa7xVs1IETknTBnvGBVxqz/9e8+tDgP2xdXgLWmHsRrwKoQRZfjgHbFYG0X6BH87xSnXYeiaVOwICLPvdMpFjGLhKuINdG1AAEQe1519tr2PlwLhWFUe0lfA2nPjEzCSAa5+pkmEk9t1ziq+bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712391440; c=relaxed/simple;
	bh=6YpwSTpbEKpa39yjI0m0McxAjY382DGN5sUkcA55dpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slUxtJ0Y4H7TSOYlQSOi8lvRSfXwpFS1Ufe6+UK+2SewN9p/H2qqIsyoeO60tLy4l0mBDsN/fBRMvYuocpxFpSF9jGAUGd6yft/4nrLl0TKefY3YHAznwTr2x8+sl1DUK4K0uJ6w3AlG48TEwUhJAo7OAuHAKFQK4oshIxCYLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.84])
	by sina.com (172.16.235.25) with ESMTP
	id 661104FE000051CE; Sat, 6 Apr 2024 16:17:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 31029034210484
X-SMAIL-UIID: 59407FAC1DCC41C5BE9E25175DACADC1-20240406-161705-1
From: Hillf Danton <hdanton@sina.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: vincent.guittot@linaro.org,
	bsegall@google.com,
	kprateek.nayak@amd.com,
	efault@gmx.de,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion
Date: Sat,  6 Apr 2024 16:16:53 +0800
Message-Id: <20240406081653.1161-1-hdanton@sina.com>
In-Reply-To: <20240405110010.934104715@infradead.org>
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 05 Apr 2024 12:28:04 +0200 Peter Zijlstra <peterz@infradead.org>
> Allow applications to directly set a suggested request/slice length using
> sched_attr::sched_runtime.
> 
> The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
> 
Given HZ=100 for example, what is preventing applications of suggested
slice=0.5ms from running 5ms a tick? If slice is 90ms otoh, is tick able
to kick the curr that has been on cpu for 10ms off cpu, given
cfs_rq->nr_running > 1?

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -984,7 +984,8 @@ static void update_deadline(struct cfs_r
>  	 * nice) while the request time r_i is determined by
>  	 * sysctl_sched_base_slice.
>  	 */
> -	se->slice = sysctl_sched_base_slice;
> +	if (!se->custom_slice)
> +		se->slice = sysctl_sched_base_slice;
>  
>  	/*
>  	 * EEVDF: vd_i = ve_i + r_i / w_i

