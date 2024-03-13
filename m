Return-Path: <linux-kernel+bounces-102538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35987B388
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D781C22BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8E54789;
	Wed, 13 Mar 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+OOBaPY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81725482D3;
	Wed, 13 Mar 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365755; cv=none; b=d1FPXesi8SDohyHsFsVyNxe6s+xMQbt1oKHxx7gOqhEmA2NpY5P3s04oGDy0/HG2lFf6NuBHZ5NjMX4rVIBUkZsiBsIQ15bsgmjk6OJfeAA5SUtgSPnwDBsaEOhbfIAcRZs1QBcTiX1JcarRjIaNlZuYE98lGEsg4tEThcS5ZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365755; c=relaxed/simple;
	bh=WF6yNI/ItEkPjATAX8YpDE/2VLytZlQPecSVQ2ffwss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpiasVVbAT/j8XR6MLKFX6rqOwfeCWmRkRnZCsHHiK6XJ50NZYfCKizS6lkSNl+dO9tkkJ62BRmz2TaS70tymG4B83KbOpgLydiFVc7/7vpi7rC38mOx20hRvmw5cbBTtv/KrZGNlk/mMSp2KIL9hx4ZcGNegnU7bZ2VUoZfOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+OOBaPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00074C433C7;
	Wed, 13 Mar 2024 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710365755;
	bh=WF6yNI/ItEkPjATAX8YpDE/2VLytZlQPecSVQ2ffwss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u+OOBaPYzVMnEddUEfS3Fu8FFrNpKYbLnfqJ/I1vV3v54ey+bk/cR/npMRmjQV2Vf
	 HAQlLG6+oVvH1wjPEt2HjlRmJmIL+0U2F5Ni3kfB6dqcAy5mGSJOEJE5s3snHI9iWd
	 Empn+nbDODTpAFx1lDGQGRe5d9OuLiTjmgdF0yKgXZ6JdZN3Bv+wDrkwkY7Vt42CK8
	 FNuekzDw6bvkbJNIukuknIxjffhT64r5att9cz9xTi34wfbR12zlVpzZ+Lu2/G9S7h
	 G+zjxhZVN14bFVJkjMmfaDyuz1IR259IsGPurpMmoKFIdJSjCNSY7b7oeILQrWX3xh
	 fCkdoTuVemReQ==
Message-ID: <922a8b73-af68-4748-9c89-d6b29a1a7e3c@kernel.org>
Date: Wed, 13 Mar 2024 22:35:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 0/3] Report RCU QS for busy network kthreads
Content-Language: en-US
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
References: <cover.1710346410.git.yan@cloudflare.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2024 17.25, Yan Zhai wrote:
> This changeset fixes a common problem for busy networking kthreads.
> These threads, e.g. NAPI threads, typically will do:
> 
> * polling a batch of packets
> * if there are more work, call cond_resched to allow scheduling
> * continue to poll more packets when rx queue is not empty
> 
> We observed this being a problem in production, since it can block RCU
> tasks from making progress under heavy load. Investigation indicates
> that just calling cond_resched is insufficient for RCU tasks to reach
> quiescent states. This at least affects NAPI threads, napi_busy_loop, and
> also cpumap kthread for now.
> 
> By reporting RCU QSes in these kthreads periodically before
> cond_resched, the blocked RCU waiters can correctly progress. Instead of
> just reporting QS for RCU tasks, these code share the same concern as
> noted in the commit d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched
> and RCU-preempt when safe"). So report a consolidated QS for safety.
> 
> It is worth noting that, although this problem is reproducible in
> napi_busy_loop, it only shows up when setting the polling interval to as
> high as 2ms, which is far larger than recommended 50us-100us in the
> documentation. So napi_busy_loop is left untouched.
> 
> V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
> V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
> 
> changes since v2:
>   * created a helper in rcu header to abstract the behavior
>   * fixed cpumap kthread in addition
> 
> changes since v1:
>   * disable preemption first as Paul McKenney suggested
> 
> Yan Zhai (3):
>    rcu: add a helper to report consolidated flavor QS
>    net: report RCU QS on threaded NAPI repolling
>    bpf: report RCU QS in cpumap kthread
> 
>   include/linux/rcupdate.h | 23 +++++++++++++++++++++++
>   kernel/bpf/cpumap.c      |  2 ++
>   net/core/dev.c           |  3 +++
>   3 files changed, 28 insertions(+)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>



