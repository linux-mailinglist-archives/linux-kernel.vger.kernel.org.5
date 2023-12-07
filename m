Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E069809281
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443915AbjLGUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjLGUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:38:58 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB11713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:04 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d226f51f71so12440627b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981544; x=1702586344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=Mn6cD47IEGNhYiJtgTi0Q/J42HOq51Rzpy9lsf1AA5BwEhob3wSOLyCoocML3DAXIq
         l7zLIztB116RuBHtxHVYsM5P+TtgFrb2Qxubla34kugzXgWtajUVoR7qXgPcA+o4yvcW
         eIkT2TMoZdFeUDW+HFKM4JIotiZ+3jWmmNMjGhj1pxLCfw1pOrbgfT3Wx9WuWOPkZopJ
         HWiAP09C2IJRrDA+KBWlEmDDWUYr2qIy383rF1/S2/jVBtUc9fDg63AHKK7lC5UsWU6E
         AdbIdXv9lpMiht8RLk4pmUN6f0kQVXqsPOyXWepQrRTw3S4m68LWHErWN2m6uM19v2lZ
         5/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981544; x=1702586344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=KN6Gxw7kIJeZAd49Q3LYMlmjydxPk72CVpOk/jkEgAhQjX8I7cYX6S66LfLwctejU9
         jjEfkweBE8k7jfIlHC4gVFsnr31eLCBRxF31yA6NBAW9N2VnvybqLf1krfVJo/H/W2Rk
         B4pHe0SNonp1gK8zDc0wlwXlbzpPvmP7imq2DPW+ho892vW8X7TDhLiJ0tKIhQi0Xff8
         MzmaHXBP/qhRlTYJ20R1aZQNZ0ekJ9puF4EG4TSu/J6nLTjMFoB8IfQSou/lFUH86Wtj
         oA/sGIQi/A8G8mrqYOOHyQX0bUvZdjA7TAexBx94mopaC1ZSv1uFa4znQYUkC8R+3lek
         1gpg==
X-Gm-Message-State: AOJu0Yysj9lsNjiu0NlEogAn4/cJEFZKEvgKafN/Vwb+A129aE9p0lDu
        lQEHqsdDoBMm1WLRMd6AZsY=
X-Google-Smtp-Source: AGHT+IEjxfx4/yblkVJIQxF90BhwSszmQgB/4/z8ZfVuRkbqovYnHwqDHbbqqMtSKVytphbLBzIWOA==
X-Received: by 2002:a81:574f:0:b0:5d7:545e:3bda with SMTP id l76-20020a81574f000000b005d7545e3bdamr2499373ywb.20.1701981543874;
        Thu, 07 Dec 2023 12:39:03 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id m132-20020a81718a000000b005d4071e3adasm144853ywc.57.2023.12.07.12.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:03 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 1/6] cpumask: introduce for_each_cpu_and_from()
Date:   Thu,  7 Dec 2023 12:38:55 -0800
Message-Id: <20231207203900.859776-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207203900.859776-1-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

