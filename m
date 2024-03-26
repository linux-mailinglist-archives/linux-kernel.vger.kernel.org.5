Return-Path: <linux-kernel+bounces-118391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74388BA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7348E2E3F46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864A12AADE;
	Tue, 26 Mar 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1Tf4vkw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CC84D0D;
	Tue, 26 Mar 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432832; cv=none; b=Cmrzr5YFjJAaqS4ur+bLSf6sZhpys2U+R3eqPIelfXEvqKiSaELrI4pwWVG5f5Zu31zNVVEw4SjMQJciOVGcLnsM5j03TwzwmR+buMcW6QhO4ZpDJksac7YFtMozHwQ1RUlQ0ifBbz8hlgPWyJX8bMmPZkjvCuIecjB6DDLqm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432832; c=relaxed/simple;
	bh=fzNeaLHkLg0VusIvgEvDrmnEwarZkEwpZ+t9NlQBe78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIfRQu3ZYjV15xnA7xmcRSUqV/eGJfTYCnfyei/U9Z6pMfKVNLcKEJDLSxDDgI2ljT49DzAzlaUotIQQDgmQpvMxGFY3L0zzq0w5wi2d/Kv7hNNUL1FxkRHL/lHrFu6TWLOq2jAHPyk0XHbNjpwnyoY0jW1Yzap54e3Q/9HfAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1Tf4vkw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711432830; x=1742968830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fzNeaLHkLg0VusIvgEvDrmnEwarZkEwpZ+t9NlQBe78=;
  b=E1Tf4vkwDsF4H+kAruLCOiCtS6eutFzaS8HlmSLcIKPZvqPEWOW++RDs
   xVgyFyKwr6yoTAzLXhuEoUZCjGfiXMrsYwypvJkJ+K5AxAs++l+EOQONP
   v9+MiMHpOw9sUK7Ccwb9YuCDLzMFzUoJ1427iEL+AyLJ2Zw8p9PFYFW/9
   Q5Jxeye1Xby9p6bk9a5ley8TUU7n439W7MIJBwUb372mJ3racs+ZsjUMZ
   T7QpdyiUxytmPgL10K/wTh09Tt5FqUGEjhZZHAgWC5XZ4qwcmEc1Ip6wY
   1ZX40/Ufpuxq4NFutN6lH1mXixMzgrh92cFX/BDWLhp/h9CJX21XBCNv3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6327507"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6327507"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 23:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16513653"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 23:00:29 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: bus: don't clear SDCA_CASCADE bit
Date: Tue, 26 Mar 2024 06:00:21 +0000
Message-Id: <20240326060021.973501-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SDCA_CASCADE bit is a SoundWire 1.2 addition. It is technically in
the DP0_INT register, but SDCA interrupts shall not be handled as part
of the DP0 interrupt processing.

The existing code has clear comments that we don't want to touch the
SDCA_CASCADE bit, but it's actually cleared due to faulty logic dating
from SoundWire 1.0

In theory clearing this bit should have no effect: a cascade bit
remains set while all ORed status are set, but better safe than sorry.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index f3fec15c3112..05b2db00d9cd 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1474,7 +1474,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 	}
 
 	do {
-		clear = status & ~SDW_DP0_INTERRUPTS;
+		clear = status & ~(SDW_DP0_INTERRUPTS | SDW_DP0_SDCA_CASCADE);
 
 		if (status & SDW_DP0_INT_TEST_FAIL) {
 			dev_err(&slave->dev, "Test fail for port 0\n");
-- 
2.34.1


