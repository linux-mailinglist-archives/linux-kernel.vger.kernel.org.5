Return-Path: <linux-kernel+bounces-128241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3F895834
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7477B24077
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E3132464;
	Tue,  2 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgXN6oQE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4C12F398;
	Tue,  2 Apr 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071800; cv=none; b=nyC8gA8/ezmhkLghDIO9swnuJNjv8Ri9UBZzhiOyZ3KkC+JO6/mRPgY1wZ3VZdmRjFi04L5yTJFKI86/z7DP9CpmWPcvqifjhbiwJpcXa25pBS6n84NFC81Ovfkg7Za+jNM4oVI8bTRxe+VF22fXolZeii00LQF6Q6x6sReRRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071800; c=relaxed/simple;
	bh=XaVUGRUrb5mPQCplqhRQIZ+eY7CGaNjyYlKQrNyMwug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQd2gKsMhxzLgKC+Jm8AhzrArntWMyq3zA0Frz517eJZgj7m8AfeUs1ACT/LZL23We7PAe9GTROMijRxVCY0dvqRNoR0W06OcrriS56HX53k7OhaJNBdRrCg73eMdJca40JyNXKGGVxEVXdZOH243OVs7/6DaCANgZNPHPpnOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgXN6oQE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712071800; x=1743607800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XaVUGRUrb5mPQCplqhRQIZ+eY7CGaNjyYlKQrNyMwug=;
  b=LgXN6oQEEa7k39jl7+g1Kw/33GCBZ+0KH3sdhyt176JSupKVpeIf6uFG
   hsy/Y8Z+SCY5GmlBpMvEw7DdJ+Krps0iJ+TXaV8qO1oculzr8IntAOiL0
   DehrT+USjgfJrcD0YTCEjpCG6KhUMlyHEN2TWEx0FxJZ9J7r0oSJ/x2YU
   PpEtmgg4Jqy0CCrbqhCrHWJKlwBAlYPBP4Ppv3IG351Slmq3bhppKEvzD
   /+iKuFO7JnDdE6yUnCXAmDLHbO5WgKhX+cJ8g+7RYC1PvYANVco3/qp16
   gkfu8cPyiOesWIIUuZ6k7JiUXuOAaJSAE9dAovbfnA+3Olhxl0pLxg4wy
   A==;
X-CSE-ConnectionGUID: YZp5r3uJR4CIF5lBwI1gPQ==
X-CSE-MsgGUID: U6wTc1JDTG2l840N579uiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17867550"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17867550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083610"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083610"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:29:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1F7011C5; Tue,  2 Apr 2024 18:29:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] ACPI: LPSS: Prepare for SPI code cleanup
Date: Tue,  2 Apr 2024 18:28:51 +0300
Message-ID: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ad-hoc cleanup followed by preparation for SPI code cleaning.
The latter will be done in the next kernel cycle to avoid conflicts.

Andy Shevchenko (2):
  ACPI: LPSS: Remove nested ifdeffery for CONFIG_PM
  ACPI: LPSS: Advertise number of chip selects via property

 drivers/acpi/acpi_lpss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


