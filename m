Return-Path: <linux-kernel+bounces-132032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE078898EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE8E1C237F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A64E13440F;
	Thu,  4 Apr 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eo4MnR9z"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CBF15EA6;
	Thu,  4 Apr 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258808; cv=none; b=cJuSjmo1kDTs4M7OQkErn3U6IODHiU0P2vFPJ8Fdb53BW96uiPiLR4wcSB7tKYOg0ws3sDnrrr5Mvj38lxQeKtEUTE4pqCP2MUG9UH1epoiS/mM6xpYenW+o1jBtumcCdMH9R3fu8QkuaH+MqdMAwHnvxnkq7fg5K2bucI2hb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258808; c=relaxed/simple;
	bh=2lgKxpRtMWH0iH+ihkZown4poVg4tjlTUOWpwf4cYhs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LmwNI1H3pbzrjobvvQaMpzXEpIdd1/FY/412mXx6khsyfD4ueE996yZPlEELkBg7U06VzTtrR6qo0TOQZhY5IgUpgeSf7iARO3BSVtrygn4c5XA6eis7ofU/YsuL40XrQH8/tW8bObvpPpTlK9dAiWay5frQw2Ltj+gjsFwinds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eo4MnR9z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2B9A820E94A7;
	Thu,  4 Apr 2024 12:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B9A820E94A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712258807;
	bh=2lgKxpRtMWH0iH+ihkZown4poVg4tjlTUOWpwf4cYhs=;
	h=Date:From:To:Cc:Subject:From;
	b=eo4MnR9zzdAhZBzh1Wo5USgTxP8M+99fhIzMom79fgPkqfOxqqF/ocFwlO0d6p/pa
	 IhtAjk5ikMLuE8uOJCGUtzdsq4ffPf+F2jhW0xpqLFN7Ng0fYS/ok0/UbYcAERZlU0
	 dIYNJAFl3IMPzLteo+HzKmT5kKuhWZ5UaQgZi+3g=
Date: Thu, 4 Apr 2024 12:26:41 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Copying TLS/user register data per perf-sample?
Message-ID: <20240404192641.GA2628-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm looking into the possibility of capturing user data that is pointed
to by a user register (IE: fs/gs for TLS on x86/64) for each sample via
perf_events.

I was hoping to find a way to do this similar to PERF_SAMPLE_STACK_USER.
I think it could even use roughly the same ABI in the perf ring buffer.
Or it may be possible by some kprobe linked to the perf sample function.

This would allow a profiler to collect TLS (or other values) on x64. In
the Open Telemetry profiling SIG [1], we are trying to find a fast way
to grab a tracing association quickly on a per-thread basis. The team
at Elastic has a bespoke way to do this [2], however, I'd like to see a
more general way to achieve this. The folks I've been talking with seem
open to the idea of just having a TLS value for this we could capture
upon each sample. We could then just state, Open Telemetry SDKs should
have a TLS value for span correlation. However, we need a way to sample
the TLS value(s) when a sampling event is generated.

Is this already possible via some other means? It'd be great to be able
to do this directly at the perf_event sample via the ABI or a probe.

Thanks,
-Beau

1. https://opentelemetry.io/blog/2024/profiling/
2. https://www.elastic.co/blog/continuous-profiling-distributed-tracing-correlation

