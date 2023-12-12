Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6280E194
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbjLLC2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345733AbjLLC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:12 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDCE5;
        Mon, 11 Dec 2023 18:28:12 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cd81e76164so50638917b3.1;
        Mon, 11 Dec 2023 18:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348090; x=1702952890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXzBG6YZWj7GIPOLgSmnK31hIBgVH/D0z2Wg9iUswnw=;
        b=UOuIZm3O+SimwsEXXZbCcSLti7e1pHIQKM6scWCeeOxYK7DSTjHDKd1xL3kToQFSpe
         GTkRpkFMZEXtQslGvCk/ou4V6BH2kO7KqHyrtKZ6qgZ2SU/dggHYmFwbk6GWkpXJg+sQ
         gqIFlFJwItQHIfwuva9gG3bgg/5xG9GHZzz7rZUorLZNcuJzKFBms52Glm9v7JJBehZ7
         OUyHyMdhoiWdLRfE+Ut3/NagUGkS11t1xuOQc4rqQrMf+6GNjj3/iFBsYpTYSBJGQU6/
         qPk+WIz1XRO1aOOwt7ZYYwZ/o5PYn91L78KPMv8Kx5YG7vE3YxP/GUB/CHpncYRdDqZB
         keMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348090; x=1702952890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXzBG6YZWj7GIPOLgSmnK31hIBgVH/D0z2Wg9iUswnw=;
        b=HuYPW9U5Ea/TPEu42GW6GypXhVFMOx3U5vC1IIelMvD/VYLfwC5tRclLEuMBNzboi8
         cEzNo+46+MjTg3WXP21NGyeA/vOr0Q9CWk8yH+LthxdizOy3mJ8X2E5rJSXDA43AV6pt
         UxoZTvDYCoFRRonL/0/UiiIqn1P58Dp3krUxM2DOA+E1H7pSf1FNIDFRnSsYQuhVAnZ2
         J2yj6qad+Auh2vFZoTPaA768VX2ozOEbvIoF9QvoAaJdugW/2emXkGKQ444niAzm1J9a
         f8wcUYEBu7125i31pXKNskclgsTHOscWamgBKD30RY6HpDNrBMI7YSVV+9qi3gK93HbS
         XfZQ==
X-Gm-Message-State: AOJu0Yy1lWWXq5zjFK+gtrzvAb1G2FEISCm7mUzagwlbzPP+kgQCW1uM
        rEH/+TFxqBQvKa7b8pNxmytM40hd69tPFg==
X-Google-Smtp-Source: AGHT+IEvJ/cdo/qBZ8m0qRhit8FNqJGxb/89AgN0CYWfyzyQakL7L0pgxHzUFK2IFJ46o//TnQm2MQ==
X-Received: by 2002:a0d:c484:0:b0:5d7:1940:dd79 with SMTP id g126-20020a0dc484000000b005d71940dd79mr4223699ywd.79.1702348090187;
        Mon, 11 Dec 2023 18:28:10 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id d63-20020a0ddb42000000b005845e6f9b50sm133308ywe.113.2023.12.11.18.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:09 -0800 (PST)
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
Subject: [PATCH v3 11/35] ath10k: optimize ath10k_snoc_napi_poll()
Date:   Mon, 11 Dec 2023 18:27:25 -0800
Message-Id: <20231212022749.625238-12-yury.norov@gmail.com>
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

ath10k_snoc_napi_poll() traverses pending_ce_irqs bitmap bit by bit.
Simplify it by using for_each_test_and_clear_bit() iterator.

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

