Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F07B478C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJANQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjJANQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:16:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DFBA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:16:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a9f139cd94so2053738866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696166197; x=1696770997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ0tDwQlRD6Ds2+VaCyIxp6VxUBqGS+A19FnDIU/GbU=;
        b=i2u356GhIprffm6YXVr6jVWf8UFEOvllXrTckigMg2VwOjqbjJgxATnqTQlCbiJ43k
         0Gi36VnVce1JPbccduU/eSnU777IkWpGksaVvvV2qrx1GcvFPtB/wS1bNO6n4e5o0fbT
         1bXvCpyxcQIJhYW/qH0ex2WkSBfHxhU8M0V5F8TpbfQ7aQ8GuouCCLs1xsmp9PorYAHi
         RYIoYDZ53fNr1fF4F9j5xoqSKNZl9OTqZXxeKycJX8tw1lP2umYwrJfmaJ9ca/uTIx03
         qeOo4h7IC1rA/Bj/sIg8peXIumL04uQyPdvpWM/ZBtJGMPFGf7qMSmD+LpXIL1QwcqRj
         hxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166197; x=1696770997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJ0tDwQlRD6Ds2+VaCyIxp6VxUBqGS+A19FnDIU/GbU=;
        b=TkV6bsdP50/uVp5o+1VDiTeqAw/b3CXiae5Z6AJRfde0eX/46nqwHhoR3FnoBJ/OMo
         A6W1yPjSG/EEnfyZauEmAG2P3x320ALUBx/4EZXSs7jkYSQoEnblMm+FeIcIHrzYOBCY
         57OulQJWSugm3oC/7XvwiNk2OhF01HtLdG1AkrDM8KrzSaVH0mQCDB5hqbZV/r1cwuVv
         Da985bCRf0O1Z6bG8ujy5jvfIQa871NIYfq/Va/bbX6AFzsGMQXOb8R01H8HCctO+X5U
         qaBfzO6YR43NrCwpm9iT1E9bZ/x7Fndlf8mNENBU1JK2b0IwRjgs9fVpZMqm7/W3lOdj
         BU/w==
X-Gm-Message-State: AOJu0YyoPBSBh1UuuL1Ij9D+TdX38Ec8UymlQ8AJ1Av70D3sNJ992adD
        ku+/nnFTtAr8GZuGPkp9f5k=
X-Google-Smtp-Source: AGHT+IH+iG2cmTsm7yj58wvz1hW5RV3lsVS1dxDNFVwQS+dO+T7ENDzoRDzdClCgFS6guYkEuEAWSg==
X-Received: by 2002:a17:906:210a:b0:9b2:b149:b818 with SMTP id 10-20020a170906210a00b009b2b149b818mr8574770ejt.70.1696166197218;
        Sun, 01 Oct 2023 06:16:37 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b0099d798a6bb5sm15504272ejb.67.2023.10.01.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:16:36 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH 2/4] x86/percpu: Detect compiler support for named address spaces
Date:   Sun,  1 Oct 2023 15:14:34 +0200
Message-ID: <20231001131620.112484-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001131620.112484-1-ubizjak@gmail.com>
References: <20231001131620.112484-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect compiler support for named address spaces by trying
to compile a small testcase that includes __seg_gs and __seg_gs
keywords. Reflect successful compilation in CC_HAS_NAMED_AS
and set USE_X86_SEG_SUPPORT to signal when segment qualifiers
should be used.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..f66fa5bf1f78 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2388,6 +2388,13 @@ source "kernel/livepatch/Kconfig"
 
 endmenu
 
+config CC_HAS_NAMED_AS
+	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -c -o /dev/null)
+
+config USE_X86_SEG_SUPPORT
+	def_bool y
+	depends on CC_HAS_NAMED_AS && SMP
+
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
 
-- 
2.41.0

