Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3629C7FD909
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjK2OOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjK2OOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:14:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B85AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:14:14 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cdd584591eso499490b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701267254; x=1701872054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZXuNEt8EzwdILEA0pIWBrLgHEq+yqwXRZX9rymE92s=;
        b=G3JxyJNvVqEK7oHVAcCtqcQv4JRqZu+vxKS2DP8YLA71OstOUh6jsEr3RO8pUP68Cd
         Qdtxp6hdgFrrABUbTPr5/zpUnUJR3zVj0oWAOGX76xWVDfWfkX84l+fMGYAFqeea39gx
         vmiv0a5+AKyteLHVLfh0jhllDkYrvJOwjoKWbDmUd/fETR/BwN2RT9nJRgAP0PUvtFGk
         aITujdP+2dTuzI25yjWl1ZG2+QCjdRgCo5J0SECzRQnTPBiXrc7SmlTCTyFfzGt0J1F9
         gAxW0W9Sh6fgg2yCNh1N6VufWUdSk0srXAB6/n9XCsC1cUKd6+1CF7DxPoYdFP1Xoxs7
         gE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267254; x=1701872054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZXuNEt8EzwdILEA0pIWBrLgHEq+yqwXRZX9rymE92s=;
        b=chFyW7BPupQfs1sd/wV8wUJ9MvaGcHapP5S69L5W+Bd+lqmVrPGKyco02Gs/Qt+ED8
         dYyq9MahgBaYpJguF6YaXX7BjKLdkqJULYh7gRy3z+vDVyYafh4r0T4XNBb27ZGf1XEp
         X+/9BMfjlKjdXaZgzmP168UIOLwLod5UgAORkYYjPO0s3BPc+BajEWDwJ1e/XShQhYx3
         V8+uSVIPfojStutyio5nislF+d06qcofJ/zqL2ksSwJ3IY3AZYqiEsP68LDMo5016bIC
         pBROqwlxPzZnBtz2wCaGWEXXwiOVGdJz4f3Edjxlv5NMlQ5Z6MrzZc45sNNibYrEFELR
         OgEw==
X-Gm-Message-State: AOJu0YwCd04Yd47hoFd8cUb+tPTYSLFsvRKyMIm/GPJx4ID1FALyV9vN
        tbLjWXSgJRKSGfvAIfBp5Cg=
X-Google-Smtp-Source: AGHT+IED3WV/0Kaj9Z/l2QM10xfUl8BGi+qAxoNX9+D8fzOWxsS2qO8X6vNYFgamntrDo50jYS5o3Q==
X-Received: by 2002:a05:6a00:1914:b0:68f:f38d:f76c with SMTP id y20-20020a056a00191400b0068ff38df76cmr20158843pfi.6.1701267253608;
        Wed, 29 Nov 2023 06:14:13 -0800 (PST)
Received: from localhost ([20.205.105.33])
        by smtp.gmail.com with ESMTPSA id j25-20020a62e919000000b006930db1e6cfsm10831794pfh.62.2023.11.29.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:14:13 -0800 (PST)
From:   Jiang Yihe <jiangyihe042@gmail.com>
Cc:     Jiang Yihe <jiangyihe042@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] intel_idle: add Cometlake support
Date:   Wed, 29 Nov 2023 22:14:07 +0800
Message-ID: <20231129141408.21739-1-jiangyihe042@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Cometlake C-State is supported, support for Cometlake should
be added to intel_idle. Just use Kabylake C-State table for Cometlake
because they share the same table in intel_cstate.

Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dcda0afec..f83f78037 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
-- 
2.43.0

