Return-Path: <linux-kernel+bounces-92668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFAC8723EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D1D1F264C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883B1292FD;
	Tue,  5 Mar 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIqqERIr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C401128801;
	Tue,  5 Mar 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655348; cv=none; b=esrMcFhqdarPntqsSEE5UxWf48ZtuHiCuNNYr09PWfNeNQ9hfC97HMlqI6GbIzxfli9E58gyN+TcTYnn0tuWZz+f3iCA0XX12ixC4tuSTSkmgW7mNfdJvlp0Tv5CE7WAq41aRtlLonZj0H1Ukz9WHJ4xooy+CGbaYzLMlh8umeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655348; c=relaxed/simple;
	bh=BkPAKryaANKE6/afrAaBMwytR98XnEaGZtgIUqUEb3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLu8dYNI6FSBbPcHwK80CRwkRr3Kns2npTpMWVb+AAOK1RD4vHqITnZPrDOsW4KGHZYIUwTf5XCGD+6WBOYyHT9wxxs1avgHNN6oPcz1M5fSVMLDR21QpC2Wtz/hGIjaXEiQtz06NDycRSwgy0Xzufiff8iAsanN7DI4U+HusLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIqqERIr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709655347; x=1741191347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BkPAKryaANKE6/afrAaBMwytR98XnEaGZtgIUqUEb3U=;
  b=jIqqERIrawFBvfD7u50lkE4iV4IIYWxJfE8TZq3aSXboVoOeakTPrJpV
   sXDYi7Ai8lAfB/9jVxDjT8yQAUPClgal4FHxBYTSuMH6ZOsHWeYbXlikP
   KVEUQGBSACTH9ZW2S7v/riSBTfFlZC4J7keihGA9BA+qgGEUsNnqdNhrw
   C8CTZJ4lUHm8lYOgivrNQZvC2kwrc87pmmQf1WzxQl8t1czrNPgfVjVrU
   WtYE4NWdPVKv2UQ997rqPJptUTR5RqawkZy11bT+PNDUrhnnAzA2uaWmx
   BY3g5i0HGDCAuBd++Hdg1FYbIhY6RRC1LyY5Dfaifwx8zGL9S+fMrpEM2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4078454"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4078454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042665"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042665"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:15:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8184F1A6; Tue,  5 Mar 2024 18:15:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Julian Winkler <julian.winkler1@web.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 0/2] platform/x86: Remove unused intel-mid.h
Date: Tue,  5 Mar 2024 18:14:57 +0200
Message-ID: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-mid.h is not used in the drivers, remove it.

Andy Shevchenko (2):
  platform/x86: intel_scu_wdt: Remove unused intel-mid.h
  platform/x86: intel_scu_pcidrv: Remove unused intel-mid.h

 drivers/platform/x86/intel_scu_pcidrv.c | 1 -
 drivers/platform/x86/intel_scu_wdt.c    | 1 -
 2 files changed, 2 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


