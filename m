Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F87789F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjHKJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjHKJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:32:08 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A7130E8;
        Fri, 11 Aug 2023 02:32:08 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9936b3d0286so255805366b.0;
        Fri, 11 Aug 2023 02:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746326; x=1692351126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L43YRbWhwTIYcqfCAzVUnGP7Ck0Q4Q4ph/jffCizGaA=;
        b=MRgK0cKOFsY5D/MsUUoeGvkSXsRqCLc2vUVPXNHYzNLqc+DCnagH7SHPOvpaPPSrs1
         w5VZRslEt2cMFuh4j80P/44x2U4N+Gn12vrJxQuZvQZCzjXHLrUTOzdmwd1PAMiU0JcJ
         BCstCh6NYC/xYYFFZb4n1EBE+KqG1nsZowzo5quLPQZLARx3jSGK5QsgwuCFZYsyC1tQ
         8jx0knjPd8PkR0j/mrFspdgQmLloyRtMTv/iWLbJ7iBdgZK4Cw9RWDI3OTBoGKQJFHWo
         NFEPrhJldPkQVUE4af/DqwIJwK4lhjJvexrvr725NJkdVi0NQ4ahRiULXWsIl5R4K8dH
         hCqg==
X-Gm-Message-State: AOJu0YxVo8F5gXwzXgtbxsNt86/Puov1TUHCnF9gfmhvqSR52zTDTTUs
        EsWLYsAVwf2joCA/cMRPne0=
X-Google-Smtp-Source: AGHT+IFMbvW4utX6c3zKgVbA/208r9lxTNN/3507/zwam861RWAtmk87zzAnYT0XcSeC7E4chhVLPA==
X-Received: by 2002:a17:906:2252:b0:991:fef4:bb9 with SMTP id 18-20020a170906225200b00991fef40bb9mr1262660ejr.58.1691746326514;
        Fri, 11 Aug 2023 02:32:06 -0700 (PDT)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709063c1800b0098e78ff1a87sm1994148ejg.120.2023.08.11.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:32:06 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, horms@kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 1/2] netconsole: Create a allocation helper
Date:   Fri, 11 Aug 2023 02:31:57 -0700
Message-Id: <20230811093158.1678322-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811093158.1678322-1-leitao@debian.org>
References: <20230811093158.1678322-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/net/netconsole.c | 43 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd..670b6f0a054c 100644
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
@@ -195,6 +207,7 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (*target_config == 'r') {
 		if (!nt->extended) {
 			pr_err("Netconsole configuration error. Release feature requires extended log message");
+			err = -EINVAL;
 			goto fail;
 		}
 		nt->release = true;
@@ -664,23 +677,13 @@ static const struct config_item_type netconsole_target_type = {
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

