Return-Path: <linux-kernel+bounces-156684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BFA8B06CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC4B1F24565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06CE159205;
	Wed, 24 Apr 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PCUqQo7+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCC1591EA;
	Wed, 24 Apr 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952894; cv=none; b=fkaEaqkXYeG1LNxpGTztdE6LXpMQ3uklavVIdABBhDnIQM7hT8Y/R5Cts8Ag4k0aJ0HmIkmzb3sYF2vrM6HcqF4gurpABoVJ377+QJIwNKGvIFBvhJjBgcVvSvTZAYMLG2oddS2Md/a9FvlIUrXbAve4n2B72OJR+MKwPAur2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952894; c=relaxed/simple;
	bh=Fu/fHJcsiVtfVkreqiB5Ns+D3AaA90LaGc5UDwmbTdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Gb7ESnYd9ZG38bQIvHrjV8duaLRmov4qBjyU9f//nGrL1bf9YeI08GCojzvm+IjkzeyzERcB7JTHkNZWaDtnHMOgWBNVgukyR4XG4qr/PjXxQ93ORJ2XSttOL5gHr08W3PIL741ThFra3bY4tcAWQuzXJlnjkzE+dJJiGDFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PCUqQo7+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fu/fHJcsiVtfVkreqiB5Ns+D3AaA90LaGc5UDwmbTdQ=; b=PCUqQo7+jBxk1uOoTa31K/5TTU
	JlpzIdnBDmQ8ymnqMSvTFOpbczpPihRtk6/6D9STocf+bOoV8LjEpVX3wHa/OgC02wbgHT63hOw7g
	jyc6sUUwslpnA7fvnsKH8D/qIXo4GEMN3Z3YJjVCrK6fS5VtlNVF8vP0znXiuZGGEx9bEi17MfRzW
	HDWizgMSfzt8ngkgtoLoHguwgbGNACXwjG++/JRmouL4x7j0qJnU/wldwqv5gT7zO3rCJe8DXx7Ot
	1yyvjgXDhv5EzUGyTsWTEAwHjBmM3fjuoUP+dkN2uQEmE6ZgBGcZMDtQNIKVk6kYQ6yQgrz7p/zWD
	ldlitDfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzZRP-0000000ELwK-3jWq;
	Wed, 24 Apr 2024 10:01:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 871FF30043E; Wed, 24 Apr 2024 12:01:27 +0200 (CEST)
Date: Wed, 24 Apr 2024 12:01:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
Message-ID: <20240424100127.GV40213@noisy.programming.kicks-ass.net>
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121526.67022-5-axboe@kernel.dk>

On Tue, Apr 16, 2024 at 06:11:21AM -0600, Jens Axboe wrote:
> iowait is a bogus metric, but it's helpful in the sense that it allows
> short waits to not enter sleep states that have a higher exit latency
> than would've otherwise have been picked for iowait'ing tasks. However,
> it's harmless in that lots of applications and monitoring assumes that
> iowait is busy time, or otherwise use it as a health metric.
> Particularly for async IO it's entirely nonsensical.

Let me get this straight, all of this is about working around
cpuidle menu governor insaity?

Rafael, how far along are we with fully deprecating that thing? Yes it
still exists, but should people really be using it still?

