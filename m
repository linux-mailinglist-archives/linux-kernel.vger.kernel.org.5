Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927F780E347
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjLLEVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjLLEVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:06 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8100BC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:12 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d34f8f211fso51824747b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354872; x=1702959672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=KFhC6+sG0Yct0kbrjF8kru2+7eFqJ+jyWXZ8zx09j3ICTxS4R5J7BJwET1Pa/46csG
         hnRMJDSXiv7080WkfDc6oD1A/X11udEChsOy6yKF8zHOxxwLDWJ+4PXU1uYFbe0boYiu
         JrAgU1NLoRSBqsFr6LnH/vSq8GS/UgT8T6oP4Bd1Xd2VuDJ8Mw5j5KYJYjoI4vaN4bRA
         pAG80H6VUw012GJ0to3+X1f1CZp/Su8wdVIpOO9oOZVvIeFnSkH68VggVP0zVO3KAaKW
         2PTEZeMM5HZKdOpRt3hiwwCALimP6npekktcCWXVqav/Yx2IcJbGGoTTyoZ9EpgzsKIX
         Lbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354872; x=1702959672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=AGRkyAt5vj/8FP1pyssl/6GJS6vkRAaJqWQc/XxSRTnZdo/Ln/0iJDb0Eaf4l1YN6U
         UD4CMh3uXDnOIboXFjPE+WYPcKrJOdd1rkcJKqTvtoKwPZOcemUdF7nSMUBkln4lV0Ii
         RVuO5evz5i8UUo/GgKddX//hxvXyeoPadFEa+BupVTzilm6ypXUUjlkSCO3ZRpA82lmR
         7Ync0gjXAWqJf3G7dMqell+nUe42YngggrjvpaEW0Oeo7f20ajEWJjk8oMEcQB3KYEnF
         8WHQx38JHqBgwXThn8tpAlFdaEo6vqpPDP1qLY9u+d/a1RqJvtMEw6ozwfpjQwcoYdIs
         NH7Q==
X-Gm-Message-State: AOJu0YyzjVBQVdwvw1kHZfC98Mle2ZoVyGkIt/LShYc/NyvJq/S01Tbo
        bejMCJOAoIu8v25QX3BbaGk=
X-Google-Smtp-Source: AGHT+IEeX2Fjxhk9K32Om1pj9o6qab9oTQx/j4eXkeWOy5mqJJ0M7g6qMU7pyCHEVme7gUTFxZKbhw==
X-Received: by 2002:a81:8357:0:b0:5de:99bb:e94 with SMTP id t84-20020a818357000000b005de99bb0e94mr4783843ywf.5.1702354871979;
        Mon, 11 Dec 2023 20:21:11 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id eo18-20020a05690c2c1200b005e1764a7a33sm612703ywb.52.2023.12.11.20.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:11 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 1/7] cpumask: introduce for_each_cpu_and_from()
Date:   Mon, 11 Dec 2023 20:21:01 -0800
Message-Id: <20231212042108.682072-2-yury.norov@gmail.com>
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

Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
which is handy when it's needed to traverse 2 cpumasks or bitmaps,
starting from a given position.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 11 +++++++++++
 include/linux/find.h    |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..73ff2e0ef090 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -332,6 +332,17 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
 
+/**
+ * for_each_cpu_and_from - iterate over every cpu in both masks starting from a given cpu
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_and_from(cpu, mask1, mask2)				\
+	for_each_and_bit_from(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
+
 /**
  * for_each_cpu_andnot - iterate over every cpu present in one mask, excluding
  *			 those present in another.
diff --git a/include/linux/find.h b/include/linux/find.h
index 5e4f39ef2e72..dfd3d51ff590 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -563,6 +563,9 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_and_bit_from(bit, addr1, addr2, size) \
+	for (; (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size); (bit)++)
+
 #define for_each_andnot_bit(bit, addr1, addr2, size) \
 	for ((bit) = 0;									\
 	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
-- 
2.40.1

