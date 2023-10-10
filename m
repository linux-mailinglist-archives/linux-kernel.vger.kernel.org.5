Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC72C7BF780
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjJJJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjJJJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:38:24 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D31D8;
        Tue, 10 Oct 2023 02:38:18 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso987500666b.1;
        Tue, 10 Oct 2023 02:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930697; x=1697535497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+S7MtfjpOsax/1um4lfOdbgQCVIBHweerFRoRDaRZc=;
        b=L2ljgAJuNsDtfv8/4jK7p77KoaGKfxL14qbbnyke/D0CSr/Bg5/JfwB9bEW7RFaS0o
         IsjHct8GCgNSdBKa/jaUmrkJh+OAOcsUpVcLUtilzb2MQ0y/ifqhAwuT63bw7t3XS/+r
         xLw8WCkDSNz775pUXPKGGfklKehn4CeveyqRcNmqtfBdETu5DZSs00M6sA9xCs00Qv4m
         SrFW1V8ZARYfnRbsq2oXs0aZh/O3sFCBMcft0ILlWXeXOIpQ+Cw6DS4vmZ3c+d9AiYjt
         ZV1RLGsOXhQ7vRQMQXCyKC5ZPZ17KFi//GjB9JWSlitn+NldpQuFf9SAk0fPXSSDsQ11
         sq9w==
X-Gm-Message-State: AOJu0YxQYi39PTs+GOkaMgeiIff3PcOs8/QFcpOOJb5Jj6SPt6nnwmxW
        94hvOxFcXemrPVsUb54u3qcJKhAo880=
X-Google-Smtp-Source: AGHT+IGhAAUNp2LGsH2fW5ztAMg1kJZ+KajaPgdjM08JddOZltyuWt/okhcCeHUBtSVPpyJntjb13Q==
X-Received: by 2002:a17:906:31d6:b0:99b:ed44:1a79 with SMTP id f22-20020a17090631d600b0099bed441a79mr15617355ejf.3.1696930696669;
        Tue, 10 Oct 2023 02:38:16 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906468600b009a5f7fb51dcsm8074699ejr.42.2023.10.10.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:38:10 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v3 2/4] netconsole: Initialize configfs_item for default targets
Date:   Tue, 10 Oct 2023 02:37:49 -0700
Message-Id: <20231010093751.3878229-3-leitao@debian.org>
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

For netconsole targets allocated during the boot time (passing
netconsole=... argument), netconsole_target->item is not initialized.
That is not a problem because it is not used inside configfs.

An upcoming patch will be using it, thus, initialize the targets with
the name 'cmdline' plus a counter starting from 0.  This name will match
entries in the configfs later.

Suggested-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d609fb59cf99..3d7002af505d 100644
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
@@ -165,6 +167,10 @@ static void netconsole_target_put(struct netconsole_target *nt)
 {
 }
 
+static void populate_configfs_item(struct netconsole_target *nt,
+				   int cmdline_count)
+{
+}
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Allocate and initialize with defaults.
@@ -688,6 +694,17 @@ static struct configfs_subsystem netconsole_subsys = {
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
@@ -887,7 +904,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 }
 
 /* Allocate new target (from boot/module param) and setup netpoll for it */
-static struct netconsole_target *alloc_param_target(char *target_config)
+static struct netconsole_target *alloc_param_target(char *target_config,
+						    int cmdline_count)
 {
 	struct netconsole_target *nt;
 	int err;
@@ -922,6 +940,7 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (err)
 		goto fail;
 
+	populate_configfs_item(nt, cmdline_count);
 	nt->enabled = true;
 
 	return nt;
@@ -954,6 +973,7 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	unsigned int count = 0;
 	bool extended = false;
 	unsigned long flags;
 	char *target_config;
@@ -961,7 +981,7 @@ static int __init init_netconsole(void)
 
 	if (strnlen(input, MAX_PARAM_LENGTH)) {
 		while ((target_config = strsep(&input, ";"))) {
-			nt = alloc_param_target(target_config);
+			nt = alloc_param_target(target_config, count);
 			if (IS_ERR(nt)) {
 				err = PTR_ERR(nt);
 				goto fail;
@@ -977,6 +997,7 @@ static int __init init_netconsole(void)
 			spin_lock_irqsave(&target_list_lock, flags);
 			list_add(&nt->list, &target_list);
 			spin_unlock_irqrestore(&target_list_lock, flags);
+			count++;
 		}
 	}
 
-- 
2.34.1

