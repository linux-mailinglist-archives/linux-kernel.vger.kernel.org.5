Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F667B2A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjI2DZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjI2DYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:24:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4D11A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692eed30152so7283916b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695957881; x=1696562681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGhwDBPbCWZ00dYqQrvOzcYwuI2lZJAyT/mcJzKB6R4=;
        b=LBbDvMAFsckb9rUyXHqwSaILl/O7qwOMEa1WpTcI0yWM+HphH0M3TBPUXTKkQPxFTX
         RWOprcE0u0X9RW2kTpY/AM16ftw2JaHliTAJpqkbKyRtaqCT1Obx34OjAGHxo244ed2a
         xY0/LKVe8n4KrLnr2iBdJFZdRGrSl2rhKJ7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695957881; x=1696562681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGhwDBPbCWZ00dYqQrvOzcYwuI2lZJAyT/mcJzKB6R4=;
        b=FTmHR6bTcl2RWPT9FzE25VwZ00rYKP8DU17iTyn5MKdDeczC//358JRyWP3+SNRyzC
         HqNjD0PuZmKlrOWd53ZZoLRYgPlMr62/9G8JA4128M9dhdGOYm+GzDMrDpgMurulb417
         P5XHyVF4bMCPxCE9vhN84VuwunUbaXXAx479LN4ywS988Zc21mIPs4AUwPuAEsZYscxF
         IMaUyZhdOLg5YLAG9pSiG1wERTh6wB4IOrgxNBJ5MjKA5QGYO1Em/bEOm/21GLssOXBA
         KL5+ff1kYPE6slcfXodxLWQTu3B1hs8fW6vEhYierYUX2tsMuDgc95EfRoItLBH1MjX7
         m/MQ==
X-Gm-Message-State: AOJu0YwQiuLwUgzBvtK0ijeAfDwmh/yPxaBAsB/qW7ZYp7WEiLAe82ZL
        oC2+1qbZzdE9+Y2NnnQHIbrK5g==
X-Google-Smtp-Source: AGHT+IEefjdEHzDxwiSxbmO/u6TF6zB5AljlbT04olaKMdKQR8C/b8AJwKo7ESYTNvbBR3eWZ847tQ==
X-Received: by 2002:a05:6a00:190e:b0:690:ce30:47ba with SMTP id y14-20020a056a00190e00b00690ce3047bamr2938508pfi.10.1695957881184;
        Thu, 28 Sep 2023 20:24:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm14427552pfe.170.2023.09.28.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:24:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 2/6] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date:   Thu, 28 Sep 2023 20:24:30 -0700
Message-Id: <20230929032435.2391507-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
References: <20230929031716.it.155-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=keescook@chromium.org;
 h=from:subject; bh=G8gKivjP+bPsGdacm75CduzZVarN6sAt0dfrtCVUjtY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFkNx2BuLhX7iIAkgIu+LW3P3r4pxnZlwRaDRf
 vA/0AICBj2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRZDcQAKCRCJcvTf3G3A
 JpKyD/9/zd7E+5U1dJPLc6FAk+4qelFfCB75a77Kwxx0x/dnFrrOEedqqpaOK3ve3TybifJrVjE
 h8wTDDoxua66DT705EB1I4t9hKVj7ivb1dRVQdU3WehX4HAJzhPWJ7EtDjtX4AeM5D+Hf7hDpz4
 hfwpwEYxXXAs73zeYWM19Na85lFwu6nSgf/ttA5F2ewH+beQAvHkMQN6gO9tp95OrFyS1MZdXBI
 NrkU9qg/ruk3uLO2OsVV6oDaLOu79M+4Kf6narATryoLsN4PLTkC8vQrd2qtvfiFgrJMPpbfCn8
 mEteP/5U+mKLFaCYdxhauFlCzaPVAwvY9GsSaOxsm+ilLLoz76BgaZJ3mTlmC1hryS1DfX5TNYm
 BmEtiulolRPfz4jsO8ynBLlG9W3OMzNzN8tAFwtRv5C9pp0Y+Fp2Q4+kBwt72QGCQLH4GAe0o9t
 m4EhUZsGXS3t3VJlwU/3NoxBNO9bz5DuQRp5K6qTCwsnbFMQXMIL3xR1Vd0jwfPPrscAtd+3IlT
 pbesK8GLRSzYSy4YOE92dGY+Av5QlXCA+DMcppAI/si2TTqnM19+SkKDASB7HwxP2YQiCADAV3U
 67MufnT9YBLfq2RWMu1o2nR3+x4f5uWbDtEvSPRE7Ki8QD8I5Ldh64XqqxhTjKdmqEPIl7TvgC2 QoH6u6C/JkEFAwQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the BSS handled generically via the new filesz/memsz mismatch
handling logic in elf_load(), elf_bss no longer needs to be tracked.
Drop the variable.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2a615f476e44..0214d5a949fc 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -854,7 +854,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
+	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1045,7 +1045,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1208,8 +1207,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
@@ -1221,7 +1218,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
-- 
2.34.1

