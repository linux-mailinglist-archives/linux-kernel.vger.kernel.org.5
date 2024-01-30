Return-Path: <linux-kernel+bounces-43925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC3841ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4641F25CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC537702;
	Tue, 30 Jan 2024 04:08:00 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47743717A;
	Tue, 30 Jan 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587680; cv=none; b=WZv4wMxwfOxngEaqPBl2R0dUKx6J6OLrVPPSd2jnNrn8KmQ3lxw5HyqJropDN272A83D97ERlfsapVPyQvBv1Im0mvCyISGRbk/HHl9K9gOL5gQPyrWCiZZZUChIWsTjtXyNx6CrXxm1WIdoeWV6Jc9CPyk+4LA9+LELNt0iiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587680; c=relaxed/simple;
	bh=CM4VCRvGWmtjbdVWi7q4j8vHwcmiajkzIgD6FOZDigQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cn6ZvS2rfxlRt2gNEbmZdQmUH4x7vQWVNVd+pWzR211cwePUDmTGUP7jC3qZgOdSEQh9F/4DRLxnmOEW5fJph8bxuey3yxAAYDhBIbWmh4eNBn4aRNF2PhNJZRHgyAOTuNeVFZ6eLiFV9wQ3iS3ukrX8nWBOGJ1ArLBYmwWiBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1706587638t88qbwk5
X-QQ-Originating-IP: ADAzaR73+8nlbAs12iepXPR/+VXxF63AXCcgAOBaFro=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jan 2024 12:07:17 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 3M0okmaRx3g7Rq5OtnCnvH/JhbQHXY5LVGoXVba5MFSQasgdHc6ppT/sHZe3W
	qDJ0+EZs7i5Vs4EK2xdJXmWm3HswDE6loIb4qKi1pwljs04WnggjCSEhN/33W2caZ5mPiEv
	fgSQsXUvwaZFr7lSCOsrzg1SyUn4U2SLvLvcQCK5dZycCCi6/ICTNh1mbW9uVoKrZVd09uW
	6j5YlgqgU66Gl5xSsQ3/8RJG9VkDuO9AzbSQZWp228qdxMfv725OPYK0rxBPHk4D9JX3xwz
	oLV7nRTdKC7qUAAD1lg1OwfW3lun6Eb2twREVR1Hd5d4KVLB4hwyKlDI3gnsu1wX+xvPl1m
	7poa4TOZUepHqg9kkW5ARv2JVl1IEmfC0j1SZkC5OqXCDdqSEI/UstkCTv6nKscHBWMO3Je
	lEtw6dzEY0Gm1tTogd+Sdg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18208672462172721914
From: Dawei Li <dawei.li@shingroup.cn>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: fancer.lancer@gmail.com,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>,
	stable@vger.kernel.org
Subject: [PATCH] misc: eeprom/idt_89hpesx: Convert data structures to LE explicitly
Date: Tue, 30 Jan 2024 12:06:32 +0800
Message-Id: <20240130040632.3039911-1-dawei.li@shingroup.cn>
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

For data structures needs cpu_to_le* conversion, its prototype needs to
be declared with __le* explicitly.

Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Cc: <stable@vger.kernel.org>
---
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


