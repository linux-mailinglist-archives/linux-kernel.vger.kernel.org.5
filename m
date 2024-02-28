Return-Path: <linux-kernel+bounces-84246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0176986A430
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3EFB298CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BD24B2C;
	Wed, 28 Feb 2024 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WILPckTW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF22364;
	Wed, 28 Feb 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078421; cv=none; b=a7LP5QPfAMJGwSArDZH1nl0KOFSq5DZJJd4aSPLBUt6NDvH6xq9JtzDENYEPZA8wI1N1OFi2ctbVfoh4ogXsOzSq0Xe11KZ7cRqzaP8T6hK5/wEOj821i5h8tcNBvc7Sk0c0aY8Hwcovt+ukERcGegVP5R31abxkmfZM4FWRNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078421; c=relaxed/simple;
	bh=Cjids9Y5fgG2A+arpd84T9h3UMgARRlLtTbh6HeGD1E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbkEQWP4A3vjoepFOcYwLuaxVHVojv7JzWP5b2GHhRVGfcvF0GFlrt8gKBYTNYqq2mMTRpQMt2Nf97vAitj1VrcyHEjuuLiLqOfxHCpc2Oft7TRhcdp5/eFeasAJkBD2M3CQyCvcAdg65NXsVH9vdoX+xFC4DII2AmKTAzvUVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WILPckTW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078420; x=1740614420;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Cjids9Y5fgG2A+arpd84T9h3UMgARRlLtTbh6HeGD1E=;
  b=WILPckTWAqOQTDXh4nWq56bwd7ShdkPP7fXKWTvWL+9ASN93Un5i6iJ3
   ZNqH2qszStxHmYISDEaRBdiVxOvQX7cwQiDWwd8UMHdReGJibT96OO6cf
   Ezw1GJLCFt8hmaOmxCEZlNzOsKq5Ndjht2uB9AePm0QbHdshduZOVF71s
   9OEWwLP6Ap9eCqM19mkmF2DdQvLzRWiy14w5ZRikHV26B5vnIypkdXkdm
   U3+s8hAAKK970RIte1aVYeqdVuwI0e653fX1JZQoszAF+puoAybm3D0OK
   aiOt40iVmBr6jrfP95LaQL4q5gF0HEPYKq+GlJ20GmVOVPXCCykGz19PH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604937"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604937"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176940"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id D44BF580D7F;
	Tue, 27 Feb 2024 16:00:16 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 3/9] platform/x86/intel/sdsi: Add in-band BIOS lock support
Date: Tue, 27 Feb 2024 16:00:10 -0800
Message-Id: <20240228000016.1685518-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per SDSi in-band interface specification, sec titled "BIOS lock for
in-band provisioning", when IB_LOCK bit is set in control qword, the
SDSI agent is only allowed to perform the read flow, but not allowed to
provision license blob or license key. So add check for it in
sdsi_provision().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Move sdsi_ib_locked() check after overflow check

 drivers/platform/x86/intel/sdsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index d80c2dc0ce71..bb3eaf5eb382 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -67,6 +67,7 @@
 #define CTRL_OWNER			GENMASK(5, 4)
 #define CTRL_COMPLETE			BIT(6)
 #define CTRL_READY			BIT(7)
+#define CTRL_INBAND_LOCK		BIT(32)
 #define CTRL_STATUS			GENMASK(15, 8)
 #define CTRL_PACKET_SIZE		GENMASK(31, 16)
 #define CTRL_MSG_SIZE			GENMASK(63, 48)
@@ -346,6 +347,11 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
 	return sdsi_mbox_cmd_read(priv, info, data_size);
 }
 
+static bool sdsi_ib_locked(struct sdsi_priv *priv)
+{
+	return !!FIELD_GET(CTRL_INBAND_LOCK, readq(priv->control_addr));
+}
+
 static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 			      enum sdsi_command command)
 {
@@ -355,6 +361,10 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
 		return -EOVERFLOW;
 
+	/* Make sure In-band lock is not set */
+	if (sdsi_ib_locked(priv))
+		return -EPERM;
+
 	/* Qword aligned message + command qword */
 	info.size = round_up(count, SDSI_SIZE_CMD) + SDSI_SIZE_CMD;
 
-- 
2.34.1


