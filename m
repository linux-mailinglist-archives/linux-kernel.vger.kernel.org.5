Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41380E33F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjLLEVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLEVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:12 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D09BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:19 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5e1e656d019so2479317b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354878; x=1702959678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqzdM1JWQlsu7k/N7xBtV+SLaOrDoqGHT+SByeHgWqU=;
        b=UC6d6PO3w2NZb5d9tH0UdWas3rs/ZjAl8v6ylZ9E3ARFTOUXyTe0/WRsugYKxN1PUC
         yGXhWx7auSab/uE99Hw5eOfSCWAVKKzvcV0/95TYjOreSlSip1IZgfQmDbkFy90dl+DR
         wVdWg/xq26ELYqUJ4WGF0K7DY75R+WzgUO9oUM2Pf3K+zfNbTwnRSvgMP0VloIoy720t
         27drinVXkFUosKN4/8P7IpS9hqEQgbml8ginjsHnVL3MREfq3i3AYRie8UJ6gpypaUrQ
         A4ALxWCt3MQYm6P7A+MzDEPpx3r1loiwRaH8G34hs7Ylghw5GdXrlRoH4z4aXMxj0qY3
         MVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354878; x=1702959678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqzdM1JWQlsu7k/N7xBtV+SLaOrDoqGHT+SByeHgWqU=;
        b=r9fYSdaN/bzt1lYXPDRBvo9yzD5/3ZC92Vkb6RCoikEKyUpQI/d0xl19HaW6z0ep1m
         K9eGhRkJVdHMM+qHs7AEVrCAmelUYbQ1Vpz81s8fv7RtvhwVAuwUlqxUAP8kLO8epAXH
         3rZj7R+5JNV2OEgoAWZ+c544KbZj58D/uw9Kb2UyCEWlV2+GRayDwvVuBmCyRFggGGkH
         FDXQqacw+cT4NebawJureaKvKFoARG24nV/LiQpGqX2zYhUKwgO/YJ8sbXrEdx+Bzyq1
         vafXlqgxqdnEHdlsiHNLAS7FgQzISUzunfcBgRwuPL/9pGM43N/M9dEoYEF6uRvOh+Oy
         PXSQ==
X-Gm-Message-State: AOJu0YzcV/tKw98sNaV3IUes5c85siBq4K1K7DI7BRqNqhOMolHy91jC
        BRKEnljsLW7D21lHH+02VIY=
X-Google-Smtp-Source: AGHT+IEpOxgjKzCRWRfaNbZ9gq8uVyIb3GxyH8tmiruZoPiABPHG5lIqbyLddNf9/MgHO/C8v1nIlg==
X-Received: by 2002:a81:7188:0:b0:5d7:1941:2c23 with SMTP id m130-20020a817188000000b005d719412c23mr4611909ywc.80.1702354878116;
        Mon, 11 Dec 2023 20:21:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id en9-20020a05690c2b8900b005de84505114sm3311734ywb.58.2023.12.11.20.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:17 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 5/7] lib/cgroup_cpus: don't zero cpumasks in group_cpus_evenly() on allocation
Date:   Mon, 11 Dec 2023 20:21:05 -0800
Message-Id: <20231212042108.682072-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212042108.682072-1-yury.norov@gmail.com>
References: <20231212042108.682072-1-yury.norov@gmail.com>
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

nmsk and npresmsk are both allocated with zalloc_cpumask_var(), but they
are initialized by copying later in the code, and so may be allocated
uninitialized.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index cded3c8ea63b..c7fcd04c87bf 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -347,10 +347,10 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	int ret = -ENOMEM;
 	struct cpumask *masks = NULL;
 
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
 
 	node_to_cpumask = alloc_node_to_cpumask();
-- 
2.40.1

