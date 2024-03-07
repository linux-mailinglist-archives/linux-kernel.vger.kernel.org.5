Return-Path: <linux-kernel+bounces-95528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30879874EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C61C23D98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9817612B140;
	Thu,  7 Mar 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRf1EMhD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EA128378;
	Thu,  7 Mar 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814233; cv=none; b=T6fabSfkaz6Ey44PkJIgsdu7Uvxidarc9uOWKNY2+PQeHvo/+O/c9FzOL8gzuZetsHdbXjbwNNFBHtQyofvFQwNmrDG9RWIPuLIbl1YwH9tI3e6Spgpmeo9PuH7ID7Xs+/3HHZOlzbTaz8X7+XQWx2G6OsvzvpkZ3vbRCf4gqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814233; c=relaxed/simple;
	bh=6GQtux3pudsAagfM4Fr9aqwmgQBQNjNw38Za9xgt5Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svpyBiI/nwfIaAsmntbBmc5nozXpWzsQ5hWzVbqw+si9UAeRHTMsOLBUJPiIBaTttcCi7dg4h8C2l3Uxwi6XaSQNZpHDDsyfA4Kk6YZwtyfaCIw9Qxzmu7RLVljpdNI16GYJLV2U/vhX18OsweKaROONnUvJ6M8xUlfe863L250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRf1EMhD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709814232; x=1741350232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6GQtux3pudsAagfM4Fr9aqwmgQBQNjNw38Za9xgt5Q0=;
  b=FRf1EMhDghjwPizXgc3ykgvWmdXqHmFSYy9jxcRKn91Md/BcpWLKBR/f
   Itz40YCwK5RDyHEZ7649jGAtpoSPfGhNon9EkGeZlAqD+X4dQKMcCun+z
   3kPzxFWsr68RBMeP2BovtxTnsTckIFSI4glml0ym2mC4wgzwjAv305Z3P
   7SMhU1bSH4JCHkJ7rNIa2htV+PfPeL49vnEHsr+xW3DZ9hf3Fj2DDHjIA
   +BFNN6fTfkpTVI4C7PpbiEZ8jdJuKwS9vzk0dq2n6TcSuNydl8BEenxxb
   XXNo+mY5ghE5rBimgmF3Xj/6/IF+jeD51bn6jBYaoI6eIEF/KLJ0nOBFq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4343139"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4343139"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045983"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045983"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 04:23:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B82EA193; Thu,  7 Mar 2024 14:23:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: phy: marvell-88x2222: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 14:23:45 +0200
Message-ID: <20240307122346.3677534-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/phy/marvell-88x2222.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell-88x2222.c
index e3aa30dad2e6..b88398e6872b 100644
--- a/drivers/net/phy/marvell-88x2222.c
+++ b/drivers/net/phy/marvell-88x2222.c
@@ -9,12 +9,10 @@
  */
 #include <linux/module.h>
 #include <linux/phy.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mdio.h>
 #include <linux/marvell_phy.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/sfp.h>
 #include <linux/netdevice.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


