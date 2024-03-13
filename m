Return-Path: <linux-kernel+bounces-102273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D387B018
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3789D1F22A98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B412C7E5;
	Wed, 13 Mar 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6PNaMSB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB664AA5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351274; cv=none; b=DDzP6GRL/dAXfsu6jgRB1SvR4i3QoLE6LSO5rY6kW1bTaC9wNNgCe8NcF27vG0+tipZLD1ZSwdyMYG+y7sO8XNFyQx1w7awufzEI1xuvmeQFTVSmWHKhQHg2Hyy9nbxmMd9D+Htvij8PjFdZO7eDnEzlFdrUH3RjrXQbX7VIRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351274; c=relaxed/simple;
	bh=zZwi6ket5Bp0OVnwD8MWhyraFkgffX6f1oCYLK4Dq+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+z3CvElDAW5RASpjJBlOn1tUOgsAvHF1G+F43OV6l5G2fKcGObWpQcFVMnCGX+7mBjTzlcqk+ERBtJUl3J1mkm1/xkbZVPykT1MGWPHZvSG6X0gsB3m/XmVUkVo4M79SvjqxgAYmJubAtFHyI+uyRCgTsrT9FG2YakVt75bjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6PNaMSB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710351273; x=1741887273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zZwi6ket5Bp0OVnwD8MWhyraFkgffX6f1oCYLK4Dq+Y=;
  b=a6PNaMSBiy8FumhaY6crV7fUzPphnToHl49UhI9AGFt5TxngP/RPFQCj
   7TqTZlzUvMYUb/cdnMPDOrREAaHpSZCyzgEU5QM3P4tV/rO9WJHROvz5s
   boQE6mmH3fusWiouINMfiWNOp0aETlGjEPYLOvGtyhYTu415badlGH0lb
   O02PKATwllwaxbBbOwvWRVRKjheqWlfwKiaZR9fxR0WLRVa+0/Be2F4ym
   Q5lVbN9YDhuf34KUeUKvi6Da0k1k0EiitIgZSuyxYXqqWhSoBzk9eDXvs
   WxQJSWx+Moms/b748rI4X5r1+tm1uIl6RA9a+P6QZTFQj146/NRe3jBCD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15772875"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15772875"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="35132852"
Received: from unknown (HELO localhost) ([10.237.72.159])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:34:30 -0700
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: mika.westerberg@linux.intel.com,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>
Subject: [PATCH v2 0/2] mtd: core: Handle unsupported OTP operations
Date: Wed, 13 Mar 2024 19:34:23 +0200
Message-ID: <20240313173425.1325790-1-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make MTD core tolerate SPI controllers without OTP support.

These changes address the issue that occurs when an OTP capable
SPI NOR device is initialized with the Intel SPI controller. The limited
supported opcode set of the SPI controller leads to failure in the OTP
initialization, which in turn fails the probe for the MTD device. By
allowing the MTD core to tolerate unsupported OTP, the rest of the MTD
functionality remains intact even if OTP initialization is unsupported.

v2 changes:
 - Move handling of -EOPNOTSUPP to mtd_otp_nvmem_add()
 - Omit error message if -EOPNOTSUPP is returned 

Aapo Vienamo (2):
  mtd: core: Report error if first mtd_otp_size() call fails in
    mtd_otp_nvmem_add()
  mtd: core: Don't fail mtd_otp_nvmem_add() if OTP is unsupported

 drivers/mtd/mtdcore.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.41.0


