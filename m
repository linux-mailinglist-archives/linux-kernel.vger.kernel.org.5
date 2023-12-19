Return-Path: <linux-kernel+bounces-4646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F8081803C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6251F24BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334D5253;
	Tue, 19 Dec 2023 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YM1dNkFb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC989522B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702956870; x=1734492870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jqer3xFMkpeqKTm36ptRc9Jv5vHMsw9msSMXd9F6Hh4=;
  b=YM1dNkFbmnyDtd0ZS113OVOW1oPzY9suUSELN1mfpC0r+OVEwsT7MxTk
   H51WctT92is4uwedEG6VOhFn/QX3jy3Qbbb2ygtspgHdYrqwBM9iTtvyn
   VeHqq0TD6a84o9PP9MQCo4XIlAPXgJoVq7hsSZzhUqM8pgEwooMr7tUCL
   Pc+wRr1hm12rgICkJccGlpZQkux3hcFVtVu7rmzTXwS7aNFL2jER4bMDa
   nOqvsowF+weOWQ0V0az0K3EyJIHdASYNabSPuC+SNo0DxyxXsx7mcvfCu
   yzOPjeEymZF436c51foSjVe3A6XS5HDA6JUetGMQJxJqbR2yEan5L6Eox
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2694481"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2694481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="24028278"
Received: from tgl-lenovo-03.sh.intel.com ([10.239.87.93])
  by orviesa001.jf.intel.com with ESMTP; 18 Dec 2023 19:34:28 -0800
From: wangxiaoming321 <xiaoming.wang@intel.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org
Cc: wangxiaoming321 <xiaoming.wang@intel.com>
Subject: [PATCH] cpu/hotplug: Increase the number of dynamic states
Date: Tue, 19 Dec 2023 11:34:11 +0800
Message-Id: <20231219033411.816100-1-xiaoming.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212025235.775986-1-xiaoming.wang@intel.com>
References: <20231212025235.775986-1-xiaoming.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dynamically allocatable hotplug state space can be exhausted by
the existing drivers and infrastructure which install CPU hotplug
states dynamically. That prevents new drivers and infrastructure from
installing dynamically allocated states.

Increase the size of the CPUHP_AP_ONLINE_DYN state by 10 to make
room.

Signed-off-by: wangxiaoming321 <xiaoming.wang@intel.com>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..c88a58c363f1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -251,7 +251,7 @@ enum cpuhp_state {
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
+	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
 	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
 	CPUHP_AP_MM_DEMOTION_ONLINE,
 	CPUHP_AP_X86_HPET_ONLINE,
-- 
2.25.1


