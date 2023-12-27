Return-Path: <linux-kernel+bounces-11858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA881EC94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29D41C222E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7EB538B;
	Wed, 27 Dec 2023 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxc8sU71"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078075666;
	Wed, 27 Dec 2023 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703658481; x=1735194481;
  h=from:to:cc:subject:date:message-id;
  bh=suBVpZrIX+26A1y1ne4PDB74bdL7C3LwazkehHNtqYs=;
  b=kxc8sU71AVh2l8de40/YCvbZf3UzME2g04h9aNGVtcxlCzqCkdV5aIP+
   l//1Y6jbP+muy6pgyP4SB53rhSQ7/3sZZAzcvQ3XA4SHkO6SZDhrKGUFd
   Vx8YQJeYmNFGBOJq9MS3x9jS9Ns8QuJlOQLZhcGOz/xnRKSYEudUUc7Px
   UGhonHARNhjczyu/HXfcluQtSLvYvdtzLaQ9YLk2GcBQ6d8b3sHNzMapa
   coxrMfiZZ6a5Tvi5aPo4COrzAxX4sIbRR0tpKQkhOl+Gaj0kf4bFehbg8
   OXbObHsRTEXdfB3cKzySrUhgz71hlcaYcO3XME3VohJN23/DzOURZGdOR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427584069"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="427584069"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025316079"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1025316079"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 26 Dec 2023 22:27:59 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	stable@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/4] thermal: intel: hfi: Fix memory corruption on resume from hibernation
Date: Tue, 26 Dec 2023 22:29:36 -0800
Message-Id: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

Memory corruption may occur if the location of the HFI memory buffer is not
restored when resuming from hibernation or suspend-to-memory.

During a normal boot, the kernel allocates a memory buffer and gives it to
the hardware for reporting updates in the HFI table. The same allocation
process is done by a restore kernel when resuming from suspend or
hibernation.

The location of the memory that the restore kernel allocates may differ
from that allocated by the image kernel. To prevent memory corruption (the
hardware keeps using the memory buffer from the restore kernel), it is
necessary to disable HFI before transferring control to the image kernel.
Once running, the image kernel must restore the location of the HFI memory
and enable HFI.

The patchset addresses the described bug on systems with one or more HFI
instances (i.e., packages) using CPU hotplug callbacks and a suspend
notifier.

I tested this patchset on Meteor Lake and Sapphire Rapids. The systems
completed 3500 (in two separate tests of 1500 and 2000 repeats) and
1000 hibernate-resume cycles, respectively. I tested it using Rafael's
testing branch as on 20th December 2023.

Thanks and BR,
Ricardo

Ricardo Neri (4):
  thermal: intel: hfi: Refactor enabling code into helper functions
  thermal: intel: hfi: Enable an HFI instance from its first online CPU
  thermal: intel: hfi: Disable an HFI instance when all its CPUs go
    offline
  thermal: intel: hfi: Add a suspend notifier

 drivers/thermal/intel/intel_hfi.c | 142 ++++++++++++++++++++++++------
 1 file changed, 116 insertions(+), 26 deletions(-)

-- 
2.25.1


