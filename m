Return-Path: <linux-kernel+bounces-153105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2498AC926
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8758C282A20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752FD64CF2;
	Mon, 22 Apr 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzxYvq81"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B681BDD3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778937; cv=none; b=p5qWDZPC0ontkg9HJothzD7AY6x8nNJUDcvBIUYFDagLJqVkE6KD8WD/sJYJhwp239bMxlZINSYA41zaqmve7EprW5mVpoXmthg1mxRn1//NFKqdq3X66n8zdLh4RAL7IpKszwTROzTRXHaMh8dOz1AHcm/mpfLQzsnFp3mz8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778937; c=relaxed/simple;
	bh=Z3SdbTn1nguh/Ie8rVGhk/PpcPQ+Ao8ZhGUdXRjh9V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsrX0uNGJVTj9m27atBjU655X5tbKVA7Hvupgtu21jzUhKos/4Z78asxQ2nCUuSuGV4QQvzBJ3WuEtGacsecR7AOVGehZofHKvy9HR+8qNHQFgVODLH+D1HhiC43jyrPSos+hzLcJGXbW2H/GZpHVW9L9M8yn42q+AMHbx6jLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzxYvq81; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z3SdbTn1nguh/Ie8rVGhk/PpcPQ+Ao8ZhGUdXRjh9V4=; b=RzxYvq81lcGeJuzS0XiAGTkslZ
	vE+RWBIJ7sZ60cRnfS0JTcKlJz21hYVL1N+Jj0gDnH2mmrpjyPKCEAuvTIG2QOdgNQoIkqc4H5LkS
	NS4DshxE6lQ1sTxE7l0qn1zpobuuPR/W1c20ChXQecmAcARGgcwr+spa8+LWnoPn8PVlsa1UyBYmG
	alqwSVvoRqvTzGqv5Bq7xtF6LEE1WiDJPDVG3IYKPXDIa+U+kjztKPe1GWGt+BfNacEuTAAH/HkgA
	q8kFKFvkwJnR853EWR/vMCAd5Uv/MlRG2kHc216kZC09CVIC+0sRQYRYHDNpgDFHRxwZSMwu1im68
	n4wbuHDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryqBR-0000000Dc2G-2xkD;
	Mon, 22 Apr 2024 09:41:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58C8A300439; Mon, 22 Apr 2024 11:41:57 +0200 (CEST)
Date: Mon, 22 Apr 2024 11:41:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
Message-ID: <20240422094157.GA34453@noisy.programming.kicks-ass.net>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
 <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:33:37PM +0800, Xuewen Yan wrote:

> On the Android system, the nice value of a task will change very
> frequently. The limit can also be exceeded.
> Maybe the !on_rq case is still necessary.
> So I'm planning to propose another patch for !on_rq case later after
> careful testing locally.

So the scaling is: vlag = vlag * old_Weight / weight

But given that integer devision is truncating, you could expect repeated
application of such scaling would eventually decrease the vlag instead
of grow it.

Is there perhaps an invocation of reweight_task() missing? Looking at
set_load_weight() I'm suspicious of the task_has_idle_policy() case.

