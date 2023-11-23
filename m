Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED017F6152
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbjKWOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjKWOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:24:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18CFB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:24:06 -0800 (PST)
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA02D66073C1;
        Thu, 23 Nov 2023 14:24:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700749445;
        bh=XLlFUppiZTcE2XT8hs3mPsepvnwkxkup7a8IWuwxykY=;
        h=From:To:Cc:Subject:Date:From;
        b=S96rS86xzISdPqFqxaW44mm5z/lwt02xU0tdo6ebhLqaRyllxm5aIWlHz57FV+aOW
         M+WLrowBRHPxOWKCHI1QVvTz9JPuHv7yeAa5ucj6jCDTLesgxu9953lzkizayyq8Ae
         MQrA5iEL/JIOqAdzWR3eo8M5c/MyuLCA+i65YJ6M7S8eTCiFW78abNUi+m/Lqq6G85
         d6yoKwqD6vprXGEuK6OMsH6bAQ9i9nnL0/DF/44h+6+fI15vFcP0CtsCy+Y63dnc9h
         RCuvO+hejVYlB/zsqT+bM2v/9bTqhcuOdw5n09tgMrVbvzZOmTbxLuX7hv8uly1JQH
         TGSFoD0+CYxVQ==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 1BA3395B3A93; Thu, 23 Nov 2023 15:24:03 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bus: moxtet: Mark the irq as shared
Date:   Thu, 23 Nov 2023 15:23:37 +0100
Message-ID: <20231123142403.2262032-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Turris Mox shares the moxtet IRQ with various devices on the board,
so mark the IRQ as shared in the driver as well.

Without this loading the module will fail with:
  genirq: Flags mismatch irq 40. 00002002 (moxtet) vs. 00002080 (mcp7940x)

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---

 drivers/bus/moxtet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 5eb0fe73ddc4..48c18f95660a 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -755,7 +755,7 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 	moxtet->irq.masked = ~0;
 
 	ret = request_threaded_irq(moxtet->dev_irq, NULL, moxtet_irq_thread_fn,
-				   IRQF_ONESHOT, "moxtet", moxtet);
+				   IRQF_SHARED | IRQF_ONESHOT, "moxtet", moxtet);
 	if (ret < 0)
 		goto err_free;
 
-- 
2.42.0

