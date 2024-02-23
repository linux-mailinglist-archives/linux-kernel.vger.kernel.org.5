Return-Path: <linux-kernel+bounces-78964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27138861B63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7361FB22D91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDACF142631;
	Fri, 23 Feb 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCvoK3Z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A284FC7;
	Fri, 23 Feb 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712249; cv=none; b=hdJXg1iECh58ynlf0i2N6F4cQ7Bk9OLGgVvk5wwG9i/EwAOqBKzhrZUeac6kpSa2IM30VtBuMAXxPBsPNsgpxIUmImnuyic/wtuZtMujLHIy6y8svOv3d+aVD0K8R98KvUrkPNp1ZEZJT0R8ygMVei8D2SN2j6qXozacX8WFAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712249; c=relaxed/simple;
	bh=DRqSQ0pDZgRhtbd5dKOxMnglSykvuaf8uOo29P/P4P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwKVCxqPLdMHer8gOG+2p4kKIrzchjqBEZ7JFXIk1yhbCwnVBg4JRcn4AMSqHwNdEE50k40LqWGNTGgq9kihh7IDMjfS2tqCMk3EsauWjvSHTK8I2lb3S8S97emVXJiDujId5Xe1GiY+H8cDiKFwg49Y2n1ZWSD6if9tIa2x/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCvoK3Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445F6C433C7;
	Fri, 23 Feb 2024 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712248;
	bh=DRqSQ0pDZgRhtbd5dKOxMnglSykvuaf8uOo29P/P4P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCvoK3Z8RKQMcPWZaiRJx0H09yzXJ+SwC7c5t5t89/3a0lFkHYQ2t1JDh5SwT1nRy
	 WOSJsrNWRFORKr+eZMYiEyf+b6G0+2WAe5Ah/PYBQwazTaNjTmnM/H6ExNHGlXlNdr
	 HMU8wsdyt5eeQ7Z27ZZtSjdi2wLRWYKSyJAJQBEhX2ok1vGysRPrEcQZ9Hp7LSnj+/
	 9IatqhXP7wxOtfibrs5ZGa9cH1qiy6QrEnTJSpeXlKboR5SjsOQBAqzjXloxNnqzpP
	 Agph922p/JcMDxuJWETLk+7gdEC+NEv5cUNbn2Uydjez1gSozlTt/Y1nNN7I0Q2cqD
	 9uQ+PTPiUQAdg==
Date: Fri, 23 Feb 2024 15:17:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
Message-ID: <ZdjhNG1T6j6miiYg@x1>
References: <20240221175210.19936-1-khuey@kylehuey.com>
 <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <ZdemibZepMqWvv6U@x1>
 <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
 <CAP-5=fXzidk9hLm5bek3q1crds4mEjdgpq=s0YCSzLCj1GtvzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXzidk9hLm5bek3q1crds4mEjdgpq=s0YCSzLCj1GtvzQ@mail.gmail.com>

On Fri, Feb 23, 2024 at 10:01:31AM -0800, Ian Rogers wrote:
> On Fri, Feb 23, 2024 at 9:35 AM Kyle Huey <me@kylehuey.com> wrote:
> > I think perhaps I'm barking up the wrong tree here. This seems like a
> > ton of work just to write a regression test. Maybe I should be doing
> > this in tools/testing/selftests instead?
 
> The problem is detecting support for the feature in the kernel. The
> BTF approach isn't that bad, a couple of finds, but I think in this
> case there isn't anything to be found to indicate the feature is
> present. I like the perf test as perf tests are a form of
> documentation. Perhaps just using TEST_SKIP here (rather than
> TEST_FAIL) is best and the skip_reason can be a presumed lack of
> kernel support.

But going forward the general expectation is that it should pass as
the feature _is_ present, isn't it?

- Arnaldo

