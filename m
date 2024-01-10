Return-Path: <linux-kernel+bounces-22743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A838B82A265
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1DB1C2273B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7C4F1F8;
	Wed, 10 Jan 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GLJjG5We"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845554EB3A;
	Wed, 10 Jan 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1704918567;
	bh=T6deM4osMEepfQzRoS3xgD+glMc0CV0CFBWLsF6m4ww=;
	h=Date:To:From:Subject:From;
	b=GLJjG5WeO8X3W70jsA/NyJwIMiZqEYR3b/Eosv2lOP/oNagY/WNBO4tRmYcQ5GzHV
	 T3BsYKTSKJfXMUvYwmFZj4UtCNxMLKvJihjipy4iBSxE/tc7GwtiOtWnhkmMjosiqP
	 IUw6pKst1LF2F/5KLQ8TTdMX19wJle3Ku+aptuJjwkH1wwppGIKjgBVRcEDRT3IPD1
	 9Wco83Nfb/5XPcLwBdcZqGcUcIGEOjdltjNWqSQJjdOQ7HccW/vFsD1LrYYD5gZNcC
	 mhuyJW/26Ox/5Is/4kuVTMnLXhNl1qmBIlpyPBaNbD6dG+VBkiadVz0hy6ovyinaxO
	 JLKAZBRaD7Wuw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4T9KCW6Cj9zKL0;
	Wed, 10 Jan 2024 15:29:27 -0500 (EST)
Message-ID: <26640415-9822-45d3-a713-060726de2166@efficios.com>
Date: Wed, 10 Jan 2024 15:29:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.12.9 and 2.13.7 (Linux user-space tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

* New and noteworthy in these releases:

Specific to 2.13.7, a fix for misaligned urcu reader accesses was
introduced. It only applies to the lttng-ust 2.13 branch because
it implements its own "lttng-ust-urcu" flavor.

Also specific to 2.13.7, "sync" vs "unsync" enablers are introduced
to eliminate an O(n*m) algorithm:

     Eliminate iteration over unmodified enablers when synchronizing the
     enablers vs event state.

     The intent is to turn a O(m*n) algorithm (m = number of enablers, n =
     number of event probes) into a O(n) when enabling many additional events
     when tracing is active.

Specifically in 2.12.9, the rfork() wrapper is fixed: it was not
passing the flags arguments. This was fixed in a larger commit
in the master and stable-2.13 branches.

Both stable branches include:

- a build system fix for documentation examples with old autoconf when
   used with a relative path.

- a clang warning fix around volatile qualifier on function pointers.

- Python agent uplift to adapt to modern python (>= 3.10),

- a possible race condition in the ustfork helper.

Enjoy!

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Detailed change logs:

2024-01-10 (National Houseplant Appreciation Day) lttng-ust 2.13.7
         * fix: invoke MKDIR_P before changing directories
         * fix: -Wsingle-bit-bitfield-constant-conversion with clang16
         * fix: clean java inner class files in examples
         * Introduce sync vs unsync enablers
         * Fix: misaligned urcu reader accesses
         * ustfork: Fix warning about volatile qualifier
         * ustfork: Fix possible race conditions
         * Fix: tracepoint: Remove trailing \ at the end of macro
         * fix: python agent: use stdlib distutils when setuptools is installed
         * fix: python agent: install on Debian python >= 3.10
         * fix: python agent: Add a dependency on generated files
         * python: use setuptools with python >= 3.12

2024-01-10 (National Houseplant Appreciation Day) lttng-ust 2.12.9
         * fix: invoke MKDIR_P before changing directories
         * fix: clean java inner class files in examples
         * ustfork: Fix warning about volatile qualifier
         * ustfork: Fix possible race conditions
         * Fix: FreeBSD: Pass flags arguments to rfork wrapper
         * fix: python agent: use stdlib distutils when setuptools is installed
         * fix: python agent: install on Debian python >= 3.10
         * fix: python agent: Add a dependency on generated files
         * python: use setuptools with python >= 3.12


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

