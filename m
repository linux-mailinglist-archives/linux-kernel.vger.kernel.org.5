Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F97DE86A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbjKAW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjKAW6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:58:32 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629DC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:58:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a82f176860so4440097b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698879509; x=1699484309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=go9MsBs3kshTdYS1OGG6zGV5mB8GAcndMsaSv16whFQ=;
        b=fQxpOUk8Srjlzg4HEqBpyLixswTTIhhwCzxj5QIFaKGtvhlcwLkh5sytnhEKWLm/eB
         3MRC8CjKDfqs5UeKWsj7strLuxXNGeHDFOV36zcGnsv7kkj+rgzbzFyz5tTiQseALIs5
         3zxnVPC1yXdZ0Uqp4YtNiQuHUclrHz0VO+lvxkxt5alRiJ5VA0LMmvcYCRz9QGow+auA
         cfq43DXz/tb47WtKu/BonRARy1+W3OQiFozA/0uSztIVPFPilePaAB2KURCsLl7wewAh
         T2ceGlhMcqi76dHrPNFmZg3Ecy9dQPo8NpesApOGadIX1pa3vhgQ39WMmYkOjyOhDl+h
         i2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879509; x=1699484309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=go9MsBs3kshTdYS1OGG6zGV5mB8GAcndMsaSv16whFQ=;
        b=V8D+5ZbRPXV8KMwqld0skXDSNMuqIo2kKAqGQMDSfz5m7OL068bR50sIn5NF9SbDjI
         bojnzB8Ww21ULK4Puag456Xh7cyByP5btXtj8SzA40arEmOaNdZc7wiVIXgOCZDILzCo
         ydfnO9dqEb/Jrn8XnqC8M63UpRAlLY5ScbG7IMnWOkRjF6qPcF+pM+MSAUJQD2vZCfSQ
         D/1Un5hwkx5lf71SXD98n7hap0ykjGQrAz+jppAVJsb9XDm5bvgADkYbaispGKIp52HV
         oiidvqfmWLc13IEexwC15sbnQkWICEAme0s73nOEYnTY9dSHb15b1FhoEoRmhEQ8iPwV
         4H8w==
X-Gm-Message-State: AOJu0Yz7PsvHeED3OaJctZ5FF6zM8CPKnyXo1E8kRHHgFUfWb9uCzvyp
        r7WgXj6B6Qzg5IqyeCYcGm5QaNEi0iV81A==
X-Google-Smtp-Source: AGHT+IGMlrmxbbg/0TDcw6lZ7xsqd4YM+pVmk+kGMG6DsE5u8YodSHB8O1sE7YpeC9+FXpv0j3RBGw==
X-Received: by 2002:a81:ef0a:0:b0:5a7:aa54:42b1 with SMTP id o10-20020a81ef0a000000b005a7aa5442b1mr15615714ywm.28.1698879508881;
        Wed, 01 Nov 2023 15:58:28 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id u131-20020a817989000000b005a7c829dda2sm518469ywc.84.2023.11.01.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:58:28 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/4] cpumask: introduce for_each_cpu_and_from()
Date:   Wed,  1 Nov 2023 15:58:17 -0700
Message-Id: <20231101225820.51342-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101225820.51342-1-yury.norov@gmail.com>
References: <20231101225820.51342-1-yury.norov@gmail.com>
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
index f10fb87d49db..fc9f9d86229a 100644
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
2.39.2

