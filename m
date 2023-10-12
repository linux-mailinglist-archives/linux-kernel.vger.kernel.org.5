Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53207C6C03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbjJLLOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjJLLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:14:27 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1397C0;
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso136599066b.1;
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109263; x=1697714063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M90K/d3r5eUqR7rkir6gs7Lk0yYzS3hpFs7OoQ1iJbU=;
        b=GiYRpW0rJPlYW2JjcPo4ldHt/c0J7OGGdkupOWlWVRl1PBX5+n7v5sSWFl3vHRikWP
         A2sUqc7pqGiKlI37dPG3jaMbfaBzeI49oIm4l4wiRhnb0oZjri/Un2S+bbTBMdyePUhm
         FAXKTKh+tGuk5upHTBqvcTL/5bov3o5bTa06Mp5SJ3FoVXJE70Bkd/1EiiLdPtvq+e7d
         gm9QT39ZXej6kH+nYEc43Mov4zvA2Lz3MTgQ6p6ctEtWreNFnnFmfeoGZ9fAsMsigtn8
         9X6QQZsoKAS8ezJ4Uv8qfixnpgc0YFxvBbDbAl05jHDyJ5KFCD03OTWECrelBoR20NH1
         ElrQ==
X-Gm-Message-State: AOJu0YzK3x8NIQFZsS/rldzYCKEvHtziF3Vb7AG43cFHBPBKccpsBIHw
        3wuJXGQRTTmMldgRM7K17Nw=
X-Google-Smtp-Source: AGHT+IHdp+0TlQs4PMX6dvzcWne+XYmwabv8NBr66J2S8Hztt2D6WA3tkFG8POHxJpEbfAXCOMNE4g==
X-Received: by 2002:a17:906:714a:b0:9b2:b9ad:ddd1 with SMTP id z10-20020a170906714a00b009b2b9adddd1mr21560154ejj.28.1697109262971;
        Thu, 12 Oct 2023 04:14:22 -0700 (PDT)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906190600b009ad89697c86sm11016697eje.144.2023.10.12.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:14:22 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v4 1/4] netconsole: move init/cleanup functions lower
Date:   Thu, 12 Oct 2023 04:13:58 -0700
Message-Id: <20231012111401.333798-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012111401.333798-1-leitao@debian.org>
References: <20231012111401.333798-1-leitao@debian.org>
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

