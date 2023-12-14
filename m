Return-Path: <linux-kernel+bounces-172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CE813D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E49E1C21B73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28347671FD;
	Thu, 14 Dec 2023 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhzCUriS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41307671EC;
	Thu, 14 Dec 2023 22:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725ADC433C8;
	Thu, 14 Dec 2023 22:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702591677;
	bh=PfvvUQcPkoMq76dDtugLfLFSSY2BCZuxvN2noD+Kfek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhzCUriSOEIxbvRYmeccDeFGMavoNL2oMRIXkePkOyWu5ruRL8/EDNG1MX81XhQ8O
	 t5bIuRow/ZcvLrtuEQiFCtKkKWn8Qbq8/q0wz9x1GihfZQb7JTm3e6sbcFGo/iDAnV
	 wu7bXLWsiFGGVHDQv6oKHHXxo79U5jcot/y5fvn1r+i5idDxPDyKUWYV8v52JDnIWm
	 Mub+uVlJNxwIU2Ji9bDRxfgH3KUX3KU+qqfQ1NsorKACFZUJGXydWh7H66nk8oNK3Y
	 7DfhZEENvzROY8PEm0TXu8CEjL2xwqbIU9mjdjD4wQ4dCuzs5vEmc3Xr9ZQHO7D+Gq
	 4iMze3mH33ZrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C5307403EF; Thu, 14 Dec 2023 19:07:54 -0300 (-03)
Date: Thu, 14 Dec 2023 19:07:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Milian Wolff <milian.wolff@kdab.com>,
	Pablo Galindo <pablogsal@gmail.com>,
	Fangrui Song <maskray@google.com>
Subject: Re: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
Message-ID: <ZXt8uuLf2UqGw_io@kernel.org>
References: <20231212070547.612536-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212070547.612536-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 11, 2023 at 11:05:43PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> I've found a couple of issues on the unwind code while I'm playing with
> the JIT-dump code for the CPython.  The code assumes normal DSOs mapped
> from the beginning of the file and aligned to the page size.  But it's
> not true for the JIT-dumped DSOs which are generated for each function.
> 
> Depending on the JIT implementation, the code address and accompanied
> ELF info (like ELF file headers and unwind info) can be overlapped to
> adjacent (JIT-dumped) DSOs.  So it should take more care when it
> calculates the mapping address for the DSO.
> 
> It seems these changes need to go to the stable trees but they are
> changed a lot since then so I'm not sure.
> 

Thanks, applied to perf-tools-next.

- Arnaldo

 
> 
> Namhyung Kim (3):
>   perf genelf: Set ELF program header addresses properly
>   perf unwind-libdw: Handle JIT-generated DSOs properly
>   perf unwind-libunwind: Fix base address for .eh_frame
> 
>  tools/perf/util/genelf.c                 |  6 +++---
>  tools/perf/util/unwind-libdw.c           | 21 +++++++++++++++++----
>  tools/perf/util/unwind-libunwind-local.c |  2 +-
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

-- 

- Arnaldo

