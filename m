Return-Path: <linux-kernel+bounces-98577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88632877C42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FF41C20D51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B72171C2;
	Mon, 11 Mar 2024 09:05:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8241642F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147935; cv=none; b=KgU/IAuhcW10dWO8csEw1nHPTZvAPtE+Iqyj8tanbGzVrXzmymXzPFUzZvlFBuBnew5R4A9eVXWaP/kGSAwV+26t8t2X5381eCFalYByWUjnUZpeFfl4pdCVZossv5XU9+aZtj+dkDZEDE1OsjLXZWCj5tWD4C2RLekvSBS6v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147935; c=relaxed/simple;
	bh=su16VxET9iVNmavI6//qHIJdZH7F9u4t3Pf80tLZtR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Em9+SCIqW7o3Vg9GEmb8U4XEKRQbcxVxihAYVZ333croLpYrINtKvMDxhq1/+PUC2EbrDZ0TJXxdK/K1TnYeXVKqnZwxNpTADGHXpe88i+WCXn4ZYhAmg2c7StRltCWYP7w4GxGQTCm5qGV3Ga6HiW3dweGAux9BKlfcwnc4F2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D351AFEC;
	Mon, 11 Mar 2024 02:06:09 -0700 (PDT)
Received: from e126645.nice.arm.com (e126645.nice.arm.com [10.34.100.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6CD63F762;
	Mon, 11 Mar 2024 02:05:31 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] firmware: arm_scmi: Fix wrong fastchannel initialization
Date: Mon, 11 Mar 2024 10:04:12 +0100
Message-Id: <20240311090413.1710725-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fastchannels are initialized with a bad index in:
commit 2441caa84aac ("firmware: arm_scmi: Populate fast channel rate_limit")
Fix this and provide a correct index.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202403100744.7Op3PI8L-lkp@intel.com/
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index ea9201e7044c..1fa79bba492e 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -736,7 +736,7 @@ static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
 	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
 				   POWERCAP_PAI_GET, 4, domain,
 				   &fc[POWERCAP_FC_PAI].get_addr, NULL,
-				   &fc[POWERCAP_PAI_GET].rate_limit);
+				   &fc[POWERCAP_FC_PAI].rate_limit);
 
 	*p_fc = fc;
 }
-- 
2.25.1


