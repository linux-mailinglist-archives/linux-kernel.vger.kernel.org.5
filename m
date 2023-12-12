Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266CC80E1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbjLLC3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbjLLC2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:49 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BD189;
        Mon, 11 Dec 2023 18:28:46 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e1f852cb46so172957b3.2;
        Mon, 11 Dec 2023 18:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348125; x=1702952925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo8m0hD4+F1htFRsuw+mgKqoUgBikXdLbdGdafmirjs=;
        b=QBRWLcq/d/tBqDLg7eCONqV2U2nIlxfcn0P+QF+Orfd/DZuiRUmMmr4c36SB7HAWj2
         CnLJUFhLN2nXg+8eRvPWYaMl1fEtcKSabW/xW37UtOrjnc2sltLG+Vj77mXLpfXh+X4H
         kflNNzDLQ/DiNySHe00IfUjCGa7/2reyU3BEa+xxsXmWfhzPuWGgs9ygHjDspXHj3FAi
         nKpLgOjq64cLHwK5TrTZnAv5BAMHz9GscIJlgR3KtctuqzeAqFqCs2BOP75v76ZD3uJ2
         fEcYzD/eirVtxCxEyTHqpdEGO+fjlXJlE90L9Cv04KSHxYf0O3i9m5pgqT/valunlxxj
         QA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348125; x=1702952925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo8m0hD4+F1htFRsuw+mgKqoUgBikXdLbdGdafmirjs=;
        b=Or38kVKdRrI5USk9EFtanmHxsYvxkDxm9KQg3fdl3d2iBCHLkdGAMFvWcbHPM1H2MT
         uBBmXk66VUowdEvuKpo4gUlhWn8/Tu+m8hG485hB5v42Qv0rh5nJ83lwkI9U15rQap5i
         qCDmnkXHpKvsPShtxJqCWdXXCKB5ebbzGC+AUPREj5ysRQBfJ5EbFUwfrKoUVp4Ro+z4
         OLe1y+9jqBylZVtTfed4cLkuaBTfHjf+4Vns+UFEkoKesDqs04BrJus/TwbYCLICgMsq
         3MKW9FFe5SVLkCQFD9Fv7Cs3+jdNH0uLVZTKF14M/NJ/7IURpOz2nxx3AHT31qhdjb5O
         dUFg==
X-Gm-Message-State: AOJu0YzMejRNfbh/B/FIsAkt4WtNJO4OBxdtzcB+AXoVw5QW69MUycV/
        VpVSHcdgb8ijvLZl6NPmiioFEY0NLW3jzQ==
X-Google-Smtp-Source: AGHT+IHXKXarS0Td3fM708B+gCetT/1L8OI+lioZfJCrro13xZOGGax2Jo9xqqXoI9HlYUYn6jgdow==
X-Received: by 2002:a0d:dbd1:0:b0:5d7:1940:8dce with SMTP id d200-20020a0ddbd1000000b005d719408dcemr2626933ywe.53.1702348124999;
        Mon, 11 Dec 2023 18:28:44 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id x75-20020a81a04e000000b00576c727498dsm3462728ywg.92.2023.12.11.18.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:44 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yury Norov <yury.norov@gmail.com>, linux-sh@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 35/35] sh: mach-x3proto: optimize ilsel_enable()
Date:   Mon, 11 Dec 2023 18:27:49 -0800
Message-Id: <20231212022749.625238-36-yury.norov@gmail.com>
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

Simplify ilsel_enable() by using find_and_set_bit().

CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/sh/boards/mach-x3proto/ilsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3proto/ilsel.c
index f0d5eb41521a..7fadc479a80b 100644
--- a/arch/sh/boards/mach-x3proto/ilsel.c
+++ b/arch/sh/boards/mach-x3proto/ilsel.c
@@ -99,8 +99,8 @@ int ilsel_enable(ilsel_source_t set)
 	}
 
 	do {
-		bit = find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
-	} while (test_and_set_bit(bit, &ilsel_level_map));
+		bit = find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
+	} while (bit >= ILSEL_LEVELS);
 
 	__ilsel_enable(set, bit);
 
-- 
2.40.1

