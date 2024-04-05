Return-Path: <linux-kernel+bounces-132375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01D8993C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C2B2221D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A211CFBC;
	Fri,  5 Apr 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+4jhmaI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59D18C3D;
	Fri,  5 Apr 2024 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287515; cv=none; b=FUelU5jIHgQJY1iWj1M/bTRkIJLFpYjiz325gAlDJe/dgvAiXrrl33Hi1QwgO+Z3IDevV4fAIEk4S5eA7AWvZ0ZL+1Wzec0xupdQM1YEHTClF43S0YV7+jKmiIZdy6DoM39vQAGmvhd6XZFNLbb02iIudL7dgz7Vcmp7GqZ+ooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287515; c=relaxed/simple;
	bh=mYEE6+yBYiMCn4Jhzmk4sKicAPrHeVZFmbpdpkp/jIs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuCH8v03fXkNf/9fKmva5HCnvTSfBvg912TLMvCZwRH+RjnYC5HF++TRSMDpppHYPbAdfPvAeT96HLO4upIe538XVjOHDrb4wwQnBhiCAudfOfa5qMVV3veUx4OVuWkaEuxeMHFj/5aZ+qHFT0wgOIUpa860oFYECUD4Ng3y/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+4jhmaI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287514; x=1743823514;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mYEE6+yBYiMCn4Jhzmk4sKicAPrHeVZFmbpdpkp/jIs=;
  b=H+4jhmaIhbp4OW001YHr8WLGzl0iS1x9rjbYnUwPigHV+DwOIhPSoSqV
   8o1NErWzrUWMZn8KUiuDLChTwzyK4I1EHDufws3Z/PzLmw+GiakkBBa6w
   CkiSyhpYf8IzHgTXZMJLKRHfM9KIuZmE2VRmPkEg01+gjwBWEP/lYqfvE
   p2TgzCQe+hTYySrYOPrY04zYVloLYWQKLh5ZFR2QpRD75E8k8puW1pHai
   m0f+8E600hcadjGv60z8WvaQkxTUWAmbHwGcs5Lrix+bE2ze8z53qw7Nc
   K6IbOz9g2gaHsAsoOpIeLnHUPGwlNTr70x70xMna586ZEdGeWw5nu5y8w
   A==;
X-CSE-ConnectionGUID: qiOIyLFETKS4paW9Jtyevw==
X-CSE-MsgGUID: t0M8t0LYQQyycAvG/KE8sA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112457"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112457"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:12 -0700
X-CSE-ConnectionGUID: /SEQoILzTmm2jgJXwEqqcQ==
X-CSE-MsgGUID: ZzXRZt6+RkymZ/gus5iUaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955980"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:12 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 1/9] platform/x86/intel/sdsi: Set message size during writes
Date: Thu,  4 Apr 2024 20:24:59 -0700
Message-Id: <20240405032507.2637311-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405032507.2637311-1-david.e.box@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
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

V3 - no changes
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


