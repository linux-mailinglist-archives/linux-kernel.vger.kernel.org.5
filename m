Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152F8026D8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjLCTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjLCTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:30 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE3F1B9;
        Sun,  3 Dec 2023 11:33:29 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cdc0b3526eso31270867b3.1;
        Sun, 03 Dec 2023 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632007; x=1702236807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfnViHUiQRdwcyME4SHx6F8gnhZe+b7onoGZNvEd7Lo=;
        b=CLVoDE06/t7TFnnUngsr17zC9Qcw6Vmyt2yrp9ryZaZN7Sx7Ew2VX4izCIgSrXanMz
         xIx0/FOjQ53WIVrAdpFetdOy1B1FWe76LqL8tjXuj/ZpuVqcl++zOORBlBXG+3y/mt0O
         sS7XlBLi0TcSniDEwXKMd9UELELXhnvEOaHsuBPTqN07jzqo6LMksM6qJyZJdT7R0TwN
         EdvNzik6dW0z+nCFCXCwgHM/BVmw8uS6HeFc5hpBvKTM7rJ3raazptCS+/oqM3LoKQnE
         LsYUrNlheIDlFe9q4D5mNTwKMdcfaLMsNNsyJ47cKj5k+1uNq7uyuEhJcG4czt56nB33
         AhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632007; x=1702236807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfnViHUiQRdwcyME4SHx6F8gnhZe+b7onoGZNvEd7Lo=;
        b=Ps3jD5MCHdfRWZj4+7Fo51+GyagCp3tlxdoxdF7UX1tmoYUubxurvuVt6E9Vdd0+SR
         MWL/7ZTuKqXHzygJq3qJUMoAGA1spqjFwb2gRbbEXT1uIk1iBR57obm8VoMkXkbQuQUD
         jFpmcG7W9PGf65XgTz83K3B04E/QWGOFp6OVaTlp57VyJYFND+vphWRi16pQ98saKccq
         gT0mjq4dZZh7HcEIb9lXsZP0jQLFIlgcIozVIzHheL7xU3R8f6l6X4tV5BdSuEAf8Hig
         oFtCL413+ar+t2s03DX0XCFJgm3TtR9P2ivkSP7W8zgatqtByk0e84kYH1IJfUy2s+AD
         3E/g==
X-Gm-Message-State: AOJu0YzGt5Ul1Qsz0N22sug7KVzmOfwMQXRTNzyo9RXCs2K/LbrydL7S
        rCkLHUwsWl+9anJjI78ECO4z529MKdGKcA==
X-Google-Smtp-Source: AGHT+IG6vqhh+2ikOpv4+3EIQGSuGL/ROzm2e227H32GQng8dg5JFKm7uLPR9UVsyHGBiPnhm3niaQ==
X-Received: by 2002:a81:af07:0:b0:5d4:90a:566d with SMTP id n7-20020a81af07000000b005d4090a566dmr1786895ywh.4.1701632007152;
        Sun, 03 Dec 2023 11:33:27 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id t9-20020a817809000000b005d3500ea9fasm2730455ywc.10.2023.12.03.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:26 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 11/35] ath10k: optimize ath10k_snoc_napi_poll() by using find_bit()
Date:   Sun,  3 Dec 2023 11:32:43 -0800
Message-Id: <20231203193307.542794-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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

ath10k_snoc_napi_poll() traverses pending_ce_irqs bitmap bit by bit.
We can do it faster by using for_each_test_and_clear_bit() iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 2c39bad7ebfb..a1db5a973780 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1237,11 +1237,10 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 		return done;
 	}
 
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
-		if (test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs)) {
-			ath10k_ce_per_engine_service(ar, ce_id);
-			ath10k_ce_enable_interrupt(ar, ce_id);
-		}
+	for_each_test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs, CE_COUNT) {
+		ath10k_ce_per_engine_service(ar, ce_id);
+		ath10k_ce_enable_interrupt(ar, ce_id);
+	}
 
 	done = ath10k_htt_txrx_compl_task(ar, budget);
 
-- 
2.40.1

