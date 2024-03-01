Return-Path: <linux-kernel+bounces-88516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B986E2C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05781C210D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8E6EB6A;
	Fri,  1 Mar 2024 13:52:10 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5D5F84C;
	Fri,  1 Mar 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301129; cv=none; b=EiDWXbWMFBav/DmqABUyZulEAaW44N3fuDypw/WkhlzZ9+TmR1KEx+iNd1RkjhXu26pBlYuAV3/ZsIuvd/bWiUrYlM5oYD3esVQsnK6B+QOQgdRHrSpyqN3WlB0U63zIl2fuQpXLdS5ncDWY6nXUU7rWonkWv47kug8/LondUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301129; c=relaxed/simple;
	bh=Vvdvmn75+7dlWtviPz9CBYNJ1bczhRoIOAinCLpgtxk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ky72xGfP5ddtQBJtDPvmGQRL4hHmQok8q+tYTOOxF5gYbHBlLeOlInwG6oB2mVKZAZobwIcK+0+25Tno0Ku5yP2TaZgCyIj2rjnpBcHhoJx1QcOUOQuEdwN+BdW3esh8AUz3kiAnLJNdwuYn99cCKp+Qd4edsewyeTvhFErsEpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.19.153])
	by mail-app2 (Coremail) with SMTP id by_KCgBXmahn3eFl7391Ag--.39411S2;
	Fri, 01 Mar 2024 21:51:45 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	konrad.dybcio@linaro.org,
	hdegoede@redhat.com,
	minipli@grsecurity.net,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] wifi: brcmfmac: pcie: handle randbuf allocation failure
Date: Fri,  1 Mar 2024 21:51:34 +0800
Message-Id: <20240301135134.29577-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBXmahn3eFl7391Ag--.39411S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFW3ury5uw18Zw1fJFWDArb_yoW8JF18pa
	yfJFyjkr1UWw4F9a98GFWxCryYv3ZIy3y2gr4xu3s3uryrAFyFkry0kFyI9r1UCr4Iya47
	tFWUtrnxWFsxJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUHAWXg0lMPlwA1sp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kzalloc() in brcmf_pcie_download_fw_nvram() will return
null if the physical memory has run out. As a result, if we
use get_random_bytes() to generate random bytes in the randbuf,
the null pointer dereference bug will happen.

Return -ENOMEM from brcmf_pcie_download_fw_nvram() if kzalloc()
fails for randbuf.

Fixes: 91918ce88d9f ("wifi: brcmfmac: pcie: Provide a buffer of random bytes to the device")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index d7fb88bb6ae..5ab9c902e49 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1730,6 +1730,8 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 
 			address -= rand_len;
 			randbuf = kzalloc(rand_len, GFP_KERNEL);
+			if (!randbuf)
+				return -ENOMEM;
 			get_random_bytes(randbuf, rand_len);
 			memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
 			kfree(randbuf);
-- 
2.17.1


