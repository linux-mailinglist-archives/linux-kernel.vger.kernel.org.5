Return-Path: <linux-kernel+bounces-128669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DD9895DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE935282A66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6BA15E1EE;
	Tue,  2 Apr 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCfTRQNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16A15DBC5;
	Tue,  2 Apr 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090413; cv=none; b=e2mBIYXMyuIXdsOqNlOl0NMlogllkobIKPlt/CVglCgttL4LzH5eb4j3rPhxROAHnNigTihZT0YlAO16WSjGdG6lfnikt9Gm1MenOcS8ioaB2qUFLczGiCyc1CTzrbVWvtgu1YbEvGJ/bd+Qgp9zaTXiRrZhVk0DIpyW9N5Ugpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090413; c=relaxed/simple;
	bh=QDZNTpJuyP7aLWGIsgsagZLgjLOYqAjgx9+HQirqdUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phIGmkgPAJVbL1wDeIcvGjyLkd3gG+JYw7yKnNVSY2Fo/HLVmKo5UUHRjZ3STqhPkHUimsNuA3vokk3FIGoQEZbdZtt4fkeqDL5AfEoWfcz+LG+G6mpALfDVOGuyKw5hOuI8f3MzUESkHhKLqiAYRE26eUvSFQEKUl3ufHrxcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCfTRQNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32EC433F1;
	Tue,  2 Apr 2024 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712090412;
	bh=QDZNTpJuyP7aLWGIsgsagZLgjLOYqAjgx9+HQirqdUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCfTRQNGK7CwcA16/gLj36P5+CX840TopJQPgiksEHuMhwe4k5ktDeorHs5+JnnV4
	 7IWvIXOFyytRM84h2HGU2Oi3tA7Fkskp4IMbSgrkzP6zbmacT33vmeY0hV6igvF0su
	 zveS1PuBndJyZO4QaS8RtKp9a0mCUfC0vsxHDPoFa1NWGHOMXmut6gyEuUjUv7fdsJ
	 1Z1H0QcGv1/iy8ICihNbBsL2+TgQYYll+z+aEXqrvpCNMZzrKXpw6K7WBNEcROt44M
	 JACSMG9y8LbN1fz612F2SrG7dwWhVSQcgbtv8IklbSM3p2eaFRXTssi50FS05YfZIe
	 RIS9qnHvdZmZg==
Date: Tue, 2 Apr 2024 17:40:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf annotate: Get rid of duplicate --group option
 item
Message-ID: <ZgxtKVSwAbFXK01k@x1>
References: <20240322224313.423181-1-namhyung@kernel.org>
 <9cfa43c3-3698-455c-8a2f-85c30470733c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfa43c3-3698-455c-8a2f-85c30470733c@linux.intel.com>

On Mon, Mar 25, 2024 at 09:56:50AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-03-22 6:43 p.m., Namhyung Kim wrote:
> > The options array in cmd_annotate() has duplicate --group options.  It
> > only needs one and let's get rid of the other.
> > 
> >   $ perf annotate -h 2>&1 | grep group
> >         --group           Show event group information together
> >         --group           Show event group information together
> > 
> > Fixes: 7ebaf4890f63 ("perf annotate: Support '--group' option")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> For the series,
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

For 'b4' sake, next time please send the Reviewed-by to the cover letter
in the series so that it picks your Reviewed-by for all patches, not
just for the one that you replied to, as in this case.

I'm adding it to this whole series,

Thanks!

- Arnaldo

