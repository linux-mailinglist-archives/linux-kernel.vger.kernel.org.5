Return-Path: <linux-kernel+bounces-103809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F087C4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29481F221E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C2768E7;
	Thu, 14 Mar 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyZOpcKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF47353C;
	Thu, 14 Mar 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452785; cv=none; b=p5NHG2XTCmoeebV0jWKcJynkrmrgdzTX7t6ykWidLkFxAbg3hyLL2tbiewmcYxNqp4XxsqU3dBS/d6symJ9xDml3+iNdxYQrg3qM9h2Kvwl25WEFRJXxO834oHW9WZON2hXlQst3yS63T7QRoNQHWbb29KArnOJvh/Bv2H5zAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452785; c=relaxed/simple;
	bh=K5BilDS17Npbpc53Aqd9Cf2INMeiMyEyXLe6XjTz3M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBcJnb822U2Y0yXLRM6g74dqq7rgQQ33H+yjc/bTxDo4X8E/EC48B24Bm5HKyIc45GqztmdCilEjdmGi3dR3wEjhj/HeKsR+gy6htpp1akAGh/pGvGYK6zSEhD7Ma+a4PUhxvrGsaux36I2+TtH812o+6YaTuQEzwUWTgeQs/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyZOpcKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E7AC433C7;
	Thu, 14 Mar 2024 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710452784;
	bh=K5BilDS17Npbpc53Aqd9Cf2INMeiMyEyXLe6XjTz3M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyZOpcKjip1OkLA5JpYNrlgh9e4GrDPk4POBs7RKVL9p6opHxyFSFGIbL0MeXk7Bf
	 OQPksKWwuIJco5ESo6+j6msYm3+KBbRc5c+xvWWYOhZBtgwftKYPu0J4MFjZ6cpTmV
	 FW3W/GtCV6sTh5czOjTUjU3glMfJc3BJcoVVTtLAWFHDzwVjzycCiL8Ci5NvjKXDgC
	 FdUYXSDK8+TWFA12NtcT7/gUAWHLzAZa28nxnCY8OJqomhxyMqmD1I+CIJXMaO/pUY
	 PJjuqeZ7BSjZqoN4jJ9IPU6ZPO4Tm1RoUecsDth+pLDx+oHpg6v+JGl0U+5LJi25nh
	 AUCH9QxERI0kQ==
Date: Thu, 14 Mar 2024 18:46:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marco Elver <elver@google.com>, Vince Weaver <vincent.weaver@maine.edu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfNwLfdOLBytjF06@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
 <ZfHw3J5PY6qy4mXn@x1>
 <ZfIIqcmRlrxwUFTn@x1>
 <ZfIJIfqeI9tWnnS5@x1>
 <20240314091033.woaK8h83@linutronix.de>
 <ZfMK_yTzxTQCMGZ1@x1>
 <ZfNqnjdR-0YEsSnb@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfNqnjdR-0YEsSnb@x1>

On Thu, Mar 14, 2024 at 06:22:38PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Mar 14, 2024 at 11:34:39AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Mar 14, 2024 at 10:10:33AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2024-03-13 17:14:25 [-0300], Arnaldo Carvalho de Melo wrote:
> > > > > tldr; No dmesg activity, no kernel splats, most tests passed, nothing
> > > > > noticeable when running with/without the patch with Vince's regression
> > > > > tests. So:
> 
> > > > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> > > > Too quick, now I'm testing it on top of torvalds/master, no PREEMPT_RT.
> 
> > > Just to be clear: You revert your Tested-by because now you test this on
> > > torvalds/master but not because you reported a regression which I
> > > missed.
> 
> > You got it right. No regressions, the code is good, I just need to test
> > it a bit further, with torvalds/master, without PREEMPT_RT.
> 
> Tests performed, no regressions detected, same behaviour when killing
> the remove_on_exec selftests midway:
 
> [acme@nine linux]$ uname -a
> Linux nine 6.8.0-rc7.sebastian-rt6+ #2 SMP PREEMPT_RT Tue Mar 12 18:01:31 -03 2024 x86_64 x86_64 x86_64 GNU/Linux

Re-reading this I noticed I really retested with the rt kernel, d0h, so
here it goes again:

[acme@nine ~]$ uname -r
6.8.0.sigtrapfix+
[acme@nine ~]$ set -o vi
[acme@nine ~]$ perf test sigtrap
 68: Sigtrap                                                         : Ok
[acme@nine ~]$ cd ~acme/git/linux
[acme@nine linux]$ cd tools/testing/selftests/perf_events && make
make: Nothing to be done for 'all'.
[acme@nine perf_events]$ for x in {0..100}; do (./remove_on_exec &); done
<snip>
ok 4 remove_on_exec.exec_stress
# PASSED: 4 / 4 tests passed.
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
#            OK  remove_on_exec.exec_stress
ok 4 remove_on_exec.exec_stress
# PASSED: 4 / 4 tests passed.
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
#            OK  remove_on_exec.exec_stress
ok 4 remove_on_exec.exec_stress
# PASSED: 4 / 4 tests passed.
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
[acme@nine perf_events]$

So despite this mistake all is well, torvalds/master + your patchkit
seems ok.

Sorry for the noise :-\

- Arnaldo

