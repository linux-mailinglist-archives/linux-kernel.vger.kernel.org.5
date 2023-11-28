Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10CA7FC8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjK1Vfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjK1Vff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:35:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EADBD63;
        Tue, 28 Nov 2023 13:35:40 -0800 (PST)
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDB496602F24;
        Tue, 28 Nov 2023 21:35:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701207339;
        bh=67uH3wWuxI9nNHNPdHxCUf8N5hbi47QYbIBUACpFrkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khtNOesDlK2le5wbv0ZMy887UBOAZ36fL0jPVecU7ugeEmY+aX5RgaAYA0R3fwBOm
         hx+bpW/rRLZl+Y0wZRHlW3oqZDXtPryVFMvIpvKMTzDKNDp0ECeI4a83Drd4MXvC09
         KXLtD6WeiXdz/lx91N/PGNWKF1kXdlc+SOBH2q0jdb8B82JRFG5n1cG0KzzJvsbRVz
         ip1VRknzrYMxYPY5N3bAjsligu4PGW/N5p1c+aZehVnfX5lPxeMaY7//RFJFahucfi
         U3TyDcEK2KlGyf2jtx+STyXQKMHv8efs1HN+rxgaGh0es1GMvrFeEIqxIMAl3QNiEd
         aRbAXVi8khXCQ==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 203179676CFA; Tue, 28 Nov 2023 22:35:37 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] bus: moxtet: Mark the irq as shared
Date:   Tue, 28 Nov 2023 22:35:04 +0100
Message-ID: <20231128213536.3764212-2-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128213536.3764212-1-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
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

The Turris Mox shares the moxtet IRQ with various devices on the board,
so mark the IRQ as shared in the driver as well.

Without this loading the module will fail with:
  genirq: Flags mismatch irq 40. 00002002 (moxtet) vs. 00002080 (mcp7940x)

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Cc: stable@vger.kernel.org # v6.2+
---

(no changes since v1)

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
2.43.0

