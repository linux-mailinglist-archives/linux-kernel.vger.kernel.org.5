Return-Path: <linux-kernel+bounces-135554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAE89C77E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF71285872
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330313F011;
	Mon,  8 Apr 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh2Y1AE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4E1CD21;
	Mon,  8 Apr 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587867; cv=none; b=hrpGbAMIdvlQjvzzCI2pnzxBdZD/glskzBo98lPsusRjUfV0+ov5GzdzAp+FfwYx3EaqxenAObw3q8ozToHOr9gAweOroYkAmW7SnbHa0Yzck0SDAp3dJcaNU5UxajbdJ54DMYNwCJ+Rz+8mbSARPdxyfks3goQl8F1SygrH21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587867; c=relaxed/simple;
	bh=ROVMmw8JAVlfeAbn9frbLivPaMaLeic75F5rRmUOPYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMWde7ZJe6OcdY8e8lgUcTjgG2O5JD2DpD4NnlrYspGHI5BjFf7Ue4ryjPebkeD1Yf3u2O22fvBRmPD2UNmJzLAjC0LT0qHjSc3rxEirkjGdQAjmYbygTWJAC2hF+l0ckmNZq0FnfKpSY8UnXlZwLg92RBGEvOihB7Xrj8pty/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh2Y1AE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C011C433C7;
	Mon,  8 Apr 2024 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587866;
	bh=ROVMmw8JAVlfeAbn9frbLivPaMaLeic75F5rRmUOPYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xh2Y1AE4NFBOOykqNwxsDWTV5SlBHlnyXPyxZrP1LpwudwYDRoL2HPJfC+45uFMhv
	 kzvUg3nMucWx1SHLUnffJm+RJ2cbCueZFS4ySZ6bfWvcZ/3SkDmM+4MCpQPZm2UKKL
	 9cL9V98QMONV6U0l5Zkgk0mUeQa1QfIHaYqC+onTuzcCGhBDzTTZv/8zCMBKKLWAF4
	 FIQs8y7IfzUcRUFWtYIvJ5CxQpjUi1MZnEpZsk8VWK0wOWEe7xCiO/oTZTWj0fFmjO
	 38Ot4yNR4lf54ZomspbXIMYwFXE0o1vE6d9vUkw9G8iZFo3plku0XSadIQqOz5ah7E
	 oMSr8YuLKFn5A==
Date: Mon, 8 Apr 2024 11:51:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
Message-ID: <ZhQEVu2MS9g_Xwic@x1>
References: <20240403164636.3429091-1-irogers@google.com>
 <8e60ccd6-907e-445c-85e0-785b1426e98c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e60ccd6-907e-445c-85e0-785b1426e98c@linux.intel.com>

On Fri, Apr 05, 2024 at 10:45:59AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
> > Rather than place metrics without a metric group in "No_group" place
> > them in a a metric group that is their name. Still allow such metrics
> > to be selected if "No_group" is passed, this change just impacts perf
> > list.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo

