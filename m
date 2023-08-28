Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95A78AFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjH1MLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjH1MLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:11:00 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E6D8;
        Mon, 28 Aug 2023 05:10:57 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c136ee106so401781466b.1;
        Mon, 28 Aug 2023 05:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224656; x=1693829456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRKpAHPZEPVk+Fg369igBwYVlHrrvSUCvtuNi+MYNXo=;
        b=HXIAcbpFkaqUUPPCC+O2Ecy/xHmAoYiqKPu/ThiN2SHLCWwVpDBlB+IWKxjcV3K7Sw
         IZXLngJcmrfkR/7i2jU391ked2t9AxrMm41YuCeJY5SHGzTjdSzJSU+F/QNfNglvDo7w
         tjlZnmIvRVmLARGmVPk1hJh7sQY9vGvrP4HDY3o9MzuXnpuhw2Sib+Akt22RAR6fHtlb
         Myv2pNRTQEXdCwBFrCmq9YiKMRf0K+oEIgT3JBBn1bqAhMvQCvcdIniux6B0WMDMBg+K
         R8MAS97av9MgDmB6sWBOc9Gdjz4F3/p/utyqi8oe0ABSm0jeQR4Y/4oX1FgFj5lsOW1J
         9ovQ==
X-Gm-Message-State: AOJu0YzBIWXBmU0xIyEZgx2ZMfBN4uH2V0TymDZ3dp3bQvKb1TNmNvXk
        bcMbWqcySzBLwbGKtogcr5s=
X-Google-Smtp-Source: AGHT+IHh+jPAccLUybH0bG/hIhhcuZ570OrmJ9A7mqLj9tE8GeUWkUzWVRIvU1zeaQzCA2PXS+/2oA==
X-Received: by 2002:a17:907:6087:b0:9a2:96d2:b1e8 with SMTP id ht7-20020a170907608700b009a296d2b1e8mr7132102ejc.54.1693224655865;
        Mon, 28 Aug 2023 05:10:55 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b00992ea405a79sm4567898ejd.166.2023.08.28.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:10:55 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, Lucas Tanure <tanure@linux.com>
Subject: [PATCH] tty: serial: meson: Add a earlycon for the S4 SoC
Date:   Mon, 28 Aug 2023 13:10:53 +0100
Message-ID: <20230828121053.60838-1-tanure@linux.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Amlogic S4 SoC does not have a always-on uart, so add
OF_EARLYCON_DECLARE for it.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/tty/serial/meson_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 790d910dafa5..8dfaa260e545 100644
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

