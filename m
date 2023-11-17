Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762A7EF844
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjKQUOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjKQUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:13:57 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E210D9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:53 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2ea7cca04so1480148b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252033; x=1700856833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daUtcUgvD3JlASmZskT09A6jBu8ff2l03YGGYSvkuOo=;
        b=f48DKjAEIQUdrbqTo8CyXZNyvcYeKbLZzgsbK9bp6xrsHmzxpAXHkNPhWNfRkTSaLa
         0S/L9/iwFFvnwYMTjARBSJg3tj8Nb4n9UYVr9cQ0+/A7YKRIr8xhMD34l/INVH9noRdv
         9sOMzurGwze+y4Z16rKZnoMzqdj7ZsHnFWAFZsmIJPnZM5Ysl96ymCgwGMcU+1Yo+grr
         R2BMwrIsnXk1o7hHcd4VHpErxPyU2y242szks8KOljLatQlm48qqF/67x7UV5cEjzZF/
         DOtJgqQZNeC9twILU8f8qd/LocFsJI1WtV6R6aSTts6gmTUm+Hj8/l69wZ17ldD5twCc
         xi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252033; x=1700856833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daUtcUgvD3JlASmZskT09A6jBu8ff2l03YGGYSvkuOo=;
        b=MGK3wKmilA2V0KlT1LmWTQ1vlMHefTvtlVOZ8sZ+PKOb+281CYcAEIfRzo9JTojhPa
         Ugw0xr64uTpoTyFK08L6S7uEr1l5e4TvWVXNbSyfJzfvSCtjDonqCK4V+kan5mOZm3Uw
         wxQewwfj12p52raZ94sfQ82IeSxqkIvf8rcCuhzMzvD7dNiQQREE8z0Lkd5WLM2PYEsL
         c4HWz/MQpxODtgC0JDaiHLlcewuAUBS+KKV2iysszbLjAPXwlItubDnTdzU0E4yhfUAh
         j+QO+mdt5nvIJH84z4T2clnzZ8OUE7zBxWx+Iy2RuqEpQM8wnvBTfZgTsvUT4qdpxhaH
         v5zA==
X-Gm-Message-State: AOJu0YwdDGexlus+Y8DffVwKVYUFvWNMaUsPtr+lggDpiI/j/Soxl5qG
        GiVJSxOM9MNIc5VdhnlghFe2WbtLWJOss0QbHZJeKA==
X-Google-Smtp-Source: AGHT+IGupY9tgQkSOvQ1he/qTdneFPbPBSmCn8gJ3wctSyTP/DRvtzXTw5+16bwfGWkofb9g09taVw==
X-Received: by 2002:a05:6808:1704:b0:3b6:d617:a6f7 with SMTP id bc4-20020a056808170400b003b6d617a6f7mr595509oib.3.1700252032911;
        Fri, 17 Nov 2023 12:13:52 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:52 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] MAINTAINERS: add entry for AXI SPI Engine
Date:   Fri, 17 Nov 2023 14:12:53 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-2-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXI SPI Engine driver has been in the kernel for many years but has
lacked a proper maintainers entry. This adds a new entry for the driver
and the devicetree bindings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Note: This work is being done by BayLibre on behalf of Analog Devices Inc.
This is why the maintainers are @analog.com rather than @baylibre.com.

 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..a40f61ad5843 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3415,6 +3415,16 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 F:	drivers/hwmon/axi-fan-control.c
 
+AXI SPI ENGINE
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+F:	drivers/spi/spi-axi-spi-engine.c
+
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
 L:	linux-i2c@vger.kernel.org

-- 
2.42.0

