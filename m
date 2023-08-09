Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1B77665F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjHIRWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjHIRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDFB2136;
        Wed,  9 Aug 2023 10:22:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565439b6b3fso74368a12.2;
        Wed, 09 Aug 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601745; x=1692206545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21IzbhQ2qjGtr356saQ9/OyLk1G9ny5Nf5RhalLfvY4=;
        b=a6zpV1t5R1NQADr/jZIw4xflFyUDDEs4/PrW1oOsEYv66hRh/k422x3led/2UR7kxh
         6K9+LUccbmYVxgXAI9F+Q2b5Wyikw40lGuE3a7ozGyclMa72Nw6WxgC17xt24EhVGiQm
         +s0S+Y8dzcjQHFV66lZZ7SlY4EH2R5b+d55/WKXpPcwt6iJnHid5bGa1HXv5LGn5zIpM
         XHMwzwI/Oaxmz2jOy0VnHcLMD0BziK8hBhxK7dqGdevnwWUP0mjwWstRrxO7dFrRel+Z
         tsChzASA/kUArYAVVmQ2L9o7zdVu/RHzPQB7Zv1nGjMpKd+p+woWXZwUL+r2jJCASrP+
         dnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601745; x=1692206545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21IzbhQ2qjGtr356saQ9/OyLk1G9ny5Nf5RhalLfvY4=;
        b=dfcBRyGtEle7NPq5X8GKa8jOVjlg6L+DQZnOdE61mdcDsCUnOxP3aiMKKR5M3Ib0Ud
         fKML143C6DbG8hWcwRMTruGTuJU1c9Y159ngYGUmG2W1jnti1rU5gsZgW5QnSAC6kDzZ
         6KaBNH1n/+2VA/ngxb7IPtHJ2Jy89L9s9XAMdLX9DHtGmWb+2LzVlIhU5tPj7kErXr0o
         uHvx7/gdHjbowEjfGOmpVmknWpWqMplPB0K+NYGQ5sVb/dIAYSm7CKftfIOk4wIstSlQ
         /rEONIuyg93iqSVMB9aIARJrx69J8eAM5uzgQkjUS7vERgr87RGLY2oQ42qcePVS+hdZ
         hsPg==
X-Gm-Message-State: AOJu0Yw167hzKVXcXGHqeQU3Vp2idfdUT9egRU/DNFMPStcSR9p6aEr/
        69a/ed/CuGwZDARkpefcZ7dz8e4ivY4FvA==
X-Google-Smtp-Source: AGHT+IHvBwUV6GQxEpE9JPR10Mb4LwY+GRArhzuhC4WOHp0TymnHuJVTiQ83Tuxq8mT2NGFQiZWbOQ==
X-Received: by 2002:a17:90b:224b:b0:269:228b:ef6 with SMTP id hk11-20020a17090b224b00b00269228b0ef6mr2609891pjb.32.1691601745560;
        Wed, 09 Aug 2023 10:22:25 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:25 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 6/7] sign-file: use const with a global string constant
Date:   Wed,  9 Aug 2023 22:52:09 +0530
Message-ID: <20230809172211.343677-7-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809172211.343677-1-yesshedi@gmail.com>
References: <20230809172211.343677-1-yesshedi@gmail.com>
MIME-Version: 1.0
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

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index d3abc5721a7e..e8dfbdd3eea3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void print_usage(void)
-- 
2.41.0

