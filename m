Return-Path: <linux-kernel+bounces-117011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919EE88A61A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D02C21AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC8146A77;
	Mon, 25 Mar 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="et2XpH8p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA438140364;
	Mon, 25 Mar 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370095; cv=none; b=bKMOJZr720ZLhNq9xB1dE3t3tOz14swiVpz4WAeUjYi+6Z4CSwU2BkbgNNSaAoBBEvCctIhruFuMRqxR8xDodc8DuwwOJtdG2tIGp36lAlhnW/txMvoY4zcRv9+JThJxBvmZv0d5N/yfE/CFsV4fWt6DKCOUHg05zv7eZlTVjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370095; c=relaxed/simple;
	bh=biGNLvjZxsnLB/YZsxsoQQ4aRn4EP/9IpoXiUDXO3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6KYYI7phU8whxbVwwus1NkeYB4d8oDdHLE1Omq477wyc1j5aDCovOsTejvlpdvJsqZyPN8D+fXg2gH0DJsdxsI+xld6ThbBC7u5Enw5JQwJuRGvWVTkyeE0GEQq2OYSxY6ngrCYHYwNl6AK7fKeOBqwRxxi3yvObF2bguWPWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=et2XpH8p; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370094; x=1742906094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biGNLvjZxsnLB/YZsxsoQQ4aRn4EP/9IpoXiUDXO3iE=;
  b=et2XpH8pfxksdOIy0CJkHtsBEMcD6uC7vKhqhATluMWy0bt2F0ZrR4b1
   E8fzL6BxJomf/jJHTA/xnZgobgJrUq1l0yDZjDoN6JzGeBSMXsgdi6GeS
   TNZ1Ki7ndwIn6PgCclW5wasI4SAlred5WdHqv28uiBLg6n9FC5Ruwnlrs
   K7yQxHfvKqROPr81GMd6aOMm2Uz4+/Jmb2AWh1AiVWUG16aIdwKg52EOk
   ryenLXS6Bo43WM0ez3VY2ZWqKqjHa6rG3Fi6FZ3lBErbLkD7IqjZdM7fY
   20OfJuyOgdnnVEhcjeeeOAQeejL9q1NN606h+QM2866Tv79v92Axw/2nD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549694"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549694"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070333"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BD3852CA; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 2/7] ACPI: bus: Don't use "proxy" headers
Date: Mon, 25 Mar 2024 14:32:58 +0200
Message-ID: <20240325123444.3031851-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cdee38ef9ba5..acb62d1d3306 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -9,8 +9,13 @@
 #ifndef __ACPI_BUS_H__
 #define __ACPI_BUS_H__
 
+#include <linux/completion.h>
+#include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
+#include <linux/types.h>
 
 struct acpi_handle_list {
 	u32 count;
-- 
2.43.0.rc1.1.gbec44491f096


