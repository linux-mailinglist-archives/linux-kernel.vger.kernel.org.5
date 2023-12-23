Return-Path: <linux-kernel+bounces-10258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8981D1D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B1F1C22D00
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61B1375;
	Sat, 23 Dec 2023 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Atvm423l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05964A59;
	Sat, 23 Dec 2023 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301951; x=1734837951;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4M9SYNQomWn9fS80p33fIleeHiF+NBXr8fhqDr8znwY=;
  b=Atvm423lUkUE8HjN/tr7e3y7qHHErv+lTre9Ik/lAVs06JOKeMz7stXh
   3MF2G8dXNfMGaD4klDiCRqHp5aJkhCQYrtJMQnvisrKoagvFAsSFrcJd6
   n7gcIrZMzg+Rxc8kXTVYq0D1Ukleo0fywMW8SlwAkqWfGf3g/eAmdxaLD
   E8qv6WEHggwFmrMvsy+YO6K25ge22PfnINuxYQIfjeBTLjA1G2AOvjs4h
   X22VH9tNXxLi2tV0/T5BYGv4WGXSaTuVE46PEshLAjXq6t8VK+FYuE1aj
   4XNn+9Fr9Kg/Q2393tihULXF2CHQlFa7LJIHuWpOcTCbWBmEVR+/OSQE5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462619287"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="462619287"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811534572"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="811534572"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:51 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id 19518580CC6;
	Fri, 22 Dec 2023 19:25:51 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Intel PMC Core GBE LTR regression fix
Date: Fri, 22 Dec 2023 19:25:40 -0800
Message-Id: <20231223032548.1680738-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the network performance regression caused by
commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
core_configure()").

Unfortunately, the regression is included in the recent Lunar Lake and
Arrow Lake support patches in the review branch. Patches 1 and 2 remove the
LTR ignore without a fix. They may be folded into the respective enabling
patches indicated in the changelog. This is done so that the next patches
fixing the regression can be backported to stable kernels with fewer, if
any, conflicts.

Patches 3 and 4 provide the support needed for Patch 5 to move the GBE LTR
ignore from probe-time to suspend/resume time. All three carry the same
Fixes tag so that the stable kernels can pick them up without causing a
separate suspend-time PC10 regression.

Patches 6 and 7 then add the LTR suspend/resume fix for Arrow Lake and
Lunar Lake. Of course, they cannot be folded into the enabling patches
unless the LTR fixes (3-5) are applied before. Sorry about this :(.

Patch 8 finally addresses an unrelated sparse warning for a missing extern
introduced in the commit mentioned in that changelog. This could be folded
back into that commit if desired.

Note that there is no current solution to address the loss of runtime PC10
with these patches. With a network cable attached to the PCH LAN, the best
that can be achieved is PC8/9. However, this is unlikely to affect many
mobile systems which tend not to use LAN and if they do, not the PCH LAN.

David E. Box (8):
  platform/x86/intel/pmc/arl.c: Remove probe time LTR ignore
  platform/x86/intel/pmc/lnl.c: Remove probe time LTR ignore
  platform/x86/intel/pmc: Add suspend callback
  platform/x86/intel/pmc: Allow renabling LTRs
  platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback
  platform/x86/intel/pmc/arl: Add GBE LTR ignore during suspend
  platform/x86/intel/pmc/lnl: Add GBE LTR ignore during suspend
  platform/x86/intel/pmc: Add missing extern

 drivers/platform/x86/intel/pmc/adl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/arl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/cnp.c  | 26 ++++++++++++++++++++------
 drivers/platform/x86/intel/pmc/core.c | 12 +++++++++---
 drivers/platform/x86/intel/pmc/core.h |  9 ++++++++-
 drivers/platform/x86/intel/pmc/lnl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/mtl.c  |  9 +++------
 drivers/platform/x86/intel/pmc/tgl.c  |  8 +++-----
 8 files changed, 52 insertions(+), 39 deletions(-)


base-commit: 119652b855e6c96676406ee9a7f535f4db4e8eff
-- 
2.34.1


