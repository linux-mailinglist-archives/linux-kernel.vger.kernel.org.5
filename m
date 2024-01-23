Return-Path: <linux-kernel+bounces-35682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2C839516
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7DD296859
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6064080050;
	Tue, 23 Jan 2024 16:39:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2480034;
	Tue, 23 Jan 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027958; cv=none; b=IMuMA8+saxCvCdKq624fWtVJE8nBPqjP+pipFTxGondv+ZmjUJMDCGUmOnss7CW6IqzbDBz9TOq1fK0Qxcc7njTjUhVhiftFUwzwtM2sK/6pQCT9Oae5vdgTdyXTt1F7ry2uyO42LRZ7HfT+8FPu3dZZAmHWoXLylyZb5Q1AHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027958; c=relaxed/simple;
	bh=Y0y9EQrax0annxGXKzptQ0MkdIKONr0Czi0BUW7Zw2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMEYP9Se0lwIVSZlZbKjdkRt2k+NVxptMUxb5OEiIEzpspDncoyIRezG0C5wYYOKRMh/cP+J5PVYeWj9gOF7rN+iV5PzHilT0KuVHPr6fGO/BQxP7LxNukif4/VtXlI8vS+zVvQDtrhpCUBN1qki6rhBQPeUMgNCmA1mTf1jY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC624FEC;
	Tue, 23 Jan 2024 08:40:00 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 559663F5A1;
	Tue, 23 Jan 2024 08:39:13 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Spoorthy S <spoorts2@in.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf version: Display availability of HAVE_DWARF_UNWIND_SUPPORT
Date: Tue, 23 Jan 2024 16:39:01 +0000
Message-Id: <20240123163903.350306-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123163903.350306-1-james.clark@arm.com>
References: <20240123163903.350306-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though unwinding depends on either HAVE_DWARF_SUPPORT or
HAVE_LIBUNWIND, scripts testing unwinding can't just look for the
existence of either of those flags. This is because
NO_LIBDW_DWARF_UNWIND=1 can disable unwinding with libdw, but libdw will
still be linked leaving HAVE_DWARF_SUPPORT turned on. Presumably because
it is used for things other than unwinding, so I don't think this needs
to be fixed.

HAVE_DWARF_UNWIND_SUPPORT already takes the combination of all those
things into account, and is used to gate the built in tests like "Test
dwarf unwind", so add it to the feature list output so that it can be
used by the script tests too.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index ac20c2b9bbc2..529e9ce8c46c 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -82,6 +82,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBPFM, libpfm4);
 	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
 	STATUS(HAVE_BPF_SKEL, bpf_skeletons);
+	STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.34.1


