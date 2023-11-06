Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065E7E2676
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjKFOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKFOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:19:01 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88987DF;
        Mon,  6 Nov 2023 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GHKDY
        oOVMXecpK9LSE+iNohkCdObnkzqAJ+O5AtWvHk=; b=Y7XpWMSFxGujh2q/yvDDI
        5+YQvSOeWb9zLtnoTrKoG0u4ufiGme5GDs3dWob2lAfuYOT0PbI5s6y4uFtVyXNw
        beXDxhuN/hrAogS4bp2VDB/i6+TAdjx7IsA+RA1c84jTF0eYambo7Bc/yZK0qqGs
        2jS6Qp97s87fdR547iXQU4=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wDXv09k9UhlfEHwCQ--.49806S2;
        Mon, 06 Nov 2023 22:17:08 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     aspriel@gmail.com
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, johannes.berg@intel.com, marcan@marcan.st,
        linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
        linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, arend.vanspriel@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org,
        hackerzheng666@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in  brcmf_cfg80211_detach
Date:   Mon,  6 Nov 2023 22:17:04 +0800
Message-Id: <20231106141704.866455-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXv09k9UhlfEHwCQ--.49806S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr13tw1fAw4UJw1rZFyxKrg_yoW8ur1kpF
        WxWa4qyryUWrW3Kr4F9rnrJFy8ta1DKwnYkr4j93Z3uFn8Wr18JrW8KFya93WDGrs2yay7
        Ar4vqrnrGrZ7GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1rWrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBgwggU1d7gdDP3AAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the candidate patch of CVE-2023-47233 :
https://nvd.nist.gov/vuln/detail/CVE-2023-47233

In brcm80211 driver,it starts with the following invoking chain
to start init a timeout worker:

->brcmf_usb_probe
  ->brcmf_usb_probe_cb
    ->brcmf_attach
      ->brcmf_bus_started
        ->brcmf_cfg80211_attach
          ->wl_init_priv
            ->brcmf_init_escan
              ->INIT_WORK(&cfg->escan_timeout_work,
		  brcmf_cfg80211_escan_timeout_worker);

If we disconnect the USB by hotplug, it will call
brcmf_usb_disconnect to make cleanup. The invoking chain is :

brcmf_usb_disconnect
  ->brcmf_usb_disconnect_cb
    ->brcmf_detach
      ->brcmf_cfg80211_detach
        ->kfree(cfg);

While the timeout woker may still be running. This will cause
a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.

Fix it by deleting the timer and canceling the worker in
brcmf_cfg80211_detach.

Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Cc: stable@vger.kernel.org
---
v5:
- replace del_timer_sync with timer_shutdown_sync suggested by
Arend and Takashi
v4:
- rename the subject and add CVE number as Ping-Ke Shih suggested
v3:
- rename the subject as Johannes suggested
v2:
- fix the error of kernel test bot reported
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 667462369a32..a8723a61c9e4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8431,6 +8431,8 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
 	if (!cfg)
 		return;
 
+	timer_shutdown_sync(&cfg->escan_timeout);
+	cancel_work_sync(&cfg->escan_timeout_work);
 	brcmf_pno_detach(cfg);
 	brcmf_btcoex_detach(cfg);
 	wiphy_unregister(cfg->wiphy);
-- 
2.25.1

