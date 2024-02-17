Return-Path: <linux-kernel+bounces-69814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7669C858EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152461F21E99
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FF59B56;
	Sat, 17 Feb 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV/tyjgM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646059B52;
	Sat, 17 Feb 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167560; cv=none; b=tLMq9eenzFEwJ0tIpRj9YFK/CrmT/N62tZ2+5iKT5B98Nu03Ozcls+AfU2hNBUW6zgk16saR9cshVZ+bmKB4hmYISIzR5CA8+x2kZ6CWAxoww8lTJF1dN+wkDo9zJO1B0ix5279qIb7qW0pGgz8xRtVi/FGy0gUkoEONW65YAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167560; c=relaxed/simple;
	bh=GdLaoOmmqrV/IjtLPmRhjoptn9Egef0+L9PbSHcVQLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4kH3Q8hVqe0hNlUu64JNQi7C6Lj8PJC7XOGVfNF+jG8reFABArG8zFhVhCJ7hlc1oJuGKUw5gECKxdJatAdW368w85UJU8iyVfB8JspAAYZ6TWCJKQm5wPxL2GxK0hm2oK1wpE3+B4hEEkKepNty3TcsyxaLf3/M2QGFiv3oN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV/tyjgM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708167558; x=1739703558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GdLaoOmmqrV/IjtLPmRhjoptn9Egef0+L9PbSHcVQLA=;
  b=DV/tyjgMsin7VMgLJ5uofVOxLB4Tot1fZhQU65LvxR8w2Suo/ZjSHUgF
   qZp7UYhYfnAmxNnECa0wlN2NNrbUo1uXdlgrbyeI+eOIRuLmCAqoOrqs4
   rwzAA98BIs54CxsVltbjgDO6LPb6k04UnqkACf1rtfFkpmCLtm+1eUlp+
   xSJqY9AJUSg605dNxxGBXvtUJeXsOXOUwGmJccA7jeJLF5yOLWpfogx8b
   7c7QlnFUHPWEQ2KtMXt27R15sQ9hcBNNrpS9x/T5onmko++5PuBgCL7X0
   Bz65nms6Zfmt9UbHSsryJ6czJumnSsYbVJ8XtjUQ9Nd188TYfwJI6Pgdt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="27746701"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="27746701"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="4348703"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.3.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:14 -0800
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
Subject: [PATCH 0/3 v5] Add cond_guard() to conditional guards
Date: Sat, 17 Feb 2024 11:59:01 +0100
Message-ID: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cond_guard() macro to conditional guards. Show how to use it by 
converting two functions in drivers/cxl to replace open-coded up_read()
in show_targetN() and in cxl_inject_poison() and avoid to 'goto' to a
cleanup block marked by an 'out' label. The second conversion is added
with v5 to show that the most recent implementation of cond_guard() can
also be used more than once in the same scope.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---

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
Changes from v4:
	Made it possible to call cond_guard() more than once in the same
	scope. Jonathan suggested a more elegant implementation than the
	one I had thought. It uses an exhisting helper instead of creating
	an ad hoc one (thanks). Added a second conversion to show that
	cond_guard() can be used twice in the same scope. Deleted the
	Reviewed-by tags from 1/3 since the implementation of cond_guard()
	has significantly been reworked to allow multiple calls.

Fabio M. De Francesco (3):
  cleanup: Add cond_guard() to conditional guards
  cxl/region: Use cond_guard() in show_targetN()
  cxl/memdev: Use cond_guard() in cxl_inject_poison()

 drivers/cxl/core/memdev.c | 19 +++++--------------
 drivers/cxl/core/region.c | 16 ++++------------
 include/linux/cleanup.h   | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.43.2


