Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D87F009D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjKRPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjKRPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:27 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E751717;
        Sat, 18 Nov 2023 07:51:28 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so2930520276.0;
        Sat, 18 Nov 2023 07:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322686; x=1700927486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aggm3BNjkpQF7Koo2HqoELFr7cmqY1seHu1T/WMe7U=;
        b=YSZU3unXxunBjc0Nwg3LGWUwuVEUIjnWBFaxcuQ9q+Z7ObgNYQN7NrfhdPSPxzbxhk
         04W07mpNFFNRxri1fG5gJ4sn697UaQVCebHYqn09C4vzO4FDtuZHBqMfM67miN4aHZkQ
         SopWczZEwqmnakeZUnlT81J9LVUL2nb1Ry718lGzB0ORy7xQtpwHkCea3USCkItcsEBx
         IwC+QXKKHqu5UWSiSW13C/IeFtrvu5i54A1D9sw2brWvw6ardCzvhP40s4XUjSpJhODB
         L05cydNJKVLuvG8L6mgODO7HJnCugy9faB2ZCVS8Baf45q+yIYYR4rAFJOaYYp3n6ilW
         pn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322686; x=1700927486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aggm3BNjkpQF7Koo2HqoELFr7cmqY1seHu1T/WMe7U=;
        b=Fvgf4DImL67n1JSfpUjw7oDFeopsi1R4kTRqpID8Rkw8ukteAo6NAFsQojoFsvAE2h
         YhLranh7PaT0tmQWOVXhPvYEt0Ng+p5E7Miha+TqJUoT8HcOhe6z544DQ9OuyNbFLEuc
         e2EJJQ6KRbH528fSyMjt1zND1E2XTV3bkHNXFt54zezKMcLDXHo0jmsG8lnaX+lyf95x
         LMjp+yeeIttagJCjYUUOeL9ehwhSW7KC8vZnWW/YrwTPa/pmYRCdirjnNdvdVdFpoQJI
         BZLIouQq+3C5PcfSSLhRfCb5+JyttbfdU28DXcrBZ/9Ueq4FDM4Y6+2ab0LuTWK5WdfS
         /QBA==
X-Gm-Message-State: AOJu0YxoxW9nVCmObO/zyylhyj3qjvM7e9MS4+B2oBa/Zdk/WerOd+9x
        1CMHNloY7Q3i2yj0RV8msqx9GyvoT57NN8I+
X-Google-Smtp-Source: AGHT+IEl/Ly5SGFxHhjFErkw0m69iAcv/uiGWWg8tpAKjYHYXPFvZ4wbYsrNE640IyvZon4rsbzP6w==
X-Received: by 2002:a25:2bc8:0:b0:d9a:5630:5281 with SMTP id r191-20020a252bc8000000b00d9a56305281mr2127641ybr.62.1700322686501;
        Sat, 18 Nov 2023 07:51:26 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id w16-20020a05690202d000b00d9abce6acf2sm964670ybh.59.2023.11.18.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:25 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 11/34] wifi: rtw88: optimize rtw_pci_tx_kick_off() by using find_bit()
Date:   Sat, 18 Nov 2023 07:50:42 -0800
Message-Id: <20231118155105.25678-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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
2.39.2

