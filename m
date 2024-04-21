Return-Path: <linux-kernel+bounces-152505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF88ABF72
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AD61F2100A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10558175B7;
	Sun, 21 Apr 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a78ZuRWR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD3168A9;
	Sun, 21 Apr 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707814; cv=none; b=HVaaEgY2ND2+dm2pGETNX8oZqlUZ82nsKa8Iji0BoyHAaWKIQsRlvPDdlWuKhsMt4yhoj/8qq5aC7juDDY8zIgy9hp4yAgkVQTRScSqXhtpk1sUTB+cg1J/YR9O+wnhN7rmWntfm9m4itOw7CkP2v5xQop0JSdwkIIvgLq6YTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707814; c=relaxed/simple;
	bh=YS/cOFZkCM2X+3vXF+LBITqYIkF6kpEri0ympu3mVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQhvWiQfjN6DLTkiNIxyW9NPorb/4MHuc6iJ782yuTQs5RvKzvwYUFl8M9v6XzHAxz9hxnrrbb9tXTtHvbJwsSBdCxMN3jVGybTEhVJKyZzk/CoqEANxIFVIVYjbOhRtGjamNpt8zXVgepyOLX7YV165i4a2lezlx2/8nySk5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a78ZuRWR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713707812; x=1745243812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YS/cOFZkCM2X+3vXF+LBITqYIkF6kpEri0ympu3mVQw=;
  b=a78ZuRWRs6e0whKB9vwdM6QEqUrdXfuckhWGSukXWlCfQ5wajeTEbH/9
   71CIdMAmqNG/EY4q1TMkXJwdboc28T0Mr2mh5BduTBERhhGNh7eYm0YDu
   fU7NE+YjQmBtRZp8JudnJDiWv3ZkDpKoeT8iH5BvIemaUBtRsmf6II/w3
   N0uDnDz9tsiO64swB1ON8GtieEvP0QshgB9zRdPiKBKFS/rpByYzA0f7N
   OTZoACpxYjm37/O+mxWEXo3ISSDRQFeQisWxUJCJW4D4C5cj//9crjP9r
   1T4/gNaOFgmfmRVg2aFZQvwCZSrLoWi872Do8oGE8sygD+zo9aOP4xA7o
   w==;
X-CSE-ConnectionGUID: vaWKR3nOQZKK9JXV4Oc6kw==
X-CSE-MsgGUID: GfCy3T7RQXKTGKrDQz8uxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="9406996"
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="9406996"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 06:56:51 -0700
X-CSE-ConnectionGUID: /TYa/mG3T1m+rDbry8JMxQ==
X-CSE-MsgGUID: X4P6TX/bSRKWdw1AVGwx9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="28558801"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 06:56:49 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc] mei: me: add lunar lake point M DID
Date: Sun, 21 Apr 2024 16:56:31 +0300
Message-ID: <20240421135631.223362-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add Lunar (Point) Lake M device id.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index aac36750d2c54a658debcca5..c3a6657dcd4a291a09d2f5ab 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -115,6 +115,8 @@
 #define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
 #define MEI_DEV_ID_ARL_H      0x7770  /* Arrow Lake Point H */
 
+#define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index b5757993c9b2af992c54468a..1db01718eafae806087c6bfe 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -122,6 +122,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_H, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
-- 
2.44.0


