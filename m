Return-Path: <linux-kernel+bounces-117384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598B88AABB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444CA3417E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5512EBC1;
	Mon, 25 Mar 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnWCqJKt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550512EBC0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381007; cv=none; b=rYguKcpWNTqeWdnxCBHohrmMT2JZGRUabLTXAFRwlq+p2IGlm8BLa1GCUdPoUQKISN2JgsipKr2n7FK5vhbb0FSQR/ZH7LuOcNv8q/B7ffjCwjnHoxlU+zUa12J21fzMfNTQbl1SR5uoREqaso4p/epWi4ZlkB0ZpJhaZmTVdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381007; c=relaxed/simple;
	bh=63ps3itBNH6CkxrvJz2SUMrLS5Lmnnh52yVxG/KH+F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9TpMW/X1N/libevyrKYqRtl0DAqoevQhFKea/JNU82OWP1UTyoOoUpEKSHFu6DenWWS7jL7hEFAoFbJeNUJi/jG0Pwiva6eDoogOQOFCYxUJVwcBtNK1ECF9umZcrOQuh/rhrBSzYaZBjeTzxRZXiPME0lGdIrywgCLYeQkQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnWCqJKt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381005; x=1742917005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63ps3itBNH6CkxrvJz2SUMrLS5Lmnnh52yVxG/KH+F4=;
  b=dnWCqJKtM1OLZSCXiE6Prbdqv7pcYOvvYJVN22shaS7W5WSrzVshxgt7
   FRER/xh8nPYnfdeyQHU3K0UEuJ8MZst1aqniqvNt8vZJIzYbrcULFaWOC
   AA0rTT+q3sy+qLDNKxjNTZbKl/MVrFrdUiKZOMWcRFP7KCwMRhDMITBha
   /8RB1pXJ76qd0NSd5T9tex3dIHkU769ILwiKKPbf0Q6gc575kDhHKsFfq
   EWlLx71gPGup9ldvweoTVgjd8TtbhulP729RAeDE2EK5jCl15HT87I/cM
   u64avAFUjT58gz21hn6e6pn7+MIf11b/u0YRoMkh3QlBRcnxZY5+ewxsF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23842518"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23842518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20337599"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:44 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [RFC 1/4] kernel/panic: return early from print_tainted() when not tainted
Date: Mon, 25 Mar 2024 17:36:32 +0200
Message-Id: <2adfb5b76982d65d83077c8c5b269dbd8a63864a.1711380724.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1711380724.git.jani.nikula@intel.com>
References: <cover.1711380724.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Reduce indent to make follow-up changes slightly easier on the eyes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/panic.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 628673ddf1c9..b6d4d1da1eaa 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -509,22 +509,23 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 const char *print_tainted(void)
 {
 	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
+	char *s;
+	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
 
-	if (tainted_mask) {
-		char *s;
-		int i;
-
-		s = buf + sprintf(buf, "Tainted: ");
-		for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-			const struct taint_flag *t = &taint_flags[i];
-			*s++ = test_bit(i, &tainted_mask) ?
-					t->c_true : t->c_false;
-		}
-		*s = 0;
-	} else
+	if (!tainted_mask) {
 		snprintf(buf, sizeof(buf), "Not tainted");
+		return buf;
+	}
+
+	s = buf + sprintf(buf, "Tainted: ");
+	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
+		const struct taint_flag *t = &taint_flags[i];
+		*s++ = test_bit(i, &tainted_mask) ?
+			t->c_true : t->c_false;
+	}
+	*s = 0;
 
 	return buf;
 }
-- 
2.39.2


