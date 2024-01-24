Return-Path: <linux-kernel+bounces-37197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278583AC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129B11F22439
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36F77641;
	Wed, 24 Jan 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR4EzU17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32017E774
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107364; cv=none; b=qi9m71ZiJVJg6D/gXq3KE+ZV9kz09IiqU7i5Y6oCAKcdq2Ugc1sV25LAR8SM9Ju93GA5pD+Yh9bmBDQuui2LRQXPnxU4vQUR/rrdBe498ApQ/aZFsmCa29g+9EgjTkdzQ7JPAC0sopqwsjhhqFW1UWXJHzhmmovEfAD5pgGtJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107364; c=relaxed/simple;
	bh=wCPHcF2kRTlRySGOaeV0Cen6uSwRmqdRtCEYBTLRkVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge+lbTby3XfVygop/qTjezwOD+dqrn9MBUGe/Dc+z52sWgMjslvAPWsryQ+Oc0Sbn78HKf9xYzIxPWZ4ZA03OF2txy+pEDuncMLLu7Hw1Y7tERclQf6QARIt5VKls7Mky4M3iNBC7jLzcRr/hLJL/wDG0Cyjfs5YjSCgOe+Bg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR4EzU17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA464C433C7;
	Wed, 24 Jan 2024 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706107363;
	bh=wCPHcF2kRTlRySGOaeV0Cen6uSwRmqdRtCEYBTLRkVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hR4EzU17NKS0Riax1VgMzse174Wxqe1HzX0VW+/OEgdP82Iag1kOzsHIQp+aHLyat
	 pmmojeVQmOjeM+dA6Y8c7eTK1QIbf9H/xud6Qr3EqGibVikgvJzNMrNZ30fC9YVoeQ
	 CVh0RNgk4LK0sfP+kgqjZ4gVcgIEL7Kkqu7S/RUQqpb3gJL1Ev9IvS8pkM31divR5l
	 GmqyAQlkzPkFtnsVpv1bXSJwIr4zi24TopNzvQCGJHwD+OsNAqxXGLDWeB/B9A3YPy
	 HBgs4WX0If2RTrIVC+gNlxVgXHOdfGt+fv2DL/1aAjSXbDj7TAbpuXT6UVlq/sK82o
	 INunxvWm+RBsA==
Date: Wed, 24 Jan 2024 15:42:40 +0100
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
Subject: Re: [PATCH v10 16/20] tick/sched: Split out jiffies update helper
 function
Message-ID: <ZbEh4LWmkd8xjNmo@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-17-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-17-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:39PM +0100, Anna-Maria Behnsen a écrit :
> From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>
> 
> The logic to get the time of the last jiffies update will be needed by
> the timer pull model as well.
> 
> Move the code into a global function in anticipation of the new caller.
> 
> No functional change.
> 
> Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

