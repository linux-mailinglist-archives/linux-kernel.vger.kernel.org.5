Return-Path: <linux-kernel+bounces-106686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D836B87F1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93060282803
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC95822C;
	Mon, 18 Mar 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0C88CsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C858201;
	Mon, 18 Mar 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796825; cv=none; b=vAsj5YTwY5DSOKUHJWVV5rWgaA1DdgdZLZr3nh+Gz7baGSXweI0C3QSfh68sWb6VcIW1n2XnUsT9O5XpD4qhlomvbhA/kBMHATERgcWRIuvgAyQznjTMcML6iMD1c6SDKaYAH5TVP2E0H8XQKLatcwTkOw5lil2W2tTVrDeUCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796825; c=relaxed/simple;
	bh=FkbiyeuX+QmNZ+8tFY9VNUuhycImKMM3RYIiML/0zjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy5k98rfsPMEKcI+Sh4cy+ssuxa8R8Xkbzb2zqpG5VgBqc25WLSufpKDnV4X2mYADg2XpSun4vVK26u2AU95/3xFlJ5QxIJoMXqUFP2Hf+Y9C0S/Ssdmo91ccPWh3zC/Rqt9FeE2ALW7Gb3OkoMs1t0Kx31pfU3Bn27wpdOT9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0C88CsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C100C433F1;
	Mon, 18 Mar 2024 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710796823;
	bh=FkbiyeuX+QmNZ+8tFY9VNUuhycImKMM3RYIiML/0zjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0C88CsEckIF91Ho9J6+y90Cehfiic9le0z4iTcGYiD1bnaWqhsEwMZvMf8lIIX54
	 ViiEv+CZB63nSsWeyEX7eNd1qW5JteWw0dZwnz2jcZazQeEg090lHkpYj6wYUfGBlY
	 c2g2BwBKK0kgdwFGAhTCFyx6Lj+dqDpWUpncJcOTdQadLDh3V4mSyiGWVKVWIPSeWc
	 aL6OPI9W+xZ7ot8pMl70BjaI7uaCEUx3gOL0ZXCMNyiohJ2k6rSpzqJK+tbW0RP7QU
	 xOEEIqZnkpkDzpBqUsJ/iPJ6ouilOwZqRax5J09egu5igjEFClfYiDnx2p5tAyiagD
	 1OUUfBnpkNqUA==
Date: Mon, 18 Mar 2024 18:20:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Show also errors for --insn-trace option
Message-ID: <ZfiwFB6TpAX90YZf@x1>
References: <20240315071334.3478-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315071334.3478-1-adrian.hunter@intel.com>

On Fri, Mar 15, 2024 at 09:13:33AM +0200, Adrian Hunter wrote:
> The trace could be misleading if trace errors are not taken into
> account, so display them also by adding the itrace "e" option.
> 
> Note --call-trace and --call-ret-trace already add the itrace "e"
> option.
> 
> Fixes: b585ebdb5912 ("perf script: Add --insn-trace for instruction decoding")
> Cc: stable@vger.kernel.org

Thanks, applied both patches to perf-tools-next.

- Arnaldo

