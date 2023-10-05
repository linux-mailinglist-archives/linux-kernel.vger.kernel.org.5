Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F97BA037
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjJEOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjJEOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6726A4C;
        Thu,  5 Oct 2023 05:37:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so1538302a12.2;
        Thu, 05 Oct 2023 05:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696509431; x=1697114231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evoVQq8sZfXXqhKGthgDih8IbsSodAMl/ul/GSH8ebw=;
        b=sNzx7w5KPKtur6My5QhL+eb2fpJeXOQci7YtcpzPrkqnXhZYt4UfQBDHONkUDa6MC/
         tIyfbo9gu9aJY9vY1u7f4FEfg/nfRUj7mRTvO55IeM8moySHXD+kua1ev7btZ3Ilqihg
         3hdX958objluz4N2CxTes2OIZNFLFYq0PMmaG5EwIe8P6FxIBRvfdmZZnXNhmOBbgOTq
         Yyu5hUyJZeAkUOxkKxWm2jxLARhgksDJZ+d1QUd/doa82Hr7ucYHOxn9zcUamrPkrwZF
         EP57zAVtBFUi4kldGCPSyQ02okZMBNmVzq4DpYKF4NsnMeKG54HjtQ1QEc+16BBd+hEa
         Wy4Q==
X-Gm-Message-State: AOJu0YxD2G5TZLOJrC+q78Paxk1coKxtxyBMZUkYPNk1okW7MN7sr2k1
        1132ENJAfTbsno6wGcl1cWk=
X-Google-Smtp-Source: AGHT+IGN+bQa1DsuV1ym/1baM5eKYxNEDhg82QhHBCqEQYE71dOyF4vOVoDbI8TFAYhISe3sCbsfFA==
X-Received: by 2002:a17:906:714a:b0:9b2:b9ad:ddd1 with SMTP id z10-20020a170906714a00b009b2b9adddd1mr4885066ejj.28.1696509430566;
        Thu, 05 Oct 2023 05:37:10 -0700 (PDT)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id gq7-20020a170906e24700b00993664a9987sm1131147ejb.103.2023.10.05.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:37:10 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v2 1/3] netconsole: Initialize configfs_item for default targets
Date:   Thu,  5 Oct 2023 05:36:34 -0700
Message-Id: <20231005123637.2685334-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005123637.2685334-1-leitao@debian.org>
References: <20231005123637.2685334-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For netconsole targets allocated during the boot time (passing
netconsole=... argument), netconsole_target->item is not initialized.
That is not a problem because it is not used inside configfs.

An upcoming patch will be using it, thus, initialize the targets with
the name 'cmdline' plus a counter starting from 0.  This name will match
entries in the configfs later.

Suggested-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3111e1648592..7c46cf1c923e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -53,6 +53,8 @@ static bool oops_only = false;
 module_param(oops_only, bool, 0600);
 MODULE_PARM_DESC(oops_only, "Only log oops messages");
 
+#define NETCONSOLE_PARAM_TARGET_NAME "cmdline"
+
 #ifndef	MODULE
 static int __init option_setup(char *opt)
 {
@@ -108,6 +110,8 @@ struct netconsole_target {
 	struct netpoll		np;
 };
 
+static void populate_configfs_item(struct netconsole_target *nt,
+				   int cmdline_count);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 static struct configfs_subsystem netconsole_subsys;
@@ -165,6 +169,10 @@ static void netconsole_target_put(struct netconsole_target *nt)
 {
 }
 
+static void populate_configfs_item(struct netconsole_target *nt,
+				   int cmdline_count)
+{
+}
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Allocate and initialize with defaults.
@@ -193,7 +201,8 @@ static struct netconsole_target *alloc_and_init(void)
 }
 
 /* Allocate new target (from boot/module param) and setup netpoll for it */
-static struct netconsole_target *alloc_param_target(char *target_config)
+static struct netconsole_target *alloc_param_target(char *target_config,
+						    int cmdline_count)
 {
 	struct netconsole_target *nt;
 	int err;
@@ -228,6 +237,7 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (err)
 		goto fail;
 
+	populate_configfs_item(nt, cmdline_count);
 	nt->enabled = true;
 
 	return nt;
@@ -740,6 +750,17 @@ static struct configfs_subsystem netconsole_subsys = {
 	},
 };
 
+static void populate_configfs_item(struct netconsole_target *nt,
+				   int cmdline_count)
+{
+	char target_name[16];
+
+	snprintf(target_name, sizeof(target_name), "%s%d",
+		 NETCONSOLE_PARAM_TARGET_NAME, cmdline_count);
+	config_item_init_type_name(&nt->item, target_name,
+				   &netconsole_target_type);
+}
+
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Handle network interface device notifications */
@@ -954,6 +975,7 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	unsigned int count = 0;
 	bool extended = false;
 	unsigned long flags;
 	char *target_config;
@@ -961,7 +983,7 @@ static int __init init_netconsole(void)
 
 	if (strnlen(input, MAX_PARAM_LENGTH)) {
 		while ((target_config = strsep(&input, ";"))) {
-			nt = alloc_param_target(target_config);
+			nt = alloc_param_target(target_config, count);
 			if (IS_ERR(nt)) {
 				err = PTR_ERR(nt);
 				goto fail;
@@ -977,6 +999,7 @@ static int __init init_netconsole(void)
 			spin_lock_irqsave(&target_list_lock, flags);
 			list_add(&nt->list, &target_list);
 			spin_unlock_irqrestore(&target_list_lock, flags);
+			count++;
 		}
 	}
 
-- 
2.34.1

