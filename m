Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5822F75C2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGUJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjGUJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:22:02 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F8C30D7;
        Fri, 21 Jul 2023 02:22:00 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-992ca792065so267324766b.2;
        Fri, 21 Jul 2023 02:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931319; x=1690536119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nffHfmIGWBNnYrHHaoebYbm1P0ZPQ4FxstxDXTgR2ek=;
        b=X9meTX17x8yJaG8IIV6000QQx46DxXf+I1hyIOGxeZ1d9d5pPUHoMwL9OZG8LS8dJj
         jB/nbe8eyISiwTKxhLNWK2sP/G4FeC3ClWhedhEktMa6i8doKr9Dx0gwwAwNEStDosOz
         q4SPXbNwwo9rMja8r+NnTYUfhC0OSwH8rh4o1hBdj+VVICSZuzaAQ3e64tLexIUDFmFq
         1Ukq88zvQGPlM4C6cO/8HDCCOuQkSyvdn4cb2lsXcTiDDK4ZpyId46S+8mX39wsV8r/Y
         g9gwjGMrxAG4u2BubrY9kxsF4ehDdg5zfpIcukhmMzGQ/riJLqywLbIOTixcSd00s0hj
         4S5g==
X-Gm-Message-State: ABy/qLYmDmXykGwK+eRN5wyZbfzhAyYyvFQlRZ7m2NiKN2flKBGQr/Gw
        AANXzHjLzVFBgTAtRSZJTVo=
X-Google-Smtp-Source: APBJJlGt2mx4nWNVpjQ9AqMDLzHuc19dTEUMtuNzhdBXWfS5s23tLFFQpbWcgc0XBGWs5Hc2Mtk9dA==
X-Received: by 2002:a17:906:51c2:b0:99b:5cce:9746 with SMTP id v2-20020a17090651c200b0099b5cce9746mr1221087ejk.52.1689931318643;
        Fri, 21 Jul 2023 02:21:58 -0700 (PDT)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906254100b00992076f4a01sm1885080ejb.190.2023.07.21.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:21:58 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     leit@meta.com, Petr Mladek <pmladek@suse.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] netconsole: Use sysfs_emit() instead of snprintf()
Date:   Fri, 21 Jul 2023 02:21:44 -0700
Message-Id: <20230721092146.4036622-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the sysfs.rst documentation, _show() functions should only
use sysfs_emit() instead of snprintf().

Since snprintf() shouldn't be used in the sysfs _show() path, replace it
by sysfs_emit().

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 31cbe02eda49..a3c53b8c9efc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -260,32 +260,32 @@ static struct netconsole_target *to_target(struct config_item *item)
 
 static ssize_t enabled_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->enabled);
+	return sysfs_emit(buf, "%d\n", to_target(item)->enabled);
 }
 
 static ssize_t extended_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->extended);
+	return sysfs_emit(buf, "%d\n", to_target(item)->extended);
 }
 
 static ssize_t release_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->release);
+	return sysfs_emit(buf, "%d\n", to_target(item)->release);
 }
 
 static ssize_t dev_name_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", to_target(item)->np.dev_name);
+	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
 }
 
 static ssize_t local_port_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->np.local_port);
+	return sysfs_emit(buf, "%d\n", to_target(item)->np.local_port);
 }
 
 static ssize_t remote_port_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->np.remote_port);
+	return sysfs_emit(buf, "%d\n", to_target(item)->np.remote_port);
 }
 
 static ssize_t local_ip_show(struct config_item *item, char *buf)
@@ -293,9 +293,9 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 	struct netconsole_target *nt = to_target(item);
 
 	if (nt->np.ipv6)
-		return snprintf(buf, PAGE_SIZE, "%pI6c\n", &nt->np.local_ip.in6);
+		return sysfs_emit(buf, "%pI6c\n", &nt->np.local_ip.in6);
 	else
-		return snprintf(buf, PAGE_SIZE, "%pI4\n", &nt->np.local_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->np.local_ip);
 }
 
 static ssize_t remote_ip_show(struct config_item *item, char *buf)
@@ -303,9 +303,9 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 	struct netconsole_target *nt = to_target(item);
 
 	if (nt->np.ipv6)
-		return snprintf(buf, PAGE_SIZE, "%pI6c\n", &nt->np.remote_ip.in6);
+		return sysfs_emit(buf, "%pI6c\n", &nt->np.remote_ip.in6);
 	else
-		return snprintf(buf, PAGE_SIZE, "%pI4\n", &nt->np.remote_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->np.remote_ip);
 }
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
@@ -313,12 +313,12 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 	struct net_device *dev = to_target(item)->np.dev;
 	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
-	return snprintf(buf, PAGE_SIZE, "%pM\n", dev ? dev->dev_addr : bcast);
+	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
 }
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%pM\n", to_target(item)->np.remote_mac);
+	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
 }
 
 /*
-- 
2.34.1

