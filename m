Return-Path: <linux-kernel+bounces-77298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BBD860379
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42C61F24937
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626F6E5E0;
	Thu, 22 Feb 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IipYHtpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC781DFD9;
	Thu, 22 Feb 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632443; cv=none; b=trxk4hWQf9fd4P8E3Lf62YhDiA2703viZJHQLRUKMg2C7h5f92onTOsPyJRGxxeVX0GFVSJvrnGWBZ0s/iRxQLVMn8Perl8WbQTK4+mTltCJCjkJSL9LW44japxmZT0/D/Dr5jCXJBfYCnnoccPsZfkKEgRmZ6lKcCsT6xoOWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632443; c=relaxed/simple;
	bh=KVIBnT2LtbhcVP80MhdOB/x/YdmrcAklBvoJsn7DqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CknjpuMxgkW6H5xlhKvxFthV4JE6To0d1ihY8ExkMq7hVjB0uKooWL48lvTFbrIuVGSPhh2xZS6O9oBnwc+e6Tw8GNgE2cIoKeXS01z2mbj4XHPTbdh30aRv+nuty+QwwLcUcb7gkJjqksmipmj5v0X49hFVUJjyv4NREj0OyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IipYHtpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25506C433C7;
	Thu, 22 Feb 2024 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708632443;
	bh=KVIBnT2LtbhcVP80MhdOB/x/YdmrcAklBvoJsn7DqUU=;
	h=Date:From:To:Cc:Subject:From;
	b=IipYHtpidMTbQoEZw7xa2XR/0ci+6GjBFLQy0jm2yAYyWUA9JIU3ZnpOMpAtOQFFa
	 wG88tHFznzmblRpm2W3+hoLyMVKiQ2HlMkbA/CsD6dUBmEIG/jkGlVCjsRc1GqDC7i
	 xkAy3jwoxMP4n4Sx2EtffrWmpaY3OMh3y0Okj+OX1L6Cdp2V/0pqrva/y3Ci1wV+n8
	 ymgVTMDNXpZ5nct9VNIk/EkG4K2HSAwn+LTOFCvzD8Ea6X8m2vESOGJ90yv3k1QUGS
	 DwBT9U0dKPFjdrUyYkGy/bgLpBvxJDeJPCclYgo6Mlu/Bz2khN29uPxfjJJVb9DZ3C
	 5HUnwJX9JPdvQ==
Date: Thu, 22 Feb 2024 17:07:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf test: Use TEST_FAIL in the TEST_ASSERT macros
 instead of -1
Message-ID: <ZdepeMsjagbf1ufD@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just to make things clearer, return TEST_FAIL (-1) instead of an open
coded -1.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/tests.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index dad3d7414142d1be..3aa7701ee0e939f7 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -4,11 +4,17 @@
 
 #include <stdbool.h>
 
+enum {
+	TEST_OK   =  0,
+	TEST_FAIL = -1,
+	TEST_SKIP = -2,
+};
+
 #define TEST_ASSERT_VAL(text, cond)					 \
 do {									 \
 	if (!(cond)) {							 \
 		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
-		return -1;						 \
+		return TEST_FAIL;					 \
 	}								 \
 } while (0)
 
@@ -17,16 +23,10 @@ do {									 \
 	if (val != expected) {						 \
 		pr_debug("FAILED %s:%d %s (%d != %d)\n",		 \
 			 __FILE__, __LINE__, text, val, expected);	 \
-		return -1;						 \
+		return TEST_FAIL;						 \
 	}								 \
 } while (0)
 
-enum {
-	TEST_OK   =  0,
-	TEST_FAIL = -1,
-	TEST_SKIP = -2,
-};
-
 struct test_suite;
 
 typedef int (*test_fnptr)(struct test_suite *, int);
-- 
2.43.0


