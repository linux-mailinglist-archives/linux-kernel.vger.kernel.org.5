Return-Path: <linux-kernel+bounces-88642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D6086E4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0911C23419
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A670AC0;
	Fri,  1 Mar 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxENJ5kg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCD38DC3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308281; cv=none; b=K/O6KOoh5g0FUbbySeAiAg0Cf1D67jOZGCJK/+0ONjX3sevqcyOZ8ZLTvi6WrpULYrsbGDZS/qkRNdzpxvK+MYAMpsXYz6kIu96P6+ljUIH2tKY0R6EDr4bgjbr2rwTZWh4Z4jNcl2eDWOg1kw2m/yMTB+ZLgZH/1g5kQsaPWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308281; c=relaxed/simple;
	bh=d6MyUCxfd8VWHve1C20bkt0ftD6ke8XNB2uL/3fRcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJ/3caYFOkHdfNsvz4j6pPzP6lFDtWe8383mnxRrkcqSW2p8rA7nL7cTA40WIpFRlQSQ9EKme3XOG0u8OIKtjspPNRU4G4/uV8t21+MSJPzsorWHkOQkwAx+f+hO6n0bebkXTP5QE7WZgl4w3Q6nJkfw/OSCPOLeGDsSWEDVcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxENJ5kg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709308279; x=1740844279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d6MyUCxfd8VWHve1C20bkt0ftD6ke8XNB2uL/3fRcT8=;
  b=hxENJ5kgqAHQtOXES5Ks2/IOAIspQUC45KT/d0svZ4g6WxOXh/8qdfUd
   Ud8d16EDKqiw6g7fc9slDVXni/80SGNfwj+A0GPbzU2XbA4vWC2CK4+tD
   Z80h1/DmoQ0YWILQ4+5S0WVacDlsjwp/7g+3MkwXLDmxUQD7iql4A8XJX
   nZ85STBOdeMlOBAMWevNlRz987MQe4F+74rJFGc82/b/w6KqDPom8/N9h
   vAxqnuCdPcR9QwezIJtH8MEQYTuDgYlhLfP/teNCeR+r7CXpH3oDQo1at
   ve7QyjrIr7iFFgRjNmo3Cd6/bExqaF2c9x4nj5rlHYjtpDR3dSOZi1+bM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3700832"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3700832"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 07:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8370177"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2024 07:51:15 -0800
From: rulinhuang <rulin.huang@intel.com>
To: urezki@gmail.com,
	bhe@redhat.com
Cc: akpm@linux-foundation.org,
	colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	wangyang.guo@intel.com,
	zhiguo.zhou@intel.com
Subject: [PATCH v7 0/2] mm/vmalloc: lock contention optimization under multi-threading
Date: Fri,  1 Mar 2024 10:54:15 -0500
Message-ID: <20240301155417.1852290-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This version has the rearrangement of macros from the previous one.

We are not sure whether we have completely moved these macros and 
their corresponding helper to the correct position. Could you please 
help to check whether they are correct?

~

1. Motivation

When allocating a new memory area where the mapping address range is 
known, it is observed that the vmap_node->busy.lock is acquired twice 
but one of the acquisitions is actually unnecessary.

2. Design

Among the two acquisitions, the first one occurs in the 
alloc_vmap_area() function when inserting the vm area into the vm 
mapping red-black tree, and the second one occurs in the 
setup_vmalloc_vm() function when updating the properties of the vm, 
such as flags and address, etc.

Combine these two operations together in alloc_vmap_area(), which 
improves scalability when the vmap_node->busy.lock is contended.
By doing so, the need to acquire the lock twice can also be eliminated 
to once.

3. Test results

With the above change, tested on intel sapphire rapids
platform(224 vcpu), a 4% performance improvement is gained on 
stress-ng/pthread(https://github.com/ColinIanKing/stress-ng),
which is the stress test of thread creations.

rulinhuang

[v1] https://lore.kernel.org/all/20240207033059.1565623-1-rulin.huang@intel.com/
[v2] https://lore.kernel.org/all/20240220090521.3316345-1-rulin.huang@intel.com/
[v3] https://lore.kernel.org/all/20240221032905.11392-1-rulin.huang@intel.com/
[v4] https://lore.kernel.org/all/20240222120536.216166-1-rulin.huang@intel.com/
[v5] https://lore.kernel.org/all/20240223130318.112198-2-rulin.huang@intel.com/
[v6] https://lore.kernel.org/lkml/aa8f0413-d055-4b49-bcd3-401e93e01c6d@intel.com/


rulinhuang (2):
  mm/vmalloc: Moved macros with no functional change happened
  mm/vmalloc: Eliminated the lock contention from twice to once

 mm/vmalloc.c | 314 +++++++++++++++++++++++++--------------------------
 1 file changed, 155 insertions(+), 159 deletions(-)


base-commit: 10c2cf5fe97647d68ee89b1f921e982e71519f20
-- 
2.43.0


