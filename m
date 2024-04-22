Return-Path: <linux-kernel+bounces-154303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F78ADA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9495E1F21A40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F401802D9;
	Mon, 22 Apr 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBlMio5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF61586CB;
	Mon, 22 Apr 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830272; cv=none; b=WnX/mFugaP8wmkEBXJrM1XX64DHM+3TziFsyS3Zna6O7N/QANC83+eqAcdkWLwza+5a6xobfNLJRDrm1FeEw1nwLEIDJm9IGEWkfoRyRuRpGIxw8W1urQUvutiBzlcfHvrX2badHzAeFYesD86kofn44Fnkjpu/pOsLKvKd2SvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830272; c=relaxed/simple;
	bh=3Gq8cBSaJ1JSVPhkNb8fPVSOPXXQ3PW7K3PXZdpUft0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4OLdtiribRNEagTmoS2lAGhtULbgRGgPSBiYYM+pYO0/Pil/IKOXTMQlTq3M7lkaH/H2hxNqBz0WGfEP0H0ODm6qH0F88nJSsEQh4Zp5FcgsKUVtZYtt53+5aF/8yWPj/8kKO7Uc5K7ok/6ezQ7rqaCvMbvdNHeAXqGWz7qXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBlMio5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CDCC113CC;
	Mon, 22 Apr 2024 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830272;
	bh=3Gq8cBSaJ1JSVPhkNb8fPVSOPXXQ3PW7K3PXZdpUft0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBlMio5yWR+Ow59Gwya1eRL4dfe4JMxjNEtn9Dvs97PavH0KEn7GMw1q3YvIA7pjT
	 6w6LFz41R1YGDhkPp18ybu1h0Sp16LpI26gzLQIVKjmo6Iu0CxMF27S0hEGtyDJlvJ
	 k5wIOnVAS5rZY2jXJt+fEFvG0fH4n90Wggr8wPKaZ5jjnCxZ7k8AE/esl6BFV1YVBX
	 8pyT5id49jBsFF/TSoVpzP7ti3dDAe00gKBoyi6Qv3/OVxPE1Oqf3dUXP+C9S/m5R7
	 /hGrbBD7UUs8ZtUVcA4ReIlTzAwmvhbo9yPs/g8L/D9wsbDukkGPXuEu6TW6EpqL9B
	 KhLqhIUFsOSgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Ernst <justin.ernst@hpe.com>,
	Thomas Renninger <trenn@suse.de>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/19] tools/power/turbostat: Fix uncore frequency file string
Date: Mon, 22 Apr 2024 19:18:27 -0400
Message-ID: <20240422231845.1607921-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index a674500e7e63d..a41bad8e653bb 100644
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


