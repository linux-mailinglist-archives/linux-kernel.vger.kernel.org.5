Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0317D0963
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376501AbjJTHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbjJTHWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:22:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5E610C1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:22:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79faba5fe12so18715639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697786537; x=1698391337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwlyMPcz0zqeFoKpmeSvnyAhcAgahoPS/k2EPhyd9Ww=;
        b=JvsWy9tI8Qc+kx0cpzg5opF0cLQB/gDC9oFvHcduXBta5uGVSLbsXwSCq2fP5vNJeb
         3D3brFJrmwZc6Oo+IOYgkg1H3NSRtPfTmsgOZJh3yOvCjrxQPOq7DVzDPpbEj8r8I3nt
         ecHy1tlYv+2XEQgQ53XJD3NjC1fB0pFI1bTF2bqYaw3xKcGF6YgByZo1sClyAQhMBs5F
         Aopmuv8MfnQSuMWkhrMkmfuB3zChegJdZaL+fspKt6i+gTkyCOEnZpMRUAGPZym7EQ3C
         dztSkCOAu0/O71NnNFrjoAKpCtTDRXdBWmM+6YtqYYtcJRrhAwflLfKCOOYKqOvFwLPw
         G3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786537; x=1698391337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwlyMPcz0zqeFoKpmeSvnyAhcAgahoPS/k2EPhyd9Ww=;
        b=a9E59iyC2qf5Bp9F+VZID1+Q9HhVG8vWJNzXPH05/k14d0dV2cuopU0E/O2zAF6meb
         611hNGecI2tk1R2dxmGsFvMGHXMYpkm6x3E7W0hPJgGDVXLpe3jGfF3QU4iXaxe0fje2
         in8esEfeZJoeHgIrbIIFxrBmAQrXEN/6Ku8uBwjGJk0G+CCEIzrEFOpFplLQjAqg5WXd
         wmc6B0nrpUc4vfuCZLpcAwkXRaMvAFBgyhPjXdqmpI8Au5juJL+chVsFFAmy92Mdmnde
         m6jSa+EmDYQz1BUaOcmuMgf9EuW18MYMSrTHk4idCuTqvlFaTXhS2TcPyy1u5WZYOSct
         9TdQ==
X-Gm-Message-State: AOJu0YyOsABHjYLaL7XnSfpFDhlvTcsZoXDWnJjOEzvrkrWAYe8FCA5A
        br9UlW+RBM+Fad3A2wRRSTb5Tw==
X-Google-Smtp-Source: AGHT+IGxC63+68DtxcLP2NLHVLlq5o7kgQhRaiJb+wOy0CTSQu3yay0cbuJzx5Z+DRUCCNZLZovnkw==
X-Received: by 2002:a05:6e02:1748:b0:34c:e16d:6793 with SMTP id y8-20020a056e02174800b0034ce16d6793mr1508711ill.14.1697786537209;
        Fri, 20 Oct 2023 00:22:17 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.83.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a63f20c000000b005b32d6b4f2fsm828204pgh.81.2023.10.20.00.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:22:16 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 6/9] RISC-V: Add stubs for sbi_console_putchar/getchar()
Date:   Fri, 20 Oct 2023 12:51:37 +0530
Message-Id: <20231020072140.900967-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions sbi_console_putchar() and sbi_console_getchar() are
not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
stub of these functions to avoid "#ifdef" on user side.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 12dfda6bb924..cbcefa344417 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+#ifdef CONFIG_RISCV_SBI_V01
 void sbi_console_putchar(int ch);
 int sbi_console_getchar(void);
+#else
+static inline void sbi_console_putchar(int ch) { }
+static inline int sbi_console_getchar(void) { return -1; }
+#endif
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
-- 
2.34.1

