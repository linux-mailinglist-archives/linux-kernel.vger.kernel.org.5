Return-Path: <linux-kernel+bounces-153280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886758ACBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CA41C221C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621CF146597;
	Mon, 22 Apr 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DvjCbNMJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0126AE6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784677; cv=none; b=ELID0QC/PY2yPci21Owqu2+za99MBIkTB3NIFAzZGKrCeMVBP/dkHUhgEFRbRdKJ+egTcVES8I3PIe/wVpVwZH++5sa0WhvwmYQDCBDr5PEeOeH6WnXhN3+puNqSIgWZdBpiKifvQYsBBFJfQ4ehw9E+ngqyuuY0GPWBZub//+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784677; c=relaxed/simple;
	bh=3HTBs8uYzG+qgved11753oIo5smuqzX+aqxjD9LRROU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz4MbftAjMzIUaH6d5tbsV6MNBjwb3y0deGl6LE8CWMij7d0zdhEL36hzDA65luH5ERHlkdSVZ6gyNHB4QHXoYB6MtlJfCiMudVmWfvYDgSO/1cj2DeWtgG4OBhh4wsPM8R4QGpZ1f97qZ4b4eDZ1nvZRKAdg/Z6BnkJgWtgmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DvjCbNMJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=klYVYxoyZc5Ys+G/99+0FWzSz6uZcVcksgl+fOSPZsI=; b=DvjCbNMJOOLlOEL1usO9NelC+/
	LigroHhnhromLtzpqvoVPA5j7/XzUXZzCP6ZsSe32ELKLsZtxM2J4w1sxxsJiHRDoOGja8AxdzZ+O
	sxyJSNYDHGIdtUX6SSiXFSZ/VGixYfzqfaURB4YIaA8clgN/RDB1iNyERoNHErV0hcNidC80dsJgv
	c2cjMvAJT65Tv9TUpTA/zdsBvCXj8w5Qav9xqMPTKFzlElOTbOaE4D+YDDM2EUlvwMLUxe0MEeHqE
	RVVh9BPR4nfKO4R1u8AVGRWNW13ZkRFRPictgr/X/DCkYVIeQEdXNbXemuCGnVq2XGd5cnsXxPrs4
	B53esLhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryrg9-0000000Ddzp-0hrO;
	Mon, 22 Apr 2024 11:17:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF09A30045D; Mon, 22 Apr 2024 13:17:44 +0200 (CEST)
Date: Mon, 22 Apr 2024 13:17:44 +0200
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
Message-ID: <20240422111744.GO30852@noisy.programming.kicks-ass.net>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
 <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net>
 <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>

On Mon, Apr 22, 2024 at 07:07:25PM +0800, Xuewen Yan wrote:
> On Mon, Apr 22, 2024 at 5:42 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Apr 22, 2024 at 04:33:37PM +0800, Xuewen Yan wrote:
> >
> > > On the Android system, the nice value of a task will change very
> > > frequently. The limit can also be exceeded.
> > > Maybe the !on_rq case is still necessary.
> > > So I'm planning to propose another patch for !on_rq case later after
> > > careful testing locally.
> >
> > So the scaling is: vlag = vlag * old_Weight / weight
> >
> > But given that integer devision is truncating, you could expect repeated
> > application of such scaling would eventually decrease the vlag instead
> > of grow it.
> >
> > Is there perhaps an invocation of reweight_task() missing? Looking at
> 
> Is it necessary to add reweight_task in the prio_changed_fair()?

I think that's the wrong place. Note how __setscheduler_params() already
has set_load_weight(). And all other callers of ->prio_changed() already
seem to do set_load_weight() as well.

But that idle policy thing there still looks wrong, that sets the weight
very low but doesn't re-adjust anything.

