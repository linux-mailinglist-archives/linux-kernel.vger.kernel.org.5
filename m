Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA797FFB86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376541AbjK3TkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376533AbjK3TkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:40:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73493;
        Thu, 30 Nov 2023 11:40:26 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cde4aeea29so1115887b3a.2;
        Thu, 30 Nov 2023 11:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373226; x=1701978026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu5h2uK3efWNzQSn40V3SLhhxDZPSFSFXXaEbLeDNVU=;
        b=YmkUr7hK8s3vKG4KyUdq9tGqrt46SJDxlPgYzC+2ms5s2fZF9FWemm9CzMAtnpLXoj
         mSwp9VE+vdUXycehX5skKznJpO4laRlGBOqbinPTZsvLNUFu1yZc8wF8kAyk9Bq1yZrQ
         TTxItInlzYR8UYV+FX+RC9ocTSt0pFzhotTI8ZS83uyATDdcGciJf0AdBHshk/IVqltY
         OqbE2S87hUTyTkc5Rhldg47vOrr+wC0geKef0VY2nL0d8hLTGR2y3HeCJ3RcZliugPPt
         9hXbqRZGekh90PpyRYLwNk2Z/kHzUq+ocpF5wshETJXuxACdGRkb0S6f0mSZdQPWyw6Z
         yCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373226; x=1701978026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu5h2uK3efWNzQSn40V3SLhhxDZPSFSFXXaEbLeDNVU=;
        b=mar4BOaKoN/HTjRRQqjI1q+81QdsCvVk1FBWDZ/vx0ue44OxKyiVDgZFA/3A6YtwcR
         4XxV+X+2hn2xijht/8psoHN5XGSwAq6WI6OGUomBOydGG5JKxG3nwXTMMC0VE5JHX7r/
         sr0UcCq41U1xCbfR0r/qJGB4NPKDYEThSsGlSmOLJkQrjCxH4MOkScMXKhvhsuekEYEW
         NWece3HhA66MOj/ggmeNa+D6z1hOOmUUnXChxffhFJz3DCe50F2fnL/4eHh7aySgvj0p
         eJ5/MpsXEut7I2IMaD7w0IVAJ+V0moXsr1nkSbpqBizCifombBiKxX4wmd74+xPoxIsh
         cDYw==
X-Gm-Message-State: AOJu0Yz0QLF0WL7Zu7dAkpB20JT6LBAmULUUCoiIX3eseay2p5oNP1LR
        q+4b0Hq/cSAJVk5DldG3od0=
X-Google-Smtp-Source: AGHT+IHAYv2QywW+kJu67uQmw9fkTUq5k9I3OqO0/TQg0O7WFleUTQj+azK6qIpJqRZiFpj/7FBacg==
X-Received: by 2002:a05:6a00:1894:b0:6cd:eb43:f1cd with SMTP id x20-20020a056a00189400b006cdeb43f1cdmr2816622pfh.9.1701373225625;
        Thu, 30 Nov 2023 11:40:25 -0800 (PST)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b006cda62f118bsm1593501pfo.60.2023.11.30.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:40:25 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
Date:   Thu, 30 Nov 2023 11:40:19 -0800
Message-Id: <20231130194023.4102148-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-1-nphamcs@gmail.com>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
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

This patch implements a helper function that try to get a reference to
an memcg's css, as well as checking if it is online. This new function
is almost exactly the same as the existing mem_cgroup_tryget(), except
for the onlineness check. In the !CONFIG_MEMCG case, it always returns
true, analogous to mem_cgroup_tryget(). This is useful for e.g to the
new zswap writeback scheme, where we need to select the next online
memcg as a candidate for the global limit reclaim.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7bdcf3020d7a..2bd7d14ace78 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
 	return !memcg || css_tryget(&memcg->css);
 }
 
+static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
+{
+	return !memcg || css_tryget_online(&memcg->css);
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
 	return true;
 }
 
+static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
-- 
2.34.1
