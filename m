Return-Path: <linux-kernel+bounces-99902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A1878EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A6282259
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477B69952;
	Tue, 12 Mar 2024 06:59:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CFB69944
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710226767; cv=none; b=EuY036ixf9n/C6jXu7/nKeO5fhKeY1gxVKKbOXvWYlK5jdwM+FQ07wYvQKpCvbKrHNTLeqMjLwxVJK0KOctBuIeeWKYtJG0jpZgadLBM1w6Np65vitMGp5N+QTgIhUp4YCAksQtF3DPo4GWPDNBgpqVqVnCBtIOqYoC/tqPIn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710226767; c=relaxed/simple;
	bh=bqlr2ZwpBjj2MMyQPPOzjOrwE1LOBDd6rk6/nGLiLX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHagmamafD51yedcNYLhJdFqb9EntUyERxc+DQ2itCnRBVf9H7pYFPudmn2ZhKOgioTVwOJBkOtoWpEI4vicbmz9PzXPAA/31rAUKMGrOVKbkp1nhTAzYWA4nN1xf3uG1Zf7x+xZi+SuB2xPkBu0/kD4fANxLvo0iFUgMG7SZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ED251007;
	Mon, 11 Mar 2024 23:59:54 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E63B83F762;
	Mon, 11 Mar 2024 23:59:15 -0700 (PDT)
From: "levi.yun" <yeoreum.yun@arm.com>
To: james.morse@arm.com,
	will@kernel.org,
	pierre.gondois@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	"levi.yun" <yeoreum.yun@arm.com>
Subject: [PATCH RESEND] firmware/arm_sdei: Fix invalid argument to unregister private events.
Date: Tue, 12 Mar 2024 06:59:08 +0000
Message-Id: <20240312065908.12194-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unregister private events in device freeze, it should call
cpuhp_remove_state() with sedi_hp_state not sdei_entry_point.
otherwise, it seems to fail on cpuhp_cb_check().

Fixes: d2c48b2387eb ("firmware: arm_sdei: Fix sleep from invalid context BUG")
Signed-off-by: levi.yun <yeoreum.yun@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..973972d50287 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,9 @@ static int sdei_device_freeze(struct device *dev)
 	int err;

 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
+
+	sdei_hp_state = 0;

 	err = sdei_unregister_shared();
 	if (err)
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


