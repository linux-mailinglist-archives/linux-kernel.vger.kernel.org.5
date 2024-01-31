Return-Path: <linux-kernel+bounces-45747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6648434E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E8C1F25F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6D11805F;
	Wed, 31 Jan 2024 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBomMRlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD917BD1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706676177; cv=none; b=SaFufLCWzMgtGhvkd9oWInRKEI9f43OWPQ1Y2dfkMlTzzEm/5ZUFd4gFYLydGSfZ68etIM0J7SC64JFl1c4aVgYkIhKVVa2148QWmkWHOdRyVNruppwA84msVHzfIpd9/uOBkrYHJbAyUY8k7QN47NHHL87uARdQKiyhN3EUMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706676177; c=relaxed/simple;
	bh=wj/RHLEcO+Eso75EMA5XDjcUsbQTGg2WZ36dJdkuttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2c6bvJl/9H900u9InEt3BlOgQaOmOpAU27IXblQqo96SypsuuuQlGQeRuRL56v0dn7jxCKTKa668dqrxzA+dkQ8v9ypIziY+MSo+eB39M47mRIZReugl2RIb/yx/oURlO2/99ZfcQHSM6ZDno/qnq/SKDX5jobuxmaZS4/apmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBomMRlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3CCC433F1;
	Wed, 31 Jan 2024 04:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706676177;
	bh=wj/RHLEcO+Eso75EMA5XDjcUsbQTGg2WZ36dJdkuttE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBomMRlfRzJuDCtTlwEOL8klHygV+naNXVlOivvS+PfUz83i+EK5ljh1VRKBMZyOD
	 d9Pp6k8cNEswifLc7EPFrk1Be3iqEseGwfrt8C5LmLAGbZz1GvLEvE8iBE0C/vsFGZ
	 nR0P/SAyMcannwWTJknmkSsX1laB1kD5SBe7eAMYuhc3K84ZrC2CHiUYulhAtR1I7d
	 MKP33AAvVUnbIsJMKy32kk95Uii+B3D3IndHzt06JMAJcbH4S29EUXEF24h9dRtqdx
	 qWuRaPgv6Duo76rkcCca6RpS3mfcHS2eBMmJKiH9urWqfAYZ80gT6ssPV86NoWPybu
	 lt3ZCH1ODunHw==
Date: Tue, 30 Jan 2024 21:42:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <20240131044254.GA802495@dev-arch.thelio-3990X>
References: <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
 <20240131041205.GA3517117@dev-arch.thelio-3990X>
 <ZbnIzqmClhAvPxKC@slm.duckdns.org>
 <20240131042031.GA3946229@dev-arch.thelio-3990X>
 <ZbnLk7pZbcODRNER@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbnLk7pZbcODRNER@slm.duckdns.org>

On Tue, Jan 30, 2024 at 06:24:51PM -1000, Tejun Heo wrote:
> On Tue, Jan 30, 2024 at 09:20:31PM -0700, Nathan Chancellor wrote:
> > On Tue, Jan 30, 2024 at 06:13:02PM -1000, Tejun Heo wrote:
> > > On Tue, Jan 30, 2024 at 09:12:05PM -0700, Nathan Chancellor wrote:
> > > > Hi Tejun,
> > > > 
> > > > On Tue, Jan 30, 2024 at 06:02:52PM -1000, Tejun Heo wrote:
> > > > > Hello,
> > > > > 
> > > > > Thanks for the report. Can you please test whether the following patch fixes
> > > > > the problem?
> > > > 
> > > > I just tested this change on top of 5797b1c18919 but it does not appear
> > > > to resolve the issue for any of the three configurations that I tested.
> > > 
> > > Bummer. Can you map the faulting address to the source line?
> > 
> > Sure, here is the arm64 stacktrace run through
> > scripts/decode_stacktrace.sh, the line numbers correspond to your tree
> > at 5797b1c18919.
> 
> Ah, I see. How about the following?
> 
> Thanks.

That works for three easy to test configurations that were broken,
thanks!

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9221a4c57ae1..31c1373505d8 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1510,7 +1510,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
>  
>  	lockdep_assert_held(&wq->mutex);
>  
> -	if (!cpumask_test_cpu(off_cpu, effective))
> +	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
>  		off_cpu = -1;
>  
>  	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
> 
> -- 
> tejun

