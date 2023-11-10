Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229F7E80A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjKJSRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbjKJSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3F41B29
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:53:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc4d306fe9so1476265ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699635201; x=1700240001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnZ7OJ7ZO64iFks47AdcXTMyF5IKFy2leso5ma8wKRQ=;
        b=JmCHm9YBm0J7SOqdpbS6qgINro1fGCkULIj0iZt0N9xQkqbR394JMcTcXtdlLabpbH
         9gEVEEkgaudGmOsmHCMaR0EUeo4qEtB41L7H1qIwIg8H9pBT7fTV3PBJuZ40wYMUYrtg
         OA/dwpVKul2D4CM1gIX1nFMTJ4KTJeAUjrTxf7MEtcSvDsMyoX8l71X20FLswld2ysuo
         mRj6LRW/rM/mp5/igS+jFCFm3QTiV5qy1Fu1KxLVexZLYkXmVwh33OzH/Ov+5tTfHfnQ
         qFaxKEnXukCnJBwhyR0h0N9+wFrQQbqH/kZba4wxR+kumzhdysjJ0VdBSjxzMH0hVXK3
         JC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635201; x=1700240001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnZ7OJ7ZO64iFks47AdcXTMyF5IKFy2leso5ma8wKRQ=;
        b=ZKsy0PDMMM4uf7R86ttmh/Upv4ju5daULuxyXEjiDekPMKFMfUh/31mn/1xW9az3+5
         LM27d9L6QqoYvb+xnX8mblGer82G0HPHodnoxaVyOBtji9uE5X/JvLZJWnySDKMmEw3m
         dZgKMNYzMz02joYV6pbmqcU0dcbRYuPIfNpGTvs4xEe8Ehl1EEnkhmo5++lztm1Qd2oO
         Y7ACF63vuj0KiCnlqyKF2inc/JFpyOxXuK9nGTn9wnuIKTvF33r6JBGVTnPLo8Qe7qg4
         Shj02RC9pLCkRiOUEw6Oy1yOFJOKnMcSUm20CtqyoPcj5n+TLHswyPje59LoR8vTv6rL
         cYKA==
X-Gm-Message-State: AOJu0YxNYwerjGbwUzDLh/okqkANTedig2khIrI1o85C2N6iq2n9ra4K
        3HEeoAEWjnalMM+8LTIV71c=
X-Google-Smtp-Source: AGHT+IFHYwV0F4JTZH6DSsZIwf0T4sriqiKP0sUq3rDyhenXz/S4W6a730H/SWWCdixBagVdL5oI+w==
X-Received: by 2002:a17:902:e545:b0:1ca:28f3:569a with SMTP id n5-20020a170902e54500b001ca28f3569amr9149475plf.5.1699635200924;
        Fri, 10 Nov 2023 08:53:20 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9da42cd7dsm5584404pld.279.2023.11.10.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 08:53:20 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] platform/chrome: sensorhub: Implement quickselect for median calculation
Date:   Sat, 11 Nov 2023 00:53:14 +0800
Message-Id: <20231110165314.1559285-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZU3GbHTA3x19h2Zi@google.com>
References: <ZU3GbHTA3x19h2Zi@google.com>
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

The cros_ec_sensor_ring_median function currently uses an inefficient
sorting algorithm (> O(n)) to find the median of an array. This patch
replaces the sorting approach with the quickselect algorithm, which
achieves an average time complexity of O(n).

The algorithm employs the median-of-three rule to select the pivot,
mitigating worst-case scenarios and reducing the expected number of
necessary comparisons. This strategy enhances the algorithm's
efficiency and ensures a more balanced partitioning.

In the worst case, the runtime of quickselect could regress to O(n^2).
To address this, alternative algorithms like median-of-medians that
can guarantee O(n) even in the worst case. However, due to higher
overhead and increased complexity of implementation, quickselect
remains a pragmatic choice for our use case.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
v1 -> v2:
 * Separate patch series into two patches.
 * Modify the microbenchmark[1] to set n=64 and run 10000 repeated times.
 * Enhance coding style and comments.

[1]:
static void init_array(s64 *arr, size_t length, s64 seed)
{
	for (int i = 0; i < length; i++) {
		seed = (seed * 725861) % 6599;
		arr[i] = seed;
	}
}

static int quickselect_test(void)
{
	s64 *arr;
	s64 median_old, median_new;
	ktime_t start, end;
	s64 delta, time_old = 0, time_new = 0;
	const size_t array_length = 64;
	const size_t round = 10000;

	arr = kmalloc(array_length * sizeof(s64), GFP_KERNEL);
	if (!arr)
		return -ENOMEM;

	for(size_t i = 0; i < round; i++) {
		init_array(arr, array_length, i + 1);
		start = ktime_get();
		median_old = cros_ec_sensor_ring_median(arr, array_length);
		end = ktime_get();
		delta = ktime_us_delta(end, start);
		time_old += delta;

		init_array(arr, array_length, i + 1);
		start = ktime_get();
		median_new = cros_ec_sensor_ring_median_new(arr, array_length);
		end = ktime_get();
		delta = ktime_us_delta(end, start);
		time_new += delta;

		if(median_old != median_new)
			return 1;
	}

	printk(KERN_ALERT "Total time of original function: %lld\n", time_old);
	printk(KERN_ALERT "Total time of new function: %lld\n", time_new);

	kfree(arr);

	/* return 0 on success */
	return 0;
}

/* Result:
 * Total time of original function: 157561
 * Total time of new function: 1480
 */

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 62 ++++++++++++++-----
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 9e17f7483ca0..1205219515d6 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -133,33 +133,61 @@ int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
 	return ret;
 }
 
-static int cros_ec_sensor_ring_median_cmp(const void *pv1, const void *pv2)
+static void cros_ec_sensor_ring_median_swap(s64 *a, s64 *b)
 {
-	s64 v1 = *(s64 *)pv1;
-	s64 v2 = *(s64 *)pv2;
-
-	if (v1 > v2)
-		return 1;
-	else if (v1 < v2)
-		return -1;
-	else
-		return 0;
+	s64 tmp = *a;
+	*a = *b;
+	*b = tmp;
 }
 
 /*
  * cros_ec_sensor_ring_median: Gets median of an array of numbers
  *
- * For now it's implemented using an inefficient > O(n) sort then return
- * the middle element. A more optimal method would be something like
- * quickselect, but given that n = 64 we can probably live with it in the
- * name of clarity.
+ * It's implemented using the quickselect algorithm, which achieves an
+ * average time complexity of O(n) the middle element. In the worst case,
+ * the runtime of quickselect could regress to O(n^2). To mitigate this,
+ * algorithms like median-of-medians exist, which can guarantee O(n) even
+ * in the worst case. However, these algorithms come with a higher
+ * overhead and are more complex to implement, making quickselect a
+ * pragmatic choice for our use case.
  *
- * Warning: the input array gets modified (sorted)!
+ * Warning: the input array gets modified!
  */
 static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
 {
-	sort(array, length, sizeof(s64), cros_ec_sensor_ring_median_cmp, NULL);
-	return array[length / 2];
+	int lo = 0;
+	int hi = length - 1;
+
+	while (lo <= hi) {
+		int mid = lo + (hi - lo) / 2;
+		int pivot, i;
+
+		if (array[lo] > array[mid])
+			cros_ec_sensor_ring_median_swap(&array[lo], &array[mid]);
+		if (array[lo] > array[hi])
+			cros_ec_sensor_ring_median_swap(&array[lo], &array[hi]);
+		if (array[mid] < array[hi])
+			cros_ec_sensor_ring_median_swap(&array[mid], &array[hi]);
+
+		pivot = array[hi];
+		i = lo - 1;
+
+		for (int j = lo; j < hi; j++)
+			if (array[j] < pivot)
+				cros_ec_sensor_ring_median_swap(&array[++i], &array[j]);
+
+		/* The pivot's index corresponds to i+1. */
+		cros_ec_sensor_ring_median_swap(&array[i + 1], &array[hi]);
+		if (i + 1 == length / 2)
+			return array[i + 1];
+		if (i + 1 > length / 2)
+			hi = i;
+		else
+			lo = i + 2;
+	}
+
+	/* Should never reach here. */
+	return -1;
 }
 
 /*
-- 
2.25.1

