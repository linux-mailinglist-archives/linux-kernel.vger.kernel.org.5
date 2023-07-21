Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703E375C33A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGUJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGUJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A202D46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e3b15370so1244631b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932483; x=1690537283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj8dA1DktttqIwOcB9+fhQ+T0lm3kSZr4JIH2/qzqQA=;
        b=ppSdeh1tc7/xXjxPCMvsSLzFw8TMUJ+nxHU66ilqA2uJIXDHmUOzyl4Jhi3/j3Xxkn
         bfZ9i1cASnTa6Yxxl+HjKVYqZiVFA8lTf45yyrSB82n+lGi4ucYK86AjQwwnI3NAL1gc
         GCVmCtXOjB1m8QAo63HIFFGB6JNi4DTzyY7AYQ09GWX/PtG2JgDmxbUtMpZKYuQGUTFa
         IK9CQ6hNGTlmVIwjvsYyzE5+2fQpNDBZTEKESutobnEaknXcJf1MXkJsifXubACig7YY
         XMIfHP/45X5v3I6GkyI23Zf8bkcFIyc6ULojKi8BtpAi3D2RAYyj3SY39FOZmJEZ9VsX
         0HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932483; x=1690537283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj8dA1DktttqIwOcB9+fhQ+T0lm3kSZr4JIH2/qzqQA=;
        b=fHOE/4sT7AH+oT1yvAqaG3RUcEN+dK+zNQAMyV1QGjHZwrsQnlGuG9QVYcGM0HMJ5E
         2HjAb2Hw1m+FJlQXbj8qDKMqlVSrCthjHb2h46mX++dc7ByiIAWE5ziJEJom05TmjsV/
         GMWWz69W3yg/LRZAqXfiWQIQaviFM9qUDeJmKtcRV8n+r7Rrqa+FBIIdBlXFk7EvLxtU
         vegireQODcMooKA77xcrwmMZCwyu5Rg0bCy2TrvfBrCw/CPux3anvfAfwuUiovxiSysg
         SydUbuGKqDKeeDyad0pCJNfJF8vxPY70WudjOjsRe4aXqJXvMCs6nnhWcPrdd/3Lyuuf
         k+lg==
X-Gm-Message-State: ABy/qLZnF1hPFFSrfq/ienRC1Szc1AboX6n6Knul1CaZDK/7b5t1YbLO
        +kwjjvbw/PECZH/vE6JfsYKrRg==
X-Google-Smtp-Source: APBJJlE+Z+Q/a/hBNzBPrnIj9DIFZ6m3Wrxijt1nY+kqHYntfPBiUWs0s1pC4fNMKmMdjmCEHnjM1A==
X-Received: by 2002:a05:6a20:b715:b0:130:661c:613d with SMTP id fg21-20020a056a20b71500b00130661c613dmr1069627pzb.5.1689932482813;
        Fri, 21 Jul 2023 02:41:22 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j26-20020a62e91a000000b00682ad247e5fsm2634011pfh.179.2023.07.21.02.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] OPP: Add dev_pm_opp_find_freq_exact_indexed()
Date:   Fri, 21 Jul 2023 15:10:57 +0530
Message-Id: <852a47c0e7a795bdf6424519ab7fadfdeb5b4a3c.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indexed version of the API is added for other floor and ceil, add
the same for exact as well for completeness.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 +++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 00638d40353f..7b1d5724b3d8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -648,6 +648,34 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+/**
+ * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
+ *					 clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	frequency to search for
+ * @index:	Clock index
+ * @available:	true/false - match for available opp
+ *
+ * Search for the matching exact OPP for the clock corresponding to the
+ * specified index from a starting freq for a device.
+ *
+ * Return: matching *opp , else returns ERR_PTR in case of error and should be
+ * handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *
+dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
+				   u32 index, bool available)
+{
+	return _find_key_exact(dev, freq, index, available, _read_freq, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
+
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a13a1705df57..23e4e4eaaa42 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -124,6 +124,10 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
 
+struct dev_pm_opp *
+dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
+				   u32 index, bool available);
+
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
 
@@ -268,6 +272,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *
+dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
+				   u32 index, bool available)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					unsigned long *freq)
 {
-- 
2.31.1.272.g89b43f80a514

