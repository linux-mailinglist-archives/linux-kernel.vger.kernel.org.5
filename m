Return-Path: <linux-kernel+bounces-139343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBAE8A019B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0298A1F23586
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F871836E0;
	Wed, 10 Apr 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtFu6LwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A02181CFF;
	Wed, 10 Apr 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782827; cv=none; b=eXC8ONhbUq1eLQjNrcX9t9Mi5N0/tZC5HVUKgV1UZbjH3glI0wEZTpfmxp1ZamT6Zrg3Q/6jDvAVgg8/pNSayBF/0el8zDl1Bu3hg2IggoI6gGJ1gfi39SOpmpIMfR2FJzptD27vhwrlZYVAU//BZJ8h4jPJ6ZuI8Rx0Q7PdW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782827; c=relaxed/simple;
	bh=xJZ6Dd9iWj7YtydFi/8FqoYMITmH16JTKtZaGi8eKhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIjpJctqP3SnHl8RfQUcdyvunMQ+J1dotBPJbx/IGTlMLy6al75+RNjoQTKgYWWNJz0TcuX+2C66cNogG8Av0/Ci0W6vfX4uYNvLpnB07ucvDd0NmZzCyUd9/ZRb1wgEaTaQ/aZ4wd/rjX8tQr0/JBlJdMsZtiMOE33VMSAJUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtFu6LwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2092BC43394;
	Wed, 10 Apr 2024 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782826;
	bh=xJZ6Dd9iWj7YtydFi/8FqoYMITmH16JTKtZaGi8eKhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtFu6LwYciP/an1N3sZcbtVGMLzJ2mhFv5y3exZizAs2kt3imUVcm4p0FLMDeJ9bu
	 srBmJHKcwjYwXS073ngcVP1HKaXzlJb8X88xxWudfztH2c60slua3PEIiYdPiLtbpF
	 uzxxU2x92YFQP7WY+SctjWurFsHPnFffshlAZcp8Je4SJEmu9Lxi+Ek/bx6VDjWZVg
	 Porh6MAZzeLJ1OqHzDc6NfWkNWwgzpNIZY+e3X2m845JhFgAh3B7jKsKLx6XM9EX3B
	 iiaCh6YT/82GhDV/k5azsJ3DvrBlX9inWuds8QKAxd8UucarMvg7xLgfltGYFYLINs
	 nz99W2cXd27jw==
Date: Wed, 10 Apr 2024 18:00:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Spoorthy S <spoorts2@in.ibm.com>, Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf test: "object code reading" test fixes
Message-ID: <Zhb95zKXvVDtUljY@x1>
References: <20240410103458.813656-1-james.clark@arm.com>
 <CAP-5=fVgf3cOgbV1KGGLd5gykxT+BzuX1=XUsp+2BNUahGn6QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVgf3cOgbV1KGGLd5gykxT+BzuX1=XUsp+2BNUahGn6QQ@mail.gmail.com>

On Wed, Apr 10, 2024 at 09:17:04AM -0700, Ian Rogers wrote:
> On Wed, Apr 10, 2024 at 3:35 AM James Clark <james.clark@arm.com> wrote:
> >
> > A few fixes around the object code reading test. The first patch
> > appears to be unrelated, but in this case the data symbol test is
> > broken on Arm N1 by the second commit.
> >
> > Changes since V1:
> >   * Put data symbol test fix first so that bisecting still works on N1
> >   * Instead of skipping "test data symbol" on N1, add some noise into
> >     the loop.
> >   * Add a commit to replace the only usage of lscpu in the tests with
> >     uname
> >
> > James Clark (4):
> >   perf tests: Make "test data symbol" more robust on Neoverse N1
> >   perf tests: Apply attributes to all events in object code reading test
> >   perf map: Remove kernel map before updating start and end addresses
> >   perf tests: Remove dependency on lscpu
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

