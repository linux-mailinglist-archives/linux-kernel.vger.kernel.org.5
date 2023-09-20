Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120B7A8C39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjITTD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjITTDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B80C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so102262b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236592; x=1695841392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fTb+Ik2udqF6O5creFYnCkxLACYh4nJ1pznoCTKYdgg=;
        b=cOZzq3xEY/EzAjSu/J2gB67UYARR/97qXxfEnak7ificFrznnSQT5c8KElVc/KhbHP
         kwZ8PBDdTfpRxbpFwjz2BEH5z4/F9ZQ+zJVuLYWgCjC5pmkvmBVQrO7LOfK+ORaVwYh6
         3w7b8Lq5CAPTVmCTH3mElMs6fzTuJT9q0ktDn7thXTGz/My1nMHSP9WenfbF2ce10AKS
         erIaO0pedz9d3H+tX1z2xArUu/Bknns3Yf9FWPNe+RSXfSgKoS+2z2W31RCi7N3OKrfw
         QnGLXSMinBN5SPtm2AO0k+zJM+dpP4KQG5r/XSOTnI4PWEa3Rl2p6PAzoFVr/S0guklM
         nnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236592; x=1695841392;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTb+Ik2udqF6O5creFYnCkxLACYh4nJ1pznoCTKYdgg=;
        b=jdZyv6o7q8QPERSua6mk8/bBHxXpbbreQnqupa23+9k+/G06slC3gpCNNE5GDuaSFR
         xMoV/wT6WtSdNheBMaaAWTObCTSvJU+Cbme3tUagD94gwhin/7Fq2kmvg0g/1bIJCk03
         sEvIEScC6q1KmiBHpckxu9gDQcGnAWSrZnmFM++rk3TdcbBj8BZnXU73BGjynL+7QHER
         H0NZVK8cxSqxPLy/MnDk3Nm1gmMYb5giskY58ZcP8GqcIfpY6AkcUGxU1Kwl5t9qEn62
         kETS3EDdKBQXKaVcqNczq83+P+Zs9TdS4U3gBq8RoZWiAFIUNpl6/7LJM7CMyXsV85ZQ
         vQ3g==
X-Gm-Message-State: AOJu0YxNJhoKabfEYsJqPOkNhjeJ23Jm/nHGNUUMmVyFeAQDZRWn9wmK
        CKdsPjm83gMj1J8xWTPYoK8=
X-Google-Smtp-Source: AGHT+IGOR3t7SCi0X1jSkUkFA5SJ42qQ186NGsFE41qOKCO7kuJQXQAUD43UH6S65kiieutgbFyoyA==
X-Received: by 2002:a05:6a20:3ca7:b0:13a:59b1:c884 with SMTP id b39-20020a056a203ca700b0013a59b1c884mr3984546pzj.40.1695236591863;
        Wed, 20 Sep 2023 12:03:11 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.03.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:03:11 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH v3 3/6] workignset: simplify the initilization code
Date:   Thu, 21 Sep 2023 03:02:41 +0800
Message-ID: <20230920190244.16839-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920190244.16839-1-ryncsn@gmail.com>
References: <20230920190244.16839-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Use the new introduced EVICTION_BITS to replace timestamp_bits, compiler
should be able to optimize out the previous variable but this should
make the code more clear and unified.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/workingset.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index b0704cbfc667..278c3b9eb549 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -772,7 +772,6 @@ static struct lock_class_key shadow_nodes_key;
 
 static int __init workingset_init(void)
 {
-	unsigned int timestamp_bits;
 	unsigned int max_order;
 	int ret;
 
@@ -784,12 +783,11 @@ static int __init workingset_init(void)
 	 * some more pages at runtime, so keep working with up to
 	 * double the initial memory by using totalram_pages as-is.
 	 */
-	timestamp_bits = BITS_PER_LONG - EVICTION_SHIFT;
 	max_order = fls_long(totalram_pages() - 1);
-	if (max_order > timestamp_bits)
-		bucket_order = max_order - timestamp_bits;
+	if (max_order > EVICTION_BITS)
+		bucket_order = max_order - EVICTION_BITS;
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
-	       timestamp_bits, max_order, bucket_order);
+		EVICTION_BITS, max_order, bucket_order);
 
 	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
 	if (ret)
-- 
2.41.0

