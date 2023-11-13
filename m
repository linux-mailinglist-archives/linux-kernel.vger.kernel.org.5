Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D47E94D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjKMCba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKMCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:31:28 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C4410C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:31:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc30bf9e22so29534125ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699842685; x=1700447485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sd10hTgpNqYujYyn3UZDz1YnF+lDmSTrk9YJNSbPP8c=;
        b=CjcdcvmjGOEtaLjZu8WsRNJIIP/ADVPq0Tklm+q3GiHI382L81t9yXBVFtYMfBdNcq
         z+puoccTIGoiijIMkthzVo+UJI9gSY/JjlQQguhuWEObFvU9dO/AagTuHzvLc8iDGodq
         p9LaKw0bQUMyJFlafLe3C7uMGP4v/RvAmwFDGpS3SCELInCYxcK7Okoirb3MQ/kdQY22
         owAK6UrwyGa1f0Zg4VgBnvg/QA2Th//hr3wJ6rfx7f3WhRYSz9N5kjDc3EMF3ye/RXU4
         VVcEu7iDXnkeGu7a5y8A3GYSZYMs4cLNN0+08/cCTPNex68DONInF/JNGtTux4uBQum9
         6nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699842685; x=1700447485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd10hTgpNqYujYyn3UZDz1YnF+lDmSTrk9YJNSbPP8c=;
        b=Y1T7a3T2tO09bvLbYN64BvhHz5sJMWD+SHg5lZdn0vurU1vGPF8bGqEWR0y55wQAFL
         XmeyTr4ErWqs43WIF4ipzkniS9GyEoTZ1UjfmdEXL/V9/ao6ROPhWF9uMXPKzJLUo+G+
         omNktyPg6wgo+Ksvi9SiVgYGT4rmWP6zXGqdSHgCLHh9qQCQO2iLI4MVLL6rW++CKXMv
         w5XaG6L3gjBuebRbI9ImOmQeo+3AEtBoITje+iPsR1RCRvzU6baQJvaMaAYE+3QUXPjQ
         ueXr36E72MBXp1E/5pL0MdmLbD1xzVJtCHTERJfYtb8LfvQ05d46yeeD9qGZW/Mf6OtK
         XQlg==
X-Gm-Message-State: AOJu0YxLiZUWl3CS0gofIa/vxEfsu4HybqqFXCWXbnGReC+/coUwx5Jk
        56CrTsSxD2Nmn4gGoupMY9WrgQ==
X-Google-Smtp-Source: AGHT+IGH+R3Li3avmxjpcVqHSD9l7bHR0YYeJvyXAI9k1LPViN5lzWQ03fiF6Iics7iinolaM2XpYw==
X-Received: by 2002:a17:903:32c9:b0:1cc:332f:9e4b with SMTP id i9-20020a17090332c900b001cc332f9e4bmr8122899plr.1.1699842684834;
        Sun, 12 Nov 2023 18:31:24 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001c9c5a1b477sm3143643plb.169.2023.11.12.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 18:31:24 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nick Hu <nick.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: sifive: Declare PM operations as static
Date:   Sun, 12 Nov 2023 18:31:19 -0800
Message-ID: <20231113023122.1185407-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are only used within this file, so they should have static linkage.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/tty/serial/sifive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index b296e57a9dee..3babc6c3a527 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1033,8 +1033,8 @@ static int sifive_serial_resume(struct device *dev)
 	return uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
-			 sifive_serial_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
+				sifive_serial_resume);
 
 static const struct of_device_id sifive_serial_of_match[] = {
 	{ .compatible = "sifive,fu540-c000-uart0" },
-- 
2.42.0

