Return-Path: <linux-kernel+bounces-54934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A6F84B526
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40F71C24570
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA21CFB2;
	Tue,  6 Feb 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWwnsyTA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1E12EBE6;
	Tue,  6 Feb 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221593; cv=none; b=sBqABxEq5H+Z5FhZd7PmkYrBF9jBo0IeHaBnjF9KfC1LLJOgn9E+BBC+f/8YZ5SCYE19OvSXpIkyJFZ8SS1kycDo3XkO8tK6oYrzmLlskAnAR7eRraUcGKvBihh0ZQhBUt4T5VVM1ILB1iC/HNikXGfIvyrzJB+4u9EXwTZyMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221593; c=relaxed/simple;
	bh=HNOUf291pv9yr5OMqopIb665gLes2bjCx3QC88n6zX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ84sbdclqGeBnB/0YSAeetAfDAmgnrcCvgl36Ui+BG6GSY3A9cMv2akHnsgnTImuYp/qVW60ZSCFuIV2LHjmbtiEOBSA0G4rAztX/foRpQo8Hpmxy3wNbpH6lctEcjJ/5q5Xf0v4kXJ84WN/D0t9/Y5dS9gRJaicflqtnpgxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWwnsyTA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707221592; x=1738757592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNOUf291pv9yr5OMqopIb665gLes2bjCx3QC88n6zX0=;
  b=UWwnsyTA4H3s0cGTt7zg5QiGi1RVwQEijX8lPEC++dJpUtXDd2UEpWDx
   9BgdS4RyRwSvsqmOPteOd1JDBF/koeYQKR0KjdS9z/WX2Lj8N2Y8Z3K5r
   3kYgNl7VjiD3gD+pwdjk0D7rSKj7ADZhMHt58S6uDwSu7HnNJqOF7B7O3
   KMtdR6f6KIIOdZNaLBpMldhcDZ2OY7lTNgjRQyyIQEP3JLIng3S7qI1uh
   iy8jRPbIwwH/NSvP27At0/QrOQzVGjGuuOb2jQomjjq/TPCutoOx3pHSU
   KK8fGJvF/VgxrdfO6lfCe5i2TQef9SQoB+HM1LlKwDWfkmY4PXp4fRHEZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="998413"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="998413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:13:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="24247456"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.2.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:13:06 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2 v3] Add cond_guard() to conditional guards
Date: Tue,  6 Feb 2024 13:12:59 +0100
Message-ID: <20240206121301.7225-1-fabio.maria.de.francesco@linux.intel.com>
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

Fabio M. De Francesco (2):
  cleanup: Add cond_guard() to conditional guards
  cxl/region: Use cond_guard() in show_targetN()

 drivers/cxl/core/region.c | 16 ++++------------
 include/linux/cleanup.h   | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.43.0


