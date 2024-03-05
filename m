Return-Path: <linux-kernel+bounces-91542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A993187136F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45953B20D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411251B59C;
	Tue,  5 Mar 2024 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xvjr4z9A"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4D1AADC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604847; cv=none; b=qMXoGDXYAKpChYgo5/JWQR0cgx+WxTtNy05/nPKa7rvpiQ7AO+1HRJL1MBZv52tChn6PneWjBXdN0nF0YEJsoncqNYBdhlKKP+8O1hFpWw/4nLERLVTy+RYZVIcbL5Qvlks4fbhWvcSKPugwHFTQlzqYfEuI3xUGG1C/1s41jDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604847; c=relaxed/simple;
	bh=lK5YuSrbfE7Kx/eALl2rZ0XA8T+IedWcCy5Js7/rsFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne1YmU326nLNOQzgxPCw2RfxwM33Fi2CuVqi0FTiBtPKsBiseHVatwjNdrl27XGTYAlBjFVtltAoDc8hakNhUvihR7Uvm5Zu1iRp81x5o0OJrPmcwCBCbMN0prdnYw6ZENmgtN4r8+nlZE0jIPVc3FyeUCGmWg82vp7xt8lb9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xvjr4z9A; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709604842; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iYWL+gVoEZhwFv5brMSLgBh5lKRPMNae3MhIIf17YYs=;
	b=Xvjr4z9AQ/jXJKBP+WXKFIpi7Z/99TH9VDW5BNd8pofeTkIcf/TXFwDGc/6npugkala3DjlXGd2ZnBgQg1QIqdScyY2uIRt+u6jWYSmIRQewgB9cQXvf2knrL0M/d9woRTslKW/skW1Xuwv3RcwzwxdUV3fgMAptJbrNdVsEAXQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1sbocr_1709604840;
Received: from 30.97.48.234(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1sbocr_1709604840)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 10:14:01 +0800
Message-ID: <5b863dfe-bb97-4bc9-a117-153b1ba087f0@linux.alibaba.com>
Date: Tue, 5 Mar 2024 10:13:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/eevdf: Always update V if se->on_rq when
 reweighting
Content-Language: en-US
To: Abel Wu <wuyun.abel@bytedance.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
References: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
 <20240304030042.2690-2-dtcccc@linux.alibaba.com>
 <ad801d18-6243-47c5-8e37-ce712ca5d0c5@bytedance.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <ad801d18-6243-47c5-8e37-ce712ca5d0c5@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 20:06, Abel Wu wrote:
> On 3/4/24 11:00 AM, Tianchen Ding Wrote:
>> reweight_eevdf() needs the latest V to do accurate calculation for new
>> ve and vd. So update V unconditionally when se is runnable.
> 
> As this should come along with commit eab03c23c2a1, I think it would
> be better add a Fixes tag?
> 

I'm not sure. In fact avg_vruntime_sub() in reweight_entity() was first 
introduced by af4cf40470c2, and at that time the algorithm about reweight was 
not completed...


