Return-Path: <linux-kernel+bounces-99840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31C878E23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F4E282C01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0610A0F;
	Tue, 12 Mar 2024 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyLnLaqH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80E3C484;
	Tue, 12 Mar 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710220818; cv=none; b=oUwrZp6N0LWntKpsgnJz9IvATRKr48KQ1RUIVxaJKyBgMVjeZEM/UCAIWM8L1Ull6ZiW5eXZB9DEW1GMh5s+UWXM7csiIzcU7isnhvKZjuq8gS7auAWdEM+GjcaOawY0atKNbfKjFVMjqvymngmSPpZG1EksqeALXtohbAu3wT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710220818; c=relaxed/simple;
	bh=BYkFiuglXoRFHRlY1FsgrFFiGDBpKTXgHjkkepTgQ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLlWO8pTWdoj2YKVcqnTXHavxP9OI8QBKsq0QVaPu2fPIifGMcYrKUpflstUcly4HLpTyA3mQPT1f43mdhPv5K7V6mTILswysh7IuYaKuwmaHBpgIyM5H1W163q61Wr34zlM+Xh05nU7n3QDaRohNDn0Dm+lECoFTMVD2AE4EjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyLnLaqH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710220817; x=1741756817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BYkFiuglXoRFHRlY1FsgrFFiGDBpKTXgHjkkepTgQ3w=;
  b=EyLnLaqHDWJfb7PnvjUqaz1ezN5XA6nNNlYoj4Jdgk44vJ6SuAYjGbWU
   0VxHOD0HEbVOPHpHmJM5e4cd3uId5OYpCy00K6VzogoxNPyHr04TR+6aC
   wsKbBp977/lyEtIL384JzirC23lh01chOji5rWyPPX6UAQ9b/Rn2UUza7
   y21KujE+UT8WDeXyTMUFolBcWG6K9qmQWuNwhYMkIP/5O0O2l8CWQPwOt
   k24QsEvJlFA01I/p7h1CofxKp09c5td3tED0fyTIg5rdqKndTjYGKzgNE
   6q4JwKT4ct6ssULpOmp7fzjsPm/pHT8obL/PteL9/H9OSubwJy4/VYuNT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8677125"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="8677125"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16056387"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:20:14 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: me: disable RPL-S on SPS and IGN firmwares
Date: Tue, 12 Mar 2024 07:19:58 +0200
Message-ID: <20240312051958.118478-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Extend the quirk to disable MEI interface on Intel PCH Ignition (IGN)
and SPS firmwares for RPL-S devices. These firmwares do not support
the MEI protocol.


Fixes: 3ed8c7d39cfe ("mei: me: add raptor lake point S DID")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pci-me.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 1f0d983d3f06e5385b30592b..9b8021eb7ab5f8eefdb89ab1 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -116,7 +116,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_P, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_N, MEI_ME_PCH15_CFG)},
 
-	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_SPS_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
 
-- 
2.44.0


