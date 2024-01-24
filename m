Return-Path: <linux-kernel+bounces-37106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E037E83AB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1E028861D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11777A717;
	Wed, 24 Jan 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5FWdKpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589977652
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106167; cv=none; b=rrYUjz2ywSqsKbGG3lKFR0p6YzH+kwoRuiJNUdzIb82DLlxw4f4BWYjHjEHcMR724popvrRYdeJfJ6vvbllBSrcZFLHLNmTsET3D12GdnjMaeofSycuHdpIAxLlYdDGVJLGkjYOHmCQPuDv/UiPf4e6f+UMeTckWMO8KYiRRm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106167; c=relaxed/simple;
	bh=YKQBwhLmBvzLW3JuJTH1JCvphAS4rYf0ui4Wx8xS1/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edwoywvz0b7UEvRTz3H46dsk1knsz4R++fS8NgrgCFW9qZYxXayk59RF3ba3A4KbxJIWpYNZDjcV9rjWl+EjxWli9a6WK6x5oiPKyF2xMo6FvSCpm5Ks3mMxLdcqdIa3ndaAVuyckY+DHVqaz+ltkpL4vo0UIa7EnRPtujjHNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5FWdKpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19036C433F1;
	Wed, 24 Jan 2024 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106166;
	bh=YKQBwhLmBvzLW3JuJTH1JCvphAS4rYf0ui4Wx8xS1/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5FWdKpZMMIq5/Cn2gVkRSzZX24sd+gYns1ygTt4LFKE2o7gllOsqaKZXuR2K2av0
	 dmCsphq+Mmr1/xr2XN/smd/i16NhDd9llu7KSSXloVUKEuEMtH0sWEa0RVR4zeV4jW
	 Wdecw3/B4CEh5IdZsLO0nljc9JvgpZE0vH1+53cWhGC7+/eHYLegI5aU6iy+eTG7ao
	 HU2CLPtlV8XgoxEF9P7H6ULkXf3b/kgFvZZ43x2vn406m4w0xElPvMTlzSZzDEX6Rd
	 isyY/k3sD9kDRYKvcgfqOlcc4annQvf6ZBUe6RVhIIHOWXNJde9KDzYhrnHfDlMCJg
	 PH1zGKL3sYFbQ==
Date: Wed, 24 Jan 2024 15:22:43 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 15/20] timers: Check if timers base is handled already
Message-ID: <ZbEdM9U1q9PDP6ns@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-16-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-16-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:38PM +0100, Anna-Maria Behnsen a écrit :
> Due to the conversion of the NOHZ timer placement to a pull at expiry
> time model, the per CPU timer bases with non pinned timers are no
> longer handled only by the local CPU. In case a remote CPU already
> expires the non pinned timers base of the local CPU, nothing more
> needs to be done by the local CPU. A check at the begin of the expire
> timers routine is required, because timer base lock is dropped before
> executing the timer callback function.
> 
> This is a preparatory work, but has no functional impact right now.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

