Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053F7AD7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjIYMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:18:17 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17ACE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:18:11 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3adf06730c4so4029058b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695644290; x=1696249090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOnVN1rOFVajKAbeVV2zdOVaxv00+S/fJ9PzfWMptxI=;
        b=mbotxPjS3WmjMnBbou1Y2jk2/8BoMY3mvlmsnDJsbPFEuxs20F56gDnKAyjm3Jpw5v
         3Paweu4LhBfgdk4qKNURJWn1onGDnq8ACHokjg4opIZalyqkQIHvyqwXV2TVyDuLAJk6
         OVA8zzaFMADK2Se94TVuwrm+2PY1MnCgueR3ckCN3ALZijUXR2Tc7yb3kMLSEnwNSXFa
         plLhoqNnPufg4sleNJ40efo+1FLSzX+qXnzKyl+HVrHSzaF8uJ6R+/D2EwafFm5G0nLm
         fguMlP36trOElubUObk0OvGlFSXDlSZvYcmCbiffTtanyKX2dFQO69U4bx+PwAL023sQ
         e41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644290; x=1696249090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOnVN1rOFVajKAbeVV2zdOVaxv00+S/fJ9PzfWMptxI=;
        b=iz/mLpYxiiy+4To07U57Xj5XiXiw8y074niVc3DTgIy5cAzrLFWTHmbyvbiBE6YeWq
         E/Hu9iZaBbDzpkLORAdOXm3B9M4yaz6/J0qPlxpjXL8dKp7z75qYzAutMKkX4Jh7ITX2
         vcySflLOpj1CDfnPbbXYx/UTbjT4UC1bMay/KqS/BwfxCsHqRN+9SaqOjaH/I63cG4Zk
         nQRQb6Qs5aBO6EWeELEYcTtxUF3YvrtpEoyuX7uhlOlfhpRp9N9iwb5gFDNB7PmPsG8Y
         3Ra5VFVxVyJbzySAAuaktI+uEwOlq1AYOUC52fgjYyc63LWalYraSy20vrqVOVH3NM7c
         +Iow==
X-Gm-Message-State: AOJu0YxtCMXGAUK2FZJtd7UrwFh06MHqt81VS1P8t5MEIdGhEfw/eh9b
        EsV4fPKOYCjRJNTFdvz8ZjbNMFVrPSnmXw==
X-Google-Smtp-Source: AGHT+IHc2C+1GCW2kpICDog9+xeLilUnvwGiOlFDt1eRvD2+Nz6+mDh8uyUFd+ERzSvogC4JT9xIVA==
X-Received: by 2002:a05:6808:18a1:b0:3ad:f866:39bd with SMTP id bi33-20020a05680818a100b003adf86639bdmr9199813oib.27.1695644290598;
        Mon, 25 Sep 2023 05:18:10 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b00689f1ce7dacsm7992426pff.23.2023.09.25.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:18:10 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] irq/generic-chip: fix the irq_chip name for /proc/interrupts
Date:   Mon, 25 Sep 2023 20:17:34 +0800
Message-Id: <20230925121734.93017-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_init_generic_chip() only sets name for the first chip type,
which will lead to empty names for other chip types.
Eventually, these names will be shown as "-" /proc/interrupts.

This patch sets name for all chip types by default.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 kernel/irq/generic-chip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c653cd31548d..81ecca08caad 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -219,11 +219,15 @@ void irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 			   int num_ct, unsigned int irq_base,
 			   void __iomem *reg_base, irq_flow_handler_t handler)
 {
+	struct irq_chip_type *ct = gc->chip_types;
+	int i;
+
 	raw_spin_lock_init(&gc->lock);
 	gc->num_ct = num_ct;
 	gc->irq_base = irq_base;
 	gc->reg_base = reg_base;
-	gc->chip_types->chip.name = name;
+	for (i = 0; i < num_ct; i++)
+		ct[i].chip.name = name;
 	gc->chip_types->handler = handler;
 }
 

base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
-- 
2.39.2

