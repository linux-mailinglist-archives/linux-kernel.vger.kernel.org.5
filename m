Return-Path: <linux-kernel+bounces-163632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256028B6DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35F428127C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587512836D;
	Tue, 30 Apr 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QezeMGZb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCD127B68;
	Tue, 30 Apr 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468520; cv=none; b=KkXPciJILt7US24TFu7aQ0+ypOcywrkwOKSqpfOiVn+sPdAhaD9UQ02xwvYxfdYSyBz4R8561A1DoTGZcZa3LoKedK02lFOtEKhYxO3bJ6QOdg65wbPAgoI3H5/hgVL5/AjdZgEZVTQC+wQ3hvcjopP988GM9PH96cNsr0URJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468520; c=relaxed/simple;
	bh=A5/HDxwcKe1CPVTAY+cgDukpdoaBFZ/fMspZPwQu9PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBZ1DLx3W9wag4CJlNOIqzbIGoz6/hLFSXX0Oscsse+SJ/wSbahaNNJ7mv+jghissMx10XIvOg9BefSGURHBKkQGEvzSOxy1lMIf/EBs/Tn7KgLQN1Ki6ORbNb93aIcJQe4Cv7Dbvzy/neKu7qvHmxmbpBl0Lbad7TjyepjVVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QezeMGZb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A5/HDxwcKe1CPVTAY+cgDukpdoaBFZ/fMspZPwQu9PA=; b=QezeMGZbL/2NWH6nP0/grm30hL
	jMekjRq2qFRUCFMRCVKslzxjAbg9qKxnPhvTx49CL9iwrEZkwp43xFyQ0hHRqjVecoKP32EYhnlYA
	F7dLnahlYnkHPvtIlVuNduOC/6DiIs0YE0BNWfCwjHkGa3Iepoi9C6AD95I5r4h1/DGRvLsrycMOj
	XhG0q9cRd0XBlsKJ/npaieP0mBo/2iId1P1fa5DvQPM2vivUKoCsHcxz4syC9vcHK4oPuzkLS4zf0
	Se759pCqFVTnwp1pXJJWiexcYhQ4XC/Lfhh/wVX2XZtGeCfqZ5RPr4C6k/6Bbbi7gZfurl8CVIIxS
	ne8E90VA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1jZo-0000000Gsl8-2RdT;
	Tue, 30 Apr 2024 09:15:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F7AD300684; Tue, 30 Apr 2024 11:15:04 +0200 (CEST)
Date: Tue, 30 Apr 2024 11:15:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <20240430091504.GC40213@noisy.programming.kicks-ass.net>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].

So personally I detest struct_size() because I can never remember wtf it
does, whereas the code it replaces is simple and straight forward :/

