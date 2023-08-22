Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F17848AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjHVRtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHVRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:49:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E7CD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:49:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3c55532fso1914785b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692726544; x=1693331344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjhjUhDDffkOIUaZDJIu5PrTOrHAFrTP4TrU/Wpefq0=;
        b=IljsDgrISbgSERcWxlAwIMfYZ/0cSg9rQLJSpMlXud+ssJK7urVfIOeX92KgfkqQ9+
         Qro/WVUCsjbbScLCXco5FhRWVuxOGVaKeT07QM4JO09n60XuHx1Q391GnnRwbMEhY48u
         pRXHgQxT9vNRyMSTHvVjm1eJqkpj/V5KdH8Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726544; x=1693331344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjhjUhDDffkOIUaZDJIu5PrTOrHAFrTP4TrU/Wpefq0=;
        b=T77Cgp+xj0mqtSUU/iXfX9rclawNcqkGrB/Ba2tKGC9v/0WHfSrp0BzvQkDbVNtyEu
         SrY33T0sewZYUqVK+0g45D0k30ZE5xW/mSegsp2Hljwr+ndDvrDdkflj4oVOY3eUclq1
         h+JOWDHZzWH+1HrlRKjkH9GeuVROA5tZ1aENADvV9f4zMPd5IiXJLurdxKk2PdCKXTDZ
         isLtpyZngCWsIm740wRzb0riQHOPmHpyjhMeGpdtdzKxGbmzTw8GcoyJSFvMxoHg6c4n
         BDMKZZSuRbKhj5hm8jRoEFMFhhUehUGi0yVZVsxG0QZChNNz2NgaIQN5ryUbFp3CYTVq
         BlrQ==
X-Gm-Message-State: AOJu0Yz+KyN5oUfDwiyrlX1WfE1vwWf4BTWMs6byjV4VYpLUBGGcsJki
        b6r9aePi0A21KfabbZdXSpnPvg==
X-Google-Smtp-Source: AGHT+IHdnPPtB09/YhHDM1CEZhegP+sfv2Vtsp194uiz+xZX2iHZXkAcgQ1rKhQ26Db+dyAQ9YbnTQ==
X-Received: by 2002:a17:90a:db08:b0:26b:3f10:820f with SMTP id g8-20020a17090adb0800b0026b3f10820fmr7055221pjv.36.1692726544092;
        Tue, 22 Aug 2023 10:49:04 -0700 (PDT)
Received: from localhost ([2620:15c:2d3:205:cd6c:a3a2:6d96:d21a])
        by smtp.gmail.com with UTF8SMTPSA id a17-20020a17090abe1100b0026b76edd607sm8222696pjs.15.2023.08.22.10.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:49:03 -0700 (PDT)
From:   Denis Nikitin <denik@chromium.org>
To:     linux-kbuild@vger.kernel.org
Cc:     denik@chromium.org, Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2] modpost: Skip .llvm.call-graph-profile section check
Date:   Tue, 22 Aug 2023 10:48:34 -0700
Message-ID: <20230822174835.253469-1-denik@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822065256.163660-1-denik@chromium.org>
References: <20230822065256.163660-1-denik@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.llvm.call-graph-profile section is added by clang when the kernel is
built with profiles (e.g. -fprofile-sample-use= or -fprofile-use=).

The section contains edge information derived from text sections,
so .llvm.call-graph-profile itself doesn't need more analysis as
the text sections have been analyzed.

This change fixes the kernel build with clang and a sample profile
which currently fails with:

"FATAL: modpost: Please add code to calculate addend for this architecture"

Signed-off-by: Denis Nikitin <denik@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/mod/modpost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b29b29707f10..64bd13f7199c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -761,6 +761,7 @@ static const char *const section_white_list[] =
 	".fmt_slot*",			/* EZchip */
 	".gnu.lto*",
 	".discard.*",
+	".llvm.call-graph-profile",	/* call graph */
 	NULL
 };
 
-- 
2.42.0.rc1.204.g551eb34607-goog

