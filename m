Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9B782452
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjHUHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjHUHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:20:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9127C4;
        Mon, 21 Aug 2023 00:20:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso15464045e9.1;
        Mon, 21 Aug 2023 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602435; x=1693207235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUA014eiWMc0O0JO4ua0VCD3sT2u+1P98fzdR5PzPH8=;
        b=hrV6y9Y4dx8RklS/Z2n9y9X7NlJo6mGbDEDvSRy+dMOqGGwyvxJKHygvZ0NzxrRdyS
         i6zVfmR+JtTU9AZUy71gIB/Huf3ADcwTXtEhpDjUXrnixIR8EWqq8o/HCZ7TSxECw5qN
         VPYXOlyZr1XMSf+q7jS3xjXgaiGfO7mhcgIjKhkUlK++wPsVnVe/s37MvqGYoKpBPMMy
         gCmuLrpSR2vtAyBXECpEOr3BXyJuIbL/jLF00GmPCGdOalqIqyErcsqzUIKgbrnoudKC
         6nDai9ZzXQqWTOqg23j+tWuIenR1VnjpHsaPVsQ0vRDQIq+lrgW6ovEt5uSHYuo8+pBS
         wyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602435; x=1693207235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUA014eiWMc0O0JO4ua0VCD3sT2u+1P98fzdR5PzPH8=;
        b=VeFd7hVVIlRLAIhnxrUbKycubDOODQgemY1SlbCCuJ4ZMrn/KZUrhAQJ8IshATxUT/
         swIEHe0x11ERvcSom62lhlZCQk58un8Jgu7DhobcIYjA0wGVr7sWZAb/rsUTJW695s4O
         iS/gga2cy/vM7j4t4LVvNbRjhVnQdf32qZ37nBm5TCNA5AAeRw7lhJwLyqTl7aF5Bshk
         hDlvWL9QD0NMaBXkI6Rqsqu9Gbd7f9+hlNQREeeno3CG7QqsF3XuCmk9cn87la4FYtYm
         OlBjmiOBZfcopDYdFLUrzReAnyxXjlzP5xoL3fropA/oNkhsrZe8uFSQv3Y4qc4wamEU
         tXlA==
X-Gm-Message-State: AOJu0YwAMsV0KnSxADjIWDk0P8D8/qftF51REQ3zEyDuWApPYYQG6g/c
        JzUk/sSpLrxNjB0BSHb0pBiCqoFmxT8=
X-Google-Smtp-Source: AGHT+IE/heFB8YigTjGWNTnSsUs6UiPutLTuNhNpgXY36woxvXu5tPhC0sVP5RnWvOOyeuSSB9+foA==
X-Received: by 2002:a1c:f716:0:b0:3fb:df34:176e with SMTP id v22-20020a1cf716000000b003fbdf34176emr4110237wmh.31.1692602434677;
        Mon, 21 Aug 2023 00:20:34 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p7-20020a7bcc87000000b003fee6e170f9sm6975677wma.45.2023.08.21.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:34 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 2/8] openrisc: Declare do_signal function as static
Date:   Mon, 21 Aug 2023 08:20:01 +0100
Message-Id: <20230821072007.2698186-3-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230821072007.2698186-1-shorne@gmail.com>
References: <20230821072007.2698186-1-shorne@gmail.com>
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

When compiling with W=1 enabling -Wmissing-prototypes the compiler
warns:

  arch/openrisc/kernel/signal.c:227:5: error: no previous prototype for 'do_signal' [-Werror=missing-prototypes]

Fix this by declaring the function a static as it is not used outside of
the scope of this file.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 3fbf00330043..e2f21a5d8ad9 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -229,7 +229,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
  * mode below.
  */
 
-int do_signal(struct pt_regs *regs, int syscall)
+static int do_signal(struct pt_regs *regs, int syscall)
 {
 	struct ksignal ksig;
 	unsigned long continue_addr = 0;
-- 
2.39.1

