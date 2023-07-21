Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBAE75C2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGUJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGUJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:22:10 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75FA30E1;
        Fri, 21 Jul 2023 02:22:02 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-993a37b79e2so271183866b.1;
        Fri, 21 Jul 2023 02:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931321; x=1690536121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCflDaV8zc69JhQDjjJilHCHdTvzcdDmX3C6lC+uvr4=;
        b=i3LGgn9aX67POknKwfpDma8GVzNrXq+e+pVS+oRcNH6WsOVbnleROIpZZ660qID78f
         JgjxuJBmgsB38+KIv+wba/WGoh0c6EvMZCLpMOI+giNt+EMb4EVOJ6i8F99IvJsBquTi
         PVADBkhxMetS5p9vUaaMMk7t6PYgt/CyU8iurPzxYIqNYfbMmwzwRh2sKuzjS7Umz0rb
         bnFrJ56ylmV27PIsetSWnI0gMt1sTpgUrUt3586hkHmQ3eD0fDlqwi9ZZORVQFHOPk8x
         RzKnqaqVBP0zd74FW0xUxujzd92mqfVXqtG+tnYTyl1b+4266YJ3kGAaW4/6xDUCRWUF
         85Bw==
X-Gm-Message-State: ABy/qLbHyQb91JHLoBGnjMj4h0lkSyJ5SuxFz/rhwwcQA8ljeOtmgK+6
        U9oafGhGFk2zCiReJ09YrheTo7FA8nQ=
X-Google-Smtp-Source: APBJJlFxIwuGPdeTEGimkFui9rLogtwLz/TKUG+5JEEX48ah0L+VvWgnfcd8BNE9TCp0rwEPzznwhQ==
X-Received: by 2002:a17:907:7817:b0:99b:4210:cc75 with SMTP id la23-20020a170907781700b0099b4210cc75mr1171431ejc.40.1689931320897;
        Fri, 21 Jul 2023 02:22:00 -0700 (PDT)
Received: from localhost (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id dk20-20020a170906f0d400b00992ab0262c9sm1927268ejb.147.2023.07.21.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:22:00 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     leit@meta.com, Petr Mladek <pmladek@suse.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] netconsole: Use kstrtobool() instead of kstrtoint()
Date:   Fri, 21 Jul 2023 02:21:45 -0700
Message-Id: <20230721092146.4036622-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721092146.4036622-1-leitao@debian.org>
References: <20230721092146.4036622-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kstrtoint() by kstrtobool() in the sysfs _store() functions.
This improves the user usability and simplify the code.

With this fix, it is now possible to use [YyNn] to set and unset a
feature. Old behaviour is still unchanged.

kstrtobool() is also safer and doesn't need the extra validation that
is required when converting a string to bool (end field in the struct),
which makes the code simpler.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a3c53b8c9efc..87f18aedd3bd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -333,17 +333,15 @@ static ssize_t enabled_store(struct config_item *item,
 {
 	struct netconsole_target *nt = to_target(item);
 	unsigned long flags;
-	int enabled;
+	bool enabled;
 	int err;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	err = kstrtoint(buf, 10, &enabled);
-	if (err < 0)
+	err = kstrtobool(buf, &enabled);
+	if (err)
 		goto out_unlock;
 
 	err = -EINVAL;
-	if (enabled < 0 || enabled > 1)
-		goto out_unlock;
 	if ((bool)enabled == nt->enabled) {
 		pr_info("network logging has already %s\n",
 			nt->enabled ? "started" : "stopped");
@@ -394,7 +392,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 			     size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	int release;
+	bool release;
 	int err;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -405,13 +403,9 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	err = kstrtoint(buf, 10, &release);
-	if (err < 0)
-		goto out_unlock;
-	if (release < 0 || release > 1) {
-		err = -EINVAL;
+	err = kstrtobool(buf, &release);
+	if (err)
 		goto out_unlock;
-	}
 
 	nt->release = release;
 
@@ -426,7 +420,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	int extended;
+	bool extended;
 	int err;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -437,13 +431,9 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	err = kstrtoint(buf, 10, &extended);
-	if (err < 0)
-		goto out_unlock;
-	if (extended < 0 || extended > 1) {
-		err = -EINVAL;
+	err = kstrtobool(buf, &extended);
+	if (err)
 		goto out_unlock;
-	}
 
 	nt->extended = extended;
 
-- 
2.34.1

