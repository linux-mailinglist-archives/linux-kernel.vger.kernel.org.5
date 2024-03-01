Return-Path: <linux-kernel+bounces-88885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65CF86E7F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6CCB2AE1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE339FD6;
	Fri,  1 Mar 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQL0Cqh3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79B37701;
	Fri,  1 Mar 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316131; cv=none; b=lQmmH8ZrznpeAgro6wjZdT6JDDjdp7pViFt830ndgAvPTymZG5vaIn61mp5x3mqwE3ZQ/fTCo0pnk9gWwfHNQ7ci+76GLmN7jG4qqDVboa6pR1gyuRc00golwIWDwYMjmiZ9dnxTtlFDU7vzZxn4oM78BzCpLDulNM2DMU2kcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316131; c=relaxed/simple;
	bh=BW1c/RkhUJtoUJ2pTjmMw2HsXxDX+1fRKgzP9b4AcP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leIqbBRkSPnbVgVDKQk6lDQPzAYMmHaTjzHlU8IAyGyv5ULRc+48UUErg+Ia3vymR80FpHXLWKQTN2yMjfY0pVuA7Fyn5Cis4Hr45d8HGGjq1D+Rpbml7ePMEjxgzQwJ0JsJcGzQbUYvqtlroKkmXWYxPj5H5XN08/y4xMuwZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQL0Cqh3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709316130; x=1740852130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BW1c/RkhUJtoUJ2pTjmMw2HsXxDX+1fRKgzP9b4AcP8=;
  b=mQL0Cqh3f4G8+GV4y5XZt556trM4BlE7/bQIDtKvNTvFZ3WSpXdQMh1t
   o9TRh11QnL3TyA8BTpIkCUbyyRKeH4VfVHo8KIQY3eVOL3EjIdf68BwQR
   yfg3GYJ7frgmbBIe08zUYR38ohxn5018T0+ykIII8v0gnPpAZIiaVqNMe
   7CX/g+PR0SwiA1znuxZ/Tmn5RBQfzDsP1qCFvvWvpoJWyUIZsR5H358M7
   +zKtx6T3H/Q5rX4xVZGRvRCjBpXlAP5Fdkf0A83yP8QDkN3iLqkuELllQ
   dJfCDvzIl+cmQtfCRN8VW9Owq3dQcAkWOmD2iq1HEpBxtk+6IIpH2olzR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684821"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037848"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 10:01:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2CA611A5; Fri,  1 Mar 2024 20:01:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 1/4] driver core: Drop unneeded 'extern' keyword in fwnode.h
Date: Fri,  1 Mar 2024 20:00:05 +0200
Message-ID: <20240301180138.271590-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
References: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not use 'extern' keyword with functions. Remove the last one
mistakenly added to fwnode.h.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb..2d23a14857c7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -209,9 +209,9 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
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


