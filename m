Return-Path: <linux-kernel+bounces-154320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04A8ADAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C5A1F209AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1DF158D63;
	Mon, 22 Apr 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G48Q5OhN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115094779D;
	Mon, 22 Apr 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830319; cv=none; b=Sy/xjm8nTkUOifOBpg1OiDu4zUY4ueGNgwnezP/EWPZRrM0aaJqonXtU0xqqZGUg4IijAdpv1oWytwmKeHpM0MKxlKmbqBDdP08E49/b2os02SuxhULqgAXLwAgnjO2l+FJSVN6iuFscb3qSjcMF8AM8mvOWIQRQ7wncDbK0GzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830319; c=relaxed/simple;
	bh=G7idWjgxc/34u/hfIgwtN8r8Ovl6lZDC+XTCX0/agCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5aWm+F2zxzti3RHgJ3TyvJ5oPjB2Th9QMmqj3QQjkSn0QHK+mo8B7Em/wNzWMlX7sk9xNCKL5NScm1cCV7PiLYKTkRebvrUUQuKfJcYPCOr4nn108BHVN+xR/CWU0Jv4j7LUTiYbK8uoIecy6Ye3E5/43I5sSSWBH1/BzTrEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G48Q5OhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B630BC113CC;
	Mon, 22 Apr 2024 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830318;
	bh=G7idWjgxc/34u/hfIgwtN8r8Ovl6lZDC+XTCX0/agCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=G48Q5OhNRYLa5KwK7kKFnOg8dVi/QXuifCUuV7WZDrK3mjMiPTRHvzma8TALNLgyi
	 uoXCMm/oa+ea7DI/qLtQSE+XOMkLuwtIh/GcYuLx1Wn7N5mJXAmjHqfi8Y+5KbmMnV
	 OkOsFLEegE7pHa71JEe2nQ1sri1rAP+6IYMLcDu4Ho+DS/Yha3EsuIhyKarevPD1iE
	 iLzFid2jZcHM3cLmCL1jO1t3sNscBmuDLmL5ZoDJuyUK+Que6nsRuPzS5VBCksG3Wo
	 n315pRvhar1qm4C3/WFdIagxB5HBnGU4NiTwBGM9+SQfDC6AQXGjB+6EcMgifXnRyT
	 8DJ4QhkhMm4pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/9] tools/power turbostat: Fix added raw MSR output
Date: Mon, 22 Apr 2024 19:19:42 -0400
Message-ID: <20240422231955.1613650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Doug Smythies <dsmythies@telus.net>

[ Upstream commit e5f4e68eed85fa8495d78cd966eecc2b27bb9e53 ]

When using --Summary mode, added MSRs in raw mode always
print zeros. Print the actual register contents.

Example, with patch:

note the added column:
--add msr0x64f,u32,package,raw,REASON

Where:

0x64F is MSR_CORE_PERF_LIMIT_REASONS

Busy%   Bzy_MHz PkgTmp  PkgWatt CorWatt     REASON
0.00    4800    35      1.42    0.76    0x00000000
0.00    4801    34      1.42    0.76    0x00000000
80.08   4531    66      108.17  107.52  0x08000000
98.69   4530    66      133.21  132.54  0x08000000
99.28   4505    66      128.26  127.60  0x0c000400
99.65   4486    68      124.91  124.25  0x0c000400
99.63   4483    68      124.90  124.25  0x0c000400
79.34   4481    41      99.80   99.13   0x0c000000
0.00    4801    41      1.40    0.73    0x0c000000

Where, for the test processor (i5-10600K):

PKG Limit #1: 125.000 Watts, 8.000000 sec
MSR bit 26 = log; bit 10 = status

PKG Limit #2: 136.000 Watts, 0.002441 sec
MSR bit 27 = log; bit 11 = status

Example, without patch:

Busy%   Bzy_MHz PkgTmp  PkgWatt CorWatt     REASON
0.01    4800    35      1.43    0.77    0x00000000
0.00    4801    35      1.39    0.73    0x00000000
83.49   4531    66      112.71  112.06  0x00000000
98.69   4530    68      133.35  132.69  0x00000000
99.31   4500    67      127.96  127.30  0x00000000
99.63   4483    69      124.91  124.25  0x00000000
99.61   4481    69      124.90  124.25  0x00000000
99.61   4481    71      124.92  124.25  0x00000000
59.35   4479    42      75.03   74.37   0x00000000
0.00    4800    42      1.39    0.73    0x00000000
0.00    4801    42      1.42    0.76    0x00000000

c000000

[lenb: simplified patch to apply only to package scope]

Signed-off-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9d4a249cc98bb..11f1b6288e123 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1685,9 +1685,10 @@ int sum_counters(struct thread_data *t, struct core_data *c,
 	average.packages.rapl_dram_perf_status += p->rapl_dram_perf_status;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW)
-			continue;
-		average.packages.counter[i] += p->counter[i];
+		if ((mp->format == FORMAT_RAW) && (topo.num_packages == 0))
+			average.packages.counter[i] = p->counter[i];
+		else
+			average.packages.counter[i] += p->counter[i];
 	}
 	return 0;
 }
-- 
2.43.0


