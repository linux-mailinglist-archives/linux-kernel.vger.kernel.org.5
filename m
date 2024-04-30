Return-Path: <linux-kernel+bounces-163651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20438B6E18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249D5B21A00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4F1A0AF3;
	Tue, 30 Apr 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vn8aMbTO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57ED12836D;
	Tue, 30 Apr 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468730; cv=none; b=oRZdp9b8BNfTwuGc4lGdeX0i3xhdBjdGnojSt1qgdrazL5J5iowd62MIrI45kGAYf0aasE8f/5qwz/qJg3n0jWgEh1fKqmg2fVcG+hXrUZyUwd/wwBfCdryAU0gugoP63oTAm3yxkk/8nfV5d5/JqW4dzzivBDGeqhC73N3p8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468730; c=relaxed/simple;
	bh=xu4688X5LpIa9WsGUbdB5ty/Fonowhlc5KxUVayyEn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2i0wi9HsbThNaa6E8108lFUxIZH7AkfvJ19QPpYWi1tWG7cjpQSSej9C2KpK8th+Fqg3zoS9PdsZF6++hVq2FcDD6ryeqfP73C5v1cTwRgnjeI46b96xxNWEKA+wKztpRUw7p4wWNdaJjFoQJzOr0Xtnavr6FHFc5LmpNR22g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vn8aMbTO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xu4688X5LpIa9WsGUbdB5ty/Fonowhlc5KxUVayyEn0=; b=Vn8aMbTOd8x2KVdzx4zx502abC
	0ktMguPbT3STkiJJH+4+777WbgZ65KoqqWsk2WT/EuE9hUlfueqcxjDFMQ7+J8wJyDotHw30CVIOc
	RCqa8aB4lB2dfZ/WR273ADnGoXUuKd1HlgqZTFk90YCigUys4LbTLX1kTzOFAYvljtp/SWvbqluW9
	/qaf7TSHDeEqR9NJ58xrV2OKocqbZ4zuCeDK0PIZS+R5BRPxjBxBzYVJNr8ucIIAcNmeG+nutSnqD
	tSgP166iVlyEUahURv+90me2NJ/BpEAnkg03NRU2o1IGia0t3H+HGspAwh5ra0/Y3qfvoU7knzLN/
	tIxHbq3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1jdB-0000000ETrS-2ro4;
	Tue, 30 Apr 2024 09:18:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C0DB300684; Tue, 30 Apr 2024 11:18:33 +0200 (CEST)
Date: Tue, 30 Apr 2024 11:18:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Erick Archer <erick.archer@outlook.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Prefer struct_size over open
 coded arithmetic
Message-ID: <20240430091833.GD40213@noisy.programming.kicks-ass.net>
References: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202404291013.B21EADD4F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404291013.B21EADD4F@keescook>

On Mon, Apr 29, 2024 at 10:18:03AM -0700, Kees Cook wrote:

> Peter and Ingo, you seem to traditionally take these changes (via -tip)?
> Can you please pick this up?

I have been explicitly not taking these things for perf and sched for a
while now. As I wrote in that other mail, I detest struct_size(), it
obfuscates code for no real benefit afaict.

