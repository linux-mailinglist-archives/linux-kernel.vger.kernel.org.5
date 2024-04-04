Return-Path: <linux-kernel+bounces-132170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934A899090
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9031E1C22D27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237B13BC3B;
	Thu,  4 Apr 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrJJUjBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E482D90;
	Thu,  4 Apr 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266962; cv=none; b=ATyFr2AOsL0sghQ6Lvc2+jHUR5OKH0FOoTZ5feG78v82iA/Gfsx8bCa07kekSOSXF7XZWOkkD+DgCN+ME6SkuAN++fZ8S+pf3YHRNr5t4PDl+T7XfZUMcnQIBknkpXG/0meSOnz98CXwKSVcPvBGgvNdtYv6qBL/QL6uP4OBKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266962; c=relaxed/simple;
	bh=Xyh52LJT/Gq5z0Hoib95KyYOLCM70uEqSNbBLWZh9cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvklDP4XYbHueVg7usHUyo7oxXYLM8SJjkAnto32cW/whWz+UVOPY9nwEAEZ5L3mdAWA/Eml4Vu0cVCUTysVbXFgjpQMsRiwLTojQy6aJNsZmN6Ejh6KybJROY0xLGjFxUhAZnIcNigfquntJWFzo5ycfWsC8rC/7bbrNLi07F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrJJUjBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBAEC433F1;
	Thu,  4 Apr 2024 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712266961;
	bh=Xyh52LJT/Gq5z0Hoib95KyYOLCM70uEqSNbBLWZh9cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrJJUjBjtvE5nSfzJg7iyIX1RC55IgB5MVx3PESMue0xrJZlkr56PK9AuYMWai7Dm
	 arZdeSo4SuOHJ+UJYZL823GXxYtbJJSUV8Po93pjIhXqzTYPz4LqXgH63HA/dD7oTd
	 DJ164AkiMz4Z10MhIduLAapP14qFgEnY0znpfibK68q1ocwgWSVhLf+WX9uKWXl3jK
	 yuUS3syeccAeycsdbyLVk8vE8N29vIv/Xc+NcbJJ0jaQjSfuS5XELHZS9UrDE9TgiE
	 NFpWIxmDtm8jHLwf9EbWR4odMEc0kbI1Jnszh7V6BYQhI91n+d1kpkrWbeBhv4Ugac
	 EvhI57RoGOU5Q==
Date: Thu, 4 Apr 2024 23:42:38 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, urezki@gmail.com,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() delays when all wait
 heads are in use
Message-ID: <Zg8ezv2vzylVwg2q@pavilion.home>
References: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>

Le Wed, Apr 03, 2024 at 04:22:12PM +0530, Neeraj Upadhyay a écrit :
> When all wait heads are in use, which can happen when
> rcu_sr_normal_gp_cleanup_work()'s callback processing
> is slow, any new synchronize_rcu() user's rcu_synchronize
> node's processing is deferred to future GP periods. This
> can result in long list of synchronize_rcu() invocations
> waiting for full grace period processing, which can delay
> freeing of memory. Mitigate this problem by using first
> node in the list as wait tail when all wait heads are in use.
> While methods to speed up callback processing would be needed
> to recover from this situation, allowing new nodes to complete
> their grace period can help prevent delays due to a fixed
> number of wait head nodes.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Looking at it again, I'm not sure if it's a good idea to
optimize the thing that far. It's already a tricky state machine
to review and the workqueue has SR_NORMAL_GP_WAIT_HEAD_MAX - 1 = 4
grace periods worth of time to execute. Such a tense situation may
happen of course but, should we really work around that?

I let you guys judge. In the meantime, I haven't found correctness
issues:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

