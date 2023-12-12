Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE9E80E1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbjLLC3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbjLLC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:48 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7736EA;
        Mon, 11 Dec 2023 18:28:40 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d7fa93afe9so3750358a34.2;
        Mon, 11 Dec 2023 18:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348119; x=1702952919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEOzzCmNkZ5d9Lsb5EU/wd0mwIpfakhGSYCXk0VOfrE=;
        b=hHYMCV1FcUGDHrfWKkeQiwL5Fab7+g5uLY651+dYZbJi70sHmQJ91SOk7DSESnuIoa
         vQV3L0YxxT2OT3MyOXFzLR3ah5SGAjxmJSc2oa3HRXnQAfriOL3pCZtXQAaZO7b+7sV5
         WJXX26C+RwdjAevT9mmt9Go8DDJGziIA8xvK8jCCR6xbh7KaDxhKUn5e4HcwH1YlwKtH
         m+j9G/y10HvWOAZJdNoitlsRGjGXjCOmhVBDbTCR6ensUvaEGO6tD2hdxyJSEETZOwBh
         RFozTAbJ++dqRyKdbEnZGhArJhLERH9ntK6d3aPdzFXAO5mCqg62ms7TQdlGYUOjmObb
         E0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348119; x=1702952919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEOzzCmNkZ5d9Lsb5EU/wd0mwIpfakhGSYCXk0VOfrE=;
        b=Y3BpQfskiIfVTej0K63BDCU8GcIQm+wCcgl5lSkA3UZUZItuqT/c9K7Tn59KJ9vNY9
         1LwKSEhg/rrppBSPrAp7abYv4p0cofR2oCfH4/na2vcv9hyFGuUxDJIkQSxF3dyYW3yA
         +C2Nlhpu7dXMFdtcdVS2hPup8U5+LLgcxs1cV0N6rSKgfY05XoApPjHy+cHIKvbT2zag
         63jItXwwDb/5HmLghPHkEtrPdIP5UXjHGfYPIbXnNO4LeLeU6BLV6Oe8V35gVQUUx6BR
         MNkXgss3nsNuPCdgYTPxiJlExuauSdIS1hgeNuBl28f1wuDLISnG8Zus81zl6+snhSJy
         Q3cw==
X-Gm-Message-State: AOJu0Yxh40xz415i7fdwj3zpeNxS4xBKRfxKW+75NxM7WJeWxN4LBGHG
        8dBLTlGaeWznMWR5J+4dbQfTWJSSGzcrCQ==
X-Google-Smtp-Source: AGHT+IGS1JDKxXZkdy+V57D9INseET5dn8eBZ7VIB4tOZj8XSJDFgApPFNydqZo+uLxUbeCSlTo6IA==
X-Received: by 2002:a9d:7a57:0:b0:6d9:d6f9:359f with SMTP id z23-20020a9d7a57000000b006d9d6f9359fmr4288975otm.53.1702348119498;
        Mon, 11 Dec 2023 18:28:39 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id d64-20020a0df443000000b0059f766f9750sm3434546ywf.124.2023.12.11.18.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:39 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH v3 31/35] net: smc: optimize smc_wr_tx_get_free_slot_index()
Date:   Mon, 11 Dec 2023 18:27:45 -0800
Message-Id: <20231212022749.625238-32-yury.norov@gmail.com>
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

Simplify the function by using find_and_set_bit() and make it a simple
almost one-liner.

While here, drop explicit initialization of *idx, because it's already
initialized by the caller in case of ENOLINK, or set properly with
->wr_tx_mask, if nothing is found, in case of EBUSY.

CC: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/smc/smc_wr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 0021065a600a..b6f0cfc52788 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
 
 static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
 {
-	*idx = link->wr_tx_cnt;
 	if (!smc_link_sendable(link))
 		return -ENOLINK;
-	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
-		if (!test_and_set_bit(*idx, link->wr_tx_mask))
-			return 0;
-	}
-	*idx = link->wr_tx_cnt;
-	return -EBUSY;
+
+	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
+	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
 }
 
 /**
-- 
2.40.1

