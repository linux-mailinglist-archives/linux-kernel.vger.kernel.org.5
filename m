Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7081D7C6428
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbjJLEkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjJLEkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:40:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9218B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:40:13 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7db1f864bso6612257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697085613; x=1697690413; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+l9a+mEwNtEsZNHCdrwSvDlM5U4OjWSgjs4wg5g9aAk=;
        b=aTIhyDFWtoGp35tCDGdduIuAL0GUDGZXlYewKzVE/tUjVPLWuR96rCUK8wOGg0is9I
         nqrtXaJIs/EARoXiHEnukbaDHL8IXjMJ75ESnlS2WdcfXvN0O2CJV7jPZN+udbTamnRx
         6GdcZXKevQNNx/5KMNxIjgP4lxYE7p/vZoYgjdDPFRpEL3UKHYJZ8Hf5ipHOStcE5mT/
         DVZdN+9ug+L5h0ebgzokbjFzz/CXvA8mMnK4PnrgXVlx52piQuHX97jkdkdCrEfEFovx
         dt872NETiR2HqZyEsU9fmb9doQcsh7u7F0JxB771bbbAT8cxyyCVxTdLv2VU5I4Tsn1T
         fBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085613; x=1697690413;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l9a+mEwNtEsZNHCdrwSvDlM5U4OjWSgjs4wg5g9aAk=;
        b=LzbbqojfK4PHMaPUtiXpFjOUfBIiR555lQD0yt30NBsxTE7DstV8JQuYrmXdUtBW0p
         zP+0NM3QK1S0XyOdjjoAAPxpxcIgwZyJjYfAKHVr5yE86yRowqJwoZJxAjvsujsPNyh5
         Yp+Q6txzbJM6bYk2xGUUZG/vC9HbCOjxGLU20dkoNF8Nyw85ZJfJL8euHMNR4nw4FY4T
         Oc7QeBU1ejqjNVvtf7GC0cSeiffFyxjfDUkLKHkf0qHUEFpt43kiQgR48rqXSrsteS8t
         RNy+3riIj03j7F3O4l3Nn4ISeRAm1TOuvej+BAJAf73+3KtBKaPRb1gvePL26Ui+JmTQ
         nHRg==
X-Gm-Message-State: AOJu0YxPvJae8wKzM2PjBmX8mBRT6E4R90FoTxeA3UD3XJUdfiIP5IGw
        qx8d6zCUf3Or2mJU9lHBhyUZyA==
X-Google-Smtp-Source: AGHT+IEy29AB2gZVMxb+IATr0dLpEGj4Y9wZwZWi4zoiPAFB4Rim0MuDfZV+1buXtmaVCIwWelmNMQ==
X-Received: by 2002:a5b:285:0:b0:d7b:9d44:7574 with SMTP id x5-20020a5b0285000000b00d7b9d447574mr20855492ybl.64.1697085612762;
        Wed, 11 Oct 2023 21:40:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x142-20020a25ce94000000b00d89679f6d22sm1734993ybe.64.2023.10.11.21.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:40:11 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:40:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 9/8] percpu_counter: extend _limited_add() to negative
 amounts
In-Reply-To: <ddc21eb0-8fe9-c5c3-82c5-f8ac3e4a5a10@google.com>
Message-ID: <8f86083b-c452-95d4-365b-f16a2e4ebcd4@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com> <ZR3wzVJ019gH0DvS@dread.disaster.area> <2451f678-38b3-46c7-82fe-8eaf4d50a3a6@google.com> <ZSNGMvICWWaKAaJL@dread.disaster.area>
 <ddc21eb0-8fe9-c5c3-82c5-f8ac3e4a5a10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though tmpfs does not need it, percpu_counter_limited_add() can be twice
as useful if it works sensibly with negative amounts (subs) - typically
decrements towards a limit of 0 or nearby: as suggested by Dave Chinner.

And in the course of that reworking, skip the percpu counter sum if it is
already obvious that the limit would be passed: as suggested by Tim Chen.

Extend the comment above __percpu_counter_limited_add(), defining the
behaviour with positive and negative amounts, allowing negative limits,
but not bothering about overflow beyond S64_MAX.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/percpu_counter.h | 11 +++++--
 lib/percpu_counter.c           | 54 +++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 8cb7c071bd5c..3a44dd1e33d2 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -198,14 +198,21 @@ static inline bool
 percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit, s64 amount)
 {
 	unsigned long flags;
+	bool good = false;
 	s64 count;
 
+	if (amount == 0)
+		return true;
+
 	local_irq_save(flags);
 	count = fbc->count + amount;
-	if (count <= limit)
+	if ((amount > 0 && count <= limit) ||
+	    (amount < 0 && count >= limit)) {
 		fbc->count = count;
+		good = true;
+	}
 	local_irq_restore(flags);
-	return count <= limit;
+	return good;
 }
 
 /* non-SMP percpu_counter_add_local is the same with percpu_counter_add */
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 58a3392f471b..44dd133594d4 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -279,8 +279,16 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
 EXPORT_SYMBOL(__percpu_counter_compare);
 
 /*
- * Compare counter, and add amount if the total is within limit.
- * Return true if amount was added, false if it would exceed limit.
+ * Compare counter, and add amount if total is: less than or equal to limit if
+ * amount is positive, or greater than or equal to limit if amount is negative.
+ * Return true if amount is added, or false if total would be beyond the limit.
+ *
+ * Negative limit is allowed, but unusual.
+ * When negative amounts (subs) are given to percpu_counter_limited_add(),
+ * the limit would most naturally be 0 - but other limits are also allowed.
+ *
+ * Overflow beyond S64_MAX is not allowed for: counter, limit and amount
+ * are all assumed to be sane (far from S64_MIN and S64_MAX).
  */
 bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 				  s64 limit, s64 amount, s32 batch)
@@ -288,10 +296,10 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	s64 count;
 	s64 unknown;
 	unsigned long flags;
-	bool good;
+	bool good = false;
 
-	if (amount > limit)
-		return false;
+	if (amount == 0)
+		return true;
 
 	local_irq_save(flags);
 	unknown = batch * num_online_cpus();
@@ -299,7 +307,8 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 
 	/* Skip taking the lock when safe */
 	if (abs(count + amount) <= batch &&
-	    fbc->count + unknown <= limit) {
+	    ((amount > 0 && fbc->count + unknown <= limit) ||
+	     (amount < 0 && fbc->count - unknown >= limit))) {
 		this_cpu_add(*fbc->counters, amount);
 		local_irq_restore(flags);
 		return true;
@@ -309,7 +318,19 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	count = fbc->count + amount;
 
 	/* Skip percpu_counter_sum() when safe */
-	if (count + unknown > limit) {
+	if (amount > 0) {
+		if (count - unknown > limit)
+			goto out;
+		if (count + unknown <= limit)
+			good = true;
+	} else {
+		if (count + unknown < limit)
+			goto out;
+		if (count - unknown >= limit)
+			good = true;
+	}
+
+	if (!good) {
 		s32 *pcount;
 		int cpu;
 
@@ -317,15 +338,20 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 			pcount = per_cpu_ptr(fbc->counters, cpu);
 			count += *pcount;
 		}
+		if (amount > 0) {
+			if (count > limit)
+				goto out;
+		} else {
+			if (count < limit)
+				goto out;
+		}
+		good = true;
 	}
 
-	good = count <= limit;
-	if (good) {
-		count = __this_cpu_read(*fbc->counters);
-		fbc->count += count + amount;
-		__this_cpu_sub(*fbc->counters, count);
-	}
-
+	count = __this_cpu_read(*fbc->counters);
+	fbc->count += count + amount;
+	__this_cpu_sub(*fbc->counters, count);
+out:
 	raw_spin_unlock(&fbc->lock);
 	local_irq_restore(flags);
 	return good;
-- 
2.35.3

