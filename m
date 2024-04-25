Return-Path: <linux-kernel+bounces-158482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D58B20BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726FC288DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5712AAE0;
	Thu, 25 Apr 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JWzGBe3N"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADB84DFC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045896; cv=none; b=gz57DxKfTFxrqls9RWBLu7SiMvUIcfaQT5jDq+ByrzQFAPqUHEvNuE5WFQrmuWSvdNUw72JUvarog0oeDpI/6Spa7kQNk5baSbJ7cKHYVi6+LV4qTEV5m352LrV5MeNgcJ86S2NYBGtpCG7UqTe8HrNMii3HAXbTjXxGnebOwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045896; c=relaxed/simple;
	bh=/rUbNNAzRPDeOqeCh75iw3Y0y+qWeu5vitmrU/m8/Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md5jKnSIw2/2SeLJjubwIUb0Q/b8tl7BJqQYO0q0ojgsJ/Q8D23ToNnwRYsnW1CRp/Sold5oHxMkY8LuZ1cw4daRyZqygJk+BDrKTThv2Etxtmi7+4gLTJFc8vGob3n0Gyd4hdbDLvR4hV1WUfCz5jvqPxvoEfFh2g3HOaaeYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JWzGBe3N; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k9AOqaMBu30O1n0Mg30P2SEwNlRJnCFCTjCpmOuWfGY=; b=JWzGBe3NUbCw77GZXh8npiBm09
	ouRZga7ILcgq3OIxVDDjayKlg3Di9QS+THPwdNFpvf3uh36iMqmjYT9AmVwZDrEzytpNoAowx8yLM
	9bzF9JTfugTck+NnTh27NO43lcONG7iGpxuXR8I4HWxLTkEchfgqAgTEdSd0W7apCsDOTqSdd32OW
	YBWYZbSdLctovlvvDGOdFcxjvjJzPMWyhbY2eWBM3U7AbUajZxpXIBhGwSoaAM9UxQF2duR9V6fUS
	/Ju/kKovZ72/b7s0Q3bpQPY/Czq8o02Es9T9hxAeUqcmSJ7iWSzIzt+ZEUeyZ2Ayi0nQGyyC1yzpD
	ChD+cbtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzxdO-0000000ErEB-0jnb;
	Thu, 25 Apr 2024 11:51:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF459300439; Thu, 25 Apr 2024 13:51:25 +0200 (CEST)
Date: Thu, 25 Apr 2024 13:51:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: hupu@oppo.com
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair.c: Fix the calculation method of 'lag'
Message-ID: <20240425115125.GZ40213@noisy.programming.kicks-ass.net>
References: <20240424085533.GS40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424085533.GS40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 07:44:59PM +0800, hupu@oppo.com wrote:
> > > From: hupu <hupu@oppo.com>
> > >
> > > I think the 'lag' calculation here is inaccurate.
> > >
> > > Assume that delta needs to be subtracted from v_i to ensure that the
> > > vlag of task i after placement is the same as before.
> >
> > Why ?!? v_i is the unkown, it makes no sense to complicate things by
> > adding extra unknowns.
> >
> > > At this time, the
> > > vlag of task i after placement should be:
> > > vl'_i = V' - (v_i - delta)
> >
> > But but but, you can't have V' without knowing v_i.
> >
> 
> Thank you for your patient guidance. I overlooked a important fact that
> v_i is unknown in the process of proof. Below is the complete proof
> process, and it turns out that you are correct.

*phew*, thanks for checking!

