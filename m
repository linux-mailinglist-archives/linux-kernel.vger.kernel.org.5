Return-Path: <linux-kernel+bounces-58355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88A84E51A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41CB1C2198E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC27EF1F;
	Thu,  8 Feb 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL+WM+UZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC627D41C;
	Thu,  8 Feb 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410268; cv=none; b=WHozSSXKPIihgXVXlrh/F4Qlu0+QbVM4HW9G5qKqWR/sO9GUCCLas/PEWEZJFIPIf9pslfdVEnbKWKtIOGcF/uyWRexTyRguvlbdbs4ZwYgMnzdyRmzfCPPcgyUDn7RGBAUMBIHk7moQIURHTuHGQePTQjbuEH3QoOIt14B5JsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410268; c=relaxed/simple;
	bh=4ysCRgB5dlb8UEDYItJCrdPvHfgdmur5y3smiOXlH4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfWQbbV+KFVRVxjt9fLFF30+KtWQws8LhJkOcc9bytIRG8D1wV/MIseJbM9dwlBwbStEqAtfFxh7eR7ld8kAzVXQskCtLQmel2NaOJdr3UnvfSrZ/S/PhsI2ET7mwO1igObR6zVwqZ/HNCso/eU+wf9fy6+JPc4GeaakqBJSabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL+WM+UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AA0C433F1;
	Thu,  8 Feb 2024 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707410267;
	bh=4ysCRgB5dlb8UEDYItJCrdPvHfgdmur5y3smiOXlH4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL+WM+UZi+aGiy0bCd1ZH7JTO79zU5GO0XCJNVJlcsRNLR/FpnUMwQUwSlRjnX/sq
	 Xh+cnrtYmWvn8FjrmWsuxXNoVe65axsafivc/XIjb3lxOZwJ8LgUHVTtoC1mXXeIso
	 VKPn79SUM1Xw2T2azoAWfXlLa2T8LZSZ4gsMelKRv0vjK+n4/71x0yCSGNz1GcD4sD
	 nWxryoE0kHU2zle1BF5NWIzUC3a0E+KieMjdW6ezWBhAotxUFioJUHyoETmPqTATCz
	 BiHlJmSQaEvTctg79FH7twKoItXT9Zx1hPkzeIOntkndp2nOQO6yr2gNqyVK2r/V/B
	 ohmohzkPgepSQ==
Date: Thu, 8 Feb 2024 17:37:43 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/7] cpuidle:
 s/CPUIDLE_FLAG_POLLING/CPUIDLE_FLAG_POLLING_SOFT
Message-ID: <ZcUDVxZ3sIOGD6Sn@localhost.localdomain>
References: <20231124223226.24249-1-frederic@kernel.org>
 <20231124223226.24249-5-frederic@kernel.org>
 <CAJZ5v0jBzqa8UVbarJbFDcqyLsMEVYSuCtcxKk6PUSv3TDnUOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jBzqa8UVbarJbFDcqyLsMEVYSuCtcxKk6PUSv3TDnUOQ@mail.gmail.com>

Le Tue, Dec 12, 2023 at 02:09:38PM +0100, Rafael J. Wysocki a écrit :
> On Fri, Nov 24, 2023 at 11:32 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > In order to further distinguish software and hardware TIF_NEED_RESCHED
> > polling cpuidle states, rename CPUIDLE_FLAG_POLLING to
> > CPUIDLE_FLAG_POLLING_SOFT before introducing CPUIDLE_FLAG_POLLING_HARD
> > and tag mwait users with it.
> 
> Well, if MWAIT users are the only category that will be tagged with
> the new flag, it can be called CPUIDLE_FLAG_POLLING_MWAIT or even
> CPUIDLE_FLAG_MWAIT for that matter and the $subject patch won't be
> necessary any more AFAICS.

Yep.

> 
> > This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> > kinds of TIF_NEED_RESCHED polling states while keeping a necessary
> > distinction for the governors between software loops polling on
> > TIF_NEED_RESCHED and hardware monitored writes to thread flags.
> 
> Fair enough, but what about using a different name for the new flag
> and leaving the old one as is?

Sounds good. Will do.

Thanks!

