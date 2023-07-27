Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE17658C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjG0Qdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjG0Qd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:33:28 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD33AA0;
        Thu, 27 Jul 2023 09:33:05 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9936b3d0286so165514266b.0;
        Thu, 27 Jul 2023 09:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475529; x=1691080329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/aRoyEazn3Itn/bXVKqj2WVGGM2OHRTsPi8YyB+qW4=;
        b=k69pknkyvXUAdeOkGC6bcPEhcUJN9SeUpU5pEXxBd3maLCJYnKTw9d5bvatE2D0urM
         OEht26tntgSJ6E+jZfdl0WPPIyT4IUglLttVlhTTh8YDS6PXOvsOOZLBJRTCVncayAlg
         XGKbgiP8Ul8VCQu3lArYAUqspuuhLEKMtJhHtuxwBleWapEuK0xe/3+fenZPS2zSEX0B
         sTvYgS/+Ur7XeuCYtUQ5YD2R/k/Gaj5w5/2sq6SoGtHIoFpBJRdsWr+EvIWC+c9ySb+V
         8xAsfFG9QJyowPTD48UaChMltBMSHSC7ko2iFqW9JLBjLEWzmei0jlUQGhnRPy0NwNVK
         xKWg==
X-Gm-Message-State: ABy/qLZSdWVDHTMcKEt0yJIUkgq5+s4D+/ORABeFSO55iOq6idQ/WcNd
        fRyRPcXGQVx7wvHp55y41DA=
X-Google-Smtp-Source: APBJJlGpVQnFvIQ4Ue5XjUtirJDJmv1i+dFBveJugC7yNw27nS90TDpJr8QToxE8ZHqrDyoQ3HX8rg==
X-Received: by 2002:a17:906:1046:b0:98d:fc51:b3dd with SMTP id j6-20020a170906104600b0098dfc51b3ddmr2334005ejj.41.1690475529423;
        Thu, 27 Jul 2023 09:32:09 -0700 (PDT)
Received: from localhost (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ga15-20020a170906b84f00b00992d0de8762sm945445ejb.216.2023.07.27.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:32:09 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     leit@meta.com,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] netconsole: Enable compile time configuration
Date:   Thu, 27 Jul 2023 09:31:32 -0700
Message-Id: <20230727163132.745099-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable netconsole features to be set at compilation time. Create two
Kconfig options that allow users to set extended logs and release
prepending features enabled at compilation time.

Right now, the user needs to pass command line parameters to netconsole,
such as "+"/"r" to enable extended logs and version prepending features.

With these two options, the user could set the default values for the
features at compile time, and don't need to pass it in the command line
to get them enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..4d0c3c532e72 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,26 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.

+config NETCONSOLE_EXTENDED_LOG
+	bool "Enable kernel extended message"
+	depends on NETCONSOLE
+	default n
+	help
+	  Enable extended log support for netconsole. Log messages are
+	  transmitted with extended metadata header in the following format
+	  which is the same as /dev/kmsg.
+	  See <file:Documentation/networking/netconsole.rst> for details.
+
+config NETCONSOLE_APPEND_RELEASE
+	bool "Enable kernel release version in the message"
+	depends on NETCONSOLE_EXTENDED_LOG
+	default n
+	help
+	  Enable kernel release to be prepended to each netcons message. The
+	  kernel version is prepended to the first message, so, the peer knows what
+	  kernel version is send the messages.
+	  See <file:Documentation/networking/netconsole.rst> for details.
+
 config NETPOLL
 	def_bool NETCONSOLE

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd..3a74f8c9cfdb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (!nt)
 		goto fail;

+	if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
+		nt->extended = true;
+	if (IS_ENABLED(CONFIG_NETCONSOLE_APPEND_RELEASE))
+		nt->extended = true;
+
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->np.local_port = 6665;
---
 drivers/net/Kconfig      | 20 ++++++++++++++++++++
 drivers/net/netconsole.c |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..4d0c3c532e72 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,26 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.
 
+config NETCONSOLE_EXTENDED_LOG
+	bool "Enable kernel extended message"
+	depends on NETCONSOLE
+	default n
+	help
+	  Enable extended log support for netconsole. Log messages are
+	  transmitted with extended metadata header in the following format
+	  which is the same as /dev/kmsg.
+	  See <file:Documentation/networking/netconsole.rst> for details.
+
+config NETCONSOLE_APPEND_RELEASE
+	bool "Enable kernel release version in the message"
+	depends on NETCONSOLE_EXTENDED_LOG
+	default n
+	help
+	  Enable kernel release to be prepended to each netcons message. The
+	  kernel version is prepended to the first message, so, the peer knows what
+	  kernel version is send the messages.
+	  See <file:Documentation/networking/netconsole.rst> for details.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd..c84bcf97d4e4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (!nt)
 		goto fail;
 
+	if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
+		nt->extended = true;
+	if (IS_ENABLED(CONFIG_NETCONSOLE_APPEND_RELEASE))
+		nt->release = true;
+
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->np.local_port = 6665;
-- 
2.34.1

