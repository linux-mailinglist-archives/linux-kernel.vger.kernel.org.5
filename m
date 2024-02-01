Return-Path: <linux-kernel+bounces-48145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1518457F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F059BB231CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDF8665B;
	Thu,  1 Feb 2024 12:41:47 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D553363;
	Thu,  1 Feb 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791307; cv=none; b=OimGppKyitb+8jREfuab8FoUg05km8xOYiqb74oj3D+vU5SABfWFuKSK53dqEkv+EjQIQJqrmWPXFc900JbHnSck7iBUGBcGtDbL7KPr3Juuf5AUm++vtuRtfhvksdZ/jRIjMcyVKCgewn3VTxVZtvRkr0KWyPV8Xoh/PsA8qGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791307; c=relaxed/simple;
	bh=mTEwM8qtZQmg8mw1XWHtWN1F324EEuX/vctn70rwP6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pLG6g+3sLp7GHt3WaQTbyOVtY2ZUl/BEi3boLlFgYedB+xhoy3xcbjlz8ChyfG6j9U49TOIN4vJ9YyHj0BoNywh4vu+uy59SmH5ttmwX24XRwdKCi1URHSiSDVQk8ApJxOg+T8/2ye1+YKiv4kI2ESiy/M9lpKq3A0RE8ARQ3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [220.184.253.207])
	by mail-app3 (Coremail) with SMTP id cC_KCgAnDDZxkbtl8ZnjAA--.10172S2;
	Thu, 01 Feb 2024 20:41:21 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atm: idt77252: fix a memleak in open_card_ubr0
Date: Thu,  1 Feb 2024 20:41:05 +0800
Message-Id: <20240201124108.3052635-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgAnDDZxkbtl8ZnjAA--.10172S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykKr4rAw4xJr17GrW7Arb_yoWfXFXE9a
	4Fqw12q3yYqwn2ya15GFyfuayj9a10yw1ku342qanxGrZFkFW3XrWkW3WaqF13WayxZFZ8
	Kryjg34DZr18GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUc189UUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When alloc_scq fails, card->vcs[0] (i.e. vc) should be freed. Otherwise,
in the following call chain:

idt77252_init_one
  |-> idt77252_dev_open
        |-> open_card_ubr0
              |-> alloc_scq [failed]
  |-> deinit_card
        |-> vfree(card->vcs);

card->vcs is freed and card->vcs[0] is leaked.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/atm/idt77252.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index e327a0229dc1..e7f713cd70d3 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2930,6 +2930,8 @@ open_card_ubr0(struct idt77252_dev *card)
 	vc->scq = alloc_scq(card, vc->class);
 	if (!vc->scq) {
 		printk("%s: can't get SCQ.\n", card->name);
+		kfree(card->vcs[0]);
+		card->vcs[0] = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.34.1


