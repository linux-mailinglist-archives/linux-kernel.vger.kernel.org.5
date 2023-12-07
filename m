Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082C808DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjLGQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjLGQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:31:36 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433B10EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:31:43 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b86f3cdca0so714800b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966702; x=1702571502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SijZPBQdcqX6+jrUbAZKponmxKm7GHQ4E8iU54Dxwwg=;
        b=raH/+HojbOXh9ikFWgph9Qwj+K0s5GJ86OV9cQBKRF8HAU7IoqVmyg2mGph1eOLoL5
         fqQWDWM8IWLxrBp+VAOS4OMAXvHaxhNcewT4juoQm3VjfqmxEB/G9p5MBZBKzWeTicaP
         UhCyoOa66Hg7yGIeRaDRa2OuXVmXXee7ndCP7FrpdtClJvirl+nYwz3VA68CTeJ4E6TZ
         /XYCmrKYTprNI38TrNURi/yiN5Zuf9yfzlEPLQMcypnhP/XN6s6s4VcJUSjE+2SHZbl3
         7Ktfq5Mx+qNuaEhHBPB0Vf4QXPByKyH9Bh5ZHxlDygqDH/1190ggY+qYAXZlzXHLV728
         kwhg==
X-Gm-Message-State: AOJu0YxNsdwXxmmOAALtU+dEB7B3gRtUAJLx3xdUhwOJk2rPzTKhZERi
        0IcNiW6vWlchRMG82XKbFdzvohlPmw==
X-Google-Smtp-Source: AGHT+IEroZ/mtak0DS9oDnV9t19jA6wn8h8OKpxKiyS64yWr8ZB7rWsQj0pMWME2vOJbH8uSDzkifQ==
X-Received: by 2002:a05:6808:1206:b0:3b8:b063:825b with SMTP id a6-20020a056808120600b003b8b063825bmr3179380oil.93.1701966702251;
        Thu, 07 Dec 2023 08:31:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a0568080f0600b003b9d00ce109sm10806oiw.34.2023.12.07.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:31:41 -0800 (PST)
Received: (nullmailer pid 2710450 invoked by uid 1000);
        Thu, 07 Dec 2023 16:31:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cdx: Enable COMPILE_TEST
Date:   Thu,  7 Dec 2023 10:31:26 -0600
Message-ID: <20231207163128.2707993-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason CDX needs to depend on ARM64 other than limiting
visibility. So let's also enable building with COMPILE_TEST.

The CONFIG_OF dependency is redundant as ARM64 always enables it and all
the DT functions have empty stubs.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/cdx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
index a08958485e31..7cdb7c414453 100644
--- a/drivers/cdx/Kconfig
+++ b/drivers/cdx/Kconfig
@@ -7,7 +7,7 @@
 
 config CDX_BUS
 	bool "CDX Bus driver"
-	depends on OF && ARM64
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
 	  exposes Fabric devices which uses composable DMA IP to the
-- 
2.42.0

