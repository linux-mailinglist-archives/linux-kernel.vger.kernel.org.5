Return-Path: <linux-kernel+bounces-79987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D6862941
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C640281B80
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4ABA41;
	Sun, 25 Feb 2024 06:05:24 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78851944C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708841123; cv=none; b=IW4IJOL1UvGOow7t/lHAKgsqvm6PAoY7frgR1lsP1NwEhouMPcm5jpTNkjCcabyTJlBt7elCkZqMKZwBWaJzE6eMNs2yYFJwwIEh7tvvoq4zcn/1IG/Uy9w9lK5nqnIDkrkhJKBjaX0MMWlY7He4lOivdLGGfbMcJnARN2FHQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708841123; c=relaxed/simple;
	bh=ifytgLKVyzupiyqK0UXfu9ql9qICwiWLNDCvwtpaIxo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RErROj+W0qlJt90NLJIC0xgb3VnarcEk7+O47sa3u6jGv8UogjuJFhWALQrCknZtatK1rFfawxpg2tRNNm10AeUFk+SABLqlvah5qSFaxD09wy37MDH/u2BNiZBGgm6oWIsRXl/34BcTnJfK2jcYimE+LuwZWrBH5oStLZeO2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.226])
	by mail-app4 (Coremail) with SMTP id cS_KCgD3732D2NpliIKXAQ--.22731S2;
	Sun, 25 Feb 2024 14:05:02 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] ARM: mvebu: Add check in coherency.c to prevent null pointer dereference
Date: Sun, 25 Feb 2024 14:04:50 +0800
Message-Id: <20240225060450.53044-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgD3732D2NpliIKXAQ--.22731S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1DtF1rZryfJrW7Zr1UKFg_yoWDGrcEkw
	4ft3yDur1Sqw45ur1UGa17Wr9Iyws3Zry8AayIqFZ8C3yY9r43Ar9rtr1fAry7Zrs3KrW3
	tas7KF15Aw1UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUeXdbDUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMBAWXY6VIJRQBEsO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kzalloc() in armada_375_380_coherency_init() will return
null if the physical memory has run out. As a result, if we
dereference the property pointer, the null pointer dereference
bug will happen.

This patch adds a check to avoid null pointer dereference.

Fixes: 497a92308af8 ("ARM: mvebu: implement L2/PCIe deadlock workaround")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 arch/arm/mach-mvebu/coherency.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index a6b621ff0b8..a81a3c8c19a 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -191,6 +191,8 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 		struct property *p;
 
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			continue;
 		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
 		of_add_property(cache_dn, p);
 	}
-- 
2.17.1


