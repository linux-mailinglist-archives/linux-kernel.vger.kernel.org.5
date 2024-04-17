Return-Path: <linux-kernel+bounces-149192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25548A8D03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E8289D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF9D3FBB3;
	Wed, 17 Apr 2024 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuB3SxOX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085473AC01
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386004; cv=none; b=E0cTYG9YQiMWFsUoJlA1iMjj2r4OKG8lv0VXSSWIGys3yBM+3ONcXN9QSYUY7onDULRx2skWbjIlVeQ++2ao+mLfO7prS7sbJj/P9b/Xoaz6IbwZrDcYQNwf7BXlXnf9efKUavr6x9S/96IOhB+rO9zhnGPvnblAzZ1Hx4qGSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386004; c=relaxed/simple;
	bh=LU3waJkcyI1Xdf3+JQ3ynvxRqPfmiDeVyiyOnYLI/RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKO8iQkeh3AuHwX2ngkblIHWZ1wtACTitueRDtFY5LIQzaf0iMGpj1DYvyy7N28swMnZONlR2mx2fzGg0dVZM3kXlDeSG8K5C9M7Pwy22mkv/w1NKAiTEu9MzBaheCGnjDhP4sLNfku2jdBeAnL1kzv8HyO+O2fQSS30to1GW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuB3SxOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC81C072AA;
	Wed, 17 Apr 2024 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386003;
	bh=LU3waJkcyI1Xdf3+JQ3ynvxRqPfmiDeVyiyOnYLI/RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuB3SxOXrJd8MRauo192hVGlhtKj14j15cF9ScWlBvDOO9qSo+tGqejI1+r9oVJGW
	 HWo7nSz+x4y5yI3cmXv9AvjSraxMSwJ1vH074tfgv8Af9KDa+Kjl9bp39vfTlQqo2X
	 ey7/4J0iqfI4mS0N4S9aL0Xtdeh8HtmKesquL1MFHSqzPtdKvn9xLwx8aPimBIAOcy
	 c9rnsXVI7jvt2J683SAbfvhyfp//gR2B8q5GUhy+GqWiO2qmx26k8vfOPaUr8i2YIp
	 D+/pXv54OP4JAF1y2PzfzKt1fTu0fkSMw+NekM+GH1SuRVynlJrXcmTy6nH/FK06pD
	 pM2ebDQeIetSA==
Date: Wed, 17 Apr 2024 22:33:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
Message-ID: <ZiAyDjQJATgfCrvj@pavilion.home>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.376994018@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410165551.376994018@linutronix.de>

Le Thu, Apr 11, 2024 at 12:46:24AM +0200, Thomas Gleixner a écrit :
> In preparation for addressing issues in the timer_get() and timer_set()
> functions of posix CPU timers.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

