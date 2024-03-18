Return-Path: <linux-kernel+bounces-106694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E587F212
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BCB1F21791
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB159B53;
	Mon, 18 Mar 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV3PKwJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D158237;
	Mon, 18 Mar 2024 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797125; cv=none; b=AG9sX2dcbaXk5iMpRp6Phaq2lkY7oyjV8UCZ/By0vViGhvyCfwnFl6b1xFDpkPYcwDHe9mXHSWYXuGsaJFpxryTwkdwzl5Ii8FpylKya0yj0ByTegFVA1PPS3yDzFeB9AFMT5MRY55rsrnUVPivDR7wcfY2tv8dUqOZMjc875cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797125; c=relaxed/simple;
	bh=EgN5gu2wMjSIP0mbe5rfnALGps7n0Wz607GxZRvXqDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjB8p99TmpmOdVHLjJ8CYx6iyccz+IcqZNfsKlRw/EAodcrm0VWW+11vCjaT4n//2iln/594aflCCO8AjbKATvMVVpJNb6aY4+uxddNqF/+gip0WDkSp9PTMk9A7epGLZbhpaKZ735DR/8OphixfxRTbkGG5HTp6mtDWI0tYRvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV3PKwJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B8BC433C7;
	Mon, 18 Mar 2024 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710797123;
	bh=EgN5gu2wMjSIP0mbe5rfnALGps7n0Wz607GxZRvXqDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HV3PKwJGSqa8FSTdsgjVpPszxoRVAYFRkbQSGF87kXamJatqkNN1MFZEtJKFObwKA
	 nBsVePhfCn00EVoek+Wt5UP1IE6I6arV5MC7MPfgP5/AlrpHbJqVMxHHInu8DhPwFo
	 649eQzlPQkL3PIzBTnBQF/k7kfsxizTidWXkAOwwGlVglqMMo9CzdvnTivK/RZRWkL
	 ZGZ+WlVQmyr65ssz85ElGap+/c1JnQEDyU84i4O5gedQjf6Y2BmEOUTV/l1nGAUWvG
	 1iN+XzOlB5lOtiKfuzKO+J0/4WX1RY8n7/I5+4Z6xWg1B+Cdt7bDXUPz8kFvC00YFG
	 3fnvfe8Df2JWw==
Date: Mon, 18 Mar 2024 18:25:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Ethan Adams <j.ethan.adams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH] perf build: fix out of tree build
Message-ID: <ZfixQKTeeN4Tes3G@x1>
References: <20240314222012.47193-1-j.ethan.adams@gmail.com>
 <Zfh46MytnE3zOA4E@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfh46MytnE3zOA4E@linux.dev>

On Mon, Mar 18, 2024 at 05:24:56PM +0000, Oliver Upton wrote:
> On Thu, Mar 14, 2024 at 03:20:12PM -0700, Ethan Adams wrote:
> > It seems that a previous modification to sysreg-defs, which corrected
> > emitting the headaer to the specified output directory, exposed missing
> 
> typo: header

fixed
 
> > subdir, prefix variables. This breaks out of tree builds of perf as the
> > file is now built into the output directory, but still tries to descend
> > into output directory as a subdir.
> > 
> > Fixes: a29ee6aea703 ("perf build: Ensure sysreg-defs Makefile respects output dir")
> > Tested-by: Tycho Andersen <tycho@tycho.pizza>
> > Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> > Signed-off-by: Ethan Adams <j.ethan.adams@gmail.com>
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks, applied to perf-tools-next,

- Arnaldo

