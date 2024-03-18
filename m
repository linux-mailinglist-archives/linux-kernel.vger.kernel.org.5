Return-Path: <linux-kernel+bounces-106342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0887ECC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1801D28113A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08F52F8E;
	Mon, 18 Mar 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nf56PJI7"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3D537E1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777289; cv=none; b=Q7VNXG6xBm/MQ7ZX0ieiWRCkbsWuRrA9Hjpbr2QVN3sq8fNXW+HHpqTR0DjlXx0zPXiHWzZm3wVs4bQxo5/R+5VZIAJ3iF3LwLe6OB5SH2RK1Oe+HDkHwrQeDqj5fRgCiGY4g3pbZRWkXE5v8VS8oI7ZNKooLgGML6C9xG773Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777289; c=relaxed/simple;
	bh=vcYOMEAYiLvp5GB4txzZlGS/nl9zQLTuqwsD6e0HZqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeQnWsPUDwcEonlG3PgSacr1tKqjXzp+vAS/U3QwShKoeT0ymlbxTwdmrPRPWXzbYCRHCSs5GtEoZL7ufSro6cgWol1z/SHZ2jZGmBQGKuzoNs0IM4dIs/NH8X/xP7sWHySk8y0s3zWz9lBRpjSQyMn5YND6oOkfShTREFjb2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nf56PJI7; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34832c57-644d-45d6-b4bc-bd801e8bc5f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710777285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcYOMEAYiLvp5GB4txzZlGS/nl9zQLTuqwsD6e0HZqo=;
	b=Nf56PJI7xVOJrkS0f+71pB57ZHPJZk+tAQmCboLUR++39APQGUvTjN+hGBk58eCXf257pk
	zJNFU/kKTrR+8M4wSDsbOCGFRJCKYUQPjw6tZyk9oz1ad6MS8FiRhOwwnUnvW+SEKnEjO/
	UQcVPeBWNq2Qe9cLrSQ33qnzMnzJ28A=
Date: Mon, 18 Mar 2024 08:54:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
Content-Language: en-GB
To: Jose Fernandez <josef@netflix.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
References: <20240316162241.628855-1-josef@netflix.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240316162241.628855-1-josef@netflix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/16/24 9:22 AM, Jose Fernandez wrote:
> This patch enhances the BPF helpers by adding a kfunc to retrieve the
> cgroup v2 of a task, addressing a previous limitation where only
> bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> particularly useful for scenarios where obtaining the cgroup ID of a
> task other than the "current" one is necessary, which the existing
> bpf_get_current_cgroup_id helper cannot accommodate. A specific use
> case at Netflix involved the sched_switch tracepoint, where we had to
> get the cgroup IDs of both the prev and next tasks.
>
> The bpf_task_get_cgroup kfunc acquires and returns a reference to a
> task's default cgroup, ensuring thread-safe access by correctly
> implementing RCU read locking and unlocking. It leverages the existing
> cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.
>
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


