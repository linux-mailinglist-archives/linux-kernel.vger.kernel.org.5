Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0926A8026DE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjLCTdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjLCTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:33 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED178FC;
        Sun,  3 Dec 2023 11:33:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db539ab8e02so2126318276.0;
        Sun, 03 Dec 2023 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632009; x=1702236809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2bgHWfqDyO3lNVNF7Er5ockraMzuQx9Kc/cYil1cOo=;
        b=mXM/GQNhSGvUH5dY0iRIV7P63pGxaAk57QQSDEZP+DAM7nTnnmYpXmPEB+TLQhRz1s
         67hsLViH79+OO15fdCSSIvuna1YnDa2Ezj26WVDWYUdnPHVhYz0h/mXmDyy459y/ZM+F
         bI5Hs28bPXYrt99IQlrRzwtZxhuwi72wTGspqpolISMr93m3a4sX/5QXCZ5P3diAvyzx
         xuONh6botTUHc9jJuZPq3xat1pKD1DlfHl0l5h2LvkVeYFDqijSjCuK3KvUGQEMXEmGz
         32LiKzIrtYl+2QeYqRsSl9JUh2uCtSCSd2hkT0bNXqoMqX4tNKG9YZcyUdIr10CVpc8x
         UUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632009; x=1702236809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2bgHWfqDyO3lNVNF7Er5ockraMzuQx9Kc/cYil1cOo=;
        b=FHIrlkrUq++h7nYPmoSDrOGgzW0ivBekkTWvkmdFvzcQQMIOdaLU/o72C4CLV5Gau3
         043v8oscl3R+BdccFP4WiQa/K7DtWz6Ea94lhQycftGm0zVB2e9ySgT9hmFIsR+Fc3qk
         xfa9+I8cII59K2rG9UkBksXBl4mjzUoQdniyqXl2lJh23SwpOO0j1udhh8IoLAz46Zy/
         6lQaKEkeIE1vrk2WbPaEs7gFbFqKyt6uPvjZuBPywFzVcdXykJgDtPLcbyscDz6DrtS2
         MNElcOU9Un0ArbFy//bYxqFt8/4M4UnrmXaYjJEqn4m0hbYgLQMguAt8/lE4INFCrnhY
         xe4w==
X-Gm-Message-State: AOJu0YzxtMpeqJvAnqoMoeJfiH+Unb6nJeczrufc0FIaKA9Xd6UyxgA0
        j9ai5kwxgxe8WyRIshAubxsg4jzGw7vCAw==
X-Google-Smtp-Source: AGHT+IETTzlb51Pnj/XyEVoHB9AyqyMCKMnSKLn74ys+Zqx8CWiQjFdSiKyVyEzB+LTTNvzxPlUbxQ==
X-Received: by 2002:a25:cf14:0:b0:db7:dacf:ed7f with SMTP id f20-20020a25cf14000000b00db7dacfed7fmr1778995ybg.96.1701632008700;
        Sun, 03 Dec 2023 11:33:28 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id v18-20020a259112000000b00d9cbf2aabc6sm1763099ybl.14.2023.12.03.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:28 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 12/35] wifi: rtw88: optimize rtw_pci_tx_kick_off() by using find_bit()
Date:   Sun,  3 Dec 2023 11:32:44 -0800
Message-Id: <20231203193307.542794-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_pci_tx_kick_off() traverses tx_queued bitmap bit by bit. We can do it
faster by using atomic for_each_test_and_clear_bit() iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 5 ++---
 drivers/net/wireless/realtek/rtw89/pci.c | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 2bfc0e822b8d..a0d69c75a381 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -789,9 +789,8 @@ static void rtw_pci_tx_kick_off(struct rtw_dev *rtwdev)
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	enum rtw_tx_queue_type queue;
 
-	for (queue = 0; queue < RTK_MAX_TX_QUEUE_NUM; queue++)
-		if (test_and_clear_bit(queue, rtwpci->tx_queued))
-			rtw_pci_tx_kick_off_queue(rtwdev, queue);
+	for_each_test_and_clear_bit(queue, rtwpci->tx_queued, RTK_MAX_TX_QUEUE_NUM)
+		rtw_pci_tx_kick_off_queue(rtwdev, queue);
 }
 
 static int rtw_pci_tx_write_data(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 14ddb0d39e63..184d41b774d7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1077,10 +1077,7 @@ static void rtw89_pci_tx_kick_off_pending(struct rtw89_dev *rtwdev)
 	struct rtw89_pci_tx_ring *tx_ring;
 	int txch;
 
-	for (txch = 0; txch < RTW89_TXCH_NUM; txch++) {
-		if (!test_and_clear_bit(txch, rtwpci->kick_map))
-			continue;
-
+	for_each_test_and_clear_bit(txch, rtwpci->kick_map, RTW89_TXCH_NUM) {
 		tx_ring = &rtwpci->tx_rings[txch];
 		__rtw89_pci_tx_kick_off(rtwdev, tx_ring);
 	}
-- 
2.40.1

