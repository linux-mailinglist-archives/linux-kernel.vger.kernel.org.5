Return-Path: <linux-kernel+bounces-148891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3F8A889D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CFB28683C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F41487E4;
	Wed, 17 Apr 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4yCazdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571F1487E2;
	Wed, 17 Apr 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370537; cv=none; b=LF4xZ0b0wqVjgiVErIZ0cS+iLEPmzusjKsw2MI49gGEFfXWh/oEGbBh8K5q+gHX4XfMxjL87wnxnirzl/th8pTTVv18KpYobuiB2ELWD/uZ0GmBTQ8Xv6CQUI380jSmTV7NoUwpbTcqqhv9OGKSQaG9qFr/zh34k8qiVtXYJ2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370537; c=relaxed/simple;
	bh=FTzmG7MPyh44PqEdk5C7BCbIh1HKSVVdYFoDXul9zXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erxSDky6oJhoEMR+aM5Xra2ujpWNDw5H925w4JW+OJKHmcBDjtFXczQSZOUxJGdDHk+kmK++rWB/KQCBgw7lA8zJRdtYZdkEuBcnD79T34bhAg+Y56que4t50HRgdvkpHFpUlCvg39V81ubgmdyU7J9GbJnwR2SMLIXj+/t853E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4yCazdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDA6C072AA;
	Wed, 17 Apr 2024 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713370536;
	bh=FTzmG7MPyh44PqEdk5C7BCbIh1HKSVVdYFoDXul9zXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4yCazdGVtfBCjw8wIQJhHOx9X8gjbUTqm4NTsff6F+5rsMIhth6BK/sGLfu43Gk6
	 lJ011ARgfnxYojR/y86+K0q05tGYTGvUV2KyMQWP00Lnu4pNKcbrdYJPWTC6/QUyE0
	 xtdA/vyTDZ9R7jnEZL61wfx8UStwZwWr/WIadeC4hon79+bkk8BcYq+N46YVyXIheW
	 +Qm92vbyG2duolQ9RIHp0rr/fGDEjAvTK7jHUHfEtYj2wrg9r4tkhj0gVFeYGjtolr
	 3Heyb9pFOU7Xf9RtmyTpM6ut68keRoVigGHBUvd0hWw9MOzxApzWf4TdNxloGW5Edc
	 XPFe0g7i9LAvg==
Date: Wed, 17 Apr 2024 13:15:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Increase buffer size for Coresight basic tests
Message-ID: <Zh_1pR9nK1d-bivl@x1>
References: <20240326113749.257250-1-james.clark@arm.com>
 <5a4023aa-af9b-48d2-84f3-a0b9b30dc54e@arm.com>
 <7f5c32dd-edc6-4b53-9cdd-780756f5536c@arm.com>
 <369b29bf-66d8-4876-ae0c-a35f3c46973e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369b29bf-66d8-4876-ae0c-a35f3c46973e@arm.com>

On Mon, Apr 15, 2024 at 01:55:25PM +0530, Anshuman Khandual wrote:
> 
> 
> On 4/12/24 13:52, James Clark wrote:
> > 
> > 
> > On 12/04/2024 08:04, Anshuman Khandual wrote:
> >>
> >>
> >> On 3/26/24 17:07, James Clark wrote:
> >>> These tests record in a mode that includes kernel trace but look for
> >>> samples of a userspace process. This makes them sensitive to any kernel
> >>> compilation options that increase the amount of time spent in the
> >>> kernel. If the trace buffer is completely filled before userspace is
> >>> reached then the test will fail. Double the buffer size to fix this.
> >>
> >> This is a valid concern to address, but just wondering how did we arrive
> >> at the conclusion that doubling the buffer size i.e making that 8M will
> >> solve the problem positively for vast number of kerne build scenarios ?
> >>
> > 
> > Nobody else has reported anything yet, if it happens again we can always
> > increase it again if that is what the issue is. I had most of the kernel
> > debugging stuff turned on like memory debugging etc, which is probably
> > why I ran into it and 8MB fixed it for me. So I'm not sure if there is
> > much more that could be added.
> 
> Makes sense,
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo

