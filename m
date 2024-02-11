Return-Path: <linux-kernel+bounces-60697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E688508A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB38282B84
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA175A4FD;
	Sun, 11 Feb 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J46tEfeY"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877159B68;
	Sun, 11 Feb 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707647974; cv=none; b=hgn1C5EnOez59l5rzUqtxnsNB37C21h7G6Okx0zo0uH1/yZ2scRGlhPHn0Blaq6ttvWm7vUBbAOX4PG4z1JDdcX+Zd6NMVfbW8+S3oTNpsaMfRLX55Y2BOS+U2g7u3EiqdpMkR5IY+92R0egMoiW7R9nLCkacD33rBJy+6YukrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707647974; c=relaxed/simple;
	bh=8gZKK1OoDTGMFjs2+UcM47OnjAJcJ+AHRt+E/isRwKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAaS70rqaw1XPsZpmSg42RppiVdO8lnwflTP8sXOFIXe9PUp2wWX5A4oPihRQIKEZlwgArUapxg4Huq4kvaCOsE1Zd7hw8uSBl4LEmh9b8tC3kQxqFY/BmH+UV610mTxxA1HuF88iRVj8orJmCLUeVI6H27TRMwidt0PWLNSfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J46tEfeY; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707647972; x=1739183972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8gZKK1OoDTGMFjs2+UcM47OnjAJcJ+AHRt+E/isRwKE=;
  b=J46tEfeY83mzps4NagsHWQRAlqlehLRT6AiDWTHRX0t6vVMNVobu9dDq
   f8vIAf+djsoc9qVCpqiOorwzIIadiz+5ajQfpQbSnZ+lJhWy4+k9ZzRBC
   jKrkvbFH0yp8IIxgRfukN3auI7fBG5ekD+3Uq39LQPWVRu20z66i3qhgL
   e4LxNYdfsIFluzZrTH6ibVHZicahgqHMIEXqGzvZoOQJ3PK0CKniAl4Yl
   h+lNqr3aRmKr8ihZm6XIoKl6kirbEl17mBfG5KTO/nXys14nM7JLCXk5C
   mw8P1ISEPIUEfGwb4kdw3tD5+v7nBbc8Wc3a7+3MRVEQHG5jc6bzYzWf7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="396053102"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="396053102"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 02:39:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="2631669"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 02:39:30 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 2/2] mei: me: add arrow lake point H DID
Date: Sun, 11 Feb 2024 12:39:12 +0200
Message-ID: <20240211103912.117105-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211103912.117105-1-tomas.winkler@intel.com>
References: <20240211103912.117105-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add Arrow Lake H device id.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 1 +
 drivers/misc/mei/pci-me.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index b10536e4974dbdeed046f4f0..aac36750d2c54a658debcca5 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -113,6 +113,7 @@
 
 #define MEI_DEV_ID_MTL_M      0x7E70  /* Meteor Lake Point M */
 #define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
+#define MEI_DEV_ID_ARL_H      0x7770  /* Arrow Lake Point H */
 
 /*
  * MEI HW Section
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 1a614fb7fdb675e77bcb6be8..8cf636c5403225f7588a2428 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -120,6 +120,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_H, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }
-- 
2.43.0


