Return-Path: <linux-kernel+bounces-28581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26029830049
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA589B235DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB668F66;
	Wed, 17 Jan 2024 06:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpFaKOcn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC78F47;
	Wed, 17 Jan 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474362; cv=none; b=iDDpFRmDorX2xxMwf9ED+F1Ge8FSydli2c3es2DqAxPgIuxJ9yA7E1uRhpdx+bD0ihWKvRZ5SVf2WsUIXJnc6mG3zo+Pg54mKXnNu4lMPqSYMvlQDbqHeHFK4jCcQatEgnsE6BzZpdwiKjBZupVwwmEelKWwH3R0g4NJQ/I7UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474362; c=relaxed/simple;
	bh=KtZv8F8FHVAovFoALPdwWBhpOPjZ1RcvIXZt7uUSRaE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=joyJQoN2PP7PxzTL+G2N6KvYuFbYQwSEXW8CKfGzx0zNFtlQLaK1xLPr1kT1tUj1Zr52Vnay+6Lq12XWC1F7qLSnNvzhpNIU/e8kcs/IassOLv5avFJAq4ddlQ5oKd71Lp8dBewqc8ghzMYV199njiXik/wle0tkSG+1GegUGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpFaKOcn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705474361; x=1737010361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KtZv8F8FHVAovFoALPdwWBhpOPjZ1RcvIXZt7uUSRaE=;
  b=kpFaKOcnyl/3gioIXLm0rWiDw4WDlpI4AoswKXQifvwnYVtyZZuDwU54
   Q8JGAftIIlAmTX1OzLWHgsLosnViP6ctSeFPUZBa4pA39ekPaBUPiI2VJ
   3JFWnIk1YigrvskRZmasmU3SvVai+VoMOMmFViGcBeFtUH1dhu2OBnQJm
   pwqg+nFy3eAB/0m218rdgRpbn+tVkyUfmbk+jDcc4/z2CrQ8t11vzDjsw
   sg7TEtUGa3IbP1ZNtws+PrxIGM1DKrK969p4kudlbaEBwy7DsvCQQu4u0
   LidPhTOm2IHdpZw6wDtBDfoNBnN3ZMuHjHXFwyOPMjQNll4Y4Z/i2hy+T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7467391"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7467391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 22:52:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="733881873"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="733881873"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 22:52:35 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: bigeasy@linutronix.de,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	hao3.li@intel.com,
	lili.li@intel.com,
	jianfeng.gao@intel.com,
	linux-rt-users@vger.kernel.org
Subject: [PATCH] printk: nbcon: check uart port is nbcon or not in nbcon_release
Date: Wed, 17 Jan 2024 14:52:26 +0800
Message-Id: <20240117065226.4166127-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different uart ports might have same console pointer, not all of
uart ports are nbcon. When uart port is shutdown, only release
nbcon if it is nbcon. There is same nbcon checking in API
nbcon_acquire.

Fixes: 6424f396c49e ("printk: nbcon: Implement processing in port->lock wrapper")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 kernel/printk/nbcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 1b1b585b1675b..e53b8bebbb57e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1623,6 +1623,9 @@ void nbcon_release(struct uart_port *up)
 		.prio		= NBCON_PRIO_NORMAL,
 	};
 
+	if (!uart_is_nbcon(up))
+		return;
+
 	if (!con->locked_port)
 		return;
 
-- 
2.34.1


