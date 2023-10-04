Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F967B8353
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbjJDPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243130AbjJDPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F503BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406553f6976so5071545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432469; x=1697037269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XZchuQuCBpXHMvu1aRqXWCThK6+yA7m0aHqniG2w4Y=;
        b=AVQg2khABC/Xvydb92TsrAVy365xGerutucR3ODh63RyfSat3Ue7Dz8ftA3Ba/Q2Xl
         9+KwaxnQjBsCBXp0c69x/hJSVcA3ZgJwm/HgU2F1KbbyaOvgxB13sN1QDtFIwiUl/nvH
         fel2WiY4oHeXCB3GNifmj+vDZsy/mc2CW7xGzRvKOe/YNA62jgF8m2mmUUkddFUEeoVv
         /2lETf7Mbgzouvtz2MjgX24FQYRWpG8SZDvPeNAlPS5cOBUOG7z8QIeIa9OnMuGkeppM
         JHx8NL5yTM73lWnPi+MUEO5aFaEiIuJPq9s7DZig2EsKPVVE0+NTsGcoNLAEohGv2ucf
         LUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432469; x=1697037269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XZchuQuCBpXHMvu1aRqXWCThK6+yA7m0aHqniG2w4Y=;
        b=kU1uXbRH90uRXDcn+2qeewEo/gt0nOHZlf/KierBomM/cRcw0oLd7Dj8Nh75UibHbf
         NGycUJkV13tvlfUB8BEuvpfhyHDQ6aXAgoIt803zL2QGQTfdr5L6dWlVpP5/gZ5OS59V
         BJVFJrFK4CejhnFT/Wn1Jf5oKh+Ny01fyTPFIPCilGP0kJLi2a0fwB+uBwmZOcn1B6/A
         lovSIKCT1Fcbp7G7jouwpT4ZDUWz4jI50E61wnvGbgaJcy05PSgv1FomadGz/Md7hrCr
         VDU3ImnV4f7kAkCNA4eJa2+8lkEilhR+JiA2Oh1xH8YntsDM4mliu3LdOdRs6Guylihn
         KF9Q==
X-Gm-Message-State: AOJu0YyKY1ixXqtWtdqGspt5u1JDqVncEZ3UOZRvZsC0wAenOsFxzOK2
        Lc6C1Hy+UXqMRbal5qBxAAPMkw==
X-Google-Smtp-Source: AGHT+IG4Q2hW86Ee6BeC9N9w7JEqQmTEfb41i7/dbiv3giwSTJXRvEPVJJOvmzWfwKCGM00ziPcFVA==
X-Received: by 2002:a05:600c:1d03:b0:404:7606:a871 with SMTP id l3-20020a05600c1d0300b004047606a871mr2610672wms.2.1696432469747;
        Wed, 04 Oct 2023 08:14:29 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:29 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 6/8] riscv: annotate check_unaligned_access_boot_cpu() with __init
Date:   Wed,  4 Oct 2023 17:14:03 +0200
Message-ID: <20231004151405.521596-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is solely called as an initcall, thus annotate it with
__init.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..356e5677eeb1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -645,7 +645,7 @@ void check_unaligned_access(int cpu)
 	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
 }
 
-static int check_unaligned_access_boot_cpu(void)
+static int __init check_unaligned_access_boot_cpu(void)
 {
 	check_unaligned_access(0);
 	return 0;
-- 
2.42.0

