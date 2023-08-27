Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847B8789C03
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjH0ICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjH0IBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:01:41 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670511995;
        Sun, 27 Aug 2023 01:01:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99c0cb7285fso288902666b.0;
        Sun, 27 Aug 2023 01:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693123284; x=1693728084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJQrxQq8+wggDdpWlS/QjLNuLOjuY19XSVAy4OQf8wA=;
        b=ZkA4RDEEbYyObLLbPmSx5S5uO+h2bz5nMejlI3FiHadNm7+L4FiHwK7Fjb9SSNsN+E
         JfKqSGjEIhN/eAL/BpTitY61/Fo6/8e/n9XxxWsX/J+gGz/qK7lEU0MQ1r1muaMHqWEC
         UXLF41eeAq+qeX4iWcXVHObumpwUTe/hiJrARjabaxeElPnKl3/gnsWkT4tsB2oT/+Kz
         Rm+qByqkpanDTy8E3J6EVocIZWX2cxK4sFPry7XtWyNxEgLLKOgODiPmer424iqS2+x9
         o5LuU3eSaVIXLNF7wd/0hqG132WLycj3MEIdyRrX/8o5tnq2znTzh/2iqWFMkrzQZxI4
         XS0A==
X-Gm-Message-State: AOJu0Yxf9cji7pi3sOJNKbufM73zmgNHUWMz0PIAHK5pYRXNcM6y9OYY
        4WbMdX9TPYRk/Zl6Kfq/5qw=
X-Google-Smtp-Source: AGHT+IG+ttSdqT5Jha3JUwxZYiJJlJJCtQzdNAhIwuopeTVdVpuvYmkXZgtqvBH+M3EiZ6GbdP+yXg==
X-Received: by 2002:a17:907:7714:b0:99d:fd27:b38d with SMTP id kw20-20020a170907771400b0099dfd27b38dmr16989810ejc.70.1693123283542;
        Sun, 27 Aug 2023 01:01:23 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id pg23-20020a170907205700b0098e34446464sm3181883ejb.25.2023.08.27.01.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 01:01:23 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, Lucas Tanure <tanure@linux.com>
Subject: [PATCH] Revert "tty: serial: meson: Add a earlycon for the T7 SoC"
Date:   Sun, 27 Aug 2023 09:01:13 +0100
Message-ID: <20230827080113.2790-1-tanure@linux.com>
X-Mailer: git-send-email 2.42.0
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

This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.

---
 drivers/tty/serial/meson_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index c4f61d82fb727..790d910dafa5d 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
-OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
-		    meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
 #else
-- 
2.42.0

