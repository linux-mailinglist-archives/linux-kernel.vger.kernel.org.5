Return-Path: <linux-kernel+bounces-154329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF08ADACC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7441C214AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC81C2304;
	Mon, 22 Apr 2024 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRiEFvho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EC5B02B;
	Mon, 22 Apr 2024 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830343; cv=none; b=FTSUu1mIgs999EcFTfmCwc3yjvXYOkYV+SHf5MZgkJFSJnlUKThpghp6tnYgOGy54uhwKYSgSPO7rn9izKdvX+uBh/C/BU4cQkW35C51b2XYf+YYSgNPK7wBy71xuyMUwKXra+ahU53r/tGQj5TXJpbe0FDO7YypbvG6bmiUURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830343; c=relaxed/simple;
	bh=7q8Ndj+GfxSNX+6VPpYacCTj/lL9PLmiAcPrgQu6LK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpLqj6AmtMg1mPLO0UH+MjGL7yqZjwl5yC601Qj0MUekuRP9HoNDiC54TKLRAfEIfmXmZbdC6+2dy8wD+bcy0BIhObH8CupFekap281Og7jmtXe35CLGts3GwVTuxH4GJvTyFuirN1Ub/ZiyFQaPsfiHHwsSmlERJm3v/UuydwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRiEFvho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F1C113CC;
	Mon, 22 Apr 2024 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830343;
	bh=7q8Ndj+GfxSNX+6VPpYacCTj/lL9PLmiAcPrgQu6LK0=;
	h=From:To:Cc:Subject:Date:From;
	b=fRiEFvho8JdRl7eymK3mXamVh6vR9i9jNHd8fnSuWAHe6+gs2Vm7RNW3VcK77mrOG
	 CxMsHtjtDDocqVImrBbzONIPmInj5T41+F9r7tvZCEgZy8QeNYO57+elc1aBkt55px
	 Ikoc6j1xc5dp85hE5TCVudJ1VEAKn/nTxoHMkuoF69w/z0MU/wsn7kkK/yahGCsiaJ
	 aaCH2GCS7YJAQkgA938Az3S7Qz+yRR7Uwz1sxVEZSiHHZug7TGk7MAEC0LxQDm2Clo
	 jWWQAlKVZJOhb2wA4pDArHvoloUoF0/lSXEjq6yamqDSQD4P24pWWLrnCpbQB6ALue
	 NdoV63/KDXurg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/9] tools/power turbostat: Fix added raw MSR output
Date: Mon, 22 Apr 2024 19:20:06 -0400
Message-ID: <20240422232020.1615476-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index d4235d1ab912c..8a366b1d1dd91 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1571,9 +1571,10 @@ int sum_counters(struct thread_data *t, struct core_data *c,
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


