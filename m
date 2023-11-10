Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E07E807D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbjKJSMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjKJSLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCB2950D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:33:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc5916d578so16537175ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1699612422; x=1700217222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8nODykpdMd/QuQkSZ1t9BSG46K5XmlrvFgBiwL5jzw=;
        b=BfY54kMWKZiNpxgDwPTosomEnEgsKfjIYzSAPtRvKLZSmNQ9ewIT+Mh8vLAKoykbGb
         KDOy2O46yc9Mjz5mc7Owjk1YCqkmfYorpgOO9FCddogShAYDstKFaQzad4K8ivulDcH4
         5iCjIpw5cjdtkBi9S35Zh+DX4OFnEGd3H7NPLVP94fYFgAVFbR9rElUl6bPVVEG8gQCr
         uebMNwAT6awoXQ2KkMkDSkJkHzI8PYIsYJMZi6qEzI1e3orgKphgbYgAequ6/QUjTH2f
         9FDmSdiMSl37H7niunnVPnlIn1UTvRevC83/tG76Vij7Nhi2Pint+UzvEdfMz8wjXv6n
         xCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699612422; x=1700217222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8nODykpdMd/QuQkSZ1t9BSG46K5XmlrvFgBiwL5jzw=;
        b=HHcoj7euNeliWH6D7LSQuyg7msfWaGjouMc+S7XGrkZx0IOIlz+ZRvnUPLnBCaQHI1
         rjvZ2obuOmzO0o3u67cr5be8ZM6zHWVQ48P/hv/O2mX0IJIyYd0Bl71sJHhbYH7v0snB
         wNQouyI+Dvc+01BVXKTo4vn6udMn6je+IDGdKNf7zo6LN+CN9ma/hEEAscgXZjxEL+0y
         6xY+mcstYh3QMsb3OTkar1GVwCbPCjaB472dQSZPhQi36hyH9aslShvypWOW4uETWl1t
         YFyc8uax4NbCPK015SAit9bId7xgrrwORP67+WOlPyoj95itr5Chiwikffu6NonD6w72
         NooA==
X-Gm-Message-State: AOJu0YzuRJ7bXwoljj1o1zXuNSL9KN3xLD5VgXphP/tUFz/WO/1dAwUS
        Sq5tXYFwJwTbd39vVb9AukKpQQ==
X-Google-Smtp-Source: AGHT+IHjFC6nDf4W0MIiTHQ5Vsil8/hQIjbCss9sx8CmgDHYcwV6iMqCPxN37OS6HIohKShUayaC9Q==
X-Received: by 2002:a17:90b:3805:b0:27d:5562:7e0b with SMTP id mq5-20020a17090b380500b0027d55627e0bmr4235389pjb.7.1699612421849;
        Fri, 10 Nov 2023 02:33:41 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id oa3-20020a17090b1bc300b0027cfd582b51sm1319374pjb.3.2023.11.10.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:33:41 -0800 (PST)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to some Intel PCI bridge
Date:   Fri, 10 Nov 2023 18:32:28 +0800
Message-ID: <20231110103227.58008-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapter
connects to some Intel PCI bridges, such as Skylake and Kabylake.
Otherwise, the PCI AER flood hangs system:

pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5
pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: can't find device of ID00e5

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=218127
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 43b611d5288d..720c79e0781a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -25,10 +25,29 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
+	struct pci_dev *bridge_pdev;
 
 	/*close ASPM for AMD defaultly */
 	rtlpci->const_amdpci_aspm = 0;
 
+	/* Disable ASPM if RTL8723BE connects to some Intel PCI bridges, such as
+	 * Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
+	 */
+	bridge_pdev = rtlpci->pdev->bus->self;
+	if (bridge_pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch(bridge_pdev->device) {
+		case 0x9d15:
+		/* PCI bridges on Skylake */
+		case 0xa110 ... 0xa11f:
+		case 0xa167 ... 0xa16a:
+		/* PCI bridges on Kabylake */
+		case 0xa290 ... 0xa29f:
+		case 0xa2e7 ... 0xa2ee:
+			rtlpriv->cfg->mod_params->aspm_support = 0;
+			break;
+		}
+	}
+
 	/* ASPM PS mode.
 	 * 0 - Disable ASPM,
 	 * 1 - Enable ASPM without Clock Req,
-- 
2.42.1

