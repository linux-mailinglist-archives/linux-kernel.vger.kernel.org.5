Return-Path: <linux-kernel+bounces-167957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05E8BB1A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E421B21DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F33158207;
	Fri,  3 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7IQmpPs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D81581EB;
	Fri,  3 May 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756783; cv=none; b=r9HX7Uvsh/jWVtgupKwIEmE9OakDWQbgGZcxaugeHmabyc+ea1XqNmJzH/fPxeEuDxN4zXaHtoFG85k6p9veLCt3LAcetjmOreZinrLdGEqI4jQqu3IQSmP37baCiDC+mTxpZjNBDQJvvrcItyaEkfjH2opyMBPc1/wfcrFUqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756783; c=relaxed/simple;
	bh=t4GElT9Cf8GLEDUkp9KzuLxTLCrrLC4H8X0vZ1KYv78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDvaYLSVTug+6cf7SKlW0I9jj59lptWpajmYdv6az3guqePHxBv0pGUwLGP27gtZEQ8qJMNeNIb7TNZi/UvKJlWFpQ8EH7yYUpx8MPQk5eYSp8suF8AVR2oBmVwAIy97bqF0WN2hRiEExI1wkQjncrFH7pWn0C/1Sh7eFIc5Jo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7IQmpPs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756782; x=1746292782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4GElT9Cf8GLEDUkp9KzuLxTLCrrLC4H8X0vZ1KYv78=;
  b=d7IQmpPslcvvXo0vYVMNLgeNPU9kBt7euWq9mTeK/ivSMS3/ms8GO957
   UXLcCo8CsNlABKnAMe7aekn9HYzx7RvJjDz4GsILbSRpsR5wCm0Fs2Qc6
   yPnulybf7DPIgzbqcfpsL6YArsEmnxjAMudyG8ot92zDBs1hIaiAABl8p
   N+2Zim1St0KsHR6iWNAskcUlXtreF39cLuCFZcFScVPPeRUbN9vRN8Sbb
   2S2BsJJmdadAG3LgN5xgcqbQs5TehdzGtHM8Lj7zKiJZ/edfv073PLatj
   Jfih3KVn5XWSnZEtADsCyDc0kvBbKG4P6/VgVPjIxu8GRwAKgLxC0OVsJ
   w==;
X-CSE-ConnectionGUID: kP+OifPvQISDihM85cjL9g==
X-CSE-MsgGUID: 06QmPl+rSdy0iNW9YbLC2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107794"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:41 -0700
X-CSE-ConnectionGUID: 7aRZWgPJQO2+ptUny/k7Kw==
X-CSE-MsgGUID: TPmb+KzUSbK2l2j3IZa/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415412"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2A66093; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 01/13] serial: 8250_exar: Don't return positive values as error codes
Date: Fri,  3 May 2024 20:15:53 +0300
Message-ID: <20240503171917.2921250-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI core may return positive codes for the specific errors.
There is a special API to convert them to negative stanrard ones.
Use that API to avoid returning positive values as error codes.

Fixes: f7ce07062988 ("serial: exar: add CTI specific setup code")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 5e42558cbb01..9930668610ca 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1162,12 +1162,12 @@ static int cti_board_init_fpga(struct exar8250 *priv, struct pci_dev *pcidev)
 	// Enable external interrupts in special cfg space register
 	ret = pci_read_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, &cfg_val);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	cfg_val |= CTI_FPGA_CFG_INT_EN_EXT_BIT;
 	ret = pci_write_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, cfg_val);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	// RS485 gate needs to be enabled; otherwise RTS/CTS will not work
 	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
-- 
2.43.0.rc1.1336.g36b5255a03ac


