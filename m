Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5787F5753
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbjKWEJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjKWEJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:09:30 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE0A10E2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:08:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf52e5e07eso11467525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700712526; x=1701317326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnAYolYzVC6+Ox+rXpGD2+5czZDHCkLmG8m5K79PKxU=;
        b=PqAV0JPC5IJUeXEhqdUV3fWyhJ+nB73TgV5nKHv2UMY6FCh+p0ct6/eeEX3chWDIR9
         9ha44sUPsvtfshevRhQMNVGxNXmiHODQbQjTM5gWriDG9UMJGYZ/0IKEYO3a7yydqQk5
         Oqqkf3yYYRw9V4ZXnhFOb/SqAHq9yaGR234aLeWIq8WRVPjVBiBo693TNBYQpIFilbvN
         NuLpbYr9sbprwS49MLmi3O2/70CapjsPrZATJCI8FTQreTuEg46aA+VwWmmXDtT7TGtH
         xgXY1l1R81bVadg9agqz/AYshObEQIZjiO31PKYBEGHAAOQCToBKhacKuZPWxAfMaMq2
         yEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700712526; x=1701317326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnAYolYzVC6+Ox+rXpGD2+5czZDHCkLmG8m5K79PKxU=;
        b=oZeJafwlGuy8VRKqD3AgCWo0JvwEAvwNB/Ryg/voQ+WCAINGAIdMXEguwV0E/MRPty
         V12ijtUEYSeLbhp6on5MAqmOhyu5x35oPglXhdj61+6OrcTpO1vPie25EfV8lryk5ciH
         FNUyva6H+UOe3qgtoCay7gJ7RdxNRsVU2jZatWQdPsuHgQpHI+zk5xNZ1jhZ1bt//8nO
         2InDJeIjTnYq/aWc5Uf+9Ecpcd9qYJtDpeVjMyEkGcbutdMrOoQ+Fg+QCb0uG3wouqpu
         HgX+WbBLkDGybKJsLzjSmvux6MwJS2ZimfD2a7sh2gkBxu906CP8O1eWF0Y6sfmDzdqG
         0gjA==
X-Gm-Message-State: AOJu0YxbO8YmfYPIJoRfsncr+hFfbq8aLaLg6MGvTdrCdrbRIVFAuFuf
        /dPmlP7Bdg+V85srWGxGo6vqreczr2hpTQ==
X-Google-Smtp-Source: AGHT+IHNj6ZMUmWR++f0+N8mRJHp8+6lTwyWnvyQTVZ4J3zq7/0EA7iXbgZbp8g8f2E1Hrz5vwgVdw==
X-Received: by 2002:a17:902:74c8:b0:1cc:419e:cb4b with SMTP id f8-20020a17090274c800b001cc419ecb4bmr2314951plt.19.1700712525945;
        Wed, 22 Nov 2023 20:08:45 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-202-94.dynamic-ip.hinet.net. [220.143.202.94])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902904500b001cf85115f3asm213264plz.235.2023.11.22.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 20:08:45 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] ntp: Refine ntp_get_next_leap implementation
Date:   Thu, 23 Nov 2023 12:08:18 +0800
Message-Id: <20231123040818.24905-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

It is unnecessary to use the local variable 'ret' in the ntp_get_next_leap
implementation function - just return KTIME_MAX directly and get rid of
the local variable altogether.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 kernel/time/ntp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb79c2b..af1a7e0c0f9d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -379,12 +379,10 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
-	ktime_t ret;
-
 	if ((time_state == TIME_INS) && (time_status & STA_INS))
 		return ktime_set(ntp_next_leap_sec, 0);
-	ret = KTIME_MAX;
-	return ret;
+
+	return KTIME_MAX;
 }
 
 /*
-- 
2.25.1

