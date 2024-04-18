Return-Path: <linux-kernel+bounces-149566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC228A92E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C9C282225
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89E7441A;
	Thu, 18 Apr 2024 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UQ6jU32S"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D156D1A9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421019; cv=none; b=EdZaLHXeTP7IcVSj0KUh4VmxofppGO2+GbDOZKMJyp/G5xKwMYW1Uz+vU31WGBqgJVd9J9NmmuO4IieHjBVsIHAFrhmVvuGUZfMue8CoZPSp9L67IpwSgz9b94ph4FX3P0sJdEcNQXvRj2928gwHIuHaYKmbL/GN9eB5cfMVa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421019; c=relaxed/simple;
	bh=sfKMRCoV3uYUY+fjwm+vNf8dFa9IjLvdYNmcE4P9Rso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNJW+uPLq8tByE5M0ENnyUIjouFKYpBy4N9MUCxHbssJmyUA4zM84/3VzKnvJJmj/ToI764yNE+ZFtR9kr/EWgqQOfiKpJhnQfzv1joWIOwO7/dWD6WwmRFdlARgce/8wwLmtgl/v9noMAAZ6Ij6CJaLap4AlbxXvCkUEEJrrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UQ6jU32S; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713421013; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CktXo0hCwnR+bJh4SQAZ025qumYDIGNYgT2zhfl2Xf0=;
	b=UQ6jU32SeD4Cu3PNH6D0wuPkKjpNNhdjzoEvxk7OfCOYnhbl4iQyYpG90U56vrtfuAHp1Ucu7EcNAj+E37USYPEJlNcQqZI5ja3vuBcpuMvwM1v4f5YomUi4dwBdq8wK2wgCewLJYk47tl5+nSBht4vhnpjk4HOlZXY0fJT24t8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W4nYs5o_1713421011;
Received: from 30.97.48.213(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W4nYs5o_1713421011)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 14:16:52 +0800
Message-ID: <489a558f-8f56-4342-9396-544a4b8ff8c3@linux.alibaba.com>
Date: Thu, 18 Apr 2024 14:16:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Abel Wu <wuyun.abel@bytedance.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu <yujie.liu@intel.com>,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <ZiCOybMoVyNK6gPT@chenyu5-mobl2>
 <c3959f3e-ca17-4c27-9dd2-504b95f2653c@linux.alibaba.com>
 <ZiC1LuqGAXGHgeDo@chenyu5-mobl2>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <ZiC1LuqGAXGHgeDo@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/18 13:52, Chen Yu wrote:
> On 2024-04-18 at 11:37:31 +0800, Tianchen Ding wrote:
>> Hi, we've found a bug about reweight_eevdf(). Would you also please try this
>> patchset?
>>
>> https://lore.kernel.org/all/20240306022133.81008-1-dtcccc@linux.alibaba.com/
>>
> 
> Sure, I'll have a try after I test Xuewen's patch. I assume your fix is mainly in
> 2/2 which adjusts the se->vruntime in reweight_eevdf() by using the correct
> avg_vruntime(), although it might not be directly related to the s64 overflow issue
> here, it is worthy a fix.
> 

Yes. I'm hoping to reduce "noises" about the unexpected avg_vruntime() varying 
during your tests.

Thanks.

