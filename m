Return-Path: <linux-kernel+bounces-23693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0582B01C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7641C23C63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8433B185;
	Thu, 11 Jan 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehLkLBqW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75B171B3;
	Thu, 11 Jan 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704981557; x=1736517557;
  h=from:to:cc:subject:date:message-id;
  bh=0UpJJ1HfJ79wY08r8lPqeB0h9S9S+PYOAwBJXQY0h70=;
  b=ehLkLBqW19SlxvoQnT1J7RUbxkdocrxcsiceE/AfhGIojxmJDYU/9sv1
   b1cxW0CT0akTvFkBNmZFYaytokZKOwZZ8duvA80Zygax1zADmQuY9bGZ7
   aPRC2zuPuImtoad2ATUd2Spp55HGlbIcHQj43l3vKbf77Jsk2UKKkEufk
   ancFsZRw95DdA9SV8UKdD82G2ari1yZNqQdg/tsSLXqWt+IsQqICMGdYf
   AxVP0/qEEarZIG5qZ0BoeR9cIRAsZKcROm+Ap+ZwwR0KvAkSnkemW0snm
   1xfW05td6uLfPphQiWs/ApQAlkI2iel7umpSXsx3SPVYUbdFF07ijpuNu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="12340490"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="12340490"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 05:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="852958952"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="852958952"
Received: from pasangle-nuc10i7fnh.iind.intel.com ([10.223.107.92])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2024 05:59:09 -0800
From: Parshuram Sangle <parshuram.sangle@intel.com>
To: mtosatti@redhat.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jaishankar.rajendran@intel.com,
	parshuram.sangle@intel.com
Subject: [PATCH] cpuidle: do not shrink guest poll_limit_ns below grow_start
Date: Thu, 11 Jan 2024 19:29:50 +0530
Message-Id: <20240111135950.17016-1-parshuram.sangle@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

While adjusting guest halt poll limit, grow block starts at
guest_halt_poll_grow_start without taking intermediate values.
Similar behavior is expected while shrinking the value. This
avoids short interval values which are really not required.

VCPU1 trace (guest_halt_poll_shrink equals 2):

VCPU1 grow 10000
VCPU1 shrink 5000
VCPU1 shrink 2500
VCPU1 shrink 1250
VCPU1 shrink 625
VCPU1 shrink 312
VCPU1 shrink 156
VCPU1 shrink 78
VCPU1 shrink 39
VCPU1 shrink 19
VCPU1 shrink 9
VCPU1 shrink 4

Similar change is done in KVM halt poll flow with below patch:
Link: https://lore.kernel.org/kvm/20211006133021.271905-3-sashal@kernel.org/

Co-developed-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
Signed-off-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
Signed-off-by: Parshuram Sangle <parshuram.sangle@intel.com>
---
 drivers/cpuidle/governors/haltpoll.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index 1dff3a52917d..663b7f164d20 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -98,10 +98,15 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 		unsigned int shrink = guest_halt_poll_shrink;
 
 		val = dev->poll_limit_ns;
-		if (shrink == 0)
+		if (shrink == 0) {
 			val = 0;
-		else
+		} else {
 			val /= shrink;
+			/* Reset value to 0 if shrunk below grow_start */
+			if (val < guest_halt_poll_grow_start)
+				val = 0;
+		}
+
 		trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
 		dev->poll_limit_ns = val;
 	}
-- 
2.17.1


