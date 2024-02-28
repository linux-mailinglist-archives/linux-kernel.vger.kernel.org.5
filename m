Return-Path: <linux-kernel+bounces-84565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506486A85F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478551C238CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE072262B;
	Wed, 28 Feb 2024 06:34:51 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685821370;
	Wed, 28 Feb 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102091; cv=none; b=oAQ1k0w96zZIpBVOklwMGjYNFx5jYJiN2vKUObJq42bWqDjByepu0yp09r1oMTPHv7imJP2wPzlhlu5Tr/1aUNbQ0Bv8MpthRcbW7B69tQiIKovR2Fb2Q/VYTxuF45JL9bKi7Folhgyw7yYV9V/5cfXyQGQJXQ4jbUXsrOhDHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102091; c=relaxed/simple;
	bh=BtgjlI5R/JINMM0XHTf7xkkI6D/GSjgXYOSNCXC+TyU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kpzunenMffjvilWpLbAJulgy34xu6DapuH2gvfOXBQHcmtJusKOxWvk0YTOo5JOqLMeyNXmNo6kl3VqNDxWVX9qZDiXu7CB6x50olzGIX+PCbIYoNR6FIVMdtbfQS0k8qEVS4/gd+1gU1RM+DcDrv2TJZvu+72u53NbyklAprwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.17.192])
	by mail-app4 (Coremail) with SMTP id cS_KCgAXD33h095lH7WxAQ--.53491S2;
	Wed, 28 Feb 2024 14:34:23 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	justinstitt@google.com,
	jisoo.jang@yonsei.ac.kr,
	petr.tesarik.ext@huawei.com,
	quic_alokad@quicinc.com,
	hdegoede@redhat.com,
	keescook@chromium.org,
	johannes.berg@intel.com,
	kvalo@kernel.org,
	arend.vanspriel@broadcom.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] wifi: brcm80211: handle pmk_op allocation failure
Date: Wed, 28 Feb 2024 14:34:08 +0800
Message-Id: <20240228063408.7006-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgAXD33h095lH7WxAQ--.53491S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyDAF1UAr4kCw1xuFyrtFb_yoWkKFX_KF
	40vwnrJr1rKryvgryDZwsrXrZYkF1vqrZ7GrnFvayfAayrJrWUKrs5ZF98Aw47WFZFgFn8
	uw4UX34rG34YqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
	6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIFAWXeL1IIMwAGs+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kzalloc() in brcmf_pmksa_v3_op() will return null if the
physical memory has run out. As a result, if we dereference
the null value, the null pointer dereference bug will happen.

Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
for pmk_op.

Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Drop the new label and just return -ENOMEM.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 28d6a30cc01..7af6d6448b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4322,6 +4322,9 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 	int ret;
 
 	pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
+	if (!pmk_op)
+		ret = -ENOMEM;
+
 	pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
 
 	if (!pmksa) {
-- 
2.17.1


