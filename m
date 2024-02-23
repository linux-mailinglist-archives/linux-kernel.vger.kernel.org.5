Return-Path: <linux-kernel+bounces-79059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B15861CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853371C23DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153D2149396;
	Fri, 23 Feb 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5LKBtu8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912CB14690B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717879; cv=none; b=KnfrqRWkLiOyPaVW3YL5O+Q8WDwIdNJc2tlIW5K3bXaAhD0BMWwb2pho7vrX54wSi8A6Sd1iB5IV7aIzQy0Gwio9nMokC/ySccykNo8qjmBeDWaM2BoWJi7wa92OnZr4buYFw4vwbSBapLOHHdKUegdKrDPPp393K803KvdPjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717879; c=relaxed/simple;
	bh=ELLxWLLhMz8wDE2vaz+b0Dr+JKgW8d7j/s8EFVYH5L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSUR1xqsZVZUd6JWUNhsMl+6rTUa3NmQuay0Dw2rSaCVbDh7mFjIjIQ8NjD3xn2rUcFWGNQCa+wlR78X/dUTzEawzzQDcZkL1HYr8W936bzqqC3qmHwyew4LMcq6BSfLSuNvcNoT79fSSMxwCUeGAA120QyneHttMhSdB1eoyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5LKBtu8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717878; x=1740253878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ELLxWLLhMz8wDE2vaz+b0Dr+JKgW8d7j/s8EFVYH5L0=;
  b=n5LKBtu8JpUK6nblvGta05P2KZuQaTBOiHFi9KgA2EgJynvcwPn8PP0y
   pegclqpxbiyR6w/7rtVNEJTKS4BikEFswEDh4URSxdN0+daE7JePy5RbX
   377nXZQRZXqqj4aLcvrHqWOphpaAhkXoa0u2aViTMTKHzpaTb2QTIqi2n
   Q49vgfMX2sl7VJQJx9eQ3NPDDHsHXguaq8Gg9meBDU9fH4oZ6OhsoRsBO
   sl9OC6+dph3AJqG1xb8nuErMbmB1FBS9EqAP4rhEi1AB5NMxjXQEBgQh/
   SVvTlbiwZT9xMsRi4lP26AgjimD3uwb4ohE3I6VExwSH77nLRqc1YWN3I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837322"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025650"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025650"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 665EE34C; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 0/6] mfd: kempld: A few cleanups
Date: Fri, 23 Feb 2024 21:49:49 +0200
Message-ID: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a set of ad-hoc cleanups. No functional change intended.

Andy Shevchenko (6):
  mfd: kempld: Replace ACPI code with agnostic one
  mfd: kempld: Use device core to create driver-specific device
    attributes
  mfd: kempld: Simplify device registration
  mfd: kempld: Use PLATFORM_DEVID_NONE instead of -1
  mfd: kempld: Drop duplicate NULL check in ->exit()
  mfd: kempld: Remove dead code

 drivers/mfd/kempld-core.c | 105 ++++++++++++--------------------------
 1 file changed, 33 insertions(+), 72 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


