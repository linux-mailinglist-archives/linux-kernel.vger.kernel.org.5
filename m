Return-Path: <linux-kernel+bounces-102721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AFF87B67B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329CF1F22E92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960B20EB;
	Thu, 14 Mar 2024 02:44:31 +0000 (UTC)
Received: from smtp-usa2.onexmail.com (smtp-usa2.onexmail.com [35.173.142.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50757E1;
	Thu, 14 Mar 2024 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.173.142.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384270; cv=none; b=GBgKcQg3vvFqOtqWR/pSvRJFRPG9budwnPZj/pKO0T+On1kZdMEuRK8Nqahm0eR4ewoY+tpzylvypY2F6awkri6Db6agriLZsOCxrEDXSYplmhZ7UhyFlr+5+fE99KrmJT2Xa8NgRmNxYVscCc+rWACv4jPineEmntws4O4HbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384270; c=relaxed/simple;
	bh=l8iu1FS1llWJp4Vcw9klrMoX1ziiITXm9GBj4WRdg48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ik2NdzrQdsgrBJA/tAXN/Vp4Rixid3xnRUjVlfDDxzTKJdnRGNNEe24mKIdDBJyb2Zw2iTiCSozlglzJkSCGI02eFj82ST99fyXXsMfze3pbRfpSKNPoBzU4BOxkozwPvE2MA9hjKuP7SaeqeO5MkHF6X69enrOqoIM6e5H8o4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=35.173.142.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp75t1710384019tre3hm0f
X-QQ-Originating-IP: kjtrMLjRWfwclM7ul6HM/HtMROnmPBRF+sD2mVJJjWE=
Received: from localhost.trustnetic.com ( [122.235.245.139])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Mar 2024 10:40:16 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: q+EIYT+FhZprz3u6HhqywydU8Ynlc6kZxkmUS4rmGnP3jBpMzr/kW7CaJG8e3
	Q5sRMFpKLJPUV1dU/cnzYdEl+nuvJDIEew9twaNpD60vuy5yRdnw++GmkmYcaoW67ArFatj
	HobfhqWSDec6297dwwheeMie3ZFlvocvII0RQbmDhygkZCCZgKxOhoMeqJeoO8QfOGUDAJh
	82KkTYE4bVN8fzPIhie7IdlxDP2lSJz2FosUYJ+SnP24TWiU1GGcRKcqoG7JWuQ6GZLIb+K
	5MZfR4nnYlDoalXKryGxQsQ3Yd6TQwODrDcHd79OJwtyESY5lzJUOaht5btfgMbouUsBqDS
	wiGNdbm9ObckeQCQvXmlXIKdL7rmz+zaxad+vKYWpmnAahy8h+Gwijo1ZyQD69vR+cpM1rE
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 910203287647298116
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux@armlinux.org.uk,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH clk v2] clk: clkdev: add error messages for name exceeding maximum length
Date: Thu, 14 Mar 2024 10:39:09 +0800
Message-Id: <20240314023909.871105-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

if one device register clkdev with dev_id or con_id
greater than maximum length, clkdev_create functions
will not return err, but clk_find functions will not
match the device, it's difficult to identify issues
for developers.So add error messages for dev_id greater
than 20 characters and con_id greater than 16 characters.

eg. clkdev_create(clk, NULL, "i2c_designware.16796")
it will create clk_lookup with dev_id "i2c_designware.1679",
because clk_name exceeds dev_id maximum, but clkdev_create not
return err. when driver call clk_find functions, use "i2c_desig
nware.16796" to find clk, it will return failed,but I don't know
where the problem is. It took a long time to find the problem.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/clk/clkdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ee37d0be6877..2d24ea232dc7 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -165,11 +165,21 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 
 	cla->cl.clk_hw = hw;
 	if (con_id) {
+		if (strlen(dev_fmt) >= MAX_CON_ID) {
+			pr_err("%s:con_id cannot be greater than %d characters\n",
+					dev_fmt, MAX_CON_ID);
+			return NULL;
+		}
 		strscpy(cla->con_id, con_id, sizeof(cla->con_id));
 		cla->cl.con_id = cla->con_id;
 	}
 
 	if (dev_fmt) {
+		if (strlen(dev_fmt) >= MAX_DEV_ID) {
+			pr_err("%s:dev_id cannot be greater than %d characters\n",
+					dev_fmt, MAX_DEV_ID);
+			return NULL;
+		}
 		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
 		cla->cl.dev_id = cla->dev_id;
 	}
-- 
2.27.0


