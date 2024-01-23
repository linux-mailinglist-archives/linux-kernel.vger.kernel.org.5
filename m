Return-Path: <linux-kernel+bounces-35076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05421838B89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C81F22EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8275C8FE;
	Tue, 23 Jan 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le9JZqav"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B25C60F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005007; cv=none; b=MhU6M6B7ArvDTCk09Lu2Wtv3H6DfrP0Au8JeVLuZBuInFP/0NL8kbb+Qyv8pLN5roQyF1v70dniybaG5fgYceSchR9pVGNn0XmeTMmgDYJPZtnxPfqRlMBGgI6a1O/fCKBAR8uc0wlvTXytfKZEHXhl7XLCfkac684ovebuNstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005007; c=relaxed/simple;
	bh=D/FrcL7O9l3Ac/VsbOMpDPHKOYkGoJEwugRMmrbB2PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWwTu8HTtT6lwSS+hBr/G165PM2F7W0YMrvUQ/TwlMVXL4kuXoXLn5gJEKzJ+b9uUsrCvRrM+dKjDI2FD+wuyBFlaal/0/zr9SqPbPr7i5HfBycqDljldTM2p8cyULlLZZhTu6cWhLh9H9SeCA3vTqVoKWNq0qTsXZzgB9GMBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le9JZqav; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706005005; x=1737541005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/FrcL7O9l3Ac/VsbOMpDPHKOYkGoJEwugRMmrbB2PQ=;
  b=Le9JZqav9PQeyxQRXl4Gfg1W9p0QbOPABx6BwvsRnZEhntBYnni6ah8s
   wAu/ulhe25TJ4FATvp3lvmXmKq2x7zJC9NCLD3ty576PZ4HU1XNW8JSYS
   u/rXMvvaE5BOLW5F6TBuNGGFSQsFKExdBw/tzI1mpk2BiDbNDd83J6xnS
   FUhGns6DJ3qS3UTMSVm7V03UbTCQMBqiFPTc12r7hbeLo5/bN4yTIe8gn
   sD8lARsUfUNAP60BUi1z6L1R0BBQqoKFQ3Nxx0Jclcj35U3Z8Lg3V4dbe
   dsNudyzKDZ/atbL1faMM8z88e5ylIuWgTqOoEmkgXeGDNHj0lg4C06Wqr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391900207"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391900207"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1549625"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:43 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/5] mei: hdcp: add dependency on Xe driver
Date: Tue, 23 Jan 2024 12:16:24 +0200
Message-ID: <20240123101625.220365-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123101625.220365-1-tomas.winkler@intel.com>
References: <20240123101625.220365-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Optionally depend on either i915 or Xe drivers.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hdcp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
index 9be312ec798de96fb362e0dc..631dd9651d7c9dbc0f812725 100644
--- a/drivers/misc/mei/hdcp/Kconfig
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -4,7 +4,7 @@
 config INTEL_MEI_HDCP
 	tristate "Intel HDCP2.2 services of ME Interface"
 	depends on INTEL_MEI_ME
-	depends on DRM_I915
+	depends on DRM_I915 || DRM_XE
 	help
 	  MEI Support for HDCP2.2 Services on Intel platforms.
 
-- 
2.43.0


