Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB57769378
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjGaKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjGaKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:44 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114C1FD0;
        Mon, 31 Jul 2023 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690800560; bh=Vrcj0+W95eie0atm7f7h2d141pVyQYj9rZE2KYcFCZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkjBneP7eskEHDv3Pg696FP1Dy8ttxrr7xM6KKCmz40bL4sW/8VCSDP+eJ3DyZNXq
         oj4vFIeohtyX7C2zPy6tCjPDUZfAKKlmW29q3O7huLckR38wUri1qYpUHTjPZW2yaG
         uMRbv/AAbAd28/jhu4HXSFyOFC30Yq/7HlVgG/Zs=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9DEF46018C;
        Mon, 31 Jul 2023 18:49:20 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 2/5] raid6: guard the tables.c include of <linux/export.h> with __KERNEL__
Date:   Mon, 31 Jul 2023 18:49:08 +0800
Message-Id: <20230731104911.411964-3-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230731104911.411964-1-kernel@xen0n.name>
References: <20230731104911.411964-1-kernel@xen0n.name>
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

From: WANG Xuerui <git@xen0n.name>

The export directives for the tables are already emitted with __KERNEL__
guards, but the <linux/export.h> include is not, causing errors when
building the raid6test program. Guard this include too to fix the
raid6test build.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 lib/raid6/mktables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/raid6/mktables.c b/lib/raid6/mktables.c
index f02e10fa62381..3be03793237c2 100644
--- a/lib/raid6/mktables.c
+++ b/lib/raid6/mktables.c
@@ -56,7 +56,9 @@ int main(int argc, char *argv[])
 	uint8_t v;
 	uint8_t exptbl[256], invtbl[256];
 
+	printf("#ifdef __KERNEL__\n");
 	printf("#include <linux/export.h>\n");
+	printf("#endif\n");
 	printf("#include <linux/raid/pq.h>\n");
 
 	/* Compute multiplication table */
-- 
2.40.0

