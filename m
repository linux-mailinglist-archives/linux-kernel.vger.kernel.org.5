Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09580E17D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbjLLC2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbjLLC2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:00 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC6D1;
        Mon, 11 Dec 2023 18:28:06 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d33574f64eso51853727b3.3;
        Mon, 11 Dec 2023 18:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348085; x=1702952885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KOs5y8ihc64lpMASwFbDug7by8ZogxYD/q/FLr95ek=;
        b=RU+12PJJdrYBX0rXfO+62RFHWxjl6wM4YG+N+3XElFV4uC8OHdEtOf75RGccwsu5Im
         jdEj53lrq3u1MRvtzW00Kl5a2DQTCXBlwHlcpF2kZEpI69MqotZPwKtdYBUW8l46LD1x
         umT/r3ATf6FORWmIQ1Rgb13WTHonAXDvkbmZZc3XeehLGz9/cPhC+i6aBSf5oJV/qi10
         uHwv0HupD/bbRMnVVTQ9oTMGznKZSd4Gw//uGtVo8axIYysJnkgnMLPGuNXQHvkValC1
         yrymUJhY62U9VC400oRojJ6XhaogdIAFhlb9hlA2YpXD9p9inH+UdwStDqbnNrVsO2D+
         9sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348085; x=1702952885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KOs5y8ihc64lpMASwFbDug7by8ZogxYD/q/FLr95ek=;
        b=fliCjVpglKGZSh0oCjPdJtBE5K1aiDr6Lm/qRCVTUTwX4dp5YHSXILvoPfIuHeOMRD
         BtV3zMA0IphvfqR9t8bwx6kg0DzGp3+vW6eAD8/sBFB/weO0q8jDfqtEUexahtuKfYPi
         QkHe72sicNbdAmdee1oz87eQt2dl5tdwDpo1i+90N5068BABF+wWFCPF67UHJCHjF5Xm
         kFimfA+LnyFj58b9zWTA5BDpgrt9WpzdEpsDBGh7hQief92i9izkuxJ2QGVf8UYP68LN
         fBT/yI6cLLZcUDlxiINP7UGOoG12YzH5insdS+poE8n+ATCk4CIMnJCUUzBvVXpptxfN
         JCsw==
X-Gm-Message-State: AOJu0YyoNbwao2c1rJA8veVf0xCPXIQDrb/c7UqBWQeVAO7qc1D8IR7K
        m6Jtez+qfb+cLvHxdPxuF+zUSo1NP+rBmQ==
X-Google-Smtp-Source: AGHT+IE8d+wi8Uhw/fOsnqO2zHOQGoEcjLbRuwi11OWN54hN/DolHcsk1Ef03h2++Qp9JdPg/Ny6kA==
X-Received: by 2002:a0d:f881:0:b0:5d7:1940:b391 with SMTP id i123-20020a0df881000000b005d71940b391mr4788415ywf.93.1702348085065;
        Mon, 11 Dec 2023 18:28:05 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id p194-20020a0de6cb000000b005956b451fb8sm3402858ywe.100.2023.12.11.18.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:04 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Yury Norov <yury.norov@gmail.com>, sparclinux@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 07/35] sparc: optimize alloc_msi() by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:21 -0800
Message-Id: <20231212022749.625238-8-yury.norov@gmail.com>
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

alloc_msi() opencodes find_and_set_bit(). Simplify it by using the
dedicated function, and make an nice one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/sparc/kernel/pci_msi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index fc7402948b7b..91105c788d1d 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -96,14 +96,9 @@ static u32 pick_msiq(struct pci_pbm_info *pbm)
 
 static int alloc_msi(struct pci_pbm_info *pbm)
 {
-	int i;
-
-	for (i = 0; i < pbm->msi_num; i++) {
-		if (!test_and_set_bit(i, pbm->msi_bitmap))
-			return i + pbm->msi_first;
-	}
+	int i = find_and_set_bit(pbm->msi_bitmap, pbm->msi_num);
 
-	return -ENOENT;
+	return i < pbm->msi_num ? i + pbm->msi_first : -ENOENT;
 }
 
 static void free_msi(struct pci_pbm_info *pbm, int msi_num)
-- 
2.40.1

