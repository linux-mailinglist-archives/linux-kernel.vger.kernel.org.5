Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F44767135
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjG1Pzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjG1Pz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD10449F;
        Fri, 28 Jul 2023 08:55:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bc512526cso327468366b.1;
        Fri, 28 Jul 2023 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559711; x=1691164511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+ccw4NZa5atLMu3PvWU3CwI2TXUxTCi4zdltIKSN3g=;
        b=ARajOChSPVav64iGhopmQ+8nKBr9w1b6PNunqIbKhFQmYug3HbMmKML7tFUcKNDAql
         8wkzm7ISP2STHyjKgjKxt9qn0FEp1DO0S26sPjEhKfRbGY95eUuu8BVgGsX2ULoWOK5J
         LStkmwMuYdYXxRLiL6V0ilniPW8osDGql14vP84IP2odVzePfjACtH8OnVOcnAgCTRYy
         eUf1j2xi2erzVvWxtUoSBCeLvcEbeX1pPFJ/MzjeY5GzjZCVWrZQZnNWvDt0S1Gk9dEm
         q/aIXYE1FmdAlsl30NQyYVNqB4ZBaDPWUhKdw2ccwO1yHDvDXAGiXfWD2jXiiWP4sLpr
         Q5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559711; x=1691164511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+ccw4NZa5atLMu3PvWU3CwI2TXUxTCi4zdltIKSN3g=;
        b=ZcLlnpaz+ELCp5vK/IfZ7qXEFz5Ew5UbUTGXjoCtyLHPSPTlskKkRNaNIdj8neE6M5
         zxUr8+xV4gcxNlt+/DWPj+yb5AFWRRx25ZFELDRNaznoGnwPRjlZlwbjgkTPcEt2vzGJ
         1CreEv7xKr7zI+5Grx/3dGDJKTf22pmJB0owf8RgQwULmbfc1oeW29S3JwTVMld+GBsJ
         kmOC9yNz4899INr/MjOtaFX7XTrQlw+5qjuXC1QKpZcuQf8kbbBUl746bAeRpDoHF6Wu
         ay+B4ff8tIoq6UhQPVFvmIl77CJZPTOw552uSMbD77A0sr0OcfGxq9BEtXqsKfrjQ8ZX
         xRhQ==
X-Gm-Message-State: ABy/qLarP9Lp3+0ElYJGlXdisBGlY24Ys6KTjgmPrLimAudeOwD9Sphz
        kPT0bnGpthRPhB4+z0J6zf2u8wa/qUHVZS4i
X-Google-Smtp-Source: APBJJlEeR+3rhByc7CZ4OLonk4YAfn6iwAoyhwI1CSG17F28XVhqAQ7Dd2rCgsc/WVQ0wSKopXcz/w==
X-Received: by 2002:a17:906:155:b0:99b:4ed4:5527 with SMTP id 21-20020a170906015500b0099b4ed45527mr2618066ejh.25.1690559711163;
        Fri, 28 Jul 2023 08:55:11 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:10 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] selinux: use identical iterator type in hashtab_duplicate()
Date:   Fri, 28 Jul 2023 17:54:53 +0200
Message-Id: <20230728155501.39632-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the identical type u32 for the loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/ss/hashtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 30532ec319ce..7df9640554be 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -137,7 +137,8 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		void *args)
 {
 	struct hashtab_node *cur, *tmp, *tail;
-	int i, rc;
+	u32 i;
+	int rc;
 
 	memset(new, 0, sizeof(*new));
 
-- 
2.40.1

