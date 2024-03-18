Return-Path: <linux-kernel+bounces-106195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCB87EA93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72882817CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E94AEF1;
	Mon, 18 Mar 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+E2ve2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4E84A990;
	Mon, 18 Mar 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770885; cv=none; b=kLMX/eEnZI5iUHlco6u7gx2QGYQzKZu85UWwNQvgM1ZPoRVQkCXv6qAhZKmsACg9ozUM7lQ9BtpAFcyE9kVppRg4Dnv2qY/hsDqu/OZxV2kk+/GFMuW6HhnokdPq/sCoRWcdH1/vkylnLIQquVjBXXk87h8jIZq3wsdXxlyIhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770885; c=relaxed/simple;
	bh=0JUlQ9a4hnzd0bcr6tsbH/TQVpStPCr5iwkXDPIWGTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOpueVICeVqEn+YfymF4VkFecLKT5Y2Scw0Dkn9IOXtIa6yDqSd+V6OTLSedDXC4LEii+4eD7LMREmZtmbIgQs7K9t/xqQXfNP52okLbNX9LWgStiZpNVsWOQ1ZlbrYjcL6EDmqOgwq/rZQGk9O7kp2UPBeQNsZzvSpCJCx7Ahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+E2ve2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210C5C433C7;
	Mon, 18 Mar 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710770884;
	bh=0JUlQ9a4hnzd0bcr6tsbH/TQVpStPCr5iwkXDPIWGTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+E2ve2bvPshScJQ3QReFb80pLA7KO/uuvMrZE3Mabc3IOn1zDyrSpLn45KMZmccw
	 sWaPXWoQOVEZQzLfW9qHaLgB36mCo4bcTI5B9LPzkpEAFeHwhyiNnj+tAWOrvyn7a9
	 PR2VQwm2OBXUPrsCwW09M2pSej9smIgjaccfhElQ+Ef6E+BXsetJUYJe5zOmBFqEYY
	 oIiBijqYOXW8ChSFx9Vv3FnJpR9aeLSIbOfijgjOCt88Nsa8hP5l2ZJ6WEHuZiggjo
	 c1qv9th/x4SPXlZJ4WB/8s6izRDlLsqqNfREd5LjEjK286doMRbDFIe/8u9wdtmfjR
	 NJGA0ojhqxKLg==
Date: Mon, 18 Mar 2024 11:08:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
Message-ID: <ZfhKwM9DDMMMNs5u@x1>
References: <20240226201517.3540187-1-irogers@google.com>
 <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
 <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com>
 <2b950564-fe20-4426-ac91-5b40a2087099@linux.intel.com>
 <CAP-5=fURvd4nx_-QLgRBWSoJbXDUqO=WbsLkqMgjiyucXHVrjw@mail.gmail.com>
 <ZfSvwBQRBhfWGb98@x1>
 <CAP-5=fUxw21-1SXBbaPoGgvZv98E5k+V6KGM41e=8XTFhyQohA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUxw21-1SXBbaPoGgvZv98E5k+V6KGM41e=8XTFhyQohA@mail.gmail.com>

On Sun, Mar 17, 2024 at 04:04:17PM -0700, Ian Rogers wrote:
> On Fri, Mar 15, 2024 at 1:29 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Feb 28, 2024 at 08:12:10AM -0800, Ian Rogers wrote:
> > Please clarify if this remains reviewed and should be merged as-is.
 
> v2. is already applied in perf-tools-next [1] so we don't need v1. Thanks,
> Ian
 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=dd267d056fed323f1684fa52d2a864fc93ca3be0

Ok, thanks for checking.

- Arnaldo

