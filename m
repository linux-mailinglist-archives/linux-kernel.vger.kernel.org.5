Return-Path: <linux-kernel+bounces-106443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77E87EEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A91F25FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249755C32;
	Mon, 18 Mar 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXAkRQFC"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90C55766;
	Mon, 18 Mar 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782705; cv=none; b=hShmtpGq/PbS7ho0yzJ53q8e0eZd6Yl6LzAf9Fv/hTxzpSPbg0Rmg2df7X03XcNvxPT8MzvxueLnSvuoZLmoQkjjLs27evP0h50haGCNK/R2mGJUeZ/+jfA4Kgqrq20kOJ65UtMVTZ/XXoI850hihw+3SQktjhY4STPCp3/MrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782705; c=relaxed/simple;
	bh=dRwQGIJjcQCcbG/nv39ifGtF2OhFFWSOnXfgo7cUpZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTrTy1tbyS87iJMiEJPiQVg0YcAhZrFC9kVD7R/wBO8wBJLQLgxwJMJqti3pbOvp3lOdB2XTZcAnqIzFobF+pDdVm8AVFQuZLz3B5JDlLnpCQqFNjLP9WsjtA53f7NfRZtDhghuBB6Iv6KWfmVmIiFlDyOCrCG7fBHOrkIoUQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXAkRQFC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Mar 2024 17:24:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710782701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWGK09G8RtbS1Ej+sWUnnTckGMKYGUc3ngWPGG7e3lw=;
	b=qXAkRQFCZu286hM70up4c4+VnJs+j1BnibxlxJ3hGEvtwOkjaL0xIbDS95+2tvvdlfOmP9
	A2bczjitMzwjWpQAo+yBEkmf3Cjg44BxYx9Zh/AALJunTULBkPdOsNAI0KR0fuY9wjtzxb
	SFKvWmyj3U86lgNFHSci29RneYTGPFs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ethan Adams <j.ethan.adams@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH] perf build: fix out of tree build
Message-ID: <Zfh46MytnE3zOA4E@linux.dev>
References: <20240314222012.47193-1-j.ethan.adams@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314222012.47193-1-j.ethan.adams@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 03:20:12PM -0700, Ethan Adams wrote:
> It seems that a previous modification to sysreg-defs, which corrected
> emitting the headaer to the specified output directory, exposed missing

typo: header

> subdir, prefix variables. This breaks out of tree builds of perf as the
> file is now built into the output directory, but still tries to descend
> into output directory as a subdir.
> 
> Fixes: a29ee6aea703 ("perf build: Ensure sysreg-defs Makefile respects output dir")
> Tested-by: Tycho Andersen <tycho@tycho.pizza>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> Signed-off-by: Ethan Adams <j.ethan.adams@gmail.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

