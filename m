Return-Path: <linux-kernel+bounces-104911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48487D59B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBF0286865
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A05DF15;
	Fri, 15 Mar 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+PAoiOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9B5490F;
	Fri, 15 Mar 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535727; cv=none; b=tGQESfRf8V59TCozNgtWUSv+3isOHIQpuRzQcJoZDqt6ZDYYsyQF//huYFCLO6sdj/tGjKRkaCoEtWd3+r5Zwu5jo0FKKe9GL8i6+9zEPIU5ZgJpRF/smoa55FURMOpD9m0lSmLPVMV/VAjwW3aR1M+K7DYenjLOeRKEu+Hzyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535727; c=relaxed/simple;
	bh=KSHcMin1HPdOQAKKTc/0Gi9jbVVIAh8wdEBxTZxd8vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1vt03JPg8dedTAnJYGPBen1dV2wm9vwYVIL6JH+j9tNC3PpAyKuD3TXQVRWK3xNC4qZMMwxTjEtRTsg50+MYve1/579Be5ya7M3Rp/N+kPApYfvfkQeTN0s7sHMawiG8gMGvbidvbzjtInERDCaVowEKIBDPiWjfZrmbevja88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+PAoiOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B7CC43399;
	Fri, 15 Mar 2024 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535725;
	bh=KSHcMin1HPdOQAKKTc/0Gi9jbVVIAh8wdEBxTZxd8vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+PAoiOkYhVyhGpZ0AAZ8iuIAfpf4TbBUA4YRP1DN9F4VZEK453QOT/pKSAdKeNYo
	 DTr4/SGK459fS/hgfnXoaHLvqQE4V5AjR5l6V1xcytpm8gI0UzjO16/NKScBHOkePj
	 973usPZF/KrO6U2QLye0pUV6VnaFaS3rU8tQab6q0dHeq80lJPSfxhJ1pjC5/r/6rD
	 BCoZmUUZ9ErU4SC3MxuqKNqgH1uz/wki0VhqMrRVEb1auv7a/Xzuf+H71zqkCiYSfc
	 BGJgc9g1V//xBeEJJve9FcxZAStCJfFkZsfIL656PYzcozs38ELP3F+6fWR6toYmWr
	 FZsXSeXSveBDw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/5] perf beauty: Stop using the copy of uapi/linux/prctl.h
Date: Fri, 15 Mar 2024 17:48:31 -0300
Message-ID: <20240315204835.748716-2-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315204835.748716-1-acme@kernel.org>
References: <20240315204835.748716-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Use the system one, nothing used in that file isn't available in the
supported, active distros.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index 6fe5ad5f5d3a4e4b..7d1aa9fd03da52c2 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -7,7 +7,7 @@
 
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
-#include <uapi/linux/prctl.h>
+#include <linux/prctl.h>
 
 #include "trace/beauty/generated/prctl_option_array.c"
 
-- 
2.43.2


