Return-Path: <linux-kernel+bounces-4381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567D7817C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0231C22432
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30B7349E;
	Mon, 18 Dec 2023 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdDlprp6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0397346E;
	Mon, 18 Dec 2023 20:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DFC433C7;
	Mon, 18 Dec 2023 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702932820;
	bh=BMfh3lrcxmGPTr7GYpN8kaTYHMaxLq7SFzjSMIVtKgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdDlprp6u9LFydvgU37KF+hloZJ9RPnAoosCsP9NKtcH/Yzr9nL4GtZ/mrde8tZqG
	 Gll8UaEkd2QLWFYOF7bIo32EAMuJtuTmyn+wrR8RRoJNqlTl6/Dd8zTHgdKxTIh1UH
	 LN+U+khyDHIe65lhqdt/4SUHtE9HaWG8YO9RaGydx3ZiTUh4BAVWZX/v04qUrhLdYD
	 iqpCOFC2cq7b6qcmcnf5gsfqQwWlB2cHM2DhfryZF4/piQcD82rqR1VhCQeKWieF6z
	 gvrQoG04eHvoqo71PqPlf55NUa1HbgD9haydYU+2MSF7mZs63fGJ+eCixrZBqdxd4q
	 O6BB4DgiYvbOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CBE29403EF; Mon, 18 Dec 2023 17:53:37 -0300 (-03)
Date: Mon, 18 Dec 2023 17:53:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v6 00/47] maps/threads/dsos memory improvements and fixes
Message-ID: <ZYCxURwlu7Rld-IW@kernel.org>
References: <20231207011722.1220634-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 06, 2023 at 05:16:34PM -0800, Ian Rogers escreveu:
> Modify the implementation of maps to not use an rbtree as the
> container for maps, instead use a sorted array. Improve locking and
> reference counting issues.
> 
> Similar to maps separate out and reimplement threads to use a hashmap
> for lower memory consumption and faster look up. The fixes a
> regression in memory usage where reference count checking switched to
> using non-invasive tree nodes.  Reduce its default size by 32 times
> and improve locking discipline. Also, fix regressions where tids had
> become unordered to make `perf report --tasks` and
> `perf trace --summary` output easier to read.
> 
> Better encapsulate the dsos abstraction. Remove the linked list and
> rbtree used for faster iteration and log(n) lookup to a sorted array
> for similar performance but half the memory usage per dso. Improve
> reference counting and locking discipline, adding reference count
> checking to dso.
> 
> v6:
>  - Patch 1 is a parameter name fix requested by Namhyung.
>  - Patches 2 to 13 split apart a macro to function callback refactor
>    requested by Arnaldo.
>  - Add fixes and acked-by to later patches from Namhyung.

Applied 1-10, 11 is failing, I'll try to resolve if you don't do it
first.

This should be in tmp.perf-tools-next soon

- Arnaldo

