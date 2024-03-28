Return-Path: <linux-kernel+bounces-123535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0926B890A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8AD1F27A61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39013AD39;
	Thu, 28 Mar 2024 19:56:42 +0000 (UTC)
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017713AD16;
	Thu, 28 Mar 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655802; cv=none; b=JXipcbEmQUCALjNhWFUsrvs86ULihvXidyVV+cs9OzO5UA/lvQ2c0LPxbOdlWSkPJuSsNLWx08B3LP0VdTo9FOlU1cSGa4zBNXSEToxKQKZplD87TqRcFP7M0s9oh8ZKIpPnJYxBDX1+gPxKp2iFutQSf0cx/DI57Xi9uhz5/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655802; c=relaxed/simple;
	bh=ob1b+q6kmowLhhdwbncKRYOFpeHgK6/Yby6Ak/f3Skc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G+Lg/QfhswlqKhkshlIRdpCQ6V3yCANzlhUtViIKDfy1d8+smqBEE791LfI2aZLEOcGsUENrP60ILa6+yawr3zHP87hBsf/r4wzBvSKTz4eVgqUIRYqQS35Fol2f4nXDwJYeQl/FHwsNgZymurEKVMY6CY/Uv7+ARDLbffM+wbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.19] (port=7854 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rpvrU-0005Aa-Cu;
	Thu, 28 Mar 2024 22:56:32 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1106.mail.hosting.nic.ru (Exim 5.55)
	with id 1rpvrT-00H1hD-2r;
	Thu, 28 Mar 2024 22:56:31 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net-next] tg3: use sysfs_emit() in tg3_show_temp()
Date: Thu, 28 Mar 2024 22:56:26 +0300
Message-Id: <20240328195626.878904-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

Change sprintf() in sysfs show() handler to sysfs_emit(),
as recommended by sysfs documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 62ff4381ac83..ee1bc578be84 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -10892,7 +10892,7 @@ static ssize_t tg3_show_temp(struct device *dev,
 	tg3_ape_scratchpad_read(tp, &temperature, attr->index,
 				sizeof(temperature));
 	spin_unlock_bh(&tp->lock);
-	return sprintf(buf, "%u\n", temperature * 1000);
+	return sysfs_emit(buf, "%u\n", temperature * 1000);
 }
 
 
-- 
2.34.1


