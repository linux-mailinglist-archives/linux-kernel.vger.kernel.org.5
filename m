Return-Path: <linux-kernel+bounces-48874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE3846295
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194CD1F22711
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DBA3D3BC;
	Thu,  1 Feb 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au47RHpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071433CD2;
	Thu,  1 Feb 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822801; cv=none; b=NDQqjifASyKHq1OJnAU2YWJaCBN8hYJQlWHaY84IbDF8NyrxNuGB5PjANk55zsCcyd702yRfOvaLexRgneQAa293J2dv7FQRxfxkT9FE8oPdOWObFhxXHkI+tH6A6bQThfNUdfqpNOwx79hsHdxNwHR4PPGIWtPdxT76HdJnibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822801; c=relaxed/simple;
	bh=uHXO8vBspe4hFpG6HIUx8f6zPOoaQs4CBNh78fDVPR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV4aYwmLZC6oX0HHxxKoVK+SIYdCj3nxRW9Oti3Po1c5f7z4qbmm6GG5Qtnie9FV6tQCUmF6CHESl0CF3eXJ07usfvMC4wBmEdAYLMt3jqdgQAs/8j/rikoS+T22LcEXrVv5fYOiqcjL40VtyDK/TizucMAqwpvjD+z6MmHYykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au47RHpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748AFC433C7;
	Thu,  1 Feb 2024 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706822800;
	bh=uHXO8vBspe4hFpG6HIUx8f6zPOoaQs4CBNh78fDVPR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=au47RHpeuUZIx6x/nrtitp67X0IVcQg2CWujI0/JaCCZgoM80ZGI8XE27+Wv5aYZ0
	 wJF+4gMF8l2kX7fzmDOiGAVfZaXmMb1IPdwDBBp65rovINxHmjFmbI5lZSn/lYPFEd
	 IUMmoxs1Zl2gTGKW+RzmP/w8wpdrPNncku0PCQBVLIAbH07BSqWFTBDK3gvj6g89hT
	 VsCNDrBa+H6Q0BQrkxry5c4OpPv3cqird0Y9+wsrerl5JLHl1r/1RxasNnxvRDdLFD
	 hUXCLalkiGjAlI8AhZfCeHqePwXkumDUbnzdf66ispj/cWnu5N77HUWtSEpn6O5AP/
	 i0HcjvzsLu9Aw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id EED7840441; Thu,  1 Feb 2024 18:26:37 -0300 (-03)
Date: Thu, 1 Feb 2024 18:26:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
Message-ID: <ZbwMjWO-AD1eB1a_@kernel.org>
References: <20240201202254.15588-1-acme@kernel.org>
 <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
 <ZbwJrkkQbUxw-hyb@kernel.org>
 <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Feb 01, 2024 at 01:21:16PM -0800, Linus Torvalds escreveu:
> On Thu, 1 Feb 2024 at 13:14, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > I should've known better and not send the noisy JSON changes at this
> > point in time.
> 
> Arnaldo, it's not the JSON changes in the history.
> 
> It's the absolute garbage in the *tag* itself. It's crazy. Do this"
> 
>    git fetch   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
> perf-tools-fixes-for-v6.8-1-2024-02-01
> 
>    git cat-file tag FETCH_HEAD
> 
> and see complete and utter garbage in the tag contents.
> 
> Note: that is not a change *made* by the tag. It's literally just
> garbage content in the tag *message* itself.
> 
> You have something *seriously* wrong with your scripting or tag
> creation workflow.

Ok, I'll check, as I said I switched machines, I must've screwed up
something.

- Arnaldo

