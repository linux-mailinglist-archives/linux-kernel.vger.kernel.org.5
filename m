Return-Path: <linux-kernel+bounces-34730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C98386D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CC728292F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546253B9;
	Tue, 23 Jan 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWC6hzHt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405734432;
	Tue, 23 Jan 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988462; cv=none; b=sWjU/OK6gRJ096pADm2JDTRnX4JP9kPn9iiRuvaCixe6lzyqcTkJ92XVMOiMBIcufp0BTtkp2uIS4l4umePLOgXwpGv6S2nl2uSwrSp40AhYI5ZrnFZW+y4M3lbiSNoDYvGWc4uLerBm9v7ycMsBT8uRk7+XXkV6is1T+4c5kI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988462; c=relaxed/simple;
	bh=gdiyFjvMqWMG/af6i2COjazfjxZBQgaYcm1PP8azrvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABGPyMgZ1wyz0rPGM+d7sU6mGrzXiqX3jWBxw44D+UtsJpFIuHeddD5mmnCLInLIReRA5lXgREJUajC+BMnvmLGCDU8vfX+KEo7XhoECGP4CvtWn/0AT5UQZmrsXLiVkNDjmXsJYSVWKY3x3BXpXeDvHqETc/iGQKKxbqAqJDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWC6hzHt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705988462; x=1737524462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gdiyFjvMqWMG/af6i2COjazfjxZBQgaYcm1PP8azrvk=;
  b=IWC6hzHt+hGgDxM8mnhmOKjK757opWdvGQIPrJ3S1sCrDPlWBKRCNmyI
   WkGNJg1nbwrHGt0hybHhtSNKtWLhEcm1GOdFE6qIUV5EwZNj3Q1o5BAt9
   FWKtG/ludALKUDMf4YAMM+By83qOCitlD3yGyrrHi9ZzIdJprr8XHxyXa
   npxwAFEokZiWIetHfUHRqzC54fEfMtHWKtt/xQ21kPIr/6WZX6hvgJ4WN
   6CCgWYvGTQuC6+duNL7wvvSsWTgbdfhYjVn2jQa0TDFo+2NopWKIuscQ9
   uX+ctZsI+4jgHf/75tq1fX5Zv4NGM8tVCJKtFll+SYteqZsQeKimV+oeW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14770175"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="14770175"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 21:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1472008"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 21:40:47 -0800
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
Subject: [PATCH 2/2] printk: nbcon: check uart port is nbcon or not in nbcon_release
Date: Tue, 23 Jan 2024 13:40:33 +0800
Message-Id: <20240123054033.183114-3-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123054033.183114-1-junxiao.chang@intel.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Try to release nbcon only if current uart port is nbcon, as it does
in nbcon_acquire.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 kernel/printk/nbcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b53d93585ee71..d8c6f30adde8b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1623,6 +1623,9 @@ void nbcon_release(struct uart_port *up)
 		.prio		= NBCON_PRIO_NORMAL,
 	};
 
+	if (!uart_is_nbcon(up))
+		return;
+
 	if (!up->nbcon_locked_port)
 		return;
 
-- 
2.34.1


