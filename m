Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F376905E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGaIik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGaIiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:38:02 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A8171A;
        Mon, 31 Jul 2023 01:35:54 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99bdd262bb0so616459566b.3;
        Mon, 31 Jul 2023 01:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690792552; x=1691397352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PJHPNha1r6lB/KR755CQAVgQFdlXySMn0XXOuyb/Ww=;
        b=atXavI1gfSyWdrhE9jDdsi9aDkMMaTHlA4O894Y2oynYHDWuQ7xuTNjriJU3eHjf3S
         JAqk5V/CzJs8saEpvygQu9HinENKvaRUu1Kl3InPeBfvo1anPsIFeAwVn4cjz5V1YjHO
         LVRG1f91azjE1EGVhoLrW299ukjnhA63ICxesG2wERR+AEGKDnfqgqCV/uODQMuIDwSF
         V6U4x2kVFVQqtNmddsXY1QCWVXlkUxfBl4RNhp6rOKqQ1OqSRFNxJvmf+uszUMNGLWvJ
         l2xglF6Nq9IlHWYOlJ0aILn+t/cCGbOy6lY3NHhaSL+lgXY4FCnIEnulF0WERM0HLDS0
         bg7g==
X-Gm-Message-State: ABy/qLaNBSVJj8ymYesIN6nOholmNFhReWxA//lp+cn0xd2rhhApZClI
        uIe257B3Cfn3ywzBgr2eIKM=
X-Google-Smtp-Source: APBJJlGCHHaP5fxhgRuMAllkyVYegPKimV2TwltZHLVKnH3V2OjHBUNgOVRnsiauiXbV7OFKqeJusA==
X-Received: by 2002:a17:906:32d2:b0:99b:4378:a5ab with SMTP id k18-20020a17090632d200b0099b4378a5abmr5996886ejk.74.1690792552300;
        Mon, 31 Jul 2023 01:35:52 -0700 (PDT)
Received: from localhost (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id lu44-20020a170906faec00b00992f309cfe8sm5859043ejb.178.2023.07.31.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:35:51 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     leit@meta.com,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] netconsole: Enable compile time configuration
Date:   Mon, 31 Jul 2023 01:35:41 -0700
Message-Id: <20230731083542.3665886-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
  v1 -> v2:
	* Improvements in the Kconfig help section.
---
 drivers/net/Kconfig      | 22 ++++++++++++++++++++++
 drivers/net/netconsole.c |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..2c7b4b634a8f 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.
 
+config NETCONSOLE_EXTENDED_LOG
+	bool "Set kernel extended message as default"
+	depends on NETCONSOLE
+	default n
+	help
+	  Set extended log support for netconsole message. If this option is
+	  set, log messages are transmitted with extended metadata header in a
+	  format similar to /dev/kmsg.  See
+	  <file:Documentation/networking/netconsole.rst> for details.
+
+config NETCONSOLE_PREPEND_RELEASE
+	bool "Prepend kernel release version in the message"
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
index 87f18aedd3bd..8cadbcd699ae 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 	if (!nt)
 		goto fail;
 
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

