Return-Path: <linux-kernel+bounces-154277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A98ADA32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B271C201EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C016D9AF;
	Mon, 22 Apr 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU/t/N+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84B16D4FA;
	Mon, 22 Apr 2024 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830201; cv=none; b=LimjJg3Og0kVWZanzT6OPXo6VcpL2OgFnfbQLl5GmzOBS4RFfymdGh65duJLVNJDjRDDUvpR+bujitgPN1QIg2nx5MYskKvIFoulYV40ihRyeEipHTdJy/XAQC3wMEtFUKhayHEeN6vNCACTufNg6YrN4s1gMdxSLsAyYG/reKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830201; c=relaxed/simple;
	bh=LfuPnuHcChf51dbQiZm/elalM7ORqg0EA5yqXzxL7ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv896v2WYbYBou4ZjTV8UiZaLHWfnBQ7Aty36gf5VxHQtCZwPQhDI4gm+OYelKCu7jTQBdM38oeGTxcgbXw9KTly6hH+PJu2IfJUnEWBFcAQUWKW6bL6D7ksXwT5A0H1P3ndz3xy00oKsFyK+AcLJSYtAGffVYuzti/LrzshA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU/t/N+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8D5C3277B;
	Mon, 22 Apr 2024 23:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830201;
	bh=LfuPnuHcChf51dbQiZm/elalM7ORqg0EA5yqXzxL7ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FU/t/N+WogyRQBtwWfn1T7oMpN8DiM8hD5juT3Ha4mfqM2s2gDZAS8MCVfBmwg0yh
	 V58JSpHPbdFUpiGWNlM1IPn5+SJuZf3ihpHbvvHDIkLHdQJkbQ44dc1CnznjEQkjhZ
	 XN8ewnLJFBAjI6sgMA9Nbn//8HJMc4lYfC7fX05U/ym8b+owNAvwq0dVqgjCldE11p
	 iCBG1YkXCR+PUqBUxI3/SIugO3gTCZBlIcFrzIaqIbY5tc1KO5NnRoFPhD0Kf4/yn1
	 CpVXTAIc8vwPaDeXNfRsVNcvLhxqj0xu99/bxQK+eLRFh633LK8ByadE9ovXdUGAon
	 U1/zfS15kaL1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Ernst <justin.ernst@hpe.com>,
	Thomas Renninger <trenn@suse.de>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/29] tools/power/turbostat: Fix uncore frequency file string
Date: Mon, 22 Apr 2024 19:16:57 -0400
Message-ID: <20240422231730.1601976-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 0561362301c53..ffa964ddbacef 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1969,7 +1969,7 @@ unsigned long long get_uncore_mhz(int package, int die)
 {
 	char path[128];
 
-	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/current_freq_khz", package,
+	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", package,
 		die);
 
 	return (snapshot_sysfs_counter(path) / 1000);
-- 
2.43.0


