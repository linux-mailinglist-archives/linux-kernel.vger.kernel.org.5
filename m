Return-Path: <linux-kernel+bounces-111616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5115886E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D4F1F237C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012347F6C;
	Fri, 22 Mar 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7PuAJ9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B78F61;
	Fri, 22 Mar 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117891; cv=none; b=t9ilL7C1zSUhDyEVgzmFwB98qNs2EvUoToW3xSK9/f4HuUbScgLDI+TI+1UYq+QU0OhvmfQoiFU2GFBMWYJIk/TxR4nlnDCHNtm416hmjjhHboyDz5sIMqIq1FYrb9m/t4I4zgExTmHLT/likN4rhXZ3wB/AY+ZGkSgRmsHv81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117891; c=relaxed/simple;
	bh=zCITIlofRfs91flaRQ+Pv8mRJ+oNx2RFQ3EezklVvRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3EFPe2CcMFHo4VrVeGt7SoHBiIsbaDC1b1jjGXzX/8LbjzuljiSJqdtV/VOeptVEk0kf1Shs4ZoODQ9FzFhYCqG96jeU0bETeT8Hw0UnxdfFYJ/yylSDs8sGKs9X7niOSl8kOQGYxOaiy36CsChczd7X41jPO4caaVahHyaJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7PuAJ9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6446AC433F1;
	Fri, 22 Mar 2024 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117890;
	bh=zCITIlofRfs91flaRQ+Pv8mRJ+oNx2RFQ3EezklVvRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7PuAJ9rTloNSqoVQmh8OczxtRPMd+vNp9bmPZnjMWZ7lmMrGvyyIlkPEU5eyXFrc
	 tYHp6EJhJDHTS3D5fQCYdAeN96bxgrfh/sk1nLIeYgyqqF9ZhLhKMbwMJlP6JwXegk
	 /CcDdqG6g124izGPU1Zs8KQCkioF/6J3R6qu0n8g44LkiLUnJ4UCX5VZBdRAf+rTlK
	 dE7BbSSeij96Tl3Gsye6lIsq789hp1qPguYfjKpY2bPIGH++MVUYWVb+KYDlEMEtMG
	 YKRGSfuMvSfRWiqup4kCq9p8ZR+jNTEC8LBX9MGjhXu+vzWep2LdAG/kxe3M8D0/6T
	 QodobPw08c5SQ==
Date: Fri, 22 Mar 2024 11:31:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "namhyung@kernel.org" <namhyung@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH v3 4/4] tools/perf: Allow inherit + inherit_stat +
 PERF_SAMPLE_READ when opening events
Message-ID: <Zf2WP1bajI0uytBZ@x1>
References: <20240322130414.70186-1-ben.gainey@arm.com>
 <20240322130414.70186-5-ben.gainey@arm.com>
 <bffa028a3ce0ed157560a96a1f0fc3cc5d707ecb.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bffa028a3ce0ed157560a96a1f0fc3cc5d707ecb.camel@arm.com>

On Fri, Mar 22, 2024 at 02:18:54PM +0000, Ben Gainey wrote:
> > +++ b/tools/perf/tests/attr/base-record
> > @@ -5,7 +5,7 @@ group_fd=-1
> >  flags=0|8
> >  cpu=*
> >  type=0|1
> > -size=136
> > +size=144
> 
> Sigh... this one belongs elsewhere. Too many spinning plates.
> 
> I'll have to redo this one with the correct size= value.

It happens, thanks for noticing it and promply reporting, this is _very
much_ appreciated, saves me time. :-)

Just fix it and send a v4.

- Arnaldo

