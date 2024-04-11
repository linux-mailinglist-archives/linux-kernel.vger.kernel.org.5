Return-Path: <linux-kernel+bounces-139714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F398A06C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C2F1F23425
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5C13BC0F;
	Thu, 11 Apr 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IARPqoAe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1B13BADD;
	Thu, 11 Apr 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806378; cv=none; b=kz3FAmbE94M4Bb5rNwGC6Z+yn6IenCe8iVWl89oaLasvi76hbKlbAcJ29isuvpJJiK9ALuQawSqnr/d6nIcdvJggg7g0uNIFEKyq+ic3M/D/6/CmJPuAAgdhoiTjBWjubRlx1vUTn4/+2rHfLCYcAMy/eTgc+mQ0X+s9hks1ui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806378; c=relaxed/simple;
	bh=iOCpCDUmajHA6Opq8WcJ6PcQv4ZZHQHjuT0DJJ405iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngQZZ1Ex0tp/+NFYtQCc91Kb5PnsxMPlHva3IbXUdfI4jirExbcVG9PBcZdj0XjjzBiRZFQVwuTnAbvHpLi2WNnMFJczcyx2rhajsTAIPDdGiUPUJ9zoVHpCZGslj29Ei3m+Yy5tcMEaJSUant8gQHhtabR/km8z2s+hSE7veyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IARPqoAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA353C43390;
	Thu, 11 Apr 2024 03:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806378;
	bh=iOCpCDUmajHA6Opq8WcJ6PcQv4ZZHQHjuT0DJJ405iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IARPqoAeSRKcC1Y/goOtmb1IXci4uqF1C+BFBtBbFMGbU+WJmJ32+/7bWZL/1l3Wl
	 s3UYT55fYjsEDDskCZ4uGI4QJS2U0te/kzJVLdKZGJYmBHormQgU7PW2KMtVDj6yoP
	 ZHeqxprPyDPYZNIUpr1fZfAF+J2J8C1tNKIUAy8E7fmWpqzzaRFLxGwQJ34uzfYtIB
	 1sSo7X9cmxyjup4cRTaw57t5oI46vEZ/n4iCpBVvJeA6PWayIRF4xsMz2AeH/8ErGc
	 Dug1bwnKPRjMPk+8S/lk6pCnpq/3WAGsQGpOX2YOx9BhxQqYdZow3cRnjpi2IzIAoh
	 6JqfpOsOMBCzA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/7] perf annotate-data: Skip sample histogram for stack canary
Date: Wed, 10 Apr 2024 20:32:50 -0700
Message-ID: <20240411033256.2099646-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240411033256.2099646-1-namhyung@kernel.org>
References: <20240411033256.2099646-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a pseudo data type and has no field.

Fixes: b3c95109c131 ("perf annotate-data: Add stack canary type")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 11da27801d88..ec79c120a7d2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2399,8 +2399,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		mem_type = find_data_type(&dloc);
 
 		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
-			mem_type = &canary_type;
-			dloc.type_offset = 0;
+			istat->good++;
+			he->mem_type_off = 0;
+			return &canary_type;
 		}
 
 		if (mem_type)
-- 
2.44.0.478.gd926399ef9-goog


