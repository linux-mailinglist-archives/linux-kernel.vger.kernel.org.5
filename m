Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207680E1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjLLC3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbjLLC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:38 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DED121;
        Mon, 11 Dec 2023 18:28:28 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cd81e76164so50640367b3.1;
        Mon, 11 Dec 2023 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348106; x=1702952906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zknDDZPXO65EcmEriKlJmzs+43jcHB+zHIGvKah0pAA=;
        b=MqZdTTGjFZImNNR1KKtfga7ueam8z+QBLZXTmo2Xj+fGrcqxj72+38fbtfBUNU5czT
         NqewUCMbBAZE7hIOPp7ALiXUqSkD/ZQinVMgfzDwbazlI43IolsmWYPLcx+/DdDTkl4r
         8jR+9IFHSEPqzfzFDKLDL3zkDPZgSHf9qHtck5i/yxlhlwBNbRCgVH0bqBCKBjt/bTs4
         mJGCtgJmHK5aRX0Nr8jcsDv97Xd+iIOuAoMqOM6n9GpQRCT9zJt1xWdiUVhJ+ysIRxGk
         qoTsbngKxOzDoJvWZhVdAoDaASRVf3Dihvtb1jwzrm0tzHkymP9clxRlQvRd8FVXMQLY
         uANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348106; x=1702952906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zknDDZPXO65EcmEriKlJmzs+43jcHB+zHIGvKah0pAA=;
        b=oTrs9fEZJekGDyDiKMAqPo7jyajPaxEX2WB/PASAtLXbcdbEIOmXN4dony0U9OEHW4
         pavDyt46i7Oak0J8gzVMzznZKcWGiGVxMYwnBjEfWRYBwgDBmOHTYeu7a+TaH/WxWUO7
         BglUVUtFAe6eAjI6PqI4csFhJaBOo8fNSDgJMPC7IpeYBIk6CHT9o6XIW2mlJZoz3j2K
         1gC7GF8+H6Vs1OjNlPzmXDXLmqutauttr0Rs2AV3zmsT0017i/nT1t8Cp6noB6ZsffGn
         YU38LDdWeqpL6RaXYdvnOZ81GnI80oCN2gBYsv1cNTquSx6zYNIv2GvwUWVyct6r1glC
         Kkdg==
X-Gm-Message-State: AOJu0Yz21n6DVKYUiSEh6IPJvdMqIOt9JFUkbepCgv9stnBM80/MeUgj
        oZLSIRrkFYkXQ08v2wN9l8L7B9fHg+0xlg==
X-Google-Smtp-Source: AGHT+IENraHLfovA+ykpOElraTDmayTCsHv+8QALmyHtH/RgQ3A/AT8Qghg9+bwu9tGKb6rIfikViw==
X-Received: by 2002:a0d:c343:0:b0:5d7:1940:dd85 with SMTP id f64-20020a0dc343000000b005d71940dd85mr4712425ywd.91.1702348106198;
        Mon, 11 Dec 2023 18:28:26 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id t186-20020a0deac3000000b005ce039bf1ecsm3439166ywe.7.2023.12.11.18.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:25 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 22/35] tty: nozomi: optimize interrupt_handler()
Date:   Mon, 11 Dec 2023 18:27:36 -0800
Message-Id: <20231212022749.625238-23-yury.norov@gmail.com>
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

In the exit path of interrupt_handler(), dc->flip map is traversed bit
by bit to find and clear set bits and call tty_flip_buffer_push() for
corresponding ports.

Simplify it by using for_each_test_and_clear_bit(), as it skips already
clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/nozomi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 02cd40147b3a..de0503247391 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1220,9 +1220,8 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 exit_handler:
 	spin_unlock(&dc->spin_mutex);
 
-	for (a = 0; a < NOZOMI_MAX_PORTS; a++)
-		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(&dc->port[a].port);
+	for_each_test_and_clear_bit(a, &dc->flip, NOZOMI_MAX_PORTS)
+		tty_flip_buffer_push(&dc->port[a].port);
 
 	return IRQ_HANDLED;
 none:
-- 
2.40.1

