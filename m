Return-Path: <linux-kernel+bounces-7372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD1381A6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AE9B24CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BB481AE;
	Wed, 20 Dec 2023 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY21/BNr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99277481B0;
	Wed, 20 Dec 2023 18:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5002C433C8;
	Wed, 20 Dec 2023 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703095675;
	bh=2K0Vk/aHwTr1UIR4EyDGZvUHGt2peKc8TKVMqrd/yQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aY21/BNrQSxz5xRBgl9iifwLMI9tPSHeG2H3+G5NoVZSl+S5QBcyKkdR+1NPtKn2+
	 Rrxzar+Y9lb2Ahak17saiDfGP19AdL2fT/uQyIAGRtOAwoGYCKQVQH7ogEUu4Rbb0N
	 wPkn18upIviEXj0a8oNhlaM4WJDkgaHdshZA6hGIzvs9ANc601Tz54XMKmxW6qzyCv
	 YU+QczfHJxIZrWp0/4UuxrHc0IqTHIS17JPYxZKYVeO9jQBsDHo2Fc3gPxauxMcvUE
	 jrBmXXMcjxJ4egOhYG3YVuPo87kBsYlHAd76ArnIO9dP7rrr3uGBxTZ3sBioHmZqf9
	 pkGkIPIsnKxFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 9ED42403EF; Wed, 20 Dec 2023 15:07:52 -0300 (-03)
Date: Wed, 20 Dec 2023 15:07:52 -0300
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
Message-ID: <ZYMteNzcRzNml5Qg@kernel.org>
References: <20231207011722.1220634-1-irogers@google.com>
 <ZYCxURwlu7Rld-IW@kernel.org>
 <ZYDxdD_BsHbntVvz@kernel.org>
 <ZYMojok9x1DpbWUE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYMojok9x1DpbWUE@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 20, 2023 at 02:46:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 18, 2023 at 10:27:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > This is all in perf-tools-next/perf-tools-next, merged with
> > torvalds/master, which made some of the tests (e.g. "perf list" IIRC) to
> > stop failing, something that went via perf-tools for v6.7.

> > Please refresh this series and any other that you may have outstanding
> > on top of that.

> > I'll continue processing patches and will try to help with refreshing as
> > soon as I can.

> 11/47 was failing due to a trivial conflict with:

> 4fb54994b2360ab5 ("perf unwind-libunwind: Fix base address for .eh_frame")

> Fixed up, continuing...

applied up to 22/47, will review from them on later, after what has been
merged so far has some time in linux-next.

- Arnaldo

