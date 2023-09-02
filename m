Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD14790542
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbjIBFZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbjIBFZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:25:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937501A7;
        Fri,  1 Sep 2023 22:25:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso1967561b3a.3;
        Fri, 01 Sep 2023 22:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693632324; x=1694237124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKvseg8wBWK16cD/4ywynzJnBBsQpmVs8H/zJ8j4ZsM=;
        b=ZRvSiB/49q0TfmJsTO+jcPsYfmIxy5RY4nYAgAa9lkwjle65hUHQTAEDBFSZUDVMRu
         ZV1w9a4YCsh5Jl6ohbktKw0+IaM3Oeyb2EwB0bANyuRKLnZcmGPi01AFBSHWq7k+8yBm
         hElZD+HdxJYM3Xs2V3ZchNpVsLSpyDjKvnESY5ysgBjR+T5KNuhMgApfKibw0Eou1qtX
         /InU5iVawr7qJCuOIZ0N/mANLi82aae2SqUmpLVjH8AZ5dYf3vH+JAhss1jGjYW+k5lI
         Lvk/U+NZYYdtCluYcY08yM0EzFEGVVyaHCF//yppH14fOOA1vA1urQnksfICDLPtbdaw
         AQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693632324; x=1694237124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKvseg8wBWK16cD/4ywynzJnBBsQpmVs8H/zJ8j4ZsM=;
        b=H3hFBYUnJANx4wIBG6BMm2FCZZI1pUB6qbz9UXzE3tzGWfllJJ+xRAzmpaBS2m6ZPl
         FR1DXytsAPzYOsuBYoUTPEir1M/WvSxbJV05ZOzypEAjiobGkINkY/XFsyPPa4BvK6XY
         UhuKDFLCDd8fF0YR2Zh7ygNd/Mo0CbWK3Z8pGhBvR5tHZwv83fQpNfVYWZQYcsZ8AHNS
         BfhWEEZPxUsMgSM0gXELspxPkw9EDpepSaCu8nXtywGzHH+uIT63W6yesr3552uJ0zUS
         yAIZeUf6rnvqjpUlLMLRbLtI+DKBzqJ1X+LMYEjpw43NQK6x4VGN5HAekw4P7FDkXjUd
         xhYw==
X-Gm-Message-State: AOJu0Yxvh2jSJrsSri0aH7aUCHI9lFpKBXDedf6NgYsSsPULbGUtWmYC
        93ncGk2O/xEacsN+KS4ov/5iy6f70D8=
X-Google-Smtp-Source: AGHT+IExwU33ivUCrSAsir6j2BN+FUupKJT7xZ4I+UB4lhwk209uWEX3VxaSwcnzogrHXIH/rB6dyA==
X-Received: by 2002:a05:6a20:5499:b0:140:a6ec:b56a with SMTP id i25-20020a056a20549900b00140a6ecb56amr5123927pzk.3.1693632323950;
        Fri, 01 Sep 2023 22:25:23 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-250.dynamic-ip.hinet.net. [36.228.78.250])
        by smtp.gmail.com with ESMTPSA id b15-20020a63714f000000b0056c24c2e23dsm3708320pgn.25.2023.09.01.22.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 22:25:23 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        Hu Haowen <src.res.211@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v3 2/3] docs: sparse: convert sparse.txt to RST
Date:   Sat,  2 Sep 2023 13:25:11 +0800
Message-Id: <20230902052512.12184-3-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902052512.12184-1-minhuadotchen@gmail.com>
References: <20230902052512.12184-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow Randy's advice [1] to move
Documentation/translations/zh_TW/dev-tools/sparse.txt
to
Documentation/translations/zh_TW/dev-tools/sparse.rst

[1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 .../translations/zh_TW/dev-tools/{sparse.txt => sparse.rst}     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/translations/zh_TW/dev-tools/{sparse.txt => sparse.rst} (99%)

diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.txt b/Documentation/translations/zh_TW/dev-tools/sparse.rst
similarity index 99%
rename from Documentation/translations/zh_TW/dev-tools/sparse.txt
rename to Documentation/translations/zh_TW/dev-tools/sparse.rst
index 35d3d1d748e6..a6d31a20018c 100644
--- a/Documentation/translations/zh_TW/dev-tools/sparse.txt
+++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
@@ -27,7 +27,7 @@ Copyright 2006 Bob Copeland <me@bobcopeland.com>
 使用 sparse 工具做類型檢查
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-"__bitwise" 是一種類型屬性，所以你應該這樣使用它：
+"__bitwise" 是一種類型屬性，所以你應該這樣使用它::
 
         typedef int __bitwise pm_request_t;
 
-- 
2.34.1

