Return-Path: <linux-kernel+bounces-128611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7333E895D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA601C234AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0A15DBCE;
	Tue,  2 Apr 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i94rT6ig"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938A15D5A3;
	Tue,  2 Apr 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087599; cv=none; b=SyonNcuyZs+pLyXwrs8R6GnZyw4WaPx3L4h6kBGxZxHqbgEsuvpfzg+htQkSwbUUfGzxPqH2Db2nSp/GuG/ypxGiam5jnB9mtXIa6DbArTj71dZ6icwOLhEX2SEAId1SCRI0NQbjaT9IrBWj6hrJBDHOpE/Y3jrAJIyn4ahfWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087599; c=relaxed/simple;
	bh=JgM+fADrgZpk4sMyX0Kc50oOXn8dLcX4FIXcNnjC/8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqXIfJPst6+LGJgzxi09uXQzmZcIbLor2WAz/OTVQwRWYCMKxC8fhFMztcMKrROvJdHxZANPzdDClkCGuw5htNd3fmoAa7Xzz2RlnNDaF4wnNsfaXUhFSY4bbaz/ReuB5xy/jfaKLZvjo449XmJOY7F6Y5CF0ePaH3244p51QGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i94rT6ig; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087598; x=1743623598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JgM+fADrgZpk4sMyX0Kc50oOXn8dLcX4FIXcNnjC/8k=;
  b=i94rT6ig5KSLxuzSrAGmiBS1JNVggcEZMbcJPjzfamDGpn0CPVQohcE4
   OB2sOqX5yaoJLivXDWN2Kx5BjiX+WtM4iWDec6qZxNSx86rYzjnqcpR+n
   uY7NL3c3XZwjzXPRGzAZBi0EGh9zfSp8PqxNSEIOjIH+UBWEMbbiWmVaY
   pY3PAyMY1ond1Lu458JYYA3B/ORNtL8+cigMg4ckKKa33wazb4Co26Uwz
   k7BuErAxD3lBtvcYL+7xba7rFrmjcgLU0iW/OAr/x77HFP3/KQzV1LM2E
   t+YpbrcbzV4PFCST/xfSmky/ChSOfrNAI3SrlmdXVbasYw9h7O21P7VpL
   A==;
X-CSE-ConnectionGUID: emI/VjHFQy6YEq4gzbrJ9A==
X-CSE-MsgGUID: 7A+AFnyGQTeV3u7SiPVg2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7150997"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7150997"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083785"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083785"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A67461C5; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 00/16] serial: max3100: Put into shape
Date: Tue,  2 Apr 2024 22:50:27 +0300
Message-ID: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Put the driver into the shape with all new bells and whistles
from the kernel.

The first three patches marked as fixes, but there is no hurry (as it
was for ages like this in the kernel) to pipe them to stable. That's
why I sent all in one series and it's good for tty-next.

Tested on Intel Merrifield with MAX3111e connected.

In v2:
- fixed a few typos in the commit messages (Hugo)
- added an additional fix to patch 2 (Hugo)
- appended tag to patch 13 (Hugo)
- v1 (20240402154219.3583679-1-andriy.shevchenko@linux.intel.com)

Andy Shevchenko (16):
  serial: max3100: Lock port->lock when calling uart_handle_cts_change()
  serial: max3100: Update uart_driver_registered on driver removal
  serial: max3100: Fix bitwise types
  serial: max3100: Make struct plat_max3100 local
  serial: max3100: Remove custom HW shutdown support
  serial: max3100: Replace custom polling timeout with standard one
  serial: max3100: Enable TIOCM_LOOP
  serial: max3100: Get crystal frequency via device property
  serial: max3100: Remove duplicating irq field
  serial: max3100: Switch to use dev_err_probe()
  serial: max3100: Replace MODULE_ALIAS() with respective ID tables
  serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
  serial: max3100: Extract to_max3100_port() helper macro
  serial: max3100: Remove unneeded forward declaration
  serial: max3100: Sort headers
  serial: max3100: Update Kconfig entry

 drivers/tty/serial/Kconfig     |   7 +-
 drivers/tty/serial/max3100.c   | 323 +++++++++++++--------------------
 include/linux/serial_max3100.h |  48 -----
 3 files changed, 133 insertions(+), 245 deletions(-)
 delete mode 100644 include/linux/serial_max3100.h

-- 
2.43.0.rc1.1.gbec44491f096


