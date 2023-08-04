Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2377007D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHDMsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHDMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:48:16 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45D49D7;
        Fri,  4 Aug 2023 05:47:45 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c47ef365cso291703966b.0;
        Fri, 04 Aug 2023 05:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153218; x=1691758018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUQ/knP8/2GU6zZ5tytoEvJZM7rDWAU10mSJguO+jbI=;
        b=aDdztUPEOeEj1lPoeGxF/Fnf38giTmEB9C2eaR4+JshnmvD0dp8cTjy1u/TAicy6JH
         gDsBnAi7Q3t+LjU0UU528elIGWHzqAaeMJecrFXKUX26FsDrDN0CHOG8TYJibobGNnBw
         1zvtSvgD4ZyKa0MHIAYg4LIhgFXWDFug48AVPnqdleQkEwXVhbxj5oMlDcrTesdq/auM
         Y+4oYPSCjYyBGM5fFn2C3EqkAtAbimOM1m2Rcb9gXZUBnj1iFOETN5m/U6mLb7HXhyUL
         x2RTWtbsPwPG3a6BI8ykaGaJmS45O7xRHiBxrppmirkWoVT6ZPhRuwrUgqHaZFHKKelm
         tYiA==
X-Gm-Message-State: AOJu0YyTL2ggRWXMAMSVFfRa5gyr6A4ukGHxE3OM0TAXHAxaYcfuguYp
        mebFWdCe4WErUCQIss+PDIE=
X-Google-Smtp-Source: AGHT+IGRIK2D/x8GwlU5SOfQVpScfmfUJzuPIK8IM52MP3H4X8vlPWkXNOI3UPRHT/FqED9W4UBSNQ==
X-Received: by 2002:a17:906:d6:b0:99b:ed8f:551d with SMTP id 22-20020a17090600d600b0099bed8f551dmr1540953eji.55.1691153217530;
        Fri, 04 Aug 2023 05:46:57 -0700 (PDT)
Received: from localhost (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b0099bd1a78ef5sm1267308ejq.74.2023.08.04.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:46:57 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 2/2] netconsole: Enable compile time configuration
Date:   Fri,  4 Aug 2023 05:43:21 -0700
Message-Id: <20230804124322.113506-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804124322.113506-1-leitao@debian.org>
References: <20230804124322.113506-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable netconsole features to be set at compilation time. Create two
Kconfig options that allow users to set extended logs and release
prepending features at compilation time.

Right now, the user needs to pass command line parameters to netconsole,
such as "+"/"r" to enable extended logs and version prepending features.

With these two options, the user could set the default values for the
features at compile time, and don't need to pass it in the command line
to get them enabled, simplifying the command line.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/Kconfig      | 22 ++++++++++++++++++++++
 drivers/net/netconsole.c |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..55fb9509bcae 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.
 
+config NETCONSOLE_EXTENDED_LOG
+	bool "Set kernel extended message by default"
+	depends on NETCONSOLE
+	default n
+	help
+	  Set extended log support for netconsole message. If this option is
+	  set, log messages are transmitted with extended metadata header in a
+	  format similar to /dev/kmsg.  See
+	  <file:Documentation/networking/netconsole.rst> for details.
+
+config NETCONSOLE_PREPEND_RELEASE
+	bool "Prepend kernel release version in the message by default"
+	depends on NETCONSOLE_EXTENDED_LOG
+	default n
+	help
+	  Set kernel release to be prepended to each netconsole message by
+	  default. If this option is set, the kernel release is prepended into
+	  the first field of every netconsole message, so, the netconsole
+	  server/peer can easily identify what kernel release is logging each
+	  message.  See <file:Documentation/networking/netconsole.rst> for
+	  details.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a7df782530cf..c9408bd04e4c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -177,6 +177,11 @@ static struct netconsole_target *alloc_and_init(void)
 	if (!nt)
 		return nt;
 
+	if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
+		nt->extended = true;
+	if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
+		nt->release = true;
+
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->np.local_port = 6665;
-- 
2.34.1

