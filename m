Return-Path: <linux-kernel+bounces-82841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC1868A72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25292825D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189356477;
	Tue, 27 Feb 2024 08:07:05 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36255E62;
	Tue, 27 Feb 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021225; cv=none; b=QiDiFaPeMALAwbQmpiOg1hRX+CUigXqluWwJG24T5K1EY3e3k+mfPnaFsqgd0ahQ6jiYH5BH+fuyMVB6RhncOwgKSOhgn24/+i7K/U6pbFl0OlqiU8PKG0vExIRXCKcvy/G6tTZu5DnPzzo8LwSiUmNwXjZU9G2Ie2KH1//10O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021225; c=relaxed/simple;
	bh=bn8lBdZvB6L2HQkh78StuFH3Cwbf8lGTxYiUbBqrdUk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MhhROsfbMTK/tFR0hsqv/aZepUxNNg7ynpxeqw/tAaq3N0d8qbgbUP4rnmQaogheUqC+Y/hjNaw3Ff7SiYJwgrIzcqk9F30Srk41P3aTiTY13g0WWY3JjDERaAPQRK11jd/jVUTLTY4dFTQ6Mk3F6Fhr61g+8QT+VgtwuT6Ydo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.19.154])
	by mail-app2 (Coremail) with SMTP id by_KCgBnF6b2l91l841JAg--.21305S2;
	Tue, 27 Feb 2024 16:06:27 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	justinstitt@google.com,
	john@keeping.me.uk,
	quic_alokad@quicinc.com,
	marcan@marcan.st,
	johannes.berg@intel.com,
	linus.walleij@linaro.org,
	kvalo@kernel.org,
	arend.vanspriel@broadcom.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] wifi: brcm80211: handle pmk_op allocation failure
Date: Tue, 27 Feb 2024 16:06:13 +0800
Message-Id: <20240227080613.34001-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBnF6b2l91l841JAg--.21305S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF43XrW3XrWUAry8Wr13twb_yoW8GFWkpw
	s7GFyqyr1UWw4Skw45tFyvvryFga17K3sYkr4jy3s3uFZ3Gr1rJr48KFyFvFnYyr4ay3y2
	vFWktF98Wr4DWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQEAWXc3dIQZQAcsd
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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 28d6a30cc01..3b420b33188 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4322,6 +4322,10 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 	int ret;
 
 	pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
+	if (!pmk_op) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
 
 	if (!pmksa) {
@@ -4340,6 +4344,7 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 	pmk_op->length = cpu_to_le16(length);
 
 	ret = brcmf_fil_iovar_data_set(ifp, "pmkid_info", pmk_op, sizeof(*pmk_op));
+out:
 	kfree(pmk_op);
 	return ret;
 }
-- 
2.17.1


