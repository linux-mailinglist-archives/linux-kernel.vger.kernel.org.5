Return-Path: <linux-kernel+bounces-73269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D802A85C045
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153B31C21D99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDA762E3;
	Tue, 20 Feb 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfLsy+6Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058F6A8AB;
	Tue, 20 Feb 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443948; cv=none; b=h51xILrN+b/anicN7g6r8B+vF/+H5wJLP59l45TmnNM2MczCbgKIP1qlpdAyO3mU3k2Lfh3/B/sTuLx34fIzgkyj51fRGlGXCWhjxDjEGQeOIWh6MlHDSUMlUe1MhyxBuBUP74bh0qkkkTABD2e9ePzrhbgK0Tps2c1idUQXmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443948; c=relaxed/simple;
	bh=T7oBzUGm52fWTqVEWJ66ObHC6jx4/HUwbRG8vBv5ovE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uo3mBG+2sBYz94QDm4wr7iw+YTGAIK5JIirtj3Om7pib0PCpA/9Zu17hwDmItDlDnuRNt3zXkYw/5jJuZE3xBLJ/Od+QUw5Cd4Mj2xkG5X0N/J11pm7f1y8qf2Obiyk8QXryo2OeeTmCo0D2a5DgbUxlqVJ0kBA6IOrnwvIfVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfLsy+6Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708443948; x=1739979948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T7oBzUGm52fWTqVEWJ66ObHC6jx4/HUwbRG8vBv5ovE=;
  b=SfLsy+6ZmMr/32PpO/nNaDgjQCkTnDnajswCnfAz8gXG7ZBcX5SlR//B
   08vHBGPz4ddTCH4emvzu2MNQEUlcgt0LoPd2z4g87k1nqREVjhbiJ2Yyz
   z5FujRIxLFZHkBGZx3peirGcMYe1ixfcFqMjrHMD2TvFR7b12nh/seQGd
   aV2HLjOwyk40sCTXHLVXfBkBVDZi/SzpuW4OQ2/ZfwqsWd6lczSdqzJ6y
   czBy2ufMSfk4qJLylMMbH4r67151zpeUjqN1+aKBgq+3JZ6fok4d5xwtf
   O5yimC+TCe7JGIfbMzDXN/mAtMsLL3A8ULSIEduudAPL9tHXGezJaBoAD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2663585"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2663585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 07:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936468209"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="936468209"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 07:45:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BAFA5305; Tue, 20 Feb 2024 17:45:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v1 1/1] driver core:  Drop unneeded 'externt' keyword in fwnode.h
Date: Tue, 20 Feb 2024 17:45:32 +0200
Message-ID: <20240220154532.2684428-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not use 'extern' keywork with functions. Remove the last one
mistakenly added to fwnode.h.

Fixes: 19d0f5f6bff8 ("driver core: Add fw_devlink.strict kernel param")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index fdc90e6e4dc3..3b763042ee82 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -216,9 +216,9 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
 }
 
-extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
+bool fw_devlink_is_strict(void);
 
 #endif
-- 
2.43.0.rc1.1.gbec44491f096


