Return-Path: <linux-kernel+bounces-58103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F884E156
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30214B234F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892F763F6;
	Thu,  8 Feb 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUt2vObF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25304763E7;
	Thu,  8 Feb 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397478; cv=none; b=TR7knlI0r7dmONLNtp0dsUkMDpQk1PxAsQvMP6orctXlNB/oqPsb6r2/vZSXgGZxQBXFOkiSrIeydLzit2fGuCHWqXUInQ9sFJ7wMd6ob/Grn7nQ+xZHdjzD4BYaImGWs14Y+Z/MDB2mrSb1/yn28FqyficLtdsnml2ymy7S8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397478; c=relaxed/simple;
	bh=h7hT0zAQh1US2oNbTzNgMEdve8p7uZ7zf8jzekAxRAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMyR6m+wQArPC6nnfGV9U081kuwUIsar47vABuCIAOIWZ4QY6vjSuiL6lU0mZqSu6saFfFFT1/lTxiWV+j5lROYyfrjg4/mrB19atbUfFJuetNAUSiZn85Pz+pLGT44P3XTTSpZ2NCTsr4I4rwGS5bqijzqaTALuCKEZhMf9ANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUt2vObF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707397475; x=1738933475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h7hT0zAQh1US2oNbTzNgMEdve8p7uZ7zf8jzekAxRAs=;
  b=XUt2vObFtyYejNQSPSVDwZvFxKJ+Xfylt6kU8aLM+pa5yMijHGcUpE9h
   obttGQc/0/ZDNxzYWxg8wgVSjrLU0ZhvsefDzhDVeHYOIGS52u8J2eL0l
   c5LUe7FrDGxpneI7k2feODklkksH2Cv5ziHCA7hAYxrxmXgPcLjHCqoEk
   0EYjPFYefv5DdN+x2nOm2MnwhgGOP/ZjqHIMn/l3NCvjNPig2wc6ymOhW
   yLnJvo0Hh7vRcecEHJQFkYWpRDYrEqjdv3TM13CFlmOLa6Hli2l5Kz397
   HXi5M2kW3j3y189PwcZd2U3Foe5e8Mkelo2R65NlMrnRzSe2/3OkHea7s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1354943"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1354943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:04:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1884027"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.2.200])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:04:29 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: [PATCH 0/2 v4] Add cond_guard() to conditional guards
Date: Thu,  8 Feb 2024 14:04:22 +0100
Message-ID: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
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

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---

Changes from RFC v4:
        Changed the interface of cond_guard() to take a variable to store
        a return code, the succes code and failure code, to enable a
        later check of the returned code in that variable.
Changes from RFC v5:
        Changed the interface of cond_guard() to take a statement or 
        statement-expression as its second argument to conform to Dan's 
        suggestion (thanks).
Changes from v1:
        Fixed a grammar error in the commit message of 1/2; replaced the
        name of the second argument of cond_guard() with '_fail'
        according to Jonathan's comments (thanks). 
Changes from v2:
        Changed macro's implementation to add an 'else' to protect
        against it being used incorrectly within another if() block.
        Suggested by Dan (thanks). The Reviewed-by tags on 1/2 are not
        forwarded because the implementation of cond_guard() has changed.
        Removed a redundant 'else' from show_targetN() in 2/2.
Changes from v3:
	Added braces around empty body in an 'else' statement in
	cond_guard(). Added Reviewed-by tags (Dave, Ira - thanks).

Fabio M. De Francesco (2):
  cleanup: Add cond_guard() to conditional guards
  cxl/region: Use cond_guard() in show_targetN()

 drivers/cxl/core/region.c | 16 ++++------------
 include/linux/cleanup.h   | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.43.0


