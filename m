Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF8280E1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbjLLC3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbjLLC2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:44 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9089126;
        Mon, 11 Dec 2023 18:28:29 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5de93b677f4so33478097b3.2;
        Mon, 11 Dec 2023 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348108; x=1702952908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0haO+emVH9hQdnKbtmnO0lw12WWT0Jo1zjWRuqv+20=;
        b=KyI8OnCwYyekN4o5CXCTLurABKpT1zBf3HmI8w14WJSILDTlgViOclRwxSkH7vJUri
         im00/LeOdcGiSeOB75suZ83qOMDor3mQa4gIfPFfi3n2nNFxrXTScLZREE6dmLudmr6/
         ljNn49oCj8ipv+6Z9qZqskXG7zKKowIpIeF8aCg1X9BNpNLAEJvNOFq2+eV+MsyJe/re
         UM4vN+apO/TIJP7KagSxogIMR5EvYKLrG1K/nyQ4C7hzTGBtoMid6Lo/m2PWnD6elOxX
         EyeXoVhiTShf3AJXs8RtpSd47KSV1EpXhUjXcMKLUt4c4QeD1hT4lcqsFAKfNc9xIa3V
         CTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348108; x=1702952908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0haO+emVH9hQdnKbtmnO0lw12WWT0Jo1zjWRuqv+20=;
        b=aK6u0yiQIqow0WMY4ivwVwkIUQpAloFWgM8a0pCe2j5qAkMyijKoy21Shlgz5esAsH
         TeUXmxmAkx+/6o2OozzW/N43Hn9zoj2tl4UF42/9y8TZ9c5YFldTrDk5EY/Z2B1bwTke
         MegAEqfhOTGHkSoMTV5Wpo+hKbtuyvfCgUNplHeyJetSQ1+ZHhYpW1f/vb4QM8nLKk5H
         dNWuLT5e7uy/Nli4nxU2/7+RkBuALWwTY/l3l7BH4UuZw5XH5oGQZuv3l9KmJUd6GkyZ
         5GaFo+lRQfFSoPulv1XIqacVGL3e/akRze8I0hOIXY5ZwRU5ERu7IFPvfSL84TADPfu0
         /gAw==
X-Gm-Message-State: AOJu0YyKMLmpUeiDKfmCp+SnfkQa4nN4EFIbESv4x/+ZX7SRj2nUCg75
        MlcQTMawF9csj3KLuC86GBK4SH6F2f1MjQ==
X-Google-Smtp-Source: AGHT+IGXT1tgF3EHtGx8dlKy4zKSekEMGNAcx1n+XFDoi6dYydZSsA2OPFU2kmcQLtowTGGM2kDjXQ==
X-Received: by 2002:a0d:f641:0:b0:5d7:1940:7d6c with SMTP id g62-20020a0df641000000b005d719407d6cmr4563496ywf.67.1702348107794;
        Mon, 11 Dec 2023 18:28:27 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id c127-20020a0dc185000000b005d4035e6135sm3435315ywd.74.2023.12.11.18.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:27 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 23/35] usb: cdc-acm: optimize acm_softint()
Date:   Mon, 11 Dec 2023 18:27:37 -0800
Message-Id: <20231212022749.625238-24-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acm_softint() uses for-loop to traverse urbs_in_error_delay bitmap
bit by bit to find and clear set bits.

Simplify it by using for_each_test_and_clear_bit(), because it doesn't
test already clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-acm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index a1f4e1ead97f..8664b63050b0 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -613,9 +613,8 @@ static void acm_softint(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(ACM_ERROR_DELAY, &acm->flags)) {
-		for (i = 0; i < acm->rx_buflimit; i++)
-			if (test_and_clear_bit(i, &acm->urbs_in_error_delay))
-				acm_submit_read_urb(acm, i, GFP_KERNEL);
+		for_each_test_and_clear_bit(i, &acm->urbs_in_error_delay, acm->rx_buflimit)
+			acm_submit_read_urb(acm, i, GFP_KERNEL);
 	}
 
 	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
-- 
2.40.1

