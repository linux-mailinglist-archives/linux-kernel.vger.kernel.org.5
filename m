Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7391277007C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjHDMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHDMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:48:15 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA54E7;
        Fri,  4 Aug 2023 05:47:42 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so2589528a12.1;
        Fri, 04 Aug 2023 05:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153216; x=1691758016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRqehSRIoi9nVHhMtBn7xUoJn1aGYwvHr/iVwpeswiM=;
        b=ZF0s80KYufNhFMc+tfd4OXXc6USP3+WylaPsP61+Ao/qcbNDEf/+Gy4PNnii8xA/RB
         T6rA+TpV0xr9iALeYUttLdFtQGPcaFXUqo6XYMFhx/sazjuXZiAViOjGjOKx/5tcB8Ga
         sirYz2cLlTOdP+cuF3VIx9OGqeYpjWRklskfQ70l3EsEx55wZ6Nxg92NHLe4555/ZtGn
         U5ihSuSsa5XR4gwaOs4wgZizEx0jFCX23eqRqA5iHyuC6wNiSZcx7F0TSqXeC/RTHhUp
         hSn6h6OxDaXPa7JuWGMUVp0LCP/Bh7BBzSpLpcs04J9t6Eyl4Deen9Z7SyotkI/Qe8yG
         hg3w==
X-Gm-Message-State: AOJu0YxaudFrdbLXkX8n1qNp5mbmKIru+5BXxckL3UO6Uza91FAFmBLs
        s2y/dKxhOWfapU5sMGMeNMg=
X-Google-Smtp-Source: AGHT+IGSvUO6FcynF+zGxK7Ax+EVejx9GwM0nzc8z8ex+AmCy4QavFcSbHoInYsEvvqX89lnvOhWqQ==
X-Received: by 2002:aa7:d0c3:0:b0:523:1436:578d with SMTP id u3-20020aa7d0c3000000b005231436578dmr1364108edo.8.1691153216034;
        Fri, 04 Aug 2023 05:46:56 -0700 (PDT)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b005227ead61d0sm1215674edy.83.2023.08.04.05.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:46:55 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 1/2] netconsole: Create a allocation helper
Date:   Fri,  4 Aug 2023 05:43:20 -0700
Message-Id: <20230804124322.113506-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804124322.113506-1-leitao@debian.org>
References: <20230804124322.113506-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

De-duplicate the initialization and allocation code for struct
netconsole_target.

The same allocation and initialization code is duplicated in two
different places in the netconsole subsystem, when the netconsole target
is initialized by command line parameters (alloc_param_target()), and
dynamically by sysfs (make_netconsole_target()).

Create a helper function, and call it from the two different functions.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 41 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd..a7df782530cf 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -167,19 +167,15 @@ static void netconsole_target_put(struct netconsole_target *nt)
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
-/* Allocate new target (from boot/module param) and setup netpoll for it */
-static struct netconsole_target *alloc_param_target(char *target_config)
+/* Allocate and initialize with defaults.
+ * Note that these targets get their config_item fields zeroed-out.
+ */
+static struct netconsole_target *alloc_and_init(void)
 {
-	int err = -ENOMEM;
-	struct netconsole_target *nt;
+	struct netconsole_target *nt = kzalloc(sizeof(*nt), GFP_KERNEL);
 
-	/*
-	 * Allocate and initialize with defaults.
-	 * Note that these targets get their config_item fields zeroed-out.
-	 */
-	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
 	if (!nt)
-		goto fail;
+		return nt;
 
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
@@ -187,6 +183,18 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 
+	return nt;
+}
+
+/* Allocate new target (from boot/module param) and setup netpoll for it */
+static struct netconsole_target *alloc_param_target(char *target_config)
+{
+	struct netconsole_target *nt = alloc_and_init();
+	int err = -ENOMEM;
+
+	if (!nt)
+		goto fail;
+
 	if (*target_config == '+') {
 		nt->extended = true;
 		target_config++;
@@ -664,23 +672,12 @@ static const struct config_item_type netconsole_target_type = {
 static struct config_item *make_netconsole_target(struct config_group *group,
 						  const char *name)
 {
+	struct netconsole_target *nt = alloc_and_init();
 	unsigned long flags;
-	struct netconsole_target *nt;
 
-	/*
-	 * Allocate and initialize with defaults.
-	 * Target is disabled at creation (!enabled).
-	 */
-	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
 
-	nt->np.name = "netconsole";
-	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-	nt->np.local_port = 6665;
-	nt->np.remote_port = 6666;
-	eth_broadcast_addr(nt->np.remote_mac);
-
 	/* Initialize the config_item member */
 	config_item_init_type_name(&nt->item, name, &netconsole_target_type);
 
-- 
2.34.1

