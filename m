Return-Path: <linux-kernel+bounces-88881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080386E7E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427381C2344F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7C282EE;
	Fri,  1 Mar 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhqCRRzY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB875282E3;
	Fri,  1 Mar 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316127; cv=none; b=GjhHt4ZVUHt+qtz5on/xMLHbkYisWvUSjDaBziuYZ1ib1E/xaXq8Z6FPU/o9TpuJrjncpR3fyz8NihuaNWbbqiYe9RA7rUrMqHDI2hjyMoxdM2Ehbkz5b3vKTBicogxJTxuJg3RIgyEsySgX/IEgiXuxXaeSi33ad1LJKhCKbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316127; c=relaxed/simple;
	bh=UUyWHLoPkB9Bu1l9DWFa4zWxrekkobsBXFOvu6LNVAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWMFEbVFMNaTDc+b0HK2ACNtD+DQVwVKHejBUHFHn8+2JGJecsgl9C7Xn5pUaPRJcAi1ICCw3quOCss0KopgxqAI7S/ps30iXXHrvi2WhZ79BAs6uhezIQ2E68q0VRBgUv3TrGsAz5D3MeBlpVNnALKG0VrHGU+VLMYSypGCUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhqCRRzY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709316126; x=1740852126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UUyWHLoPkB9Bu1l9DWFa4zWxrekkobsBXFOvu6LNVAI=;
  b=VhqCRRzY0aNsmbQLTb+jq5YrvXLvrGep1A2yURRc8022HM4FeMIEOf1w
   5JA1MIlQBATZhvFymZ5PK2mqwN6AOvSOwmveg12kZPmippuXcDtM1HgOJ
   PotaXJfQOCl+cyhdfKetD2FzrQxdVP8o7r5VtFkNYLWYPUmE5N0D+gZo2
   7P0h2K3jIuJeDY3s09Ct0N95BA2gQ8U/AtzKxSRmiuMospch5EzbYkLTr
   A8Tb7FcVmpDZxJYkv5yrKh/vfR/hXalV4iaYhmtJwDA2jUatk++GY7eWh
   K72ka6vWOKdSnML4QY54znGVbHyaewxrpZzd2abqwqsTe3IMGlwrvqBHH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684798"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684798"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037844"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037844"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 10:01:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1CE5128A; Fri,  1 Mar 2024 20:01:41 +0200 (EET)
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
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 0/4] driver core & device property: clean up APIs
Date: Fri,  1 Mar 2024 20:00:04 +0200
Message-ID: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
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

v4:
- rebased on top of driver-core-testing

v3:
- improved commit message in patch 2 (Rafael)
- added tag (Rafael)

v2: https://lore.kernel.org/r/20240223155731.858412-1-andriy.shevchenko@linux.intel.com
- most of the patches were sent separately as v1, thus this series is v2
- harvested tags from that patches (Sakari, Saravana)

*** BLURB HERE ***

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


