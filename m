Return-Path: <linux-kernel+bounces-38730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4983C4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A301F21A29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144C6EB4E;
	Thu, 25 Jan 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZVIVoUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93656EB48
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193350; cv=none; b=P2CI4Kq07flRtpkvUGain8b179jZo9OTycbGl3NxHvC1yHxrnLC9QxEy/y8+j/gs+tDoMmwieSbvio01D0EhZEJA2z1phGingckSR34zF9VKKF+fVg8eMfIZjAKjiMBtejYnHU8EY81RZRmATVu+FW78x+XVD4l7jNo8gubqPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193350; c=relaxed/simple;
	bh=QZua+8VcGlqpZ/mGDQGfLuyULRbt8n9UNNVed2Oud5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPOvU4oF8NJXdGEPonaRs34BeHv6cAGMgp34tPYIz5bu3P9SP5bkLaFQ2KbJEtxqL8Va6BXkCzZfuuzibP1GqrwdvbIdMWz+rWDNM/0QddG9MskXFyElGiNMsc7Ybo0FRMNWAb1pPlD05/WlSwSJJPdv5DZiFB4PuD1BTpEmKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZVIVoUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10517C433F1;
	Thu, 25 Jan 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193349;
	bh=QZua+8VcGlqpZ/mGDQGfLuyULRbt8n9UNNVed2Oud5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZVIVoUFKEXI4LHsLlg85UZQhIK+xLi+5HgJr013ENetgODrQWYlVVarDUyCBl4io
	 /3IboK66izAftwI/DdqYRYtFakl4WMDK2rzuo9+Las20G7iBHaLZ3RTHn5ltlRZ69U
	 vmv2sGixJyxZhvSIm+IIWLlZemUeO8tDPbJmLCpx0TUjLTlnJ2yq+fM4eYtYPHNQpL
	 E385saN3/hAhFXvl5AG9pn3G5LJ+WP7UD62+Sk0g6f4+P1pbrpjOAHnsik9L32M+JE
	 7CIHv9Xeye5M2/sGHMJ02sq1IpXW8gVrEw2cOcTOp3OeLndVsrAE/pd4NO+ednPKZ9
	 iL7zUFWVQp99Q==
Date: Thu, 25 Jan 2024 15:35:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 01/15] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Message-ID: <ZbJxwlAsFCJb4aWp@lothringen>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-2-frederic@kernel.org>
 <87h6j1kc97.ffs@tglx>
 <ZbJMkautxpj1sQEJ@lothringen>
 <87zfwth701.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfwth701.ffs@tglx>

On Thu, Jan 25, 2024 at 02:34:06PM +0100, Thomas Gleixner wrote:
> On Thu, Jan 25 2024 at 12:57, Frederic Weisbecker wrote:
> > On Thu, Jan 25, 2024 at 10:12:20AM +0100, Thomas Gleixner wrote:
> >> Adding
> >> 
> >> #define tick_nohz_highres_handler NULL
> >> 
> >> for CONFIG_HIGH_RES_TIMERS=n somewhere allows you to write that as:
> >> 
> >> 	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
> >> 		ts->sched_timer.function = tick_nohz_highres_handler;
> >
> > So the next patch does:
> >
> > if (mode == NOHZ_MODE_HIGHRES)
> >     ts->sched_timer.function = tick_nohz_highres_handler;
> >
> > Because that condition only happens in CONFIG_HIGH_RES_TIMERS anyway
> > and the function field exists in any case.
> 
> Right, but the function does not exist for HRES=n, so you need the
> #define ... NULL. The IS_ENABLED() allows the compiler to eliminate the
> code for HRES=n completely.

Ah but the next patch moves tick_nohz_highres_handler out of CONFIG_HRES
(to soon become tick_nohz_handler()). But anyway I can add the IS_ENABLED()
to remove dead code.

Thanks.

> 
> Thanks,
> 
>         tglx

