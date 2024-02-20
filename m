Return-Path: <linux-kernel+bounces-73471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF685C306
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA0F1C2329A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE677644;
	Tue, 20 Feb 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uyot1PdL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5976C89;
	Tue, 20 Feb 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451621; cv=none; b=DPd9vt58KTok0o/NhdUpiGbYW0nKKMLIF8X/Od0fqlmLLzKJaGgdf5BzPXAvV0TiH6r/IHPNdO3rHWeNyxminuCSAOFT/G06Z022cvcPK8bmfTtLENA5f7e9SjhqJuNm4+KwoOHyxu5I7x7KkOhrioe6FSAf6RfsSORJFWk8SKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451621; c=relaxed/simple;
	bh=E0sF9V+OeFQ8gtlLiSNo8lKG76q/a1Bsao7zpK30erA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJi1oRn45jpaveTVaiAf/3XjBFmT4Dp3RexWetdai8UslysPwciX8gbZ24UTyoGAqLQuBeZaFlobP1rhMu/9Q9swo4042JzSxMjB1kRhMs59jbKW6SDgSJdh0CWVJISelvQNwvYoHXO/cCV1AZf7435UWfc8MWTPHPF38jQdgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uyot1PdL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708451620; x=1739987620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E0sF9V+OeFQ8gtlLiSNo8lKG76q/a1Bsao7zpK30erA=;
  b=Uyot1PdLZDUtyCXvb54rz1OiQ5NSssZHBpH7rMDoxEC37JcL8XasVtCl
   nZj/j16LPI+BAKw17BOT5n5lQrSzZOu6dxEB9EKKIPBi1NtHcZFMUuqzr
   5zgqpRrn7cmcgY1ewQxv+WpiLW+g/g/3MLEgmRStS6+NvaQM3Kfy5poFT
   hJH51s2VaIkZVfZcOzFpe1P7cB1ET0s/Dre6XkdsVgZrPEC9V2Vnm9AhH
   geKhZrMAFxv7UqM4lMpExdbwwpKG5Tabxzq0VN1SBZMaLgYepD5F8acaw
   +24vohXWbcsRUp9OTif7QdDrIYmugkzCbk3Y0OFx+4LPVfy1F/JS5ikAA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20007003"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20007003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:53:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936486300"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="936486300"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 09:53:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DE0A139A; Tue, 20 Feb 2024 19:53:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 1/1] driver core: Drop unneeded 'extern' keyword in fwnode.h
Date: Tue, 20 Feb 2024 19:52:53 +0200
Message-ID: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not use 'extern' keyword with functions. Remove the last one
mistakenly added to fwnode.h.

Fixes: 19d0f5f6bff8 ("driver core: Add fw_devlink.strict kernel param")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed a couple of typos in the Subject
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


