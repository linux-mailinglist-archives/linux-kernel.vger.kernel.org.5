Return-Path: <linux-kernel+bounces-75479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF585E93D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A731F24A97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C13C488;
	Wed, 21 Feb 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux04tYLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C339FE7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548629; cv=none; b=a6NY3iQ2vEDkTSe6+wfkDJlOS+XWOP7dGphqH435nxwG7AwxCJm/fG7vOsFmc2RyNEX7/tXgfBZ+a9mjqm+9blpw5FDtLTZPr+rsg8FL2KPxzZH14NxHjyNQrC34D2Pifk1q+kdTlR13LjuCCag0AjSzLLMVOwuei8fXMEmTm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548629; c=relaxed/simple;
	bh=3UZBZRGpRhgfHoUT84X8KUjqvKjE2IAgg10qk0iuOE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8t/CS7tcL7ilSWaBjVaTUQCCsWJO4OSOcjxut8b3UI0DQ7k8SJXLoIx2GEXFCrZAHeBZE3MYZQhLQhmyosXxoA0PuikWlR0TZpKLodEq5D3/HlBhSVLCjuWcaV95ni1PPditgZR7gxbII+KCwB6tSVPSyJA3hxHpTiFKy/cjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux04tYLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3692C433C7;
	Wed, 21 Feb 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708548629;
	bh=3UZBZRGpRhgfHoUT84X8KUjqvKjE2IAgg10qk0iuOE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ux04tYLruqbo9TiQJ9s/zlh+K6GbHg0HB4zC5WtX2/T/cOJ5iQrsUhP/6FjkS0OIk
	 a4ia2qFK6kEiy61y26uksnvXyxif74DW52jz/jixFLzRiXIH9B4R9BYAumCQQYfjPv
	 bjOtmforT1JwfF8eEBIo5XN47zHSqr/sNBj7HP0F31JB5t0aIQw64exHd6Okp4vu7N
	 C8U+GTtTnwSFk7QwszevPAfalcZstJnein24MlVPBZthHQJQh575GuxH4ZEfDL+nz1
	 yCRiRXa1pmGf1Q/KOM4J03xzAvDYHNWVGM2yG1/lNFLPECZWpKjKTdL8gnOLm3cDOF
	 IftnTFEIR6qXA==
Date: Wed, 21 Feb 2024 21:50:26 +0100
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
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 13/20] timers: Add get next timer interrupt
 functionality for remote CPUs
Message-ID: <ZdZiEmhFAdUZcgMK@pavilion.home>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-14-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221090548.36600-14-anna-maria@linutronix.de>

Le Wed, Feb 21, 2024 at 10:05:41AM +0100, Anna-Maria Behnsen a écrit :
> To prepare for the conversion of the NOHZ timer placement to a pull at
> expiry time model it's required to have functionality available getting the
> next timer interrupt on a remote CPU.
> 
> Locking of the timer bases and getting the information for the next timer
> interrupt functionality is split into separate functions. This is required
> to be compliant with lock ordering when the new model is in place.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

