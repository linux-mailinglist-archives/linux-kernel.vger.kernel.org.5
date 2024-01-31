Return-Path: <linux-kernel+bounces-45710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4B84347C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1E1C256B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B6125B9;
	Wed, 31 Jan 2024 03:31:16 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730751079B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706671876; cv=none; b=m/w59eq0TKpTzw655GE4+DZ8AIyDrQLYxJfi+0cMW6JLTqdjXFn2/EyB2ZtffFAeIKqlyMCaOnGzbP0+rO4EFc6+SXkrUQdQHBLS0rqBWpy5iAucu9iHKFeRr+yPk0qKWMUA1ZFfgKrIXiFwKN2oHpqt5djrYNeawORgsh+gK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706671876; c=relaxed/simple;
	bh=xtuRt7VbbEBx08muTVDKjJaxamV9CKSBx5yKzwLml9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqxTkxHrph9Cd23KHqSlQXR1VV4cNDNfw9z4Q2q+LUPZ8Z8RDK3vadXSX/IbFN9vmDmbjxvPqiZmCSYjfoYLvc7JyID7nNZ66gYxeGro/iBBiW/j20YvXXpIEper2fo4Nnyvf64CnySAZ2FnNiZrpd5UNomGtxVg14bMMn/hzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp90t1706671833tdbrcrgm
X-QQ-Originating-IP: adfhviOjvReUnc+ouFGEi8UWUjNNEf9tMmgbZXlYPGw=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 11:30:32 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 3M0okmaRx3iHkgqcopFdq/NfEZ6wxbPxFxT1Zs//B2rY5agn0yROoythOmEhl
	WOf0jGRhY+TZv5I8XJ75ArXo4z2FrgA8gU9B0QqVy5Dq0N5fWeBUnNzv6PTMvc4wZ9oaM9g
	3fenvBXBSArIYergbp5Vgckw+vXWLS6Q8sH3AkzvjwJaDFWl9JfFeNs27qnoP/XKCRrQQ2Q
	BD1pLtNFJi2E/XjbZg7oNXyMdDFuixc5/s8CP7GL0T4BviURJRWvag/GqqS+vCktgeUZG7F
	YLsJDSHLSNNNdSLjr/S2/HPoU0amckINwMFLbh5Da3TRlG7DplPtV1xnIWkEZQWq5vsezHw
	XdzvV7/LOIuZGkV1AOtfB+SwWv7jw6bMu3pISL/E7WK4NaLtxga8nV7PV04GSa9RxM/R5/q
	fjy04w/VYKXcHkibc6XHGw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13846247626016565732
From: Dawei Li <dawei.li@shingroup.cn>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: fancer.lancer@gmail.com,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2] misc: eeprom/idt_89hpesx: Convert data structures to LE explicitly
Date: Wed, 31 Jan 2024 11:30:28 +0800
Message-Id: <20240131033028.3099156-1-dawei.li@shingroup.cn>
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

Kernel test robot reports following sparse warnings:
>> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse:
   incorrect type in assignment (different base types) @@
   expected unsigned short [addressable] [assigned] [usertype]
   memaddr @@     got restricted __le16 [usertype] @@

   drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:
   expected unsigned short [addressable] [assigned] [usertype]
   memaddr

   drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:
   restricted __le16 [usertype]

   .....

For data structures needs cpu_to_le* conversion, their prototype need
to be declared with __le* explicitly.

Declare data structures to __le* explicitly to address the issue:
- struct idt_eeprom_seq::memaddr
- struct idt_csr_seq::csraddr
- struct idt_csr_seq::data

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
v1 -> v2:
- Add sparse warning info from Kernel test robot.
- Remove Fixes & cc stable tag.
- Add Reviewed-by from Serge.

v1: https://lore.kernel.org/all/20240130040632.3039911-1-dawei.li@shingroup.cn/

 drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index d807d08e2614..327afb866b21 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -129,7 +129,7 @@ struct idt_smb_seq {
 struct idt_eeprom_seq {
 	u8 cmd;
 	u8 eeaddr;
-	u16 memaddr;
+	__le16 memaddr;
 	u8 data;
 } __packed;
 
@@ -141,8 +141,8 @@ struct idt_eeprom_seq {
  */
 struct idt_csr_seq {
 	u8 cmd;
-	u16 csraddr;
-	u32 data;
+	__le16 csraddr;
+	__le32 data;
 } __packed;
 
 /*
-- 
2.27.0


