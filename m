Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C517B7F088E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjKSTss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjKSTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666810EC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:25 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso521503b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423304; x=1701028104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=65vQj2xJm5p5mk5SbjAKMeJnwT21tT7eyXmu2H+Etu0=;
        b=B2qyu2tHHOjSYZHMRZ1A/7KsSk+HF7D9RY6pMMFaA3xA7VmeEeQXegg0xgu2IhPvJl
         uuw/J7qKy27Ew+eaLv9nZPNQKm+I2LoasjIwWE3NV/3YQHs8/tjWCnB0Vk7xJoPmkwSG
         wPmhJ8XfDAHUf0VG44SCngQRGazrHxflE2bVngV1ONwqQ/XcwawtdHCwjVNES5cdoQ0G
         pMjdgO6j76wbQI5M1n+5PeCPj1SAEjkWq63I4VR4NUMRfQIik/wA+LsabbkrlQgEhFdz
         M4U1IV6cbf4Bn5rZvZfv+huCUtl/P6USk35yCCoP7v6odo7ycHcaypk/rRWLMfl+9fX/
         rcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423304; x=1701028104;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65vQj2xJm5p5mk5SbjAKMeJnwT21tT7eyXmu2H+Etu0=;
        b=rgWWBdtHKwDllUR8IOgH2vQ1LPTqjtIkIogYaY3pFkhHm32Jl2wsCm8JpUJj32bqv7
         OHfmfd/mKe6qAWUwDkuA/xW/Ija72/u1CGWXKYFhDkCoGp4DFDCreql99fAyNpQKPj5s
         ZzauF492NA9nBCkNrQ2FJyqGw1atIUeu/hVsCYBGdJj4Q/cud4meXs5Qp0GAQtgwE4dJ
         FZ9RR9lUXhv7kZimFc7zUFSsissXlEIyZNTpcR6U6fTSRxS5lAx5qoIBHaTi+Vlcd1PE
         ZEvIvdJBhs1cgoBBvbyNSTuS5BcXRkiNoJjf/V8GEyP6FBiyOD4RGqh+X7Bjh9Iz541K
         PW7g==
X-Gm-Message-State: AOJu0Yy4OYyNny2ENBUyAfMgK+3l0Kd7fY+6GlJhuj7uVcCaxgoydn75
        c0aJ1IK3/ywsZRlSQFP0oGo=
X-Google-Smtp-Source: AGHT+IHHw1felGXoqcj71N9Zw1zsM8vWNO/fCDW6ep+Q60u+G2qJ+qT6hdQV7yWi9c9XQgH0pPdoJg==
X-Received: by 2002:a05:6a00:1390:b0:6cb:8abd:39b5 with SMTP id t16-20020a056a00139000b006cb8abd39b5mr2493633pfg.1.1700423304666;
        Sun, 19 Nov 2023 11:48:24 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:24 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 07/24] mm/swap: move swap_count to header to be shared
Date:   Mon, 20 Nov 2023 03:47:23 +0800
Message-ID: <20231119194740.94101-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

No feature change, prepare for later commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h     | 5 +++++
 mm/swapfile.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index f82d43d7b52a..a9a654af791e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -61,6 +61,11 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return page_swap_info(&folio->page)->flags;
 }
+
+static inline unsigned char swap_count(unsigned char ent)
+{
+	return ent & ~SWAP_HAS_CACHE; /* may include COUNT_CONTINUED flag */
+}
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_readpage(struct page *page, bool do_poll,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0142bfc71b81..a8ae472ed2b6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -114,11 +114,6 @@ static struct swap_info_struct *swap_type_to_swap_info(int type)
 	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
-static inline unsigned char swap_count(unsigned char ent)
-{
-	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
-}
-
 /* Reclaim the swap entry anyway if possible */
 #define TTRS_ANYWAY		0x1
 /*
-- 
2.42.0

