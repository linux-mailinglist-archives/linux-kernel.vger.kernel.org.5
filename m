Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47D7BAFB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjJFAvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjJFAvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:09 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E68E8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:06 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c644a1845cso1037978a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553466; x=1697158266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmnWnKvM60dm/oO+QIaL6SFHQ4EDYTo8nwIRSW4SLrI=;
        b=PF/idpmj+1syfPcemCEME+Oj7dUosCzZZ9H/mDEyV+Qb+Ss3P80kTGQ3DsML0PyeW4
         AjQIJR3OBT8HdwmDLxsqIPMPf5+ok5kQ7gEwPFncueKhcKWNdnb1ONL0RLARqOXH5mfe
         jq8LMUIX5ZX6kt/GxA30dMyXZ5PUxOWOjtYtGRnJou8MCnkKVT5mUroFriDygb+tft6B
         PRUu7MU6YPEg/UTSYPDzwjrYMUCCOd4FymqzM/xycF7SQfuaHWrfQKuKQfuDA7d8CDCw
         vMoLpoTFFNAgi8greS6BQxDhYUj717t9R9vcg7+OS7c+mEAaMm6PzHLeL1Qw1uKCCCnj
         xYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553466; x=1697158266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmnWnKvM60dm/oO+QIaL6SFHQ4EDYTo8nwIRSW4SLrI=;
        b=WVep0xkRKpZWmJ1snsDbB4KuzoussetV1VWU4G415v6BU9FKfvBCRAD1JEQFsnR97r
         hRV2ZYcu2niueTrU/bqGpuJ7eNmlfpICMFeAGKhbPHTwPtIJfA8Tfq8Q3y67tZQbkzdc
         iVb0Knk/SzMfAMSp9Wh5NDfZbjNMXuM8d64NGnaLWyh+MYluWbQBwcUar/PF8YTgQNFB
         y8oLpOLi5UjEOZG5xzy1kwbQw34u4bnaopzpap65/lXXzqHMRm9GA6mWDftGiFiSf+zP
         x5GaWjxMTidU8JSDYCdNjao2/4x5NmwfdPyBEjXDQnJ/nvj/vWln1sPMyipGIYBH8hCB
         rlqA==
X-Gm-Message-State: AOJu0YySnOinr+gUJhDsBCW6fb9P1ghkVSmyrnIg3/Hu+aWh/eA2Lje6
        8dUeRPZldsuaOpdkMu3/ukHC9Q==
X-Google-Smtp-Source: AGHT+IEv6WtS6qh9/yTfpep5SGFAYpPtAHL09gstutBcqD5TCzldqYdZkPKppJ2qxWVI1cuLcrDWug==
X-Received: by 2002:a05:6870:9a21:b0:1db:3031:c97c with SMTP id fo33-20020a0568709a2100b001db3031c97cmr8089382oab.26.1696553466001;
        Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:05 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/17] staging: iio: resolver: ad2s1210: do not use fault register for dummy read
Date:   Thu,  5 Oct 2023 19:50:18 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-1-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading registers on the AD2S1210 chip, we have to supply a "dummy"
address for the second SPI tx byte so that we don't accidentally write
to a register. This register will be read and the value discarded on the
next regmap read or write call.

Reading the fault register has a side-effect of clearing the faults
so we should not use this register for the dummy read.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: New patch

(this probably should have been done before "staging: iio: resolver:
ad2s1210: use regmap for config registers" but was overlooked until now)

 drivers/staging/iio/resolver/ad2s1210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 67d8af0dd7ae..8fbde9517fe9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -166,9 +166,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	st->tx[0] = reg;
 	/*
 	 * Must be valid register address here otherwise this could write data.
-	 * It doesn't matter which one.
+	 * It doesn't matter which one as long as reading doesn't have side-
+	 * effects.
 	 */
-	st->tx[1] = AD2S1210_REG_FAULT;
+	st->tx[1] = AD2S1210_REG_CONTROL;
 
 	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 	if (ret < 0)

-- 
2.42.0

