Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3B7F00BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjKRPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjKRPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:09 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA111FE5;
        Sat, 18 Nov 2023 07:51:50 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5b499b18b28so32751827b3.0;
        Sat, 18 Nov 2023 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322709; x=1700927509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0DdBJNYkBobnoLbuVdpfFwfkBXRkkwlqArhSXd28Ns=;
        b=h85wGB4uDaCRaOlOiipFKIhfT6uht+Bl+Tl8v7GH6vA18ehtjHt6ia+qyyd2qF82b4
         BlwOMtt/hLHgeDnRymeeBW6olQA+DKhBpK5Ah/S063zZWYRrkhad6iOQueZwZw8/EpXQ
         1l7EWkKEcpiSnNIg3eHYj2n74NoG6P2vlDg2/CI3ty1mhuGWyegQBINphlEkjHeSHCCc
         CROPr/XXZaDg+nW0qCIWwGnvBYRA7hRvYKkA4e1wRa/cOvVn/7iNN5eUy77scPYSWHeG
         LICzIKT46NXe3LyehwIrnOAHIgPaeoLhzVGr0j4xNFptnsqn51ddM5nQWajRx4Q7MNPb
         MnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322709; x=1700927509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0DdBJNYkBobnoLbuVdpfFwfkBXRkkwlqArhSXd28Ns=;
        b=SBHnHTG2TU3yX+A+q9zRJnjGH9J99pAljaSW1/lskIvLJOVLJ03xVH3Db1zdOpR45g
         AAGWS/n3dipL2HgpuJlRdd3idwXDYm1F2Rp//Ymr4hhK3+hcsb2wJQdcc0kVhW43kF8g
         6/VMYME1fsT+LuO+2ussn2Owi2dNAgFYMmsKAU9PdlEMzaK2JwcCTr5HKjgPPsbZJPSH
         MakhXNp1nxbQFvWaymWJMrEy9XZTpzM7CdIZuMgFU6AIA+wp1czKBNokdzapaLjX3TOk
         U6JynVgkJwbFC7z5wUoXu4dmOTuMCSOBcBtvnF8TlF/wqXGjsOsrXpxkvWwNr6PLLdo6
         y1gg==
X-Gm-Message-State: AOJu0YwEUcGyoKjR7IoNapoe5tMfBd62W1kjelnHvdY1R3ZNsbDG7bFl
        PCR4HGhc6BnH0oJLiYqBthuASZuOcSaokAdo
X-Google-Smtp-Source: AGHT+IHf/y6t164pMjc17343PBLUYFLD9XOP4hlMacNZfcaCxBOFO6cO3hN3hjM1cdowPx+3vJjRHQ==
X-Received: by 2002:a81:4fcf:0:b0:5a7:c906:14f with SMTP id d198-20020a814fcf000000b005a7c906014fmr2498604ywb.11.1700322708779;
        Sat, 18 Nov 2023 07:51:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id y200-20020a81a1d1000000b005af5ef0687bsm1177615ywg.13.2023.11.18.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:48 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hui Wang <hui.wang@canonical.com>,
        Isaac True <isaac.true@canonical.com>,
        Yury Norov <yury.norov@gmail.com>, linux-serial@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 27/34] serial: sc12is7xx: optimize sc16is7xx_alloc_line()
Date:   Sat, 18 Nov 2023 07:50:58 -0800
Message-Id: <20231118155105.25678-28-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of polling every bit in sc16is7xx_lines, switch it to using a
dedicated find_and_set_bit(), and make the function a simple one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index db2bb1c0d36c..6a463988d5e0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -427,15 +427,9 @@ static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 
 static int sc16is7xx_alloc_line(void)
 {
-	int i;
-
 	BUILD_BUG_ON(SC16IS7XX_MAX_DEVS > BITS_PER_LONG);
 
-	for (i = 0; i < SC16IS7XX_MAX_DEVS; i++)
-		if (!test_and_set_bit(i, &sc16is7xx_lines))
-			break;
-
-	return i;
+	return find_and_set_bit(&sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
 }
 
 static void sc16is7xx_power(struct uart_port *port, int on)
-- 
2.39.2

