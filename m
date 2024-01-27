Return-Path: <linux-kernel+bounces-41372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CB883EFBF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76BF28398F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665482E62D;
	Sat, 27 Jan 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV4hLgFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F12E832;
	Sat, 27 Jan 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383858; cv=none; b=Av1W63y7o+dcmnvAzl95Lpo9IOU2eqzYcwD+j6RkijL/AU2e01udVF08QKZt91DcQqgadvRLbiOunhUShIvttWMiTOHqiTawpuOjrrK2psAyuNN697xDTsjYzdor0w1PFLqFxpMu7ra6GLoulI0r47FOqHm3FmdpQZs5XONaNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383858; c=relaxed/simple;
	bh=jpSz+9HoQ20a03AqhQ+2jQlTm9eUGl7jm8uBou5eYtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW9M4fUCfw7dS2PsL9pFJN/35brSuCumdbdmF8Ujy0Nu4g9SMX4EgpFobNlGw8HsC0g5mnlEfOvQtS4Jc+YtawaocbPfBlsWyLWWlRjRmMFQQilxDFAYg16M2T4ZU32lp2DXsxDGzqlX4DnoaDcfUaIfuzhbM8Jw2lbb6sQikL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV4hLgFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED792C433C7;
	Sat, 27 Jan 2024 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706383858;
	bh=jpSz+9HoQ20a03AqhQ+2jQlTm9eUGl7jm8uBou5eYtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fV4hLgFdAa09oj3pNJ9e+Rxeo7Usg7KxUWlGBqEd5pgESG6U8zd1Zt8YDnb+8vi1I
	 FvuIpsLUobbqcMfDmjHvzSpTg1Go0bOU9PaEGB1fSIEpivQmRrvJAnYQsekdwUeSSV
	 pLhRN4Iff8229cCZX62I92zbJVJOKgnb6BhOF674eYPUDee46oegIL8aW2IX4aNiQl
	 Hh9d0vW1jbHTbzf6dBgDN1rvqumpgNEglYBvow5SwKFxyL2ASZQTYX+D5yLVm2IxTi
	 Ao9rWz4tfPBpvdzPq3CZ9IV8fhTFU4tYxtv2iqjn8D6Us1YYUSQ+iweVGR7cCTz+Kl
	 Gl+HqnIgOukYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C759640441; Sat, 27 Jan 2024 16:30:55 -0300 (-03)
Date: Sat, 27 Jan 2024 16:30:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: "perf test 103: perf all metrics test" failing on hybrid i7
 14700k
Message-ID: <ZbVZ75hvYSzS3ReL@kernel.org>
References: <ZbVYhxQzodvh5Cob@kernel.org>
 <ZbVYqYEw_w4eTSdf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbVYqYEw_w4eTSdf@kernel.org>
X-Url: http://acmel.wordpress.com

Em Sat, Jan 27, 2024 at 04:25:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jan 27, 2024 at 04:24:55PM -0300, Arnaldo Carvalho de Melo escreveu:
> > FYI:
> > 
> > root@number:~# grep -m1 "model name" /proc/cpuinfo 
> > model name	: Intel(R) Core(TM) i7-14700K
> > 
> > And see after that another hybrid machine, a Lenovo Thinkpad Carbon X1:
> > 
> > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > model name	: 13th Gen Intel(R) Core(TM) i7-1365U
> 
> Ah, this is with was in perf-tools/tmp.perf-tools, that I'm prepping up
> to send for v6.8-rc

This one cured it:

Subject: Re: [PATCH v1] perf vendor events intel: Alderlake/sapphirerapids metric fixes

- Arnaldo

