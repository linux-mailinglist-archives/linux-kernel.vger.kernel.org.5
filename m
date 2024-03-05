Return-Path: <linux-kernel+bounces-92782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959458725EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010A4288C70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB717BA9;
	Tue,  5 Mar 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUyj5Xr1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30B1758F;
	Tue,  5 Mar 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660981; cv=none; b=VYgz6fJaDR9DBFX5bogCL4wex5wJOu2KATj/8skZHHjhHGnUlJbjU0khphdpjFXnvCwu079DobooKExFUR7XUu4svzsWsxwioLamIIIK59Afw8ebRKL05xetj2j9ec/Qb2HTcsIvoX9iQW6RKlzGhMH+Y1Vgxr7TwY/toGSanoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660981; c=relaxed/simple;
	bh=iKadSd4SrCoNOWp4+Qlp5ExVXQgLzONe/kqzElpRJjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=do/8tfkOmZehBdW9N048+bFcJcTHYvmCALISJMZOnI7EXo0sy7a0ryLF0b9SUR0V640+oDKoopinnMcaO8LLkP1qi3cGEQo0JLnMksYioQHngv7SSNhjKnv9fLZHwjzNIXyB6SeWJeoze8ztSfDdMTalsQ5p5EV06h2zLAYOCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUyj5Xr1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660980; x=1741196980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iKadSd4SrCoNOWp4+Qlp5ExVXQgLzONe/kqzElpRJjI=;
  b=IUyj5Xr1+YmZVw0p2CDjWdH6pvGysgPsDcBEty0rkGFQm24kg5fjYFwB
   j0FdE+LOAAsl/HnvhkXHyiQ1CxVsXNEDg+XD6JlHEotVZdCju+susIevT
   9TLJv97yZTyTvTtu88vl61sqwLAU/Kbo2gixV3XXUodOKrlFGdaxaddQX
   AGiW3aaypBY0nQOqj1Mouw8Rswja1XDRc+4GBa1bsI1LD0hKOkWxTrwgU
   5o/4fTN/yLeQUhbbjxNmWdZ9wVYgdy5qq0ioVrPTdQqK3zbUnIZstwoxX
   Q2eGfR0M1gwCu4w6cxmfXYP9jvvS464ZLcZ0Pqcfr/oCZy/qc4lGU6Sy/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4092434"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937042794"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="937042794"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 09:49:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 236545BB; Tue,  5 Mar 2024 19:49:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 0/5] media: ir-spi: A few cleanups
Date: Tue,  5 Mar 2024 19:48:25 +0200
Message-ID: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While removing of_gpio.h where it's being unused, this driver seems to 
deserve more love. Hence this series.

Andy Shevchenko (5):
  media: ir-spi: Don't use "proxy" headers
  media: ir-spi: Make use of device properties
  media: ir-spi: Utilise temporary variable for struct device
  media: ir-spi: Remove trailing comma in the terminator entry
  media: ir-spi: Unify indentation and comment style

 drivers/media/rc/ir-spi.c | 41 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


