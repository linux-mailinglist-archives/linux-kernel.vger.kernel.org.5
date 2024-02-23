Return-Path: <linux-kernel+bounces-78656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E25861699
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2580288C15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70A82D77;
	Fri, 23 Feb 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKXlQE/p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9482D70;
	Fri, 23 Feb 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703885; cv=none; b=Ixp7nCh26yYUO7iHLFgVoNQNrO52NuT0Nf2jP02o1GGDS+VLu7vG9Y8LZ2K0NbrOc+hNQDPOE0BDNmLS5C5sQD/jnN8738d0ms0vhcxAtpFO3k6dnlLOfMz50ztw/346rSAO3dfsjjZbWW+tZ+/oNx1DIYcoXZlzwmguxLFlJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703885; c=relaxed/simple;
	bh=PJ7qAZUjqnG8gnRYHxFi5Iql67p+b7I3Dz9x0Ilr4Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wg7jH3RoLf1y5/8DDj3axmw+jWCVg5eXVe3l6Xpeb9MC69z5Z5XrzwcoKcpNIOuoquABX/4FrXwkDHU75DxfWGAaAZCxCU+CZ8n2RmZfclHUxRidiEIQZtNDJBNa4KOf6qim2Xg2V60+SWqALnvhfFFDp3t2WA54sb67aPLgh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKXlQE/p; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703884; x=1740239884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PJ7qAZUjqnG8gnRYHxFi5Iql67p+b7I3Dz9x0Ilr4Ik=;
  b=UKXlQE/pynbg+6mavRnE9sxp8jU7ZrjeeW4wlvaLqUpvZfgdL+rJswBw
   mWX59YkOpIIlROcOzPmO1f5HuPhg2E/hWicXpSTx3JOVGDyg3IIcIJeEg
   /pDG/FK/oWwc/j9+pCw1zTRC4j6v8Pj9tLUx4ukPhnQaKrT4dCjs/z2Z1
   NQWKnIN4apPOyhVJyLDn3V9k0I5SWMGTmD7lXXuSfWwGifU6gs7cRFh7k
   e7DfWWMAQqf6/OAuXU0LA+xVP/Ld+jfPopv8x/96EGD4wwTen6o2lfVbN
   2cJW8UAYLny8/Hevuv5ZBrEa7pyzwq/mdTrBKN84UtREMF0Ob5/wVsDpL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3187589"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3187589"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025350"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025350"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 07:58:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F358534C; Fri, 23 Feb 2024 17:57:39 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 0/4] driver core & device property: clean up APIs
Date: Fri, 23 Feb 2024 17:54:35 +0200
Message-ID: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two, but dependent pair of patches that:
- hides unused devlink APIs
- removes 'proxy' header use

v2:
- most of the patches were sent separately as v1, thus this series is v2
- harvested tags from that patches (Sakari, Saravana)

Andy Shevchenko (4):
  driver core: Drop unneeded 'extern' keyword in fwnode.h
  driver core: Move fw_devlink stuff to where it belongs
  device property: Move enum dev_dma_attr to fwnode.h
  device property: Don't use "proxy" headers

 drivers/base/core.c      | 58 ++++++++++++++++++++++++++++++++++
 drivers/base/property.c  | 67 ++++------------------------------------
 drivers/base/swnode.c    | 13 +++++++-
 include/linux/fwnode.h   | 13 +++++---
 include/linux/property.h |  9 +-----
 5 files changed, 86 insertions(+), 74 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


