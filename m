Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346AF7C7249
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379492AbjJLQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjJLQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:18:41 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E2ADA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:18:38 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57be3d8e738so666609eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697127518; x=1697732318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoG577lFLPj6Stm65rhB03R9CTrwAM1hWYfR3bj9yuY=;
        b=S7JMUEfHV+urguW5IMI1djDo6j0vNkxomhInLa/pPu0kCmrkSGlziFc1xBXmANZigy
         F6hfA9k/Ya8Zkfk+98M5RbGXyYEU19RrDPjDOMJ5+N6uLohgQ7XSSEeUsECknmBlIhsp
         dogQI+jw2X4B7g7qXk+Ssgx+cwzUVp7WMN6ez+KvCzS25HOgTb4LTQmpx9Q/gCgd4l6O
         WVekUB7VWFmCFuUlbOd3OEu3Jf+NYzXmsFvX1tynwy0lXp9XCD3rCSUmzujmIiUpuYQ1
         bWAffpk9e3Os7jsYhyytUe/hkwSQfKvtSiFoX6OJyFh1YY7QZDNMxExJpROFNavRfyWm
         89WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127518; x=1697732318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoG577lFLPj6Stm65rhB03R9CTrwAM1hWYfR3bj9yuY=;
        b=fwxW4TXupD3ab2JxhoIXkR5OwwzYM1VagVKQ3V8YFNPSr8CxJyAIg+U4jg50QlXXVF
         +uvFAjl584Ji0a7YCBxBX8KZhyC6uP2WCYlinFXo3Il3gGFe2nrPq+qMtG5vMQ0Cl7Iu
         yJeaK10bx7pALIrhZT7aHkf5PCQa1bmY447crqhvWgadeExsHwbqCnR8m86iWvAT1QVH
         8ngq+ngBqUtXhvXRaMCs7KjOcsfSxWW2ltaIbSX4RRC2N+ZDWGunPBjypVmgM8xdG4d9
         +2YxmbdhzE/fPseN29dozeljQA5iCtwWqfB7Jez/B5cRRkjALaTPa33WPJ3/oJ+OQcIr
         EQTQ==
X-Gm-Message-State: AOJu0YzG0w1uDzySK+gtv8V94iExyBZkT7s6dBYVXDNSwcwNKvzlqe4c
        IGLqPb9h1CZgxlCsyfPzl+SbZrWhHOOskgbK/2MwjQ==
X-Google-Smtp-Source: AGHT+IFOc92yFX+49qJQbv7QqD7hfYf7CLzNLnI0ftn8sWYTPcgnhfmGlDjl0b3DkerrWH+hlZUUBg==
X-Received: by 2002:a05:6870:1814:b0:1da:ed10:bcb with SMTP id t20-20020a056870181400b001daed100bcbmr26357001oaf.31.1697127517984;
        Thu, 12 Oct 2023 09:18:37 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ob16-20020a056871761000b001dd63f65870sm414529oac.28.2023.10.12.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:18:37 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: resolver: ad2s1210: remove DRV_NAME macro
Date:   Thu, 12 Oct 2023 11:18:12 -0500
Message-ID: <20231012-ad2s1210-mainline-v1-1-b2ee31c0e9dd@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
References: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
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

The DRV_NAME macro is only used in one place in the ad2s1210 driver and
is not really needed so let's remove it.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index bd4a90c222b5..00562bc542bb 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -68,8 +68,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define DRV_NAME "ad2s1210"
-
 /* control register flags */
 #define AD2S1210_ADDRESS_DATA		BIT(7)
 #define AD2S1210_PHASE_LOCK_RANGE_44	BIT(5)
@@ -1509,7 +1507,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "ad2s1210",
 		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,

-- 
2.42.0

