Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13577774F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjHJJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjHJJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:55:18 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E6C211F;
        Thu, 10 Aug 2023 02:55:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99d6d5054bcso53172766b.1;
        Thu, 10 Aug 2023 02:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661316; x=1692266116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcmFvkTZaOEF7ex/M10t1g9cl0Ka7mKgrAMDoUfhRLc=;
        b=gfHtFhrPkk0w+tYHrQtguuPM2nRpEomgKR9AsRHOgVrGQdvGyD1cZ+xFVu6vCV+PE2
         JdEbN+baniRN7GqrOU1Q7JBiyT8tlgOLr09kqrEZwFwCh0gqHPdfRmBh25frto+gsRRW
         6ae8of1MoqS0NOzx4PjzZD0JS3yNv4IxzWIJcN7LCRsNJ06REptn73ADcDCEjtggaZWN
         v2dEiO11DYP9dxSx0XqzC5CuoXuYeLDp2qGbrVUrmfz6/IYc1lGmZqZTGkppKXgJRH6S
         r0MC3OJH3qYR6Eo2o4vRpWjRkmNTrqys9+ljZ4rTrfbJ8l0U63sy7ZC62FmnMr5jboiv
         0ujA==
X-Gm-Message-State: AOJu0YyOYGfqcWBk1zpjCoVw2zbP+IRml5282XWereQsaH47yapLZBVC
        +sVZoHUfrdU2/rgV3AVRIko=
X-Google-Smtp-Source: AGHT+IGDo7qix2jFbYzjd/Wkd9HG3qvfVtWCvu8IuJwutp1lVi6AKLgN4qxc5MXRXuhU7uSUNnYnmA==
X-Received: by 2002:a17:907:9623:b0:98e:1c4b:10e2 with SMTP id gb35-20020a170907962300b0098e1c4b10e2mr2008863ejc.20.1691661316035;
        Thu, 10 Aug 2023 02:55:16 -0700 (PDT)
Received: from localhost (fwdproxy-cln-117.fbsv.net. [2a03:2880:31ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709062dc800b0099b7276235esm697720eji.93.2023.08.10.02.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:55:15 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 1/2] netconsole: Create a allocation helper
Date:   Thu, 10 Aug 2023 02:54:50 -0700
Message-Id: <20230810095452.3171106-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095452.3171106-1-leitao@debian.org>
References: <20230810095452.3171106-1-leitao@debian.org>
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
 drivers/net/netconsole.c | 42 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd..f93b98d64a3c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -167,19 +167,16 @@ static void netconsole_target_put(struct netconsole_target *nt)
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
-/* Allocate new target (from boot/module param) and setup netpoll for it */
-static struct netconsole_target *alloc_param_target(char *target_config)
+/* Allocate and initialize with defaults.
+ * Note that these targets get their config_item fields zeroed-out.
+ */
+static struct netconsole_target *alloc_and_init(void)
 {
-	int err = -ENOMEM;
 	struct netconsole_target *nt;
 
-	/*
-	 * Allocate and initialize with defaults.
-	 * Note that these targets get their config_item fields zeroed-out.
-	 */
 	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
 	if (!nt)
-		goto fail;
+		return nt;
 
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
@@ -187,6 +184,21 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 
+	return nt;
+}
+
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
 	if (*target_config == '+') {
 		nt->extended = true;
 		target_config++;
@@ -664,23 +676,13 @@ static const struct config_item_type netconsole_target_type = {
 static struct config_item *make_netconsole_target(struct config_group *group,
 						  const char *name)
 {
-	unsigned long flags;
 	struct netconsole_target *nt;
+	unsigned long flags;
 
-	/*
-	 * Allocate and initialize with defaults.
-	 * Target is disabled at creation (!enabled).
-	 */
-	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
+	nt = alloc_and_init();
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

