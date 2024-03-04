Return-Path: <linux-kernel+bounces-90416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066686FED9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8239EB207C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6E364A3;
	Mon,  4 Mar 2024 10:18:53 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F76225CB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547533; cv=none; b=iXtp+PNw0wJ1KFWuZAeFHY1C7RFaMVNqrImrpvcbuBXodaMGg08VQVsvj7dzE6SGToPyfXCwdhoEWP6ECMGrfM/1CxTEWbOwD6VLINlI8gq/jGqEBQU0ZIRGWRdl5YKKtEZ5qgkykkoqlWzklAR4LkOEZMlwPDhT9ImAfOAymqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547533; c=relaxed/simple;
	bh=dpj4ufgifj7GIAYt7yGK4hK+qv6CPi//o/CWx5UlmNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P1HRHfBYLeNcdVKlthrCHuG4kEyoDe10aIFRvbav3szshQOvXavYW1F05ZAzZTVvrw4+/FeH+PuA5QbooMlzHsaA++4CJ5PYpkqTnWt3J3tcApZQ0aQFjkQGev6j7XrDCQ68YKkIffnKRTQ4AlEti0KpMf9SoZgm3UKmtRAhGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp62t1709547436tgx9g8d8
X-QQ-Originating-IP: 5APuCEWtsWVVSMzxS98Vxt66O3rkkYqE//ZKcb3vJ+g=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Mar 2024 18:17:15 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: K2/klV1qoGlTWfl/w1BagxXdSiRmYm4VevULtmbJrZ7m+uuFIYP55sr8PKkvE
	LFZQXXHCr2EtSCCK5SmQK1O3CRe7068aVPwYQHDZCMfx7QBCLRqh9MtFSaXOyEVk4S+IfnL
	2/c6rzZrUKUayJFC/T2TuxVOdQKJPK4MvcEOso17dcNqbz53yLtACjYbYOWZKrry9iwT4rK
	XzDZJLmzJEfCUTJb7aJM8LZ5wN7nvXIEDScRqEYoc9zVus6PtEhY12m8BHXaIfrp3UvkIuq
	UmrF6GqiRFa+hiBGw0LgRdJa9CPzsujyNW9C5ZPnUspyt0oTr42TjiB9UjisUspC6pYOJY+
	VID4BefrRwRQu91VAot+KD4yuNquhwGHqQx/zo6dV5tqUydf5QcwodVxY4LKfdFhmVkUqnD
	1lKiJBNLonDN+eqHPG21JpBfAZ4tTl0e
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11784876487773860519
From: Dawei Li <dawei.li@shingroup.cn>
To: conor.dooley@microchip.com,
	daire.mcnamara@microchip.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] firmware: microchip: Fix over-requested allocation size
Date: Mon,  4 Mar 2024 18:16:53 +0800
Message-Id: <20240304101653.126570-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

cocci warnings: (new ones prefixed by >>)
>> drivers/firmware/microchip/mpfs-auto-update.c:387:72-78:
   ERROR: application of sizeof to pointer
   drivers/firmware/microchip/mpfs-auto-update.c:170:72-78:
   ERROR: application of sizeof to pointer

response_msg is a pointer to u32, so the size of element it points to is
supposed to be a multiple of sizeof(u32), rather than sizeof(u32 *).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403040516.CYxoWTXw-lkp@intel.com/
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---

V1 -> V2:
sizeof(u32)->sizeof(*response_msg) 

V1:
https://lore.kernel.org/lkml/20240304092532.125751-1-dawei.li@shingroup.cn/

 drivers/firmware/microchip/mpfs-auto-update.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 682e417be5a3..fbeeaee4ac85 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -384,7 +384,8 @@ static int mpfs_auto_update_available(struct mpfs_auto_update_priv *priv)
 	u32 *response_msg;
 	int ret;
 
-	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(response_msg),
+	response_msg = devm_kzalloc(priv->dev,
+				    AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(*response_msg),
 				    GFP_KERNEL);
 	if (!response_msg)
 		return -ENOMEM;
-- 
2.27.0


