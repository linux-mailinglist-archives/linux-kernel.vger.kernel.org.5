Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7477B333
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjHNICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHNIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:01:50 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF40AD;
        Mon, 14 Aug 2023 01:01:49 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8396109a12.0;
        Mon, 14 Aug 2023 01:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000108; x=1692604908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMTTRR25R89hKbOO/W0HzP5By9l6RSmOyGZbfso3dPE=;
        b=HtxnY/lxXgtSB9h7YKP1g192eRQb7iZZCTGCO6tkAVktX5dGjqVo1x/dQ+oKv1WWeC
         Ct9crY+jdyNfOLQIlOV/kOEcv/Py9is6hmyMyY7WZBYKPFLUsQmXqxdk7kcc/o647X5/
         GmmJJGJDIuxYVGLRVH0lq3Ka8fnsKWG9ZZUEiYTwig1Z90HOcV1OMajHH5G81uHIF9rr
         qmKVdqfP/T1ehoFXORkRd6OHPKoik+eExcWYpSPiqEKQcP2JNhNmtitA0Z3xMdQYRhzn
         4kpiuHWYKn/hOte4uaH7LiL7TI1LowqqHQWLt5pyay6+3N23Ku21pbx2e0oczofwQcyd
         96nQ==
X-Gm-Message-State: AOJu0YxUgyDF46586d4GJypp7bfj0iSEWdTWaECRV8E8j+9fGZLlO7HR
        U8KWXBSjuFqw9WNTGYUE9lE=
X-Google-Smtp-Source: AGHT+IG9fmf+oLcXRU5lXPTS7InX83yaVfnPLLxfI8jNNzmLI02HPG3m3YGJqjVm0m5XaHVFv0q0lA==
X-Received: by 2002:a05:6402:40cf:b0:51e:5898:a23d with SMTP id z15-20020a05640240cf00b0051e5898a23dmr12673976edb.5.1692000107737;
        Mon, 14 Aug 2023 01:01:47 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0052568bf9411sm678074edx.68.2023.08.14.01.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:01:47 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v9 2/2] tty: serial: meson: Add a earlycon for the T7 SoC
Date:   Mon, 14 Aug 2023 09:01:28 +0100
Message-ID: <20230814080128.143613-2-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814080128.143613-1-tanure@linux.com>
References: <20230814080128.143613-1-tanure@linux.com>
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

The new Amlogic T7 SoC does not have a always-on uart,
so add OF_EARLYCON_DECLARE for it.

Signed-off-by: Lucas Tanure <tanure@linux.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Since v8:
 - Fix issues with git send-mail command line
Since v7:
 - Send to the correct maintainers

 drivers/tty/serial/meson_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 790d910dafa5..c4f61d82fb72 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -648,6 +648,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
+		    meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
 #else
-- 
2.41.0

