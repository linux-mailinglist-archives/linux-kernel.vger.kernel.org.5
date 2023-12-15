Return-Path: <linux-kernel+bounces-1628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6C1815119
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743B91C24053
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01D3FB28;
	Fri, 15 Dec 2023 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hNfw9Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULDG6o8E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0853846D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702672302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AV8Deyj9TYdQdy5CajmLnDhaRNnCKxjQ1PqdBdJ4EJM=;
	b=0hNfw9OtAvMznhuvLMPm+94+DO74/skheTC/tno/6JVctZ0WK77V+5A1m8S5py5upF0cIt
	KBS8rf+SVEjMoDPMoeRlJ1z8S8Zkpbf6NRXsA+/Y/dUjOZzdQRLZnmuxQeivJg2uH6Rn2Q
	01DiEilLbhQC2eVbS1ImREN/hsDihC3d82aBVgiWBRweQLqf6K6Po7Wi/GGnhAP7RM0c06
	tUuIV0blJIw3p7XnD0AeBARMCOHMdRuCxIupM+yZknRGFvFzcD3L6yBm1SwiLQOxF6lbIR
	endMrhsYIsk5paFFfScn5+Oe2QzbtgynfJ5WwwjYPnM8kOXeYugLMRb1wnrumQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702672302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AV8Deyj9TYdQdy5CajmLnDhaRNnCKxjQ1PqdBdJ4EJM=;
	b=ULDG6o8EI1Dh6y7rb57F+9UbIcho+XrRpbO0WRNsthm0sQ6dtmhbcGIPZmbaHmhrhdqDcv
	VlRFeqFtPdCJkBCA==
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
 <Babu.Moger@amd.com>, James Morse <james.morse@arm.com>,
 shameerali.kolothum.thodi@huawei.com, D Scott Phillips OS
 <scott@os.amperecomputing.com>, carl@os.amperecomputing.com,
 lcherian@marvell.com, bobo.shaobowang@huawei.com,
 tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com, Jamie Iles
 <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 peternewman@google.com, dfustini@baylibre.com, amitsinght@marvell.com,
 Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v8 01/24] tick/nohz: Move tick_nohz_full_mask
 declaration outside the #ifdef
In-Reply-To: <20231215174343.13872-2-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-2-james.morse@arm.com>
Date: Fri, 15 Dec 2023 21:31:42 +0100
Message-ID: <874jgjmclt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 15 2023 at 17:43, James Morse wrote:
> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
> a specific CPU to be tested against the mask, and evaluates to false
> when CONFIG_NO_HZ_FULL is not defined.
>
> The resctrl code needs to pick a CPU to run some work on, a new helper
> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
> be behind an ifdef too.
>
> Move the tick_nohz_full_mask declaration, this lets callers drop the
> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
> something like tick_nohz_full_cpu().
>
> The definition does not need to be moved as any callers should be
> removed at compile time unless CONFIG_NO_HZ_FULL is defined.

I can pick that up separately, but I'm fine when it goes with the
resctrl lot. For that case:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

