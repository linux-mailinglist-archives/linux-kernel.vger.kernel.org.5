Return-Path: <linux-kernel+bounces-166588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97EA8B9CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B081C222EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF8156C63;
	Thu,  2 May 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHWSMkkJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC4153BDA;
	Thu,  2 May 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661201; cv=none; b=egAaDwjAa331fZO7TY7HHBARR3rB+tFVtEJeAWPyAZNAk/ePxutfHTbLsQO44Zyb8NK+4ij68zSKZcRfjwAgBovg0GhGXYLGCA7J0qoHjMbZYc7F1gOSOCgQK+YP6rGOlckKnvArOQBky0z0iZscWamTJmBgcgr+4sDOkoY3plk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661201; c=relaxed/simple;
	bh=gwi0Y1q+5n0D0n3Bzr328+LnxrPKT8VdPbVuxfggMIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqNKCBIsjFkhcqPmMt+WDETeSUlyTk7FImHDGcJC3rErlnh8bNuWeyQiKLV2tZwK1T7YEfINRhSFt+oRUfudgbNv/xTdwQ+JX4G7w6jbihnE5/roDx3ZQxaZdMDzA8fSwCQ5yE+gdy6a7jolp+jlne/VR9+2UFlDGX/W9v2HCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHWSMkkJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661199; x=1746197199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwi0Y1q+5n0D0n3Bzr328+LnxrPKT8VdPbVuxfggMIE=;
  b=YHWSMkkJxWBAJ4y7LaUSux6J6V17SgYTS7Iqj8Hu2qhy7qdseezv+BrG
   0ltE5tU8zLPcJ1vDxetLcgnmRqftbvXFyEoZuRFCSfUjpzo7AjwdTJN57
   f1jYda1BXysk0144pab6Io1cYgOdGpVWGQAheCPqEb7Fb+C3IQe0zu4+m
   Eru8VtuHn8aismiiyaOVdNsMq4Jwa9klus1+6GiqgNNMjQ64Hk8m0gEpk
   TvEF/oIFfkMdsJs8tPxIkkj+kyFAQ1d1eYZIUJs/RKFJswz9aAQgIYQ3P
   Qn1LdKM8zD8Q/Fe3a9mc+5+rGcfYCRysHSk+b/EkZff9s7oQ6bXYEZkiY
   A==;
X-CSE-ConnectionGUID: NPRm8N1nRj6DEbQ8xjexIg==
X-CSE-MsgGUID: V9IVdJrmS2e8NKfkpaxoAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306082"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306082"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:34 -0700
X-CSE-ConnectionGUID: qd5YiABuQtCuxaNPVaecrg==
X-CSE-MsgGUID: aLo5MOr0QiGn4zKxz6NZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632824"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D55A61A5; Thu,  2 May 2024 17:46:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 02/13] serial: 8250_exar: Describe all parameters in kernel doc
Date: Thu,  2 May 2024 17:43:56 +0300
Message-ID: <20240502144626.2716994-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel doc validator is not happy:

 warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17c15x_xr17v25x'
 warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_fpga'
 warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17v35x'

Add missed descriptions.

Fixes: f7ce07062988 ("serial: exar: add CTI specific setup code")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 9930668610ca..150c4abd92fc 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -715,6 +715,7 @@ static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
 /**
  * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17v25x
  * @priv: Device's private structure
+ * @pcidev: Pointer to the PCI device for this port
  * @port_num: Port to get type of
  *
  * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
@@ -807,6 +808,7 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
 /**
  * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
  * @priv: Device's private structure
+ * @pcidev: Pointer to the PCI device for this port
  * @port_num: Port to get type of
  *
  * FPGA based cards port types are based on PCI IDs.
@@ -836,6 +838,7 @@ static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
 /**
  * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
  * @priv: Device's private structure
+ * @pcidev: Pointer to the PCI device for this port
  * @port_num: port offset
  *
  * CTI XR17V35X based cards have the port types stored in the EEPROM.
-- 
2.43.0.rc1.1336.g36b5255a03ac


