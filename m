Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A47E6CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjKIPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbjKIPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:11:25 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D835B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:11:23 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4084001846eso6370155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699542681; x=1700147481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pQ0K76qmBVGT/CgHVEv31iCSF419asbcRbCGaHbMy8=;
        b=HXmPIsyVZBhk7YQKAHvlH8qBF/pDdTeZNrusuKkTatH2PftRoNSSpbSpEQ0ijwxrTr
         /mg9CGrq6NOVwePi8gFMqBi7nmEXGE61ECDEbinCHIwW7NT3WIFV5LDNTxkmCd6t4aDx
         4VV1ARGOXREYXjvHag8m/qjY1Uyruggi7NlOe/4kVPReAGmcwdAKBmfDML8GEQsJymQ1
         2Oxxl7h5RAXOUvaat6HkAH7DqetYLAnYzH46NNcIke/tGgjwJmxMC5O3IzXn5hXs6sKo
         UOLNgjm1JxPUPJUwq0JmVgy0fbWMrRqWZygHanCHmkS8WkvZH5D6CpAYnup3J8TXJIUu
         pINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542681; x=1700147481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pQ0K76qmBVGT/CgHVEv31iCSF419asbcRbCGaHbMy8=;
        b=f1/0hRJDocHZ8YKciezKnHRtsLLAh6PaI4OWS+4MWiTtwkrgL4/SRcdFQqYW4iaEvd
         KBf++ChgtgBwsSkxHcofRAYZFIZuW/gRAJkzq0HgVhdx00znAAN2g/o0HRJZVWlOzHkE
         o56XMqpZl9/omfA7hxc5pZcmSSghEbO6BYkR1voGdSfZL6M3fv6fcGZDhtU5wLucd75c
         N88hlsz+LknKqSOwER2rrd2U2Do/p4b+/LERALmKFFZRM3UyfGAQBuOQApCjsS4ZP5tT
         KBw/ao4zCEO4ANBzXvmwO6v8VRk0ySsNjQx6qYqJ4PTSwRMJKBXdJufSfDXZMbB6Wbdo
         LB/w==
X-Gm-Message-State: AOJu0YzWkXgrburXIe0LMEGMy6FoNOLMueMpYXUZJo3qH+mLjz8uY9qN
        Qg83djkFP4HbhVxbdmlcWrKY02ZeFOk=
X-Google-Smtp-Source: AGHT+IE8K3FQIBkboGewhZkWrxz8SIQsGOaosh3E49HNMM/NkSBEmWFer7MvcowtiXDigjNNU8T+eElQX2s=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c5e3:4628:e996:9f03])
 (user=glider job=sendgmr) by 2002:a5d:6990:0:b0:32f:7cfa:a4e5 with SMTP id
 g16-20020a5d6990000000b0032f7cfaa4e5mr83401wru.3.1699542681487; Thu, 09 Nov
 2023 07:11:21 -0800 (PST)
Date:   Thu,  9 Nov 2023 16:11:06 +0100
In-Reply-To: <20231109151106.2385155-1-glider@google.com>
Mime-Version: 1.0
References: <20231109151106.2385155-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109151106.2385155-3-glider@google.com>
Subject: [PATCH v12 3/3] lib/test_bitmap: use pr_info() for non-error messages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_err() messages may be treated as errors by some log readers, so let
us only use them for test failures. For non-error messages, replace them
with pr_info().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/test_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 2761edbc83d73..8a8af5d28432e 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -484,7 +484,7 @@ static void __init test_bitmap_parselist(void)
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("parselist: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
 					i, ptest.in, time);
 
 #undef ptest
@@ -523,7 +523,7 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 	}
 
-	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
@@ -601,7 +601,7 @@ static void __init test_bitmap_parse(void)
 		}
 
 		if (test.flags & PARSE_TIME)
-			pr_err("parse: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
 					i, test.in, time);
 	}
 }
@@ -1357,7 +1357,7 @@ static void __init test_bitmap_read_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 static void __init test_bitmap_write_perf(void)
@@ -1379,7 +1379,7 @@ static void __init test_bitmap_write_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 #undef TEST_BIT_LEN
-- 
2.42.0.869.gea05f2083d-goog

