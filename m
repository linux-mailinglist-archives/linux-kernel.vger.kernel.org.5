Return-Path: <linux-kernel+bounces-34123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADA8373EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F671C266A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7C4778B;
	Mon, 22 Jan 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFV9lWMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA873D3B7;
	Mon, 22 Jan 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955876; cv=none; b=hBGB06rdL48Axe2SyUNHflA6yyZmEo4ulv6v26+z0aGhoZA9F/8KCEi8mOfyPYK17YEgagg3XqmoV8llSh+i6hISphSBRT3zv9PxY0+oRbAAWT9rviguunoBANKoopCS8Fdow6M0L0ucfVKYd4v8CyN0ayrPkDDzOLf7GTNpiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955876; c=relaxed/simple;
	bh=ryTI/dgxSGgJaY6rrLMoK3LtYddz0PEprqgR3GFrLlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjuPFBh3RTnsUVMckEn5HaBlvOclPnG+eG3urpbH1zUkCZSIdFZMTO99XnHtxF7/uKuTqVmqwwyxJQ2zYvBnQadWa9U68/+y7MubY9QKOxwS4KMxICtk5Bdmu0HAhylSYX9dadxvfcTr7fpBgVrAJ8pe0mTznPvECBv1zua5uF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFV9lWMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BEFC433F1;
	Mon, 22 Jan 2024 20:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955876;
	bh=ryTI/dgxSGgJaY6rrLMoK3LtYddz0PEprqgR3GFrLlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFV9lWMIw1a96H9ntsBDnIjP7g/6xFfGrJCtpTIKqY/if8wbrIr8zgz4CWPPzdGFI
	 UJtF+JCC8auUabBcHp6YcRSG22/xG6glbkt5sn0HTML4A5QFpp4HRQ8EiGSg67yhfm
	 0w9uNd5Ja7MIVDJkDthVoCFfZyw1nlFHxl0E9IbVwYU80TD1CrqMLuaS8GckaBlQC+
	 Jgi4/sHt/fZXmVG6IwrO2cZpXDelilJtFeLAlmXjy+YvO9z/tNTV6DBQiaVQxtznR5
	 hpysjW1hXBLDslgsnvMzH0o3kTnmUATgTxIoF0kpRjZHYe4HwNTklV0UDzZrIgXG5f
	 x7qcQ6KtFBuLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Xu Liu <xliuprof@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ian Rogers <irogers@google.com>,
	Jason Merrill <jason@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	William Huang <williamjhuang@google.com>,
	Ben Woodard <woodard@redhat.com>,
	Stephane Eranian <eranian@google.com>,
	Kees Cook <keescook@chromium.org>,
	linux-toolchains@vger.kernel.org,
	Joe Mario <jmario@redhat.com>,
	linux-trace-devel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	linux-perf-users@vger.kernel.org,
	David Blaikie <blaikie@google.com>,
	Mark Wielaard <mark@klomp.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHSET 0/9] perf tools: More updates on data type profiling (v4)
Date: Mon, 22 Jan 2024 12:37:51 -0800
Message-ID: <170595558520.377262.14088921449362386022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jan 2024 22:26:48 -0800, Namhyung Kim wrote:
> This is a continuation of the data type profiling series.  Now the basic
> part (v3) which uses pointer variables is merged to the perf-tools-next
> tree.  And this part is for memory accesses without pointers as well as
> small updates to handle some corner cases.  Still mores to come to
> complete the original series.
> 
> There's no change from the previous version.  For background and usages,
> pleaes refer the posting of previous version [1] and a LWN article [2].
> 
> [...]

Applied to perf-tools-next, thanks!

Thanks,
Namhyung

