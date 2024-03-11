Return-Path: <linux-kernel+bounces-99487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58287891E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD932B21665
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58985645B;
	Mon, 11 Mar 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuHh9Rh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832652F82;
	Mon, 11 Mar 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186787; cv=none; b=Hwk8K04/imjWJWvhOjBREfnj3J5Lid1tlmPpSf5S/dX80PMIFcAVJuJAijp1R0IuvQ68SQPzKaYZASRU6+GiGcu/WSUAPzeQ6JA/e6VAWNO6DFGBUcYDEwT2FfmjVE4iX3axCasDv8DZfsay9RBo5pvMAEFMZi3HGNFBVkiiTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186787; c=relaxed/simple;
	bh=A8wj8N49Kfd++YiRKkZS1w22NlzaRjpTlevf8GxjfzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMby6MUuJGXwq+Kl7mf4XSOLVB03UCdQsQg4n8rcpkJy2CylD6Rz4JUx8p2xjT9Bao/FOxkk36W10T9wTdjWDbMiFL9DAF5QTBDMacrBss2XeRh43z2P5x4NLyfjTZRzb2nfUvhJbdDpZPpsrN95ZZdJggit4injFlxUyFfAO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuHh9Rh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF89C433C7;
	Mon, 11 Mar 2024 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186786;
	bh=A8wj8N49Kfd++YiRKkZS1w22NlzaRjpTlevf8GxjfzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuHh9Rh9dziVdp+rlIeIxvEHtxp9Z/Fk+fhyaiwlNLOiBrnzP/6UlxA9J5P9WhAoN
	 1d1C+EPw3zrnAM9d6aMPqHdiQqHE13b5Mm1+mq3w+NMWt/4TreDasmTss+PiEAHoxx
	 UwPunojTqfX0DEY3QZ5MtKvV3p0Wnm/Kf+WU6oLuY8iibpn+22q+uyK370fG01GI1Q
	 7VKufD0ge9hehLE+PFFsJXqoSZirTO/FGrCxqOMdPp1ozP8Pt/oh2UQwv4izRCEFYi
	 wdrvN8+T0zbexx4zRlbaB5dnYdkE26AH9ejZ83wFHb+yi6J89wkUyS3+/jIscvXomg
	 ic+8z3r8hlrWQ==
Date: Mon, 11 Mar 2024 16:53:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anne Macedo <retpolanne@posteo.net>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf lock contention: skip traceiter functions
Message-ID: <Ze9hH5UzmnkFrTmB@x1>
References: <20240309132710.1055941-1-retpolanne@posteo.net>
 <CAM9d7cjhiua5rBj=CTDJJC-XJN6PzKxQ5DsooJGEz0QcQAry7w@mail.gmail.com>
 <m2il1sbocg.fsf@posteo.net>
 <m24jdcbmg3.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m24jdcbmg3.fsf@posteo.net>

On Mon, Mar 11, 2024 at 07:25:16PM +0000, Anne Macedo wrote:
> Anne Macedo <retpolanne@posteo.net> writes:
> > Namhyung Kim <namhyung@kernel.org> writes:
> >> I think it depends on the kernel version and configuration.  I remember
> >> I saw a different symbol on old kernels.  But it'd be hard to handle all
> >> the cases.  Let's have a single trace text section in the struct machine
> >> and use __traceiter_contention_begin only.  If it's not found you can
> >> fallback to trace_contention_begin.
 
> However, if we fallback to trace_contention_begin, we won't be able to
> filter out both __traceiter_contention_begin and trace_contention_begin
> at the same time.

I think for ARM we need to skip both, no? I.e. I agree with Anne.

- Arnaldo

