Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E77BDAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346649AbjJIMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbjJIMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:12:24 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E4D6C;
        Mon,  9 Oct 2023 05:11:56 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-405524e6769so26546165e9.1;
        Mon, 09 Oct 2023 05:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696853515; x=1697458315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqMkCHIJg0J3KfyKm+ow+U1NVWJ1Dko3B1vIyVCrYS8=;
        b=TWdjvMeVlqWKkbqxm2/PHkg1L/C7evYh5Wf5NuBvPdpmi0Y8JVcqCIJ46J/9jvso3B
         +vaYYlcs2y/FPoWbAqaioLk9fay9qisVSFMcDa4ZXohJnrQlSEZCdTdAGdQ9MayEsEIx
         X691rfbUa1zBARKzrZylSy9T8f/WWtHfMEdGJG2szczlwVUrlS9/ZTpeGtDtS7FZhrNN
         TlHn3jSBM+bEaFTldc8CFD0wUmLQmLPScwJjUeYT0n/LPEM/eNtVTNB5FM3YsbvPeFmT
         cqyj5l9Q5p0mvV0HAN/JdaoDDu8ovYIb5qeaB0606PcMc4ywzYPPP6PIDAZsu41sRNQx
         KAWg==
X-Gm-Message-State: AOJu0YxfZBbN98vPnc1oPclq4FLy/ChQBW/2IHE8p1HH/IBm2qaCIXCu
        Rl5QzQUYkKU7xkynYnKQOa0=
X-Google-Smtp-Source: AGHT+IEhtAtDaeK55NICa8MKuOXjnXZ6tmxOZYYdrOr4f2t7yKAr2Ky48cjoWtiT1sZKpLGG7j8S2w==
X-Received: by 2002:a05:600c:224d:b0:406:80b4:efd5 with SMTP id a13-20020a05600c224d00b0040680b4efd5mr10651820wmm.14.1696853514542;
        Mon, 09 Oct 2023 05:11:54 -0700 (PDT)
Received: from localhost.localdomain (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id l11-20020a1ced0b000000b004051f8d6207sm11067123wmh.6.2023.10.09.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 05:11:54 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, Lucas Tanure <tanure@linux.com>
Subject: [PATCH v2] tty: serial: meson: Add a earlycon for the S4 SoC
Date:   Mon,  9 Oct 2023 13:11:51 +0100
Message-ID: <20231009121151.4509-1-tanure@linux.com>
X-Mailer: git-send-email 2.42.0
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

The new Amlogic S4 SoC does not have a always-on uart, so add
OF_EARLYCON_DECLARE for it.
Amlogic T7 will use this as fallback.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/tty/serial/meson_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 45cc23e9e399..de298bf75d9b 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -646,8 +646,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 	return 0;
 }
 
-OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
-		    meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart", meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,meson-s4-uart", meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
 #else
-- 
2.42.0

