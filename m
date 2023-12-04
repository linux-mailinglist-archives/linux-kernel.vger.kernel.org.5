Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA01803BC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjLDRff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjLDRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:10 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DA102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:17 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d87cf8a297so794790a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711316; x=1702316116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXeaz0oJETMI/MHvKzRwvujLRc0Q8q0D/J+Fpu3YNWU=;
        b=PZiPpMirR3Gl9heMvlIQieYCy8omL3SrUQrCIXXVPvaNxu+42Fgr18EInypPDF7pap
         ETWVE6h62+yDSFr2/kKoMFlrXDflNTSYun3pBy/IPY1n437caTImiQHixSGUcAegNy1J
         qOMc5Y6pCZbiEFC0jBpHD6vswNzh7T4Mw+ycKo+uK3NAuOw8dFdRSbZ78EWBgpILSDB3
         lsItHaS1VlyHbfHQY8f39/j/9J5bwX2g4kqZQDKK3Z4qaJcfrXKj18ni6l+h4r0iE944
         lSXFNUW5YXBUFvDkieUSpPGA+VDz9kDTE7YOO09R8rWbxtwXY6fI8leqI+WEyGx2kt8R
         xhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711316; x=1702316116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXeaz0oJETMI/MHvKzRwvujLRc0Q8q0D/J+Fpu3YNWU=;
        b=GCDHSvXVoceKMq9TGyFyxC3isauxaN9L5QxNd1733tUHHor8cJ4UqB61TvT+bB0tAm
         IsAAXbxxvzkYTs+e36UIqD6x1Y97KKj0Rat6BZpzN33OEFVH0Gz+zb4IJB/erW+k2VQm
         Too8bDiNOl6xADP50bn9UJ1zhgZsjSrjOff/eWjpmsYCr5RR1B93it+q7vBjx79lutvR
         l2D8GQbZJRm3Y0Xb+A6z45VeeMWTw3BWQWPz8NqzpppcQZ3ZLr+qVQFMkBOgUee7ELx0
         kxu3jGUKaa4V9S8KXB5FN6NPEwhZS+h4ROQgt3f3UZfapkIwiJJ9GT1ioLG8l2V/b4Qm
         PpFQ==
X-Gm-Message-State: AOJu0YwnhThKCh4JqQVlZqcwkMmMnvCmDeq7RYQGSxq3mlWfAX6DUQkb
        gWn1Z3LwpkhTJ/KbLSE1F18hi1v317qJBmwUbGs=
X-Google-Smtp-Source: AGHT+IEbHY8B3HhnvuqLpnt7QMdgLQokFYwpaYG6qQiY3g06vhxSnhXGbt+H28bPcfWacemrIuX9Hw==
X-Received: by 2002:a05:6830:660a:b0:6d8:74e2:94f3 with SMTP id cp10-20020a056830660a00b006d874e294f3mr2897548otb.57.1701711316259;
        Mon, 04 Dec 2023 09:35:16 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:15 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] spi: axi-spi-engine: implement xfer->cs_change_delay
Date:   Mon,  4 Dec 2023 11:33:32 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-6-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds handling of xfer->cs_change_delay to the AXI SPI Engine
driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 84ec37732d8b..3437829ef8b1 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -265,6 +265,10 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 				if (!xfer->cs_off)
 					spi_engine_gen_cs(p, dry, spi, false);
 
+				spi_engine_gen_sleep(p, dry, spi_delay_to_ns(
+					&xfer->cs_change_delay, xfer),
+					xfer->effective_speed_hz);
+
 				if (!list_next_entry(xfer, transfer_list)->cs_off)
 					spi_engine_gen_cs(p, dry, spi, true);
 			}

-- 
2.43.0

