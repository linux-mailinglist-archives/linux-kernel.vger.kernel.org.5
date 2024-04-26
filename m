Return-Path: <linux-kernel+bounces-160714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A108B4180
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460E628349F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15137703;
	Fri, 26 Apr 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="farHw3iv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A463A9;
	Fri, 26 Apr 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168300; cv=none; b=O3oIARxpivag2aWedIlN99qbxoUNwIM9Gc3o/CU6ikw94aP0aba//gTz3dKkxSfVmNAHGtacRJedSVf3xeMdtF5BskLI1UCLiDmLM2zoVIdWjILCOV2P9BgJvrKj8pk26mzkL4qj8ZDYPMVd7Gbdj79kKbVb9j6cnAk7dVcSUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168300; c=relaxed/simple;
	bh=p25LKjfAYhucdY7uYC0uLj/fjyCQwe/CH3qIxeSN6so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hke0q34Unhe3MHl16kXIlk/2lv0Yxhty/e/MvBjDzxLBwP+u61/ENmh2F/tP9/LYfDMzGb3txnvn3ROfvEau434jiBYm0rJAxQHLj8R7qlR/jno2sdL8pps3IxZSVZQWkV0bCc3ciq1eO5WErTjQBwdCpNswK9TJVc0eWTh+sJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=farHw3iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09C0C113CD;
	Fri, 26 Apr 2024 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714168300;
	bh=p25LKjfAYhucdY7uYC0uLj/fjyCQwe/CH3qIxeSN6so=;
	h=From:To:Cc:Subject:Date:From;
	b=farHw3ivejo20JY6s0M9U1EZ1xYkTOcab8/qV/LBEOQ6JhiaXrE6nQWexUvnVypD8
	 uCPmFXWykyh4XVHXUvD0eWp03922eK+lkPBQjp+TT2vxqhbSf8tVRozEghc91l8921
	 Utx5KNmPkEnTGZXe9ugtYzVC3/foKkXhLW8DU2K7xPZ/5R3xkhBI58UkuQQI4L6DEv
	 AdRN7YTNT8o57ID/wari8qJuo6Vy0Ngw/YCMYulUkzpCIcbcVwfJwlDNJh+h2QGzWw
	 VxXxXSlJMj0YzBR47VFIWqpbb8bJ4G5t38NR1YCEKMllEJn+4kZUcqav3qkVh2CmAx
	 BHHom8MkgDlGA==
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
Subject: [PATCH 1/2] perf symbol: Set binary_type of dso when loading
Date: Fri, 26 Apr 2024 14:51:38 -0700
Message-ID: <20240426215139.1271039-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the kernel dso, it sets the binary type of dso when loading the
symbol table.  But it seems not to do that for user DSOs.  Actually
it sets the symtab type only.  It's not clear why we want to maintain
the two separately but it uses the binary type info before getting
the disassembly.

Let's use the symtab type as binary type too if it's not set.  I think
it's ok to set the binary type when it founds a symsrc whether or not
it has actual symbols.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7772a4d3e66c..63936269ec15 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1927,6 +1927,9 @@ int dso__load(struct dso *dso, struct map *map)
 		if (next_slot) {
 			ss_pos++;
 
+			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+				dso__set_binary_type(dso, symtab_type);
+
 			if (syms_ss && runtime_ss)
 				break;
 		} else {
-- 
2.44.0.769.g3c40516874-goog


