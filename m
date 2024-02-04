Return-Path: <linux-kernel+bounces-51827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FE848FBF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5773CB22D2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A900241E5;
	Sun,  4 Feb 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpm1xIib"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C02421F;
	Sun,  4 Feb 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067877; cv=none; b=mMmjt1c39wnguvEXMBruTju+8zYZ8aWn0rhDcHX5Q1u86e/qiN1euWNaKH2owgAtm+AU4x+b4YPQm9IHitInpVyof2hgPeR+VXxpTFLPPKmKtbj4aSEprpySFJU3KLclEndZzuNUwo6DEH1YwMw8G7qbR5sx+5yZ3tWWb92+Gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067877; c=relaxed/simple;
	bh=SBchobUhFlbRKL9roZ8rvHypMRkQnDLsR7JiDyykqDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKvc2tf67oYkg1PRIMNcTsH+b9cKvsB+5a/6HJaGXmxoe6vtpsWUVOOea8/FHnmDsJQ84wKxx+w2UOyKQgEZg8BKWctZQJhkv5qFkbCFlrK2yKF0Ebd+kijxTIAimhPA3EUQ39bjj6Zl/AnynyJQ+OVwyYlJXVsbgIOFhUnsZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpm1xIib; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707067876; x=1738603876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SBchobUhFlbRKL9roZ8rvHypMRkQnDLsR7JiDyykqDo=;
  b=kpm1xIibuPXgHvc8fGrjbC4Nd9ccebJKExdGP/XjMwr+Sh5KXlWjIWRa
   pIcHtopk+h3tWUgtOio4f2oklNjaBdZza2gIqnoaVTe4olLRy5fOz4HG1
   seRR6kJaKfFSlTE4sjatcSxICnuH0k/uT6aXxd5ux7rY0uupgsswUMLCE
   FvlACq/AA20o+n7uUb2q1+tshknHUL3Rc5FpVohON4jn4PG1d2GKc3kn9
   5EAs4lS6docGBj0O+N3IHgkg01YP//ReZR2QfJUdqtKZzveYZKCIk22ge
   LE4YNTuE52j66DlmmUD+lXaC2u0JcJ2L1ZNrdT+tAGJPHIrIobnn3TWCy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4225899"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4225899"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 09:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31626380"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.2.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 09:31:12 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2] Add cond_guard() to conditional guards
Date: Sun,  4 Feb 2024 18:31:03 +0100
Message-ID: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cond_guard() macro to conditional guards and use it to replace an
open-coded up_read() in show_targetN().

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>

Fabio M. De Francesco (2):
  cleanup: Add cond_guard() to conditional guards
  cxl/region: Use cond_guard() in show_targetN()

 drivers/cxl/core/region.c | 16 ++++------------
 include/linux/cleanup.h   | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0


