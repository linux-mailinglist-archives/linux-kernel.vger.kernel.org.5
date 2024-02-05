Return-Path: <linux-kernel+bounces-52815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82245849CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205E21F28679
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBD2C1A4;
	Mon,  5 Feb 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imGe3DNB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466ED28E09;
	Mon,  5 Feb 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143186; cv=none; b=pXZOkVLPb9uexGCfNlsJsHQf+snUL2Cj31rLfq9ibKNPOi28Y6AqZN6YRZFPEgX7qOfH46wEK53sQluGOMTUaSVSDDc0mdDQ7mOLQBkrrrdQ+4XDOG2Vf83dmZI6oLBABW0Miyf1xyB7xpkebOyvNpoqzuJ2xSyPH0g87yWxO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143186; c=relaxed/simple;
	bh=m0QLdI83zB+FnoE7IBS4lFE86qJhrmdQ15xApBEaRSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0QwT7ZB8RJQrnj3TZO2WtOmSqCWobnMTF4U5Zlpecw+HM0YcDwsz0f7WpyapN4BGOWat7zKrqqnEZ+WwzeUYQtlnkkE7Ls167T7hFdNNiqZWgANu7N90y+St9R8o5XMdRQgKTj5xIqf2fEtVIQDCZkXYUVQnOxcWYwAMgVBRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imGe3DNB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707143184; x=1738679184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m0QLdI83zB+FnoE7IBS4lFE86qJhrmdQ15xApBEaRSc=;
  b=imGe3DNBhkyOsBBqMdvRm8j092do6b4gsJ1k6e/GUNltcR9HXtQ3sqwN
   tO+jaJ5m9NdahRo+ZKhSnx/vtjFZqETu/P1vZWT+pgpAT6QSHdAF6pk79
   oPH9ayyLHB3u/YVmJKxRttKk20kfMHREIjtpJL1faax00uB26XEmH9hSd
   e9adxcdVCMpz94SzG/amQLvj2eT/4qJeJeM5G9JiGp5/Xasz8S6nCH79s
   rF7vmbSNTV0OsozYxgezad+wH95zLr3GjSwf2vHaIj/1nYX9ddMn5D0Ki
   78Mjm2jE8HkeiHaqvIa9t+fjZ3TMcP3Cve+4ZbRmY5t+Lf6IzB6mTIGHl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="787661"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="787661"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5473000"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.219])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:26:20 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2 v2] Add cond_guard() to conditional guards
Date: Mon,  5 Feb 2024 15:26:11 +0100
Message-ID: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cond_guard() macro to conditional guards and use it to replace an
open-coded up_read() in show_targetN() and remove a block marked by an
'out' label.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---

Changes from RFC v4:
	Changed the interface of cond_guard() to take a variable to store
	a return code, the succes code and failure code, to enable a
	later check of the returned code in that variable.
Changes from RFC v5:
	Changed the interface of cond_guard() to take one or more statements
	in its second argument to conform to Dan's final suggestion
	(thanks).
Changes from v1:
	Fixed a grammar error in the commit message of 1/2; replaced the
	name of the second argument of cond_guard() with '_fail'
	according to Jonathan's comments (thanks). 

Fabio M. De Francesco (2):
  cleanup: Add cond_guard() to conditional guards
  cxl/region: Use cond_guard() in show_targetN()

 drivers/cxl/core/region.c | 16 ++++------------
 include/linux/cleanup.h   | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0


