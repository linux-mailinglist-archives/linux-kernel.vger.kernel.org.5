Return-Path: <linux-kernel+bounces-79986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4D862940
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F11B21382
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11FC2ED;
	Sun, 25 Feb 2024 06:04:44 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E852FBE4D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708841083; cv=none; b=Anh60/+XYwZHIRraRexAIOMp/du2t9yOz/O2KAh5kb6Tw2wS4J9Rd3GQgDF2j4raKsBM1VSNU4jSR69pTDeDnopmXnCuZXIaknry7nogGaSl97PYAZBfrX67u3kpZcMWET8fS7U6bcaHd9IFxbVk3LnZykRvmrPgUwersSpXZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708841083; c=relaxed/simple;
	bh=O9pYAacf0RkkUX8+kCmmHElwjDQBmkf/X5szzSGN1hs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=N3PLdCvlQx9ggcVUa4fnqZTJkRgq2L69pkNWGoWJFIZVzLmUstWl0YVotJAzfcIXxGyOTZfUDogbC1LD7XQ9OY1El/yA6GU77Tq71iDq651NJZvLi7wODyeR+juIzEhmeDq8UoJM2fPpmdNBeSBWhHDPE6X4SCxQyK7+DRAqwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.226])
	by mail-app4 (Coremail) with SMTP id cS_KCgC3sH5S2Npl6IGXAQ--.50019S2;
	Sun, 25 Feb 2024 14:04:10 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] ARM: mvebu: Prevent null pointer dereference caused by kzalloc failure
Date: Sun, 25 Feb 2024 14:04:01 +0800
Message-Id: <20240225060401.52768-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgC3sH5S2Npl6IGXAQ--.50019S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1fCry8CFW3Zw1xJw17GFg_yoWDGwbEkw
	s7Aws7u3s3Xwn5Zr13Ca13ur9Iyan8uryxZrn7XF1Fy3yY9Fnrur4vqrZ3Ar43urZFgFWf
	ArWrur4Yvw1jgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMBAWXY6VIJRQBCsI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kzalloc() in i2c_quirk() will return null if the physical
memory has run out. As a result, if we dereference the new_compat
pointer, the null pointer dereference bug will happen.

This patch adds a check to avoid null pointer dereference.

Fixes: 5fd62066d290 ("ARM: mvebu: Add thermal quirk for the Armada 375 DB board")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 arch/arm/mach-mvebu/board-v7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index fd5d0c8ff69..7d2cb12e349 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -125,6 +125,8 @@ static void __init i2c_quirk(void)
 		struct property *new_compat;
 
 		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		if (!new_compat)
+			continue;
 
 		new_compat->name = kstrdup("compatible", GFP_KERNEL);
 		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
-- 
2.17.1


