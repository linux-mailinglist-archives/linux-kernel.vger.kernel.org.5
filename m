Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B937EC9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjKORhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjKORhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:36 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC1D40
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-778a47bc09aso456269685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069851; x=1700674651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo9KuMlI56r1OXsGbX0xxREbBs5j59brj7SQCaFRmtQ=;
        b=YlSAaIisc2+Kwg/Dp7A1rbRAgvDK9SSM+xxXe3z603lkeapq1kA6CcUrsjwnonDDSC
         gl/I58gNoaQJy/tKlOsMgYKCycA4ZOVE19j0HruzQ/f13cDH1s7Bda1euCYhitcsAnyx
         WnelsdQKFAk7j0RbEiaxjJ60Jd+J6Nz8FzprbW89iH2iVnlly9kpU06I84xekpcPYXV6
         5dw9FTtTgzkb69HHWFNdV8YDb6jOnwPuKKNLH1UDWcfYpmImfRgrS92qaXxopiD5bIxn
         W9L9qOX/+aCeZ/rs8J7a/H96WNLPqzG88Fz+5Zyvp726WUjWtTh6TCnBYNiR0VEUrJnS
         0jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069851; x=1700674651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo9KuMlI56r1OXsGbX0xxREbBs5j59brj7SQCaFRmtQ=;
        b=vzgbJCVCYIJhutiodfKRPjIT62k31/rP9KODNbWxfmwoTJTHM8LfCkzLDxOaZiPnMH
         VetF9S6KLwqTEll5tA7ky7bHZhVKpApZoNIgGxyHL3ilu2sADkmhrmilmPJPPqmapoRr
         cvLyzA+R5tdc0l0jda7nXQQkPLjbwhYu6BsKTmgvebeasKuwbRc6eGHi2Uc+BQlg+OLH
         lRZeB1PEQx9XloGLU9CgpFkh5b9Qh1u/hFCsX+4T/UrMVAEWbt1iq5ZoGWYYs+kiEzI8
         AD6SA4J9ZnaLwgm+RgcqickBFoatw9DWV65iBoqaLitizYibgK7kaCljCL5l5tiPs9a7
         rjjA==
X-Gm-Message-State: AOJu0Yy0sbCpzCP/nt3wyH2tcBlHXyP6AHa28y7VaIGBcyR9xSVtuPbK
        bJZ9wrYBoPneDbDK+Rq175mYx7lfow==
X-Google-Smtp-Source: AGHT+IG+38RoeXB/vuqSBSQOs8a9+IbwMtcj+WJGDLZ5zqnhopauoG4E8yH6u5ucPa15J1tJkxzgxA==
X-Received: by 2002:a05:620a:8703:b0:777:ac06:ed91 with SMTP id px3-20020a05620a870300b00777ac06ed91mr5580042qkn.23.1700069851190;
        Wed, 15 Nov 2023 09:37:31 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:30 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 05/14] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
Date:   Wed, 15 Nov 2023 12:36:59 -0500
Message-ID: <20231115173708.108316-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
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

Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
stack protector location.  Treat them as another type of PC-relative
relocation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index d30949e25ebd..24ad10c62840 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -31,6 +31,11 @@ static struct relocs relocs32;
 static struct relocs relocs32neg;
 static struct relocs relocs64;
 #define FMT PRIu64
+
+#ifndef R_X86_64_REX_GOTPCRELX
+#define R_X86_64_REX_GOTPCRELX 42
+#endif
+
 #else
 #define FMT PRIu32
 #endif
@@ -224,6 +229,7 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_X86_64_PC16),
 		REL_TYPE(R_X86_64_8),
 		REL_TYPE(R_X86_64_PC8),
+		REL_TYPE(R_X86_64_REX_GOTPCRELX),
 #else
 		REL_TYPE(R_386_NONE),
 		REL_TYPE(R_386_32),
@@ -848,6 +854,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
+	case R_X86_64_REX_GOTPCRELX:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
-- 
2.41.0

