Return-Path: <linux-kernel+bounces-137867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3489E883
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCCF1C2135F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65512C132;
	Wed, 10 Apr 2024 03:49:24 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD057BA2B;
	Wed, 10 Apr 2024 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720964; cv=none; b=m4imI2Esg5Pc4nlCbIVp+YFGp1F2tEmQ2MTCyyOushrt1zkqsparYr9Cocon1sxYStMetoMVTB1eJUR0kyRilPdHaECTbgTwddkwwPFoz2E26DC7FyJ0vfemoXRNBzeh7nURoAjynDBzGInw1d5dQNYCopBmc2VQrtj2W3mWhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720964; c=relaxed/simple;
	bh=m/XzA/BouYpHqicJ8NPirMN1TboF0HFVrEzhS/t7dHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcoURyarvcK/sd0w314r5PQUcdla5YKpcoA6Gos1GblvVcHFTq8yPnmuNW1fe1eNN1z3HYz1DcInJSihIIUM0/LCi39KKyT+3+oKKbIvivCJ35bUJ8s7vWAr3mITcfQk7lZfCLUNpWqacmzKrUcByCaqByLyrYIVJsGj6I8eHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from gui.. (unknown [115.195.151.65])
	by mail-app3 (Coremail) with SMTP id cC_KCgA3Cu0mDBZmkjmBAA--.60221S4;
	Wed, 10 Apr 2024 11:48:55 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: krzysztof.kozlowski@linaro.org,
	andreyknvl@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net-next v1] net: nfc: remove inappropriate attrs check
Date: Wed, 10 Apr 2024 11:48:46 +0800
Message-Id: <20240410034846.167421-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgA3Cu0mDBZmkjmBAA--.60221S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykXw13GF18Xw1UKw4xtFb_yoW8ZFyrpF
	y8JFyktF4jqryrWFsYy3WUu3W2vw1DGry7KrnxCa1xCFy3Gay2qFWakr95Ar47CrZ5X3sx
	AFn09w42kw4DZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU-a9-UUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/

Revert "NFC: fix attrs checks in netlink interface"
This reverts commit 18917d51472fe3b126a3a8f756c6b18085eb8130.

Our checks found weird attrs present check in function
nfc_genl_dep_link_down() and nfc_genl_llc_get_params(), which are
introduced by commit 18917d51472f ("NFC: fix attrs checks in netlink
interface").

According to its message, it should add checks for functions
nfc_genl_deactivate_target() and nfc_genl_fw_download(). However, it
didn't do that. In fact, the expected checks are added by
(1) commit 385097a36757 ("nfc: Ensure presence of required attributes in
the deactivate_target handler") and
(2) commit 280e3ebdafb8 ("nfc: Ensure presence of NFC_ATTR_FIRMWARE_NAME
attribute in nfc_genl_fw_download()"). Perhaps something went wrong.

Anyway, the attr NFC_ATTR_TARGET_INDEX is never accessed in callback
nfc_genl_dep_link_down() and same for NFC_ATTR_FIRMWARE_NAME and
nfc_genl_llc_get_params(). Thus, remove those checks.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/nfc/netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index aa1dbf654c3e..dd2ce73a24fb 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -969,8 +969,7 @@ static int nfc_genl_dep_link_down(struct sk_buff *skb, struct genl_info *info)
 	int rc;
 	u32 idx;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
-	    !info->attrs[NFC_ATTR_TARGET_INDEX])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
 		return -EINVAL;
 
 	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
@@ -1018,8 +1017,7 @@ static int nfc_genl_llc_get_params(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg = NULL;
 	u32 idx;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
-	    !info->attrs[NFC_ATTR_FIRMWARE_NAME])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
 		return -EINVAL;
 
 	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
-- 
2.34.1


