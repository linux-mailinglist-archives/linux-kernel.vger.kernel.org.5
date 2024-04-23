Return-Path: <linux-kernel+bounces-155371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1968AE976
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9751C22F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784A13B590;
	Tue, 23 Apr 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8hwkZzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAF6A03F;
	Tue, 23 Apr 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882578; cv=none; b=ktmY2wNPeoDziwtbGNhfbL+/hMPPoXMJdP1KudQqiPRLWe8wkw+U+OlDBMOJHtkuvLXOCC2KR3Rbv1tF7V2R90q9r/WY2og7vZF0gawvgEU9upKrU1ZpG0h9e8jLNSs4vHehNXwIzi/HIHtPDQKLhK01EopVG212wVQbcqZZqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882578; c=relaxed/simple;
	bh=xQ5On1MfHWhx96e4Z1Z5UDJQiU3euinVrl+3ijimgTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOHMnFinoSFzCOIgjez6gttE9XDH2wbzLsZVxVvWgb8Go1rwqt17G18v9Z6Ljzcee6mR1d5/hkALNQXZaYEkUFr2pFmkKdAL/lQSCpXnMWN5ktHW+9TThCxtvOb3okH0h8VO5kW+ixVM8mREOfP6AJRRIl9QW5a4aCBMEXek4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8hwkZzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52509C116B1;
	Tue, 23 Apr 2024 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713882577;
	bh=xQ5On1MfHWhx96e4Z1Z5UDJQiU3euinVrl+3ijimgTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8hwkZzpzrXYUObGZB1ZEw8s8h7AP3O4N67s5E9Vj2HVW/BhOeLMpW4ttasmWvxDX
	 XOTOsUciHHmdjhfDTIAED5BNajGZcgxVQVko5LaylcYjmZcneIfYZLBkyjINWfe+Lv
	 ZkB3K6kjgQeyREGcLvoYSpT4g4zwR77TM9keCJP70To9Qmn04bttpfJrQorItndolH
	 bHnIgZq42UyctCDj+9//7FD+RfmN+YQwTpRmgZM7Ks1fuBCwcCe0rEWQHuErs3lnpz
	 GtZtdhMlm7icfilbcm/l3diqH7Mupuy/LEJfxydGx5BS8b9bjJeZ5M7WWwDHb2J9v2
	 dLK0vCOVzSKMQ==
Date: Tue, 23 Apr 2024 11:29:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] dso/dsos memory savings and clean up
Message-ID: <ZifFzieU1w2SxIsq@x1>
References: <20240423042601.2009469-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423042601.2009469-1-irogers@google.com>

On Mon, Apr 22, 2024 at 09:25:54PM -0700, Ian Rogers wrote:
> v4. Rebases, dealing with merge conflicts, on tmp.perf-tools-next
>     dropping the merged:
>   perf dsos: Attempt to better abstract dsos internals
>   perf dsos: Tidy reference counting and locking
>   perf dsos: Add dsos__for_each_dso
>   perf dso: Move dso functions out of dsos
>   perf dsos: Switch more loops to dsos__for_each_dso

I think Namyung acked the previous series, right? I'll check later. For
now all is in tmp.perf-tools-next and going thru build tests.

Thanks,

- Arnaldo
 
> v3. Rebases and drops merged "perf dso: Reorder variables to save
>     space in struct dso"
> 
> v2. Rebases on top of tmp.perf-tools-next resolving merge conflicts.

