Return-Path: <linux-kernel+bounces-7364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C8F81A68E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA671C25A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A5481B0;
	Wed, 20 Dec 2023 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKbAcoGz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9547A7B;
	Wed, 20 Dec 2023 17:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC888C433C7;
	Wed, 20 Dec 2023 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703094417;
	bh=opcchTdVvorA43TVftLO5IxlAfT039kjEflnPjuH/yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKbAcoGzRC50Hp/RgtXRUXMlRMStCloK1hAcMHh75iRxASUIxiS/X3s0gxNfh6rH6
	 9ub0fySkawyBE8bpCA0MHSibwrCdQFHhdfk7uJSQr4VoFfTrhYJlSvsMBZB7aOGD8s
	 Kot7VPF7udwrybq81cRD3BqlcUGcgA4eEwh/1A0/fX58vBWlNujnISbxP3/9vRmXzT
	 ELVXMX3QUVrATkW4MW6aKBKvMuv2i5w1seH2K2uStNLQqVL/6pEcHiikxoAJECJyB8
	 wSOqAekGo+BUIghGKAMAo9WeE7s+t0ay3rHLZU/BU62z+KCA35ALcKIWXeoeQOfoIY
	 simuxCDDhll3g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 2DCFF403EF; Wed, 20 Dec 2023 14:46:54 -0300 (-03)
Date: Wed, 20 Dec 2023 14:46:54 -0300
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
Message-ID: <ZYMojok9x1DpbWUE@kernel.org>
References: <20231207011722.1220634-1-irogers@google.com>
 <ZYCxURwlu7Rld-IW@kernel.org>
 <ZYDxdD_BsHbntVvz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYDxdD_BsHbntVvz@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 18, 2023 at 10:27:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 18, 2023 at 05:53:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Dec 06, 2023 at 05:16:34PM -0800, Ian Rogers escreveu:
> > > v6:
> > >  - Patch 1 is a parameter name fix requested by Namhyung.
> > >  - Patches 2 to 13 split apart a macro to function callback refactor
> > >    requested by Arnaldo.
> > >  - Add fixes and acked-by to later patches from Namhyung.
> > 
> > Applied 1-10, 11 is failing, I'll try to resolve if you don't do it
> > first.
> > 
> > This should be in tmp.perf-tools-next soon
> 
> This is all in perf-tools-next/perf-tools-next, merged with
> torvalds/master, which made some of the tests (e.g. "perf list" IIRC) to
> stop failing, something that went via perf-tools for v6.7.
> 
> Please refresh this series and any other that you may have outstanding
> on top of that.
> 
> I'll continue processing patches and will try to help with refreshing as
> soon as I can.



11/47 was failing due to a trivial conflict with:

4fb54994b2360ab5 ("perf unwind-libunwind: Fix base address for .eh_frame")

Fixed up, continuing...

- Arnaldo

