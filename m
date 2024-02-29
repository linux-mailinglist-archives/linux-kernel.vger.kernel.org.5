Return-Path: <linux-kernel+bounces-86555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0F86C6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706661F26564
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1876C7A;
	Thu, 29 Feb 2024 10:32:41 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A6768F4;
	Thu, 29 Feb 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202760; cv=none; b=C50IpytTR6Tw6dLj7cdz+4x076xkHynwoaZTrCYhCfbHZBIggEMCjM+8ZQF+Y5NRRb4y0w0HNZyvqKroKNs5sLvjn13Y2n6GUAlRgTEOr8mwc+ze32VvLvNKi3QCAE9YldioKeWAVz2e9alMaroKUSOCPJIWGY4eOb0wUyoh6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202760; c=relaxed/simple;
	bh=LflXo9uhwDjMO2CtqfGpFbBk07gB8N/MJw3BYUAPA5E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DJ+SNaMvDUnLJgTSkxFRzZlQYap2TyrnJ7ehRAplXs3Xs4ndYmCmXxZYT862k2/3Wpv/vJsy4UT2zyqW7nlNNmYhDKlR2UyE2c30ytxy+gvTK3OzTjqmfK/xzTC5ohMHKb/0ef5QfJ7+25eytfuEnbZbHmTdQ+W2WXiv/+8mhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.19.137])
	by mail-app3 (Coremail) with SMTP id cC_KCgBXOzUZXeBlwXS1AQ--.1150S2;
	Thu, 29 Feb 2024 18:32:05 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	justinstitt@google.com,
	quic_alokad@quicinc.com,
	jisoo.jang@yonsei.ac.kr,
	petr.tesarik.ext@huawei.com,
	hdegoede@redhat.com,
	keescook@chromium.org,
	johannes.berg@intel.com,
	kvalo@kernel.org,
	arend.vanspriel@broadcom.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v3] wifi: brcm80211: handle pmk_op allocation failure
Date: Thu, 29 Feb 2024 18:31:53 +0800
Message-Id: <20240229103153.18533-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBXOzUZXeBlwXS1AQ--.1150S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFyDAF1UAr4kCw1xuFyrtFb_yoW8JrW7pw
	4xGFyqyr1UWw4Ykw4rtF92yryFg3W7K34Fkr4jva4fuFs3Gr18Jw48KFyYvF1kArW2y3y2
	yFWkJasxWrs8X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1VyI5UUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQGAWXfgNMKpABfsY
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
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v3:
  - Just return -ENOMEM.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 28d6a30cc01..1a5d7494f5e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4322,6 +4322,9 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 	int ret;
 
 	pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
+	if (!pmk_op)
+		return -ENOMEM;
+
 	pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
 
 	if (!pmksa) {
-- 
2.17.1


