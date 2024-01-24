Return-Path: <linux-kernel+bounces-37081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFB83AB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F2D1F23D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAA777F38;
	Wed, 24 Jan 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQF2HJY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CABA48
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104603; cv=none; b=cMZd0sVE1J+yEjNp50L/bZ8Q37qer1m7TxyRRGcVw6ecBoNI2n8Rj7oJXrQSISC6w/h1yz9StyY6wh071wPgX1f8lsho+0bKdFLd9R46aeWeE2pOQKs226ehMRd4j0kPrrdz4LxgaccHiBsaPmoFhB5Kc0orunyU73/t/EWvQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104603; c=relaxed/simple;
	bh=fO+Kb4S1vDsw8RGbUhohqDu1hI9gt4XV/mefpNFpTM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx/s6reCPv6dScb5iG7K0cBpl9xXBtfjiEkQV6/qLXwmKKYkvdHTNlkEo4fagGuUIJ6pjku/vER33+1QQ2l9AOa0DR6mMA9IfttZHLlDUE8b0vQPgrUD/azwfzFwN09Gl/3ELivzE6KgIHKIfwvxKwEKmNRENHWu4JoieYr4Oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQF2HJY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C54C433F1;
	Wed, 24 Jan 2024 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706104602;
	bh=fO+Kb4S1vDsw8RGbUhohqDu1hI9gt4XV/mefpNFpTM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQF2HJY405CqnhZ0maObVHeMu2QDPW39RTJNTQ77hLXI3YPbsBmNhYL1UyjK0gChx
	 n7VqdonQeNfJcLnLcqVQBpVm5PfFaNAOG7m1QNeXGf4DqPW+znVpZEDI1TosN7K8PM
	 CCIqf/TPdvRHT0mn8mPwpI3L94wLppEoRake9M6MVWdZpkD3uS1Jf/xDYddHFKJKPJ
	 /+ZB3qhSXfkiJeVIFLhMS3abAhPnlg6LV+XDJJlX32y1XQ9tYOH5Mmbp2pp+PD0S3T
	 C/3iw4j3H9cIO2kYcH3s13BoqwDyqidLW9yxdufzQ8X6IO0fcN0IcfftGwsElxzYvz
	 bCR2cKbqrPj0g==
Date: Wed, 24 Jan 2024 14:56:39 +0100
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>
Subject: Re: [PATCH v10 14/20] timers: Restructure internal locking
Message-ID: <ZbEXFwSDw9666c0f@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-15-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-15-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:37PM +0100, Anna-Maria Behnsen a écrit :
> From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>
> 
> Move the locking out from __run_timers() to the call sites, so the
> protected section can be extended at the call site. Preparatory patch for
> changing the NOHZ timer placement to a pull at expiry time model.
> 
> No functional change.
> 
> Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

