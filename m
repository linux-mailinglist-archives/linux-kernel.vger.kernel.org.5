Return-Path: <linux-kernel+bounces-88663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3C86E4F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EECB2442B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8071720;
	Fri,  1 Mar 2024 16:06:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FB3A8DE;
	Fri,  1 Mar 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309169; cv=none; b=VLO0aNPUFtECG2KkVm9Vif6SwtHSMyjozd3PBMA7Ygbnn5l9aXLPiLzo9jZoIP635I5Gb1PvZHUe/LT2VfZSkAIr7NzEUlkCR1kXQByi2CIWCwvGUzUNjcokltDSMkSeTQulsEyQNaA9C3NV2SNs0R0PPgxT3FFlU/lERPNKw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309169; c=relaxed/simple;
	bh=+I5q0INsRXMPfcHW7TQCG058hRSgznIpYTjriNmFjAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kevFHJRcx08rvKNd6F51ovrzhzL1tDpPaYzL1uyp9eo+YvjFoExpavCHCdv0NJhKoeWbQYxQNlCtf1pBRqhu3YqB9OPLFmASv4Zu9OF8Xp83/HwC+vcJGevx/mDLDAVzwFvhEJC3QB179JSaXpdXjJ/puGSixLk79speiX2+GZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193491FB;
	Fri,  1 Mar 2024 08:06:43 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAD6A3F73F;
	Fri,  1 Mar 2024 08:06:01 -0800 (PST)
Date: Fri, 1 Mar 2024 16:05:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <ZeH81_k6TFk7W4tm@FVFF77S0Q05N>
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>

Hi Doug,

On Tue, Feb 27, 2024 at 04:57:31PM -0800, Doug Anderson wrote:
> On Mon, Jan 8, 2024 at 4:54 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Thu, Dec 7, 2023 at 5:03 PM Douglas Anderson <dianders@chromium.org> wrote:

> > The sound of crickets is overwhelming. ;-) Does anyone have any
> > comments here? Is this a terrible idea? Is this the best idea you've
> > heard all year (it's only been 8 days, so maybe)? Is this great but
> > the implementation is lacking (at best)? Do you hate that this waits
> > for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?
> >
> > Aside from the weirdness of a processor being killed while holding the
> > console lock, it does seem beneficial to give IRQs at least a little
> > time to finish before killing a processor. I don't have any other
> > explicit examples, but I could just imagine that things might be a
> > little more orderly in such a case...
> 
> I'm still hoping to get some sort of feedback here. If people think
> this is a terrible idea then I'll shut up now and leave well enough
> alone, but it would be nice to actively decide and get the patch out
> of limbo.
> 
> FWIW the serial console dumping issue that originally inspired me to
> track this down has been worked around at least well enough to not
> spew garbage in my console. See commit 9e957a155005 ("serial:
> qcom-geni: Don't cancel/abort if we can't get the port lock"). It's
> still a little awkward because we'll be running fully lockless during
> panic time, but it seems to work...

This is on my list of things to look into, but I haven't had the chance to go
through it in detail.

From a high level, I think this sounds reasonable; I just want to make sure
this doesn't lead to any new surprises...

Mark.

