Return-Path: <linux-kernel+bounces-87080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945186CF29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C997B2850C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD504AED8;
	Thu, 29 Feb 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieCkvpQH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA0160642;
	Thu, 29 Feb 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224076; cv=none; b=ggPiSVUq2hrqdPI7OXVIs9AiJcf/JEMDmMXf0X1gDmwEBuU8jEd9YTDmA1AqPxm+OPKf70RbrA/9uRb5Ktay58t75dIt4MS2LicosLAJljkKmau0UtdlnA97Fnlg3HXSwjCry92gEmYFQHogYHqHP0PhgrW5o9hbqcIGZTT14ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224076; c=relaxed/simple;
	bh=ejvm1bmnxBFMRwAGP7H9c0MFEeLIiilFk0iRRW12wW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPvTxDIbg10BJ1h2Du9tza/SZqDp5knLsXkCm3jENhsp6Z5HVASy6OhjtblOaG/mEy8BYXAobKx+RN0jtGyXNHvmCft40/bMWXLTF8nFBivURGatTDxzROSupGaKrVtG/zCgluhycVfcaMP4dBJw7B81gT6xAqNsJO8DkS2UIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieCkvpQH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224074; x=1740760074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ejvm1bmnxBFMRwAGP7H9c0MFEeLIiilFk0iRRW12wW4=;
  b=ieCkvpQHJtxnjSizOR4ld81czQ8F2KehjyHqpRA6DbL92I1b1GPg9kUP
   Bd7ncMZEvxpdk8r9niSAwD40+UomwCOvTgWnfYf3oYgM0P0eJwPjX0wxp
   FQ/bNuyz/H4saRcOB8xRQWIPruNgs/Jaf1w0XaqcN/V6w8UPEFNSSAVbF
   bUmPvIenRdyIPPLn8lORDsGXiKN4VLflaYX6ZyGqMHiD8Lpw2DsvpiHtz
   8El5YKKd1B+vd0wHz8pKUVWm9jmBokH3v8tCWChC0HaXCTXr7L4B0Uh3K
   SDH6OvoWDzfvop2HGQ3f4bifg42WdS3IzDzuBi8X+NA0CD+KxJ/AugYMc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6660703"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6660703"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036135"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036135"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 08:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 821A023A; Thu, 29 Feb 2024 18:27:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 0/4] driver core & device property: clean up APIs
Date: Thu, 29 Feb 2024 18:23:42 +0200
Message-ID: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two, but dependent pair of patches that:
- makes some of devlink APIs static
- removes 'proxy' header use

This is rebased on top of latest patches from Jonathan as it has a minor
conflict in property.h. The series can be applied directly to driver
core tree with reduced context, but it may be better just to route it
via IIO. Greg, which way do you prefer?

v3:
- improved commit message in patch 2 (Rafael)
- added tag (Rafael)

v2: https://lore.kernel.org/r/20240223155731.858412-1-andriy.shevchenko@linux.intel.com
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


