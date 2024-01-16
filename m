Return-Path: <linux-kernel+bounces-27623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E282F324
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB06A1C2378A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776911CAAF;
	Tue, 16 Jan 2024 17:27:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E81C6BC;
	Tue, 16 Jan 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426054; cv=none; b=Cmu0CHtJzC8mUn85RvWxpWIrNwjjm5lx/ChbgknfiOtl2q9p5CKMCPkHz6bUNh8IMr9yBrLH1qmH1aO9NAVEvqHMWkvO8ywrQeCo8oZujSrHpHlVHvJvTERqEAgxX/JOehNp85fPNidM1Rv9gcULusTuvXjZDBSW0kK66c80YTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426054; c=relaxed/simple;
	bh=VW44apBSdyltR2D0bKdEyxqnETDMeUYBy3s+/rylPSo=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=IKJlIKZAHK8Cd2gor8jHYncN/sdYi8kZ0j3pCbv5H3aKvdHRPjir0+P6CsgSbwCDGpbGP0cIKU8gS0ZerxyBOIjRuo3Nhj45TamBYgDj6gBuY5M1RY149htcM2DwguudywVp7dnvRNJzMKHIXFQfHAUVXOPch+PZNjOWmHF0ywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1799C2F4;
	Tue, 16 Jan 2024 09:28:19 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1393F73F;
	Tue, 16 Jan 2024 09:27:31 -0800 (PST)
Date: Tue, 16 Jan 2024 17:27:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf test hybrid failing on 14700K
Message-ID: <Zaa8e-fM5rdEwVNp@FVFF77S0Q05N>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
 <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N>
 <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>
 <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWCn88KchSdQg87FRY0cpH4tVqO0UEYMhE=ioANeRBdwg@mail.gmail.com>
 <ZaUQaaT_Hi_c0JhO@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaUQaaT_Hi_c0JhO@FVFF77S0Q05N>

On Mon, Jan 15, 2024 at 11:00:57AM +0000, Mark Rutland wrote:
> On Wed, Jan 10, 2024 at 08:29:18AM -0800, Ian Rogers wrote:

> > Lacking hardware with the broken PMU(s) I'm not able to do this. Could
> > you turn the suggestion into a patch and test on BIG.little? I can
> > test on Intel Alderlake.

For the sake of the archive; I sent that out as:

  https://lore.kernel.org/lkml/20240116170348.463479-1-mark.rutland@arm.com/

I've given that some testing on big.LITTLE: I've asked Hector and Marc to give
it a go with the Apple M1/M2 PMU specifically.

Mark.

