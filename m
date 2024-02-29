Return-Path: <linux-kernel+bounces-87034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5586CE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5690B27A82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A544AECC;
	Thu, 29 Feb 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7nM05NM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41A4AEC0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222117; cv=none; b=JqakdCO4C5EQPimQG9vXbclMjnL8cs7BzCI/5LgIPzk3bV6DAT/u61cbFKL5tq+oZRTaYL0Z3n94SnMk+LP8rB9WQVEaCteJak1wZoxU/ZqHilMFxMxwCkqGE9hPYHlGTREYL4oAzyh3m91y8g6b5bxnuvITthRTjpseLjC5ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222117; c=relaxed/simple;
	bh=ztUaX763WcnO/b/ycvH636BChB6l29JhJMLpSuRok5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CX8xwQenL/KEBBS06sGHz7l8IVPROfj9txRqkNaJbyQz+ttEAEpIjg/AotJ7l0L84TtnJe4iuKvtaoLwLKhBN4SqtEIdisNPLXYrCePnj9RCoIjETEOh6m+Op6quQ+Fz6sbOD67vsEs/sJO2U+ES8YOXtQg1XrEgRRS8MzPr/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7nM05NM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709222116; x=1740758116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ztUaX763WcnO/b/ycvH636BChB6l29JhJMLpSuRok5g=;
  b=a7nM05NMNF11X+zcAI3T1GK4uHEe8zwy2EHqoBTmc9gY/b90k53ku3ue
   XzKkKQ/bV1ea1XkDPGA86hWmYlP3Tzb33LrWCVZ7e6X/AUiFXRN0VNGHh
   lm6HEHiD9rXHz0FCCFeYlDFmt2+HwnLsDLY/U/SvGpenBaBLFdBp5qgOo
   gtq+cZC2buzSTPd6RWPiFZfiCvX4nYPOwWf22h7vs9O1R02hYIkXwqrPY
   4eytlaPlZ05r1aYbuFSg2AeYr25wNskKWPK2NrnueQ6KOrAqCapN70s8u
   IB5xLBXFYDgzV3Aoh68ImUnEgUFo+odc8IrzhreCoUr/rtDOMD17KdceV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7479278"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7479278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036108"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036108"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 07:55:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EFD7623A; Thu, 29 Feb 2024 17:55:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/2] devres: A couple of cleanups
Date: Thu, 29 Feb 2024 17:53:38 +0200
Message-ID: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of ad-hoc cleanups. No functional changes intended.

v2:
- fixed plural vs. singular "to have" (Philipp)

Andy Shevchenko (2):
  devres: Switch to use dev_err_probe() for unification
  devres: Don't use "proxy" headers

 lib/devres.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


