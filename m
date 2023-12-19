Return-Path: <linux-kernel+bounces-4870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26350818329
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C748C284740
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F211700;
	Tue, 19 Dec 2023 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bed6tn3E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5A11702;
	Tue, 19 Dec 2023 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702973844; x=1734509844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BGmrAqqK+vPXeg2UNmmfvUM3glSTLMuvYVtHcbTfpp0=;
  b=Bed6tn3EO4rQ58wsx/BbVzAdtHHMJ3u5GT3rnbeqhnWStOeAukg6j9yb
   dAgq+7HPyxWaqsccEUCPdX0a4eHJTAnB2is6AQwNdyAymT4f2NC32k+tQ
   kZTnw0Oo/EFMlTbr3pGXYL/7LrInuZQ6rqNMshRRsSHBF9FPR+tR4zF8T
   FIwsIGEBtkpUJxjSRmZeToG0WW2shuuzIlWtSfV1yPSmd47HcZyuATy96
   vszdq6UBKrGNctTR9iiDZmq4olFAPXi3oJVKjzDLxtpCSdmBApBA+JeWS
   k6d4SDqULaaPnb4siyUA6ft5tFTlKWP18SSPXOGcNVme4K+oANeHJgOMs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2717386"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2717386"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894193879"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="894193879"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:22 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 7A1AA580E21;
	Tue, 19 Dec 2023 00:17:19 -0800 (PST)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net 0/4] qbv cycle time extension/truncation
Date: Tue, 19 Dec 2023 03:14:49 -0500
Message-Id: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
the Cycle Time Extension variable allows this extension of the last old
cycle to be done in a defined way. If the last complete old cycle would
normally end less than OperCycleTimeExtension nanoseconds before the new
base time, then the last complete cycle before AdminBaseTime is reached
is extended so that it ends at AdminBaseTime.

Changes in v3:
- Removed the last 3 patches related to fixing cycle time adjustment
for the "current entry". This is to simplify this patch series submission 
which only covers cycle time adjustment for the "next entry".
- Negative correction calculation in get_cycle_time_correction() is
  guarded so that it doesn't exceed interval
- Some rename (macro, function)
- Transport commit message comments to the code comments 
- Removed unnecessary null check
- Reword commit message 

Changes in v2:
- Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
- Removed sched_changed created in v1 since the new cycle_time_correction
  field can also serve to indicate the need for a schedule change.
- Added 'bool correction_active' in 'struct sched_entry' to represent
  the correction state from the entry's perspective and return corrected
  interval value when active.
- Fix cycle time correction logics for the next entry in advance_sched()
- Fix and implement proper cycle time correction logics for current
  entry in taprio_start_sched()

v2 at:
https://lore.kernel.org/lkml/20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com/
v1 at:
https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/

Faizal Rahim (4):
  net/sched: taprio: fix too early schedules switching
  net/sched: taprio: fix cycle time adjustment for next entry
  net/sched: taprio: fix impacted fields value during cycle time
    adjustment
  net/sched: taprio: get corrected value of cycle_time and interval

 net/sched/sch_taprio.c | 178 +++++++++++++++++++++++++++++++----------
 1 file changed, 135 insertions(+), 43 deletions(-)

-- 
2.25.1


