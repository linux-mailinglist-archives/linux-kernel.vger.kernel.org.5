Return-Path: <linux-kernel+bounces-160672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B58B40DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B5B284823
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36628DD2;
	Fri, 26 Apr 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGlFRNCy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F403125AE;
	Fri, 26 Apr 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163702; cv=none; b=DHJJW93zyxGiY3fsE/J0a8XSY6ABqCD5gggDy3ogZAwa25zfp2yANol1DRKmOB5uS/D7Vk67jXjesvWRbppl+Hbsqf923b2tHHsSyTU4Jjjn/6RJsDEKA2+5OvLRG1mQTvlp+jcnGAWHDKVEeXZ+AdMeBmaTM1Ok1jjl2njCaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163702; c=relaxed/simple;
	bh=WlLetHc67AjKN+Njhs8c+QzGc+WTaiJ32UG6ag4gQMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXpjPffLpZklO2Riz0l/hWmif7YtjcPMkhcapy/7KCFeUQUN1rGOml6DU4SoGlPlTMPFoq5GtSS4Bnj3K/A0hxP/uspdg7USJqmfm0XXl4AWTOL0EV5MVCc0koUQ23jAEizJ6rJshtAZPlcl+f1osY4h0t0tv4HJLC03q4iOWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGlFRNCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883BFC113CD;
	Fri, 26 Apr 2024 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714163702;
	bh=WlLetHc67AjKN+Njhs8c+QzGc+WTaiJ32UG6ag4gQMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGlFRNCypSphlrcFnfldK3JiJtId2WjLUDon8o1ndv2thzTC/N5HvKPMsA62Lx0Gh
	 fqZLxkjOq8mm+IFiaQaf8jrP4eb5MkvfgwrAV0IUCCmmi1tkCkGm0JmbAQQ8CQ4b23
	 jgoXz2nx3pKsZXsvbZ748SLLVkdX15AXLRXOQaM3GtIWuJfIIz/ekRLu0/b83pynHy
	 qGxDY9BlqtO4l3pgov8nVTiphsF0YB18jzvlAvuA7BqDQ24BsXNruWM0DmHpg1rDpi
	 aEnwKuTRtK6lpUoDzBTm8gxDLOejBnGJvKfrXZSnd1UyHtXNBITgXovFONDitwHgF0
	 fNGUocxPDdesQ==
Date: Fri, 26 Apr 2024 17:34:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V3] perf scripts python: Add a script to run instances of
 perf script in parallel
Message-ID: <ZiwP85A_ROwL_xJN@x1>
References: <20240423133248.10206-1-adrian.hunter@intel.com>
 <ZihFYbdrnarNFWOd@tassilo>
 <ZikT69GIsijZajoI@x1>
 <ZiuiiFdPhJIrjI7k@x1>
 <1e2bee89-0a4a-42e3-9f81-bd7296cfb351@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2bee89-0a4a-42e3-9f81-bd7296cfb351@intel.com>

On Fri, Apr 26, 2024 at 06:24:12PM +0300, Adrian Hunter wrote:
> On 26/04/24 15:48, Arnaldo Carvalho de Melo wrote:
> >   +       python3 "${pp}" -o "${output2_dir}" --jobs 4 --verbose --per-cpu -- perf script -i "${perf_data}"
 
> Sorry, didn't have shellcheck installed!

Its a life saver, when I saw what it found I slapped myself in the face
for having applied that patch ;-(
 
> Looks good. The shellcheck page refers to bash for "${var:?}"
> but it is POSIX too.

Thanks for checking! We really need more build checks like that.

- Arnaldo

