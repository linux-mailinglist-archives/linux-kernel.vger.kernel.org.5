Return-Path: <linux-kernel+bounces-160209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C859F8B3A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D01281B30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1A14A4E9;
	Fri, 26 Apr 2024 15:06:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512414900B;
	Fri, 26 Apr 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143996; cv=none; b=d/1L6GdNNiYfIL04KhO3rZOHCsLKyGUIupmVBgc9SGmyvgJ87S28RYcagO4H/pbS6JiobrgdhjM4fTQtc1ElS/aBK3yQRvEcYM8mne9PBvdub3E47/FfW0ccTcLMbl4nWgN0a5xT0zwXKMkDH+ZW47qXPtCmHhmzDmqB1jmr+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143996; c=relaxed/simple;
	bh=LNCspRv71TcIP3ZbJ/TMAX90WJJx42Sm7l811YLKB4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hUE1+WyENVgS8He6/f2htAGr+Gxdq9PFsQtKGycvi0R0YP8k/GhtzaDqCYA+M/IkXNOoYr00riEyY4eacb4kq9Q3JfsTcvDZFACD25csJMWyrLEQPL0vsXWrH+Izja4784/2OwrarmBfkohjFcQVeh1WVJ449ez8PejqtqOxuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460FD1007;
	Fri, 26 Apr 2024 08:07:02 -0700 (PDT)
Received: from [192.168.1.216] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C09AC3F73F;
	Fri, 26 Apr 2024 08:06:31 -0700 (PDT)
Message-ID: <3e54fea7-2a37-4774-8a6a-85f75cc4a9ea@arm.com>
Date: Fri, 26 Apr 2024 16:06:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tests: Run tests in parallel by default
To: Ian Rogers <irogers@google.com>
References: <20240301174711.2646944-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240301174711.2646944-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/03/2024 17:47, Ian Rogers wrote:
> Switch from running tests sequentially to running in parallel by
> default. Change the opt-in '-p' or '--parallel' flag to '-S' or
> '--sequential'.
> 
> On an 8 core tigerlake an address sanitizer run time changes from:
> 326.54user 622.73system 6:59.91elapsed 226%CPU
> to:
> 973.02user 583.98system 3:01.17elapsed 859%CPU
> 
> So over twice as fast, saving 4 minutes.
> 

Apologies for not replying earlier before this was applied. But IMO this
isn't a good default. Tests that use things like exclusive PMUs
(Coresight for example) can never pass when run in parallel.

For CI it's arguable whether you'd want to trade stability for speed.
And for interactive sessions there was already the --parallel option
which was easy to add and have it in your bash history.

Now we've changed the default, any CI will need to be updated to add
--sequential if it wants all the tests to pass. Maybe we could do some
hack and gate it on interactive vs non interactive sessions, but that
might be getting too clever. (Or a "don't run in parallel" flag on
certain tests)


Thanks
James


