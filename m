Return-Path: <linux-kernel+bounces-124041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8289117A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97524290D89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA940863;
	Fri, 29 Mar 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaISkusb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689473C48D;
	Fri, 29 Mar 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678190; cv=none; b=kJFK/Fc4WnWwlzDtba38ugaTFd0x5ixurergrA0s79snsP0pX2E8G/hgEztlrkC3o4AwUUcr4Ku+DQBN8PUoBLKCxjcw0HFuFgwxqoWINbmVLxwgNxvi40YFxfnxLPeVyP8WlRoKgiQ1enTNbzptnD5RJaKTY7E7fm96aHkhVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678190; c=relaxed/simple;
	bh=qoYT81wmdpJZjtmAFrTyCEr2wuBbIWdL55Nla8I0oJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qBGuqH7X9nnvve/JMiyntL1FgBj6UhXG5y458I2wpQnKKqf/iyLYbK6+xSek1Bshtt3hbq82M+145dml7Vg9VLAkEShqWjOGyRAMHxBrN9d7KlSoL8SKQA9ee+xKjLAsPlffwOVX6uQzU5/9MZlK+c5fG2kFccHHUStdistjZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaISkusb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678188; x=1743214188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qoYT81wmdpJZjtmAFrTyCEr2wuBbIWdL55Nla8I0oJk=;
  b=GaISkusbB+5r4l38BYA9FEU1Mr2MHpYRMHxRlIMN4pLDfrli/9ZEp/3l
   2+ySldoqh/glJUm8O/KAcaPp+j0w4YiQDjQiR9MNgbcCeKL9Pv/fvU+VA
   fqFpXHqKgnzkJ3x9Rzfu60sqqq9p3FrwDID8WuYLP2AlpNzX4Inq323EX
   Cek5tHv1aLwSPc1161Mt8fyzp+Ni1pnRaDMXZGTGLaCE7/V2TAS7QJLYv
   IrtQzbX2Tji/LD1oP69rqh7eSeFVXVnrmNFfCv+HHoJcigeoW4sDhf5gG
   54d6PNsmFpmylhEGjPsmPNKwZc+C9cMa9vjPraoDnW7sm5bUieLjChjTw
   w==;
X-CSE-ConnectionGUID: taYdZxwOQGykpoHSUgKvAg==
X-CSE-MsgGUID: fr9bq4GhRn2jABf43DSJMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700095"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700095"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301417"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:47 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com,
	Sangwhan Moon <sxm@google.com>
Subject: [PATCH v9 09/14] x86/hotplug/keylocker: Ensure wrapping key backup capability
Date: Thu, 28 Mar 2024 18:53:41 -0700
Message-Id: <20240329015346.635933-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To facilitate CPU hotplug, the wrapping key needs to be loaded during CPU
hotplug bringup. setup_keylocker() already establishes the routine
for the wakeup path by copying the key from the backup state.

Disable the feature if it's missing with CONFIG_HOTPLUG_CPU=y. Also,
update the code comment to indicate support for CPU hotplug.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Sangwhan Moon <sxm@google.com>
---
Changes from v8:
* Add as a new patch.
---
 arch/x86/kernel/keylocker.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index d5d11d0263b7..1b57e11d93ad 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -69,6 +69,8 @@ static bool copy_keylocker(void)
  * On wakeup, APs copy a wrapping key after the boot CPU verifies a valid
  * backup status through restore_keylocker(). Subsequently, they adhere
  * to the error handling protocol by invalidating the flag.
+ *
+ * This setup routine is also invoked in the hotplug bringup path.
  */
 void setup_keylocker(void)
 {
@@ -135,11 +137,11 @@ static int __init init_keylocker(void)
 
 	/*
 	 * The backup is critical for restoring the wrapping key upon
-	 * wakeup.
+	 * wakeup or during hotplug bringup.
 	 */
 	backup_available = !!(ebx & KEYLOCKER_CPUID_EBX_BACKUP);
-	if (!backup_available && IS_ENABLED(CONFIG_SUSPEND)) {
-		pr_debug("x86/keylocker: No key backup with possible S3/4.\n");
+	if (!backup_available && (IS_ENABLED(CONFIG_SUSPEND) || IS_ENABLED(CONFIG_HOTPLUG_CPU))) {
+		pr_debug("x86/keylocker: No key backup with possible S3/4 or CPU hotplug.\n");
 		goto clear_cap;
 	}
 
-- 
2.34.1


