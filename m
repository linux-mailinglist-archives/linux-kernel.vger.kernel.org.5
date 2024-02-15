Return-Path: <linux-kernel+bounces-67672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1C856EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EF71F260B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FEB13B2AC;
	Thu, 15 Feb 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoJ9DZUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03A23D0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030501; cv=none; b=OlMLajth1JAf+41Wrta0EIGBHOw2Bb8Z3kFZmGWB4OtVv6iQA4MiviBrHozM/Xwpbfbe7VowC8oe7PGbvGMeuEdO8LbBNzatveiv8vhIc1WPzypfuQ5j+zX/TgN6BGKBZItJsEoyMIdyeMkIsg5OrUs0ez7i47NXSsVitphLyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030501; c=relaxed/simple;
	bh=aHAAf/eYEqbMIgGiLamIQT1uJEOPhsZ0QPwFACiwfUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZcxK6JBrzIEhuZVFthXJslZcnjR9Wxy3cjYNOMdi6+U+7df+tTuAPNLUncBfSspqwdSjSmSFjDawUM5yeAsYTl4ZNy76lh0+hSFhbXab/VOFI+pqAlI/lEeYQk6h0QBejwMyXNY4J7NzNZv+JEjP0iJV74tyo9FXMsGwsSh/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoJ9DZUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB09C433C7;
	Thu, 15 Feb 2024 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708030500;
	bh=aHAAf/eYEqbMIgGiLamIQT1uJEOPhsZ0QPwFACiwfUU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WoJ9DZUySKcUVt698bLNFZSqjCBxDsHZBzx0w7xhhFLhfFL1hxCGrgare77HrenbD
	 kPyxbUggv6UM5rHVsAqn8flx4cpihCFuaaYqsFS9zkJ3e2vhzHg/7/QdWYF57EkHh8
	 f50CyMlqd7tS3uJJgMWzhSWrFiciasp1T5CyyPfb7Sbukzfm5Z3/HH2/7DKuGo6PJT
	 +k/SuM1rgvBxJG2/p4vcv6EYUYuuD//sxf4LPDKz3xvY90CfVq7qteiiwV3jpKKcSC
	 8hFDURfcdrUrBFit3+lcbnjhoz743SsVbIY46ucp1poK6xC2O6S5Qiw2GsMFNjVN/r
	 38ZzM6BvDWtBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F010BCE0D0D; Thu, 15 Feb 2024 12:54:59 -0800 (PST)
Date: Thu, 15 Feb 2024 12:54:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <fe7fc182-31f4-4b0d-97dd-e48d7b8edc25@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <87sf1tcx5b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf1tcx5b.ffs@tglx>

On Thu, Feb 15, 2024 at 09:04:00PM +0100, Thomas Gleixner wrote:
> On Thu, Feb 15 2024 at 11:28, Paul E. McKenney wrote:
> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> > I am also getting these from builds that enable KASAN:
> >
> > vmlinux.o: warning: objtool: mwait_idle+0x13: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x36: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_safe_halt+0x0: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: poll_idle+0x33: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: default_enter_idle+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
> >
> > Does tif_resched() need to be marked noinstr or some such?
> 
> __always_inline() probably

That does the trick, thank you!

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 8752dbc2dac75..43b729935804e 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -81,7 +81,7 @@ typedef enum {
  * reduce to the same value (TIF_NEED_RESCHED) leaving any scheduling behaviour
  * unchanged.
  */
-static inline int tif_resched(resched_t rs)
+static __always_inline int tif_resched(resched_t rs)
 {
 	return TIF_NEED_RESCHED + rs * TIF_NEED_RESCHED_LAZY_OFFSET;
 }

