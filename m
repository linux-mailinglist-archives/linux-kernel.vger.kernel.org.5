Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA767E0DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjKDFt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDFt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:49:26 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396D7D45;
        Fri,  3 Nov 2023 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DFi6A
        Y3VrieYh4gF0CjCQ0nYAz1QmkjAeciIYlFEwvU=; b=JUPmOAaeRt2VZcrFp6bK4
        iJhZBR3WJDLZ6VqCZ5N4Po3qpte3t4Eyct2hXFHqNw/hRj8LfPJT96wbML0ttE8u
        UzGo2fHkGhyefuxmQ4OohFSrlnyDPyGzy+cuQ3RrQNqAyf9sc4OKXGo1bDkqjtQY
        RRxjDeMN0xTbKByoQDY4oQ=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wCn937u2kVlbNpXAw--.9138S2;
        Sat, 04 Nov 2023 13:47:27 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     aspriel@gmail.com
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, johannes.berg@intel.com, marcan@marcan.st,
        linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
        linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] wifi: cfg80211: Fix use-after-free bug in brcmf_cfg80211_detach
Date:   Sat,  4 Nov 2023 13:47:09 +0800
Message-Id: <20231104054709.716585-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn937u2kVlbNpXAw--.9138S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr45GryUGF4rGr4fXF4UCFg_yoW8AF47pF
        WxXa4DAryUWrW3Kr4F9rnrXFyrta1DGwnYkr4UZF93uFn5ur1rJrWjgFya93WDGrs2y3y7
        ZrsYqr17GrZ7Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1rWrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzg8eU2I0bMRTiQAAso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 667462369a32..0224e377eb6e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8431,6 +8431,9 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
 	if (!cfg)
 		return;
 
+	if (timer_pending(&cfg->escan_timeout))
+		del_timer_sync(&cfg->escan_timeout);
+	cancel_delayed_work_sync(&cfg->escan_timeout_work);
 	brcmf_pno_detach(cfg);
 	brcmf_btcoex_detach(cfg);
 	wiphy_unregister(cfg->wiphy);
-- 
2.25.1

