Return-Path: <linux-kernel+bounces-101586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DB87A906
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3541F23CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D1A45BFD;
	Wed, 13 Mar 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2rHGejP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB744369;
	Wed, 13 Mar 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338810; cv=none; b=dEX/NjBy6M8D+FFLFjrhQs/Ggj4irvsZuuxcy3RkvD6AIqNnEs/So472H5BVmHE/roTve7RaSeDRppEAbuYR6pM2GZ2HWngED+eWMPmYWjZS0ofJNTh/VWIuvFNPeuXTYaKw4thn36KffrM3gwjrEK/QDjUuLyOjexpvOQ35Z1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338810; c=relaxed/simple;
	bh=0jlutHs2yvu1tTSpSrKgQrXzPWCFfYo1yaC03lAmRJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAO3XgaoNVBIVSWKYszKP3jRe4SJCn1mTRv/1VMnNhRyEUutCQWzJQdg7RTC6uVVrcOhW2ZWpzGQSEJqBzpdkG7mQz7BFfI8VGjeJbTs6Vm9E0HBLMA8yEDiSA+9SRQwxO7j1Y1mC6D6zmEiwNdoMjRWC7OuCLxl6syLjH91NC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2rHGejP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E71C433F1;
	Wed, 13 Mar 2024 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710338809;
	bh=0jlutHs2yvu1tTSpSrKgQrXzPWCFfYo1yaC03lAmRJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2rHGejPC6zUe43HEHmolXuF+RGCmZkV3WlO/ezoNnheDMK4Ru0SNxL7xADNon3FG
	 BYbtnxq1u0jdpg07fV4A0ULudqsvsuttjFGMwLDN0JAjIAjfi41XEjDfFpAnSQLnGz
	 79VUBQ/GTfykN4HLG8lpZI9rrbIZJHWf0B+98jqX633EsbGzNo+XU2gTyETO1Gl0fu
	 cpb/ZIirhxyV6+GC0B5yiM3T/HR6yGQuMZ6X/7x5j8Kn7WUwUMv5YhgDC48V6c5pw8
	 wmCwVbmXMZILmfrEq4/9QQABTyq8uEwHWKnMzBtBSlMTUVLei7SPQg7M21LZ5lHPtZ
	 uZ5l9by1bouIw==
Date: Wed, 13 Mar 2024 11:06:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfGy9ggOIvtr_-cd@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <ZfDMTlTH2SdwlB9M@x1>
 <20240313081303.DClwQrvb@linutronix.de>
 <ZfGqCWzyVzyGQrAQ@x1>
 <20240313134645.bO-XyxAM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313134645.bO-XyxAM@linutronix.de>

On Wed, Mar 13, 2024 at 02:46:45PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-13 10:28:41 [-0300], Arnaldo Carvalho de Melo wrote:
> > > One part I don't get: did you let it run or did you kill it?
> > 
> > If I let them run they will finish and exit, no exec_child remains.
> > 
> > If I instead try to stop the loop that goes on forking the 100 of them,
> > then the exec_child remain spinning.
> 
> Okay. So that problem only exists if you intervene. And you can
> reproduce this odd behaviour with my patches but not without them,
> right?

See the next message, I managed to reproduce that behaviour in a non-RT
kernel as well.
 
- Arnaldo

