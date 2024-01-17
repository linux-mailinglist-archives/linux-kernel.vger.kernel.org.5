Return-Path: <linux-kernel+bounces-29121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE0830925
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB9F1F2276F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C521352;
	Wed, 17 Jan 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGPQyOd1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9067210FC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503997; cv=none; b=L9njxUoBnPWG2nOdqYGL8O9Irdu2C0UVvGf2SQK7NroIrhYBgoVPEqrE9lusEA14H5NrgoIbEz0hkL1FTthOJRKqLOSJXpjfbljjWx5VRv2UiqVZflUe97IOVLbkL51aVimBv/b7e6rg1gyfFHJgm59eOAww4HIikKqkHBMURbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503997; c=relaxed/simple;
	bh=6uZ8t74Do2OpeMaCkJBGUEtBKJZt35DzOnysBEN5OyM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=e8hJoNPWOhCfKauz9TfTBqgbJ38k9Rp/C1LB3cVFjhUuXNLZ4qlKkub3v0+pUaZwT+b1n2CvaGv6QNsbV/UXiLrNIy8OuGvgAmRLHvKyZyvN9MWhxNSWXqDVHgP7RbVUTntzsQ70F+tWiEv4ehm4raIJD8fepCNlDkwFAFBubbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGPQyOd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91687C433F1;
	Wed, 17 Jan 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705503997;
	bh=6uZ8t74Do2OpeMaCkJBGUEtBKJZt35DzOnysBEN5OyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGPQyOd1BY+PmGGVY2FMQwmeHL8l0MVk0ntkktLpVL+6+9rIWaFPgGIbaSkU4V3BI
	 1J9lkCZOjF8C1KCkmL5BOznRoNG5Hcpujdfi1kDGc72Tvh0DnmdgL+7e1yLr5cTvds
	 7l9vS+srKaV9YEqnXrPmsUxptntRWPmjvN6jIi5caDOLc1UtNzgG3emwFgay4fR6Hl
	 rIGAe9B9fOXGZPJusekd+N763QMrPFeBgT1HK1b3uSNKGFLBcqeEbyN3CM4c89T6Oc
	 UxdMm9fSyZGq+hfXLoR+f/RPbnf9U8XU0b0ikZun0glM33oSZtnBYB5piitsKBIP5Z
	 wJbNFN31zJCLA==
Date: Wed, 17 Jan 2024 16:06:34 +0100
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
Subject: Re: [PATCH v10 02/20] timers: Split out get next timer interrupt
Message-ID: <Zafs-neOXshEXrYz@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-3-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-3-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:25PM +0100, Anna-Maria Behnsen a écrit :
> Split out get_next_timer_interrupt() to be able to extend it and make it
> reusable for other call sites.
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

