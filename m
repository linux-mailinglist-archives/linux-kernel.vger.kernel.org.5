Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36B7C802B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJMI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMI0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:26:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B9A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692ada71d79so1539548b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697185604; x=1697790404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZXQ64zI4dZ66y0C+/+YXtcZqO4ReFctnoAjwEvrK3I=;
        b=OQUGnB+z8uYYaG+lJrY9i0lsBrldlYxKneukjmcc8Xyk3HCB3L3LnYGCxakUACI0Td
         MGFq0ZpWicRB1GN4uOWc5tQF71jADLnfYTg+lztztlXqbAbrqAV1+2j+PlhvLOWeQsoB
         zbddDrxFO+TUnZInVQ+poSz6lLGR4nnVXA4OJdOtgfaYfaum9sF/cDRA8WQTA3hK5Xhl
         nKm9JGVd+dB/l4tDEz5kbos3xgLp3+8RV/VEzHXBAR/pxSnRDUYj9KSvpAVReHqjeSLN
         4jFgijCuPtGj9lMWikg3iojPmhUATwiI/zTRanQzSoCGy+gPQAZoBruSdR7APuarCuQL
         ZCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697185604; x=1697790404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZXQ64zI4dZ66y0C+/+YXtcZqO4ReFctnoAjwEvrK3I=;
        b=BLtMN9EID6+sYx9zeHTBcjhMgg4zXrHnP4ROa02pPcVtqE40UuOvMzWE9nRIsLjdBY
         6TmIElqlcUyAmKwAIoxY/rBoDY90A9/gd3G8kr6Xr5XThY8uKcNjwH0TpYKK0u7cV7of
         r44+zpd7YpzNiykXt1UQQJAueQdIT5Z5kpPaZrxxOqd59wOhqLnFprFRqD5mzmQI6hBT
         581ppPtuXv5PK05kgmPDvBzNfVeRPj7SCkGzFcc17y0v8N/pdKPy5Mac3X4eVSnTYP1G
         LyhjNnV3QCDBRFnfld/aQIgwXZKVULXTB8SIhCqdxt5GYoI5CxRsf1ssi1C2zCTMQV/7
         qD3A==
X-Gm-Message-State: AOJu0YxdZsC5ptIXLi5p/N8RHuDHHikUfIs/0r0JaLn7b5/g+YgBIi5+
        bdu2uPnkBvPcRy1HKpc9vQc=
X-Google-Smtp-Source: AGHT+IHIvwAg1pMkW2F212EPWLTWWwNAnZSE/IqGZHZrUWiRCTHsfHFWxJyAHHwAGRKTdwWbO6S8Xg==
X-Received: by 2002:a05:6a20:734a:b0:15f:16f5:858e with SMTP id v10-20020a056a20734a00b0015f16f5858emr25495617pzc.58.1697185603950;
        Fri, 13 Oct 2023 01:26:43 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001c32fd9e412sm3305524plg.58.2023.10.13.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:26:43 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 1/2] tty: gdm724x: Match alignment with open parenthesis
Date:   Fri, 13 Oct 2023 01:26:34 -0700
Message-ID: <ff627fcbc9e450c2e8f4aa5810b94e56151efa2a.1697184167.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697184167.git.soumya.negi97@gmail.com>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CHECK: Alignment should match open parenthesis
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 32b2e817ff04..4e5cac76db58 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
 	int ret;
 
 	for (i = 0; i < TTY_MAX_COUNT; i++) {
-		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
-				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
+					      TTY_DRIVER_DYNAMIC_DEV);
 		if (IS_ERR(tty_driver))
 			return PTR_ERR(tty_driver);
 
-- 
2.42.0

