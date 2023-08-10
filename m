Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC27774FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjHJJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjHJJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:55:20 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED58E7F;
        Thu, 10 Aug 2023 02:55:19 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so10751981fa.2;
        Thu, 10 Aug 2023 02:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661318; x=1692266118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gffuZaa/ihRTSH1k1c/YUIAF3UhoRHwdFaPoPVPmbmw=;
        b=MXOmMHnLeWSA7FBPF9Mr1z5TCgbyMHvskShhvXmIkEaaWQK3rNJxDtlk+a2yo1W5Bg
         pS/b+hg0qJpIYkeJXM31nF9ICMcxav95RFgfp9HqhLZPrHS03E1r+UBM9qe9AHbR1H7n
         Yu0nk+prG4WzFCYBSTuiT4zrNSgFk1hzs54JwGicbBaiJr0jQMsDrLjFJdMAE0JLTOx5
         eslnMxAAaQsrmvAwDIb/fDlq15fAfvc+JCG8hlFsYnxVJVgegzl1DzTP1NalylA9HD/H
         K9cJQWIco/WhRq5xLRMly01lQM+/LE3ccHk/QcAsylRZrbt6zG8TmhP18lCV9j4iSJCr
         ywjA==
X-Gm-Message-State: AOJu0YxyZEJzjItyLuean85kBwnEFbYL1FaRQCxR8/fijgkK8fAcYvhG
        TXaeDw6HhUacAzrXDvbfgVNAD2yOx3o=
X-Google-Smtp-Source: AGHT+IF2qOMXARfDGKxIaYy0XzYbezH3oX9rJ+sMYHNNYmiKGfx4YJAsSyljW4IGXhFueEhr3HTu/Q==
X-Received: by 2002:a2e:800c:0:b0:2b8:3a1e:eec9 with SMTP id j12-20020a2e800c000000b002b83a1eeec9mr1318765ljg.36.1691661317712;
        Thu, 10 Aug 2023 02:55:17 -0700 (PDT)
Received: from localhost (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id vr2-20020a170906bfe200b00988b8ff849csm687300ejb.108.2023.08.10.02.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:55:17 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 2/2] netconsole: Enable compile time configuration
Date:   Thu, 10 Aug 2023 02:54:51 -0700
Message-Id: <20230810095452.3171106-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095452.3171106-1-leitao@debian.org>
References: <20230810095452.3171106-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index f93b98d64a3c..1dc56d6b1c15 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -178,6 +178,11 @@ static struct netconsole_target *alloc_and_init(void)
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

