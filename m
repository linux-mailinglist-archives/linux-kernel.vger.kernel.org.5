Return-Path: <linux-kernel+bounces-31370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03559832D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8950EB22B22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064854FB9;
	Fri, 19 Jan 2024 16:39:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142654F1FA;
	Fri, 19 Jan 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682393; cv=none; b=UuWEJTKuwZoUlQ6eYcLuBYFpfO4gLXEj+h0LUadFyS09+lwZ/6eTZX/1tiAwqRHjAmzRc1QCNlZZOnv8uQcgsY6TR/p6YdpxGQnKpDGIPHEDeOPO0RQcEt5XpsJ9jrvMX/qtiiZEZbDnka2lITExJcTQqQmVP7LptrC+KF7GGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682393; c=relaxed/simple;
	bh=hRwFxaLVM/9prIFMvwSX+LskTGsLe2VRFiqmVSZ/hW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9DA8hrPkO6j8sHQ1myn8tAw64qXKwivHbNIEYbnxTcq6sZ+8juyN0540bIEFkSQr7fTHLyPrbstNecRkeTq5i22bXflZ0HdtNBUEDtluD/QbFdXSeLuBxR31ooRWqKw0TBQUzWkSY9hDERJW4p6HnUqPRtfXk1snc4IPvY7oeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 933021042;
	Fri, 19 Jan 2024 08:40:35 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4CFD3F73F;
	Fri, 19 Jan 2024 08:39:46 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@arm.com,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
Date: Fri, 19 Jan 2024 16:39:23 +0000
Message-ID: <20240119163924.2801678-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit so long 
as both inherit_stat and PERF_SAMPLE_TID are set.

Currently it is not possible to use PERF_SAMPLE_READ with inherit. This 
restriction assumes the user is interested in collecting aggregate 
statistics as per `perf stat`. It prevents a user from collecting 
per-thread samples using counter groups from a multi-threaded or 
multi-process application, as with `perf record -e '{....}:S'`. Instead 
users must use system-wide mode, or forgo the ability to sample counter 
groups. System-wide mode is often problematic as it requires specific 
permissions (no CAP_PERFMON / root access), or may lead to capture of 
significant amounts of extra data from other processes running on the 
system. 

Perf already supports the ability to collect per-thread counts with 
`inherit` via the `inherit_stat` flag. This patch changes 
`perf_event_alloc` relaxing the restriction to combine `inherit` with 
`PERF_SAMPLE_READ` so that the combination will be allowed so long as 
`inherit_stat` and `PERF_SAMPLE_TID` are enabled.

In this configuration stream ids (such as may appear in the read_format 
field of a PERF_RECORD_SAMPLE) are no longer globally unique, rather 
the pair of (stream id, tid) uniquely identify each event. Tools that 
rely on this, for example to calculate a delta between samples, would 
need updating to take this into account. Previously valid event 
configurations (system-wide, no-inherit and so on) where each stream id 
is the identifier are unaffected.

This patch has been tested on aarch64 both my manual inspection of the 
output of `perf script -D` and through a modified version of Arm's 
commercial profiling tools and the numbers appear to line up as one 
would expect, but some further validation across other architectures 
and/or edge cases would be welcome.

This patch was developed and tested on top of v6.7.


Ben Gainey (1):
  perf: Support PERF_SAMPLE_READ with inherit_stat

 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.43.0


