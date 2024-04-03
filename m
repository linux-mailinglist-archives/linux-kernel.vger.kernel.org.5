Return-Path: <linux-kernel+bounces-129605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4C896D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D96D1C25145
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B1136E3E;
	Wed,  3 Apr 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aO8u70Dz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BA13A271
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141317; cv=none; b=e7E/h7H1cjYQ8WopJ0CPF/RbrcfjklUMCGz2KuwnwcI/9qwCT8yUJCoqCjAsJCfPSgkGKrk7emp+JFFeduoQSlc1der8KtmheV1SqbvqH7vCcHlEtvPvGZp25IwQfWFK6wCFxd2tgTGEV0gjfq4+Dj4+BelHraYXeV/JxUdo5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141317; c=relaxed/simple;
	bh=TgaXmplyF6t66rHFbdDjB65GlHQAwHbIlXyEF4dI4/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMMZuRN2AOWY2ECmCbevGnM+A1iP9Ui6Ld23eX9h+qsrTspD/T6EdLpcctKxon/ccUS/bpzo/GCL19zZg9FRKj/zu98VnQYf52tfMt6X34McwJu7yj4zo5Bk4ujA8gqYQ5v8u0yV1/fXnG8kahJvp6LYdAcwlkRKGuq6ugfdw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aO8u70Dz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141317; x=1743677317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TgaXmplyF6t66rHFbdDjB65GlHQAwHbIlXyEF4dI4/Q=;
  b=aO8u70DzvFWJdocQeTSPKim/1MeBvOVCoRh33CcUeyMtcADsT6SjPVPa
   p81WeW4an/nSVFlijtNBBEA6cw57lbXHtBv0Bd6XZO4AtDYfyULdTBAt2
   evc6wNQSermFuuQ9VKhEH0+RkLwYz2zO1j1gYRQsbCDXozwWF5yo0YeCI
   KGi8IIdHs6xJXwchXFoxTIZGMx2xcWsXQme5KTTY9dGzlN6YqYw1aTcjd
   APLCZqtOd3HTxWV8rBSMzAEDyD8FZo4osxJr8380tsMcMRMIFgeNFiq7h
   dk+XrYUMM/49YTVtos+T7diila6h5IEB+MWc4j5fuC0RrUwjnU8ck/lS2
   g==;
X-CSE-ConnectionGUID: CvG/rbaqQMWb/qN1Pa/eBw==
X-CSE-MsgGUID: KDHuL1NCQyKgwcnuU03jbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10333406"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10333406"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:48:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084883"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084883"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 03:48:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 621BA3E5; Wed,  3 Apr 2024 13:48:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/2] devres: A couple of cleanups
Date: Wed,  3 Apr 2024 13:46:55 +0300
Message-ID: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of ad-hoc cleanups. No functional changes intended.

v4:
- rebased on top of the latest vanilla (v6.9-rcX)

v3:
- rebased on top of driver-core-testing (Philipp)
- added tags (Philipp)

v2:
- fixed plural vs. singular "to have" (Philipp)

Andy Shevchenko (2):
  devres: Switch to use dev_err_probe() for unification
  devres: Don't use "proxy" headers

 lib/devres.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


