Return-Path: <linux-kernel+bounces-34235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A671C837610
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AC01F26FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5988495C7;
	Mon, 22 Jan 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeP6ojzk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08669495C0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962137; cv=none; b=RTcNcz73uJ5/nG4Vd8cFWHXEfUmQgFdaCSXRODn6MXmhCwyhxW33SgdWmcgiPcF62nGnsD+5sB2ESVX1+O6NH4BwDTXOWjVxchoRX9n6GnGFvKE4r+NMNdi1HwdKAbigUTzjd0ZIVTFL5snxHvN4bHr8dDcxFIbzN9rVTTzAchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962137; c=relaxed/simple;
	bh=d/fxVaGOVO5QVu91c1mmmWvSIRLFiaURtHGFApvsPj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw7o4cK/YN1a3BpLD37OfyjvCzfewrjDEi51ne89MV503HYK93cGFIsRxnVqiuT3AcPriiKWQdiUN0ErzAZSvbg5zCbCIqOKguG6bqXQFU1fXUbfR71glq6A47B3F04G8rweFzyLZDWIXcF+qdCeOSX72VnZ40hOwO9ttjG19bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeP6ojzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC8FC43390;
	Mon, 22 Jan 2024 22:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705962136;
	bh=d/fxVaGOVO5QVu91c1mmmWvSIRLFiaURtHGFApvsPj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeP6ojzkPZbUSVxkh/i+B/wvV+O+aLt1a0etxXSJ8LWMkBIdBLYELD4JncziA3TRo
	 hAd4lWovaEF1xU14/rU9Z8yA9l/2H9kIeYZ6ZB9bq3tC77qAaBU0QzYRgBPnvwOdK2
	 GQcPK9oddstNZmW1jGeEQFu/dnGz3hA7cYwo8E9NiIOKIhy09/d/Y/iUG60812TE0c
	 j320bYaCfQi5r3SfNuoTF5Ub8pDgVqwwSnp+3ESr1YPzo2ZAw5QqGiwTvPq41JnOFZ
	 gpxwrxKus07NLw0P4IToAJlHdXfbzpSXnmKFS61egIy5TaXcaZ8nowddd7+QsP0kRu
	 GRa7BLaH20smw==
Date: Mon, 22 Jan 2024 23:22:13 +0100
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
Subject: Re: [PATCH v10 04/20] timers: Optimization for
 timer_base_try_to_set_idle()
Message-ID: <Za7qlSikzxTaaUq4@pavilion.home>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-5-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:27PM +0100, Anna-Maria Behnsen a écrit :
> When tick is stopped also the timer base is_idle flag is set. When
> reentering the timer_base_try_to_set_idle() with the tick stopped, there is
> no need to check whether the timer base needs to be set idle again. When a
> timer was enqueued in the meantime, this is already handled by the
> tick_nohz_next_event() call which was executed before
> tick_nohz_stop_tick().
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

