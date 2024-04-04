Return-Path: <linux-kernel+bounces-131726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD9898B25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5711C223DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10319129E7C;
	Thu,  4 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZYB1soOt"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E2823D0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244759; cv=none; b=NRajkMUbJN865b7rsm0T/KHeikzswr5cizdewgeXAW3QYbrqW3i7blLvpDDcaSXIQvyY0Jkh+u/BJ+DlOopkmzGPNsc/vwpClCV0vTpYd0j9RTiPEsTDXvhYNWTW1GUGAU6cV+UMJiH767xTTM10Ja9qY0frobjbpdWWzh4tjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244759; c=relaxed/simple;
	bh=TbWKY4Vy0ejvQPnz3t0enxrmTjveEZaqpYoGRQFRIm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTmhcXfFzz091GGuX0emaqIZHcEcJNKfMzEGiYneyNhsp9RV8svwOSiMdc2l3F/xl00Ss3trC8lMeTy9LJYyybfit3+K/cMoJ2YgawQSmoN7jC1YBeqbYWrfjz/PYXJr/L1w+CEknhPV3iESzwLbRe4WUcbGPH0jM6PlLER+bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZYB1soOt; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bc260eb8-7a97-48d4-bb6a-6154ae2b2fb5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712244755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbWKY4Vy0ejvQPnz3t0enxrmTjveEZaqpYoGRQFRIm8=;
	b=ZYB1soOtHTtumDOiZdM3uwyHGbGNDa+hwEvjQd2iLoVoUJIzjxUzeTDQhltVGMU8ZkYGcx
	F0qiJ5rrVItcmimx14lYAYAaipvldrSc+LngQyaEY2km9s98kvva4WuzWO7EPVhbWMSc1f
	4/em2Ysci/Ut6kty1nnEkrPUJPOa0hU=
Date: Thu, 4 Apr 2024 08:32:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow invoking kfuncs from
 BPF_PROG_TYPE_SYSCALL progs
Content-Language: en-GB
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240404010308.334604-1-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404010308.334604-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/3/24 6:03 PM, David Vernet wrote:
> Currently, a set of core BPF kfuncs (e.g. bpf_task_*, bpf_cgroup_*,
> bpf_cpumask_*, etc) cannot be invoked from BPF_PROG_TYPE_SYSCALL
> programs. The whitelist approach taken for enabling kfuncs makes sense:
> it not safe to call these kfuncs from every program type. For example,
> it may not be safe to call bpf_task_acquire() in an fentry to
> free_task().
>
> BPF_PROG_TYPE_SYSCALL, on the other hand, is a perfectly safe program
> type from which to invoke these kfuncs, as it's a very controlled
> environment, and we should never be able to run into any of the typical
> problems such as recursive invoations, acquiring references on freeing
> kptrs, etc. Being able to invoke these kfuncs would be useful, as
> BPF_PROG_TYPE_SYSCALL can be invoked with BPF_PROG_RUN, and would
> therefore enable user space programs to synchronously call into BPF to
> manipulate these kptrs.
>
> This patch therefore enables invoking the aforementioned core kfuncs
> from BPF_PROG_TYPE_SYSCALL progs.
>
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


