Return-Path: <linux-kernel+bounces-48865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A07846281
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EF61F25B28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F93D0A6;
	Thu,  1 Feb 2024 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhu0w7nY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717693BB43;
	Thu,  1 Feb 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822066; cv=none; b=fkH9wA725vstVih1k5D+XKmAl0kyEyOmObRzUHNUs7hKuXgPgGWUhPd+bQLM2coiQ0RVxhmNmnZxdL3sKEMIYrs6MZH1YefGHs4DCAOcoL/rmyQMlci1SYloOx3R3H09K+M0TmWrVut/etmUceu8433lUsHa36MeDqudQGXrZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822066; c=relaxed/simple;
	bh=oYuwgQHvj3cLJDNe/eSNutQdYZiRYjbNOF45uQlcVgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjGQccPxlwbi/gzmDDIqEGR60BxObdeY3mxcv+aTGVGBXAYFD6Px195Lu8Ighcb5an3yV7EziZKZL2rXGp6Xy5BsPRN4A9aZJBa9S1rsavBEHK6lQ8goR1lMiWKxje0B2YXsmjAFHVFkQUx5fxaM/lvuoTt9D4QJ4uA4Ekh9OSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhu0w7nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A8EC433F1;
	Thu,  1 Feb 2024 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706822065;
	bh=oYuwgQHvj3cLJDNe/eSNutQdYZiRYjbNOF45uQlcVgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bhu0w7nYSbf9cLgUhi7cLUCL4CH1Fa/2vQ7pmXU4ExDqRrbAYH51mYkXQ3a9y6kwL
	 8PQPJ/uzM5WbP+aJJVGHVspSlBs53NpAYuVm7zkc5+uce60257x90uR6iOmS66fIM9
	 5q8KFFxLUQK6hT4w1GR6OZCkB6Frla91QBACR9I+lO7buDBBwWq8Ziit93wItXsBh2
	 OHeyCc+AfUQ2vVOq72APv7/PVKz9JH/xq/gSs8VWcb0odaBgW/BpoUiqtHC0DDpX5N
	 O2r4q0BFxlKCCgLvCyYPVv+8/FShvjs/TGk41iueHo93382HTzTpGeT73mEIbSiqHK
	 U52GrmE4gt+Uw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 9723E40441; Thu,  1 Feb 2024 18:14:22 -0300 (-03)
Date: Thu, 1 Feb 2024 18:14:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
Message-ID: <ZbwJrkkQbUxw-hyb@kernel.org>
References: <20240201202254.15588-1-acme@kernel.org>
 <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Feb 01, 2024 at 12:57:00PM -0800, Linus Torvalds escreveu:
> On Thu, 1 Feb 2024 at 12:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >         Please consider pulling, mostly 'perf test' issues, which in its
> > turn are mostly related to myself having Intel hybrid systems at home.
 
> I started pulling, but there's some truly odd noise in the tag, so you
> clearly have done something wrong.
 
> You need to fix your odd tagging process, they are normally noisy, but
> this is just so far off the norm that I can't overlook the craziness.

You're right, this can be routed instead thru perf-tools-next, for v6.9.

I should've known better and not send the noisy JSON changes at this
point in time.

And the other stuff doesn't affect normal day to day operation, just a
matter of addressiong artifacts in 'perf test' output so can wait.

Namhyung, please check if you agree to have this merged into
perf-tools-next on the way to v6.9.

- Arnaldo

