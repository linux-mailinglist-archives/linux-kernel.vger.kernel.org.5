Return-Path: <linux-kernel+bounces-154240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95008AD9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051F81C215FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126D158DBB;
	Mon, 22 Apr 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVlQFzw1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD313E418;
	Mon, 22 Apr 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830089; cv=none; b=XPqDmsziKSCiDXth35+J+kRSuUzJb4Kac+yuSlVua7BMl14va4J1FxCdCuetMVzz5fhnkKJ/HAQXaiW1mjFU4v5idXz+etQf7fDnmzjLlYrWtkFYu8YqJDZgojlUbI0FJjMSOlaLlzpVkhv0FadAVjHlHGeXG6A5PvIoRppkwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830089; c=relaxed/simple;
	bh=ltIROLwzh3NwESS782JFP356g9Ygs7Q1t/CRAXFVPoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKncvk7aRRFD7JtmFbgTNIbjLeOZPKe1VKVAYjm/3XbJzQ/BmiLM5SNeLA7zFnb99u1/xiD6j2SaRvnOeMoJyL2+HB8b/DXIbA1HHU6WZSO2jOMnw5jc0im2stq/eumHouSRqPtKSSQ2H2g4ZmhPuPh01AnmRAsjUVv5n+mfTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVlQFzw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D55EC32782;
	Mon, 22 Apr 2024 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830089;
	bh=ltIROLwzh3NwESS782JFP356g9Ygs7Q1t/CRAXFVPoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVlQFzw1PXhleRKKRl1ZAPxbQtLQjnxAFf5oketqIfW4Wvioo5IAky/kLotchKv29
	 RDL72C85n4nzeyFOTrYpmZAfC16MGCGJtr6FSZETq5BVXFT0OUyLCAbWWPBSIZxgv4
	 q+VKEhJ7Cbt7bJmqrkGLFdqNydTeESfcIVVBaf4/mYcW/Wva4iLRCMGlrcS24kNY6w
	 hx9tiFhvRPnPmGIkcqZV1lMwHQr6V0GesR7KXOPPhDvjtR1llLo/Uj/QRbYftQtbOy
	 RSoIiv3MO2hgxugN10SALbF/n7Mu3T+8VxMbfcOIa7dKgHNa8EuLarMc2OAwgHhhpB
	 w1K6Qk1e374fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Ernst <justin.ernst@hpe.com>,
	Thomas Renninger <trenn@suse.de>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 23/43] tools/power/turbostat: Fix uncore frequency file string
Date: Mon, 22 Apr 2024 19:14:09 -0400
Message-ID: <20240422231521.1592991-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Justin Ernst <justin.ernst@hpe.com>

[ Upstream commit 60add818ab2543b7e4f2bfeaacf2504743c1eb50 ]

Running turbostat on a 16 socket HPE Scale-up Compute 3200 (SapphireRapids) fails with:
turbostat: /sys/devices/system/cpu/intel_uncore_frequency/package_010_die_00/current_freq_khz: open failed: No such file or directory

We observe the sysfs uncore frequency directories named:
..
package_09_die_00/
package_10_die_00/
package_11_die_00/
..
package_15_die_00/

The culprit is an incorrect sprintf format string "package_0%d_die_0%d" used
with each instance of reading uncore frequency files. uncore-frequency-common.c
creates the sysfs directory with the format "package_%02d_die_%02d". Once the
package value reaches double digits, the formats diverge.

Change each instance of "package_0%d_die_0%d" to "package_%02d_die_%02d".

[lenb: deleted the probe part of this patch, as it was already fixed]

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3438ad938d7e4..53b764422e804 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2612,7 +2612,7 @@ unsigned long long get_uncore_mhz(int package, int die)
 {
 	char path[128];
 
-	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/current_freq_khz", package,
+	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", package,
 		die);
 
 	return (snapshot_sysfs_counter(path) / 1000);
-- 
2.43.0


