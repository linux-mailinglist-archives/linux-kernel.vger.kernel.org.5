Return-Path: <linux-kernel+bounces-84245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6586A421
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2801284A96
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637C1CD2E;
	Wed, 28 Feb 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDvdmSUR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7D381CB;
	Wed, 28 Feb 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078420; cv=none; b=QuBcEpiFD30RnlzT1Y/+XM3Gcw0RA9r/qypnRmnwIn0Tm7rcDkwMcDAwE8s8F6hE1IkD8TNuKnD5Ee8tBF6nc4WGyVOb/JQQacrRH3TpAT74mMBHVT6N6SRmUMylKTMQTqhbRO6HGvOqOMyc2MOQrtKwLCydzWbqP8c4mWR5xag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078420; c=relaxed/simple;
	bh=kTuJBiH0He/AE/VlrZQG9PWPYUT9ap2kxnqVhwAzT6Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc3YEn38TDYJ5ACJ1l6HATF+cMnTi+eERJ+R3J92K/LGCoWZUgt7VCUOc7JzEjacxliX5NARoaYKqa6phbu6K9LhXlz3qpG0oMpyHL+e7C5NWiZ7ApRqqKo72FCXng/24POrzfo6ryo0L43TEhD92RIE/7ofZz7eUkt58zQmcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDvdmSUR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078418; x=1740614418;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kTuJBiH0He/AE/VlrZQG9PWPYUT9ap2kxnqVhwAzT6Q=;
  b=IDvdmSUR6kYU4pmPzIpQ9Gf1uab5TOsbW/ZI7gDVahact8+EfyDDokgr
   xYCMBYhxgQ9EO352jB1riDdxdR1dVThVDlDFdSoI5tqNAOer+ijxKU+Iw
   cnlzSd2/fWayDHJCClDuFq4+JVaeKKwO14Wz0x/LmxlvWGigROUqt2F/l
   tY/LWcx0IX6M8MZ097eVa/kxo9RJGpPtwdP0wHuqUjYn7Qf2ik8a2Lbyl
   7Tr/EUnPYWEj9dcFXx7XvKvXmlEzt+DafWJk/9t6j8sMApH3fURHmKP0h
   okB+sq+19R/cIuvFS1ATR8ARJEwRciZ/8zC3sphD6m9Aloa9LzpPJX8XR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25919833"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="25919833"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7439162"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 71BFC580B9A;
	Tue, 27 Feb 2024 16:00:16 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 1/9] platform/x86/intel/sdsi: Set message size during writes
Date: Tue, 27 Feb 2024 16:00:08 -0800
Message-Id: <20240228000016.1685518-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

New mailbox commands will support sending multi packet writes and updated
firmware now requires that the message size be written for all commands
along with the packet size. Since the driver doesn't perform writes larger
than the packet size, set the message size to the same value.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V2 - no changes

 drivers/platform/x86/intel/sdsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 556e7c6dbb05..a70c071de6e2 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -252,6 +252,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_SOM, 1) |
 		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
 		  FIELD_PREP(CTRL_READ_WRITE, 1) |
+		  FIELD_PREP(CTRL_MSG_SIZE, info->size) |
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-- 
2.34.1


