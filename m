Return-Path: <linux-kernel+bounces-80102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E17B862AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CC71F21681
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549912B71;
	Sun, 25 Feb 2024 14:30:15 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E013AC5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871414; cv=none; b=kN/RIcTFao0xfJZVOh0xaBpuMwQrF7ucfAohoP2Z+F3/qpZCefc6JlpmOuYHOI/hGF5H1rm56tZ1wT/DaxD15uMJCfefRuYEaWx6tJU5MWVbB0tKciFneZjNP8v/GxNhKgC25HQl4RJyhLuZyM90pn1CYMVe6V7Z1nnUEA/9b9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871414; c=relaxed/simple;
	bh=u+NWYFXuW4Hl9Td47m9gtaVgOwboEGYnCmcnjZDbss0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CARLo8bviJprbu3NyZtawtmTpLnZA/KX2EL1vFIX0N9jWA9CKz5U7ivGmjYgxuSrXjGybBG1v5QuN9/z5K/qIfeiqgtkumQ2gv6tqYFzUlp9jgHAMMdRxMU0WdqzvM0k1qPPXhumWMNFyEJ8CGDHgKIcy3SeZQjc2wxcEanN0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.226])
	by mail-app3 (Coremail) with SMTP id cC_KCgBn3TfMTttlav+QAQ--.49229S2;
	Sun, 25 Feb 2024 22:29:44 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] ARM: mvebu: Add error handling in i2c_quirk to prevent bugs
Date: Sun, 25 Feb 2024 22:29:32 +0800
Message-Id: <20240225142932.5138-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBn3TfMTttlav+QAQ--.49229S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4Uur1fJrWfXw4DZw1UWrg_yoW8Gryrpa
	1jkw1DCFZ09ry0gFyUuas7ZFy5Aan7tFW5CFyqka47W3Z5Wa17GFW8KrWFkr15ZFWfK3yf
	u3WrZa18WasrJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbzpB3UUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMCAWXaOtIJRgAEsf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kzalloc() and the two kstrdup in i2c_quirk() will return null
if the physical memory has run out. As a result, if we dereference
these null values, the null pointer dereference bugs will happen.

This patch adds error handling to avoid null pointer dereference.

Fixes: 5fd62066d290 ("ARM: mvebu: Add thermal quirk for the Armada 375 DB board")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Adds checks to judge whether two kstrdup() fail.

 arch/arm/mach-mvebu/board-v7.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index fd5d0c8ff69..c31ac08d24a 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -125,12 +125,20 @@ static void __init i2c_quirk(void)
 		struct property *new_compat;
 
 		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		if (!new_compat)
+			continue;
 
 		new_compat->name = kstrdup("compatible", GFP_KERNEL);
 		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
 		new_compat->value = kstrdup("marvell,mv78230-a0-i2c",
 						GFP_KERNEL);
 
+		if (!new_compat->name || !new_compat->value) {
+			kfree(new_compat->name);
+			kfree(new_compat->value);
+			kfree(new_compat);
+			continue;
+		}
 		of_update_property(np, new_compat);
 	}
 }
-- 
2.17.1


