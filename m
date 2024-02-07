Return-Path: <linux-kernel+bounces-56680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADA84CD81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ED81C25AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696A7F7F1;
	Wed,  7 Feb 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxc0Th4O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE57F7C8;
	Wed,  7 Feb 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317945; cv=none; b=aBeO6IOxtRcyTxyMUwcsf4wqKlBpABJ65ifEybZByPmYSnC+iEGfuhkBrnGuQaElFQE9iWq0sGxDHtuEl0uS4jeKUfvwzpfCTmNV3p9I5RSsSF9bm3WiwUovqZ9BWxlL/7pXyGrLvgp4nFn2BOHCHnignoH+Pl36A3ssGHRpZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317945; c=relaxed/simple;
	bh=1ZgNNkR0cldx976JmgOIzZFuUQ84m8AjhI7dMPuUMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8/xKreunY3AYrhZlxzFwHCuzbNZeM4xPP3txiOcwAxzeRkEFz0GgalJlx1INLXgYog5lLytp02c9RbPfZJI6N6VPOS0eYOHs4gSQekQLBspOBIPWEFVRXiEl7Zeok3y/JV1grZifLzDzHLUBe3IjU5fAepIlLIogkutIPrKYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxc0Th4O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317944; x=1738853944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ZgNNkR0cldx976JmgOIzZFuUQ84m8AjhI7dMPuUMfs=;
  b=kxc0Th4OdgYDMflt+tYZrQ1n9yQFgn1Mb9I+k1ziZVLtXzyevUc2gyD0
   bd0rXJp9xBntcQMqXAayyzwMHtAq+Qf90ZSHyeqxwUlDvxAcCdBqPM92s
   333X5zCSrDcvCkC4fDBPnbyw9tjuqrRn/UTE3qKocskYpfh/V5INxU/rI
   bWdTBqd60aMnVlWKRpVHkQmDZGgGJGWdjtt//zUOk/s6T55uXTUBb2grS
   2O5AoU0uOQ0JN928RwXpcYwUQ0sgK9m0lYb5nsjydGUEBV6TEyZk0SuGk
   x/bf1zLvlpytDLocTDdycqfNtS/32D7um+4wcUn3Al8OasHXHkEr/DDpf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1155012"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1155012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="933798913"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="933798913"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2024 06:58:52 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Emilie Roberts <hadrosaur@google.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/chrome: typec: xHCI DbC
Date: Wed,  7 Feb 2024 16:58:49 +0200
Message-ID: <20240207145851.1603237-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In order to use xHCI DbC we need to allow the USB to be muxed to xHCI
even when the connector is in device role. That's because in DbC mode
the xHCI is the USB device controller.

In the first patch I'm just adding symlinks between the USB role
switches and their USB Type-C connectors. That way the user space can
find the correct role switch simply by following the symlink.

The second patch modifies cros_ec_typec.c. I'm assigning the PLD
(Physical Location of Device) hash of the port to the USB role switch
when it's missing from the ACPI tables. That should make sure the
first patch always works.


Heikki Krogerus (2):
  usb: roles: Link the switch to its connector
  platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD

 .../ABI/testing/sysfs-class-usb_role          |  6 +++
 drivers/platform/chrome/cros_ec_typec.c       | 11 +++++
 drivers/usb/roles/class.c                     | 40 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.43.0


