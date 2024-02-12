Return-Path: <linux-kernel+bounces-61685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D659785155B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7382C1F2137C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF945BED;
	Mon, 12 Feb 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVkhSWje"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFA3AC2D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744430; cv=none; b=lByAO33idQkp8M3Sol9NL4/1ksss8bXS8xKQPv7E92Y/8EV0/lmS90VEQT9zkVvQUYzP9RDNypz3WkUE2Z56l+mqmWd4ctXKlQmDuFRKeaa3LynAxtcJKYJ+7V+THCFLmVeG+0M12kOWO/2KRVEfycX1MK0tvW3r/GPUv4u/SNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744430; c=relaxed/simple;
	bh=/QrBKWvmLacVIjBNgZ5JR6UMddkPhDM057NuWIoe5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgmbLEGQmPe4mCkaE62/ZQn5GHyiayDgR5fE2CL4b+eRYeMNT2YnlInMqRFO5JACDf74FGmEiZ/1fA2hEp0rPlTCd+LYBsyabY2pI1AiHb9HzN3hLC4hrO9wrxqiV05Gd+AOAlvDCjIbaDCESO8+iJJYzeS1W10MRxk5VPVlQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVkhSWje; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707744429; x=1739280429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QrBKWvmLacVIjBNgZ5JR6UMddkPhDM057NuWIoe5Cg=;
  b=BVkhSWjeca9erUNmKyiEzE5mZ0I0tiLmnOcyYfEtoXj1rX+oEl1r+sEo
   I+XKYA0mRbigtkeDb3Kx5oXTU6IZC+t7/MA+cUMn8iqOLYR+5Hf82jod3
   C8qTv3FTDDgt5nA1JY3EamIQ1HyMNK8yQrvX52ZO2HSdKQ6ZGLPUIU8KH
   Y4IxIE++asUnlc+w4KCQL1qrR+VHiHAxgTYg00Y+r9qQdw701pIph7N5h
   xtYwyNusXamJLIVvv57kODdJJlqQrEcHwYfhu4h80zjarfXOa03bIYqUU
   GV81G9b4GfejteNBOXk4rcuUPOVgiYAJVtLTtz9zvBTjkATa2F2VNRDfO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5496484"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5496484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935067320"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935067320"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 05:26:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7797F138; Mon, 12 Feb 2024 15:26:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/3] auxdisplay: Add 7 and 14 segment mappings to MAINTAINERS
Date: Mon, 12 Feb 2024 15:23:55 +0200
Message-ID: <20240212132515.2660837-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mapping files are tightly related to auxdisplay subsystem.
Add them to the MAINTAINERS database.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e981d7274756..1c39b89ba749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3412,6 +3412,8 @@ S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git
 F:	Documentation/devicetree/bindings/auxdisplay/
 F:	drivers/auxdisplay/
+F:	include/uapi/linux/map_to_14segment.h
+F:	include/uapi/linux/map_to_7segment.h
 
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
-- 
2.43.0.rc1.1.gbec44491f096


