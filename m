Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB50A7E0FBF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjKDNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjKDNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:47:32 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E9125
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:47:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a86b6391e9so35720217b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699105649; x=1699710449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRyo4uayRcD1OGB0/F9hU4wPpRqY3YBFvShQiftusTQ=;
        b=aDJFS3Pf3oowHLw6elukZyMOfBpXkaIhEgf3jyWGpUr/auFCGiSPrW2fwMEPzGOLgs
         rgVUv5PAycNB7EpLsZU0dvmy2kww1t8h0jd/lZZC8L7aOK41TQ69yYG1I3Q1/bXfq2FH
         wEEZIrSn8iuL7Ob6/u/Hfak1cRJ7RpcodusqZ9c9o7/yEm5B2c56zSyxLayo3LRt8tKI
         0HJG6Ckz8UmWky7dpbI1IvdCN6jEdJjNjwLQf4E2ONG9BhOZkRmKE3NlVK+8ORsardHQ
         Gej8eUfrM+8jvqwSj3hBhDkvf4O+Rf6/DA5jcAuwfEiY7myRMNqdJIK1ipI8ftLS/gw6
         PSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699105649; x=1699710449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRyo4uayRcD1OGB0/F9hU4wPpRqY3YBFvShQiftusTQ=;
        b=mA4Dt9P3Vsk0szJ1eTvY/Ppsr5JdJ54zzoS0H0bd2WdyQ8KltBp+ClIP6EFQCm8MuD
         sGffuBpufBbuBvwDll6xcN9LDVXa3yHj4X7aBming3zHwGScaxbgUWscrN9Z+PrCHqas
         vEpQd0nifqRWd7p3u7AglURrcjzS2/YnSxwzds07I2otqaD9FTduufQ2ZN8qqOlnn072
         CFcNCEIsHj1zGXaENe/auH6zsZ9WohMG0B287x4bm/IErMqebmC6abOBwqtPo/+VkkeD
         8lkLXQZCG3sTIgjKrYaOxoBarJ3ZRMVxxmiNUgggg5HPQE9agw/SB+M4DCl1IH1+QjXK
         hxNg==
X-Gm-Message-State: AOJu0YzlmFKTJ50jck0BnfuaiclxzWqSQPlhOpaN9+p/tvu2krz4+OnK
        aTXY50M5J+Srdt8LE9OvAvR4Qg==
X-Google-Smtp-Source: AGHT+IExWjX7G6DBFF4kwLIBDEgMe2CCFTXHC3Hx30D8yPn2WKmrR6jLGq4sGRWw1jQ8lSDpAO2cAw==
X-Received: by 2002:a05:690c:ecf:b0:5a7:bc78:81e7 with SMTP id cs15-20020a05690c0ecf00b005a7bc7881e7mr6540808ywb.30.1699105648902;
        Sat, 04 Nov 2023 06:47:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:580:8201:d0::c6a9])
        by smtp.gmail.com with ESMTPSA id p188-20020a815bc5000000b00559f1cb8444sm2088339ywb.70.2023.11.04.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 06:47:28 -0700 (PDT)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     corbet@lwn.net
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v1] docs: gpu: rfc: i915_scheduler.rst remove unused directives for namespacing
Date:   Sat,  4 Nov 2023 09:47:08 -0400
Message-Id: <20231104134708.69432-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused directives for namespacing I believe to have been
originally introduced as a workaround for a Sphinx warning.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 Documentation/gpu/rfc/i915_scheduler.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gpu/rfc/i915_scheduler.rst b/Documentation/gpu/rfc/i915_scheduler.rst
index c237ebc024cd..23ba7006929b 100644
--- a/Documentation/gpu/rfc/i915_scheduler.rst
+++ b/Documentation/gpu/rfc/i915_scheduler.rst
@@ -135,13 +135,9 @@ Add I915_CONTEXT_ENGINES_EXT_PARALLEL_SUBMIT and
 drm_i915_context_engines_parallel_submit to the uAPI to implement this
 extension.
 
-.. c:namespace-push:: rfc
-
 .. kernel-doc:: include/uapi/drm/i915_drm.h
         :functions: i915_context_engines_parallel_submit
 
-.. c:namespace-pop::
-
 Extend execbuf2 IOCTL to support submitting N BBs in a single IOCTL
 -------------------------------------------------------------------
 Contexts that have been configured with the 'set_parallel' extension can only
-- 
2.39.3

