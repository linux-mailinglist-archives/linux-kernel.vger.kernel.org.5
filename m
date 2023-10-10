Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2BF7BF77E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjJJJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:38:11 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1FBA7;
        Tue, 10 Oct 2023 02:38:10 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9b64b98656bso917775666b.0;
        Tue, 10 Oct 2023 02:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930688; x=1697535488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M90K/d3r5eUqR7rkir6gs7Lk0yYzS3hpFs7OoQ1iJbU=;
        b=iXHqKlHVWl+cC2CLWN3WzQmCBfBLE2sBWgRfhTtDBQf8X3IsSaniHvwSsaG/SXSdWu
         g5gb/z1RVd1pxJAsN3Na2Xl/Dye4etorV+nFkTR+YFuZbpQ9zIa2nhdbBc8fXu5CMUOZ
         3s9Lh6vbRj390z+ai/AXNJ+oNscciAR87qPhhFHJRUH62zKAuJThharGUAY7H8GlQZ8j
         pmocfvaJbVrC+I+6PiXYQXyfNo5kFEcMJKw2oce+QJnVTpywBarNRHXb5PLnhqAxk6lD
         nyQFC33kvbIxa018+5nhMYoq+NkknoSTvG1nG3cMFny+xhpFXYeS6N9jwaBvCsu+d4YA
         sb0A==
X-Gm-Message-State: AOJu0YzYtO/vHiPFeJgQq8KthIsL5a9pGV5Y0hwpq6+o5k9DuC7TykD+
        +r3+JVvj3/flWMSWSXZHqe0=
X-Google-Smtp-Source: AGHT+IHl+5BjCBDzgSSxHqHQ+6ZcSzI7hb/S5Ath/BoScpDKMJlmMZDOLiHOXiGnQkHxuJfAx1PaRA==
X-Received: by 2002:a17:906:2d1:b0:9b2:b765:8802 with SMTP id 17-20020a17090602d100b009b2b7658802mr17226383ejk.40.1696930688532;
        Tue, 10 Oct 2023 02:38:08 -0700 (PDT)
Received: from localhost (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id jp20-20020a170906f75400b009a1c05bd672sm8008483ejb.127.2023.10.10.02.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:38:06 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v3 1/4] netconsole: move init/cleanup functions lower
Date:   Tue, 10 Oct 2023 02:37:48 -0700
Message-Id: <20231010093751.3878229-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010093751.3878229-1-leitao@debian.org>
References: <20231010093751.3878229-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move alloc_param_target() and its counterpart (free_param_target())
to the bottom of the file. These functions are called mostly at
initialization/cleanup of the module, and they should be just above the
callers, at the bottom of the file.

From a practical perspective, having alloc_param_target() at the bottom
of the file will avoid forward declaration later (in the following
patch).

Nothing changed other than the functions location.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 104 +++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3111e1648592..d609fb59cf99 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -192,58 +192,6 @@ static struct netconsole_target *alloc_and_init(void)
 	return nt;
 }
 
-/* Allocate new target (from boot/module param) and setup netpoll for it */
-static struct netconsole_target *alloc_param_target(char *target_config)
-{
-	struct netconsole_target *nt;
-	int err;
-
-	nt = alloc_and_init();
-	if (!nt) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	if (*target_config == '+') {
-		nt->extended = true;
-		target_config++;
-	}
-
-	if (*target_config == 'r') {
-		if (!nt->extended) {
-			pr_err("Netconsole configuration error. Release feature requires extended log message");
-			err = -EINVAL;
-			goto fail;
-		}
-		nt->release = true;
-		target_config++;
-	}
-
-	/* Parse parameters and setup netpoll */
-	err = netpoll_parse_options(&nt->np, target_config);
-	if (err)
-		goto fail;
-
-	err = netpoll_setup(&nt->np);
-	if (err)
-		goto fail;
-
-	nt->enabled = true;
-
-	return nt;
-
-fail:
-	kfree(nt);
-	return ERR_PTR(err);
-}
-
-/* Cleanup netpoll for given target (from boot/module param) and free it */
-static void free_param_target(struct netconsole_target *nt)
-{
-	netpoll_cleanup(&nt->np);
-	kfree(nt);
-}
-
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
@@ -938,6 +886,58 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
+/* Allocate new target (from boot/module param) and setup netpoll for it */
+static struct netconsole_target *alloc_param_target(char *target_config)
+{
+	struct netconsole_target *nt;
+	int err;
+
+	nt = alloc_and_init();
+	if (!nt) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	if (*target_config == '+') {
+		nt->extended = true;
+		target_config++;
+	}
+
+	if (*target_config == 'r') {
+		if (!nt->extended) {
+			pr_err("Netconsole configuration error. Release feature requires extended log message");
+			err = -EINVAL;
+			goto fail;
+		}
+		nt->release = true;
+		target_config++;
+	}
+
+	/* Parse parameters and setup netpoll */
+	err = netpoll_parse_options(&nt->np, target_config);
+	if (err)
+		goto fail;
+
+	err = netpoll_setup(&nt->np);
+	if (err)
+		goto fail;
+
+	nt->enabled = true;
+
+	return nt;
+
+fail:
+	kfree(nt);
+	return ERR_PTR(err);
+}
+
+/* Cleanup netpoll for given target (from boot/module param) and free it */
+static void free_param_target(struct netconsole_target *nt)
+{
+	netpoll_cleanup(&nt->np);
+	kfree(nt);
+}
+
 static struct console netconsole_ext = {
 	.name	= "netcon_ext",
 	.flags	= CON_ENABLED | CON_EXTENDED,
-- 
2.34.1

