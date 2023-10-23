Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2D7D2CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjJWIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJWIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A4188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9e072472bso18124415ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049806; x=1698654606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFjJUDD1OgrURVFCNfyqhpsKd5+0kFPMkXoyM2g55XE=;
        b=kACoJMEKjIPMrZ4Kknmviad8kSSliwgMgQYkJPgoxtR6vhlBtJJA6uZN+aHqgK2p+L
         2QsN5+EsN/32NDecwdcuhWQfc39gw7samaX1KHnKlYMvVcz2ikw4fiMrdPt1dayKlxoQ
         uB1QTi/siS4x0+kubKEsBJF1mcPh/faReofT3PNNCO7T6CFUjvcT+gH5quZAEm28omiP
         nnw0H4yOBkvHz4q7/9nK+FhnExrxz7Ijh8VP4Iy2AJkHY+VdvaJu4tXFvdhEFgeHZi9o
         blgFvnwKOT8piy4+YxB4/0YY60Jg96rPt+XufaRWmb/PU9+ZhE9jcnWMEvDtOqHAJGt5
         Hc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049806; x=1698654606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFjJUDD1OgrURVFCNfyqhpsKd5+0kFPMkXoyM2g55XE=;
        b=csy5dY4RkgYOwAhuMdFElYp38jVRDLhIz8pZvfuTMheMaRzGrGIVIiMrtQy0Mn1+In
         o41I0WK64Ad8TIAFc0bJj9zlhWItvl1xnPnCmfk6Lc1ILWKfFcGHVxTMLXn0T6lrHpEG
         +NWU7LuUcp6rk6FKYEqTOzYd13Jo8nOF/AXHoiQGiXAyz3J4JM1/Ea5gF2qpNyzSXRtK
         t+4eoI2vC85f4BZQmkuXMNb7LYJxLa4IMK+2JJuhqH10S5hxGuNxiueBzrTObF2BxF8p
         Ysg7HqUNoTT9EXmrUfP2FZaGEWxtOy3wJvliRTx9UFjMmXVVbBFI7W3AykUdXjKsAvJ6
         ifZg==
X-Gm-Message-State: AOJu0YzUsagKoOuHjYmi0uXjXuH84t0/vP30oaOIPm1bepkF7IBCdEya
        +WdHsXzyIIgMlin7CwUoU79MO9yZcs6BknaKPp0=
X-Google-Smtp-Source: AGHT+IHxUbIFNlkoPGxo4yFGNIhvxArkkFh19bAzzG/qz3kZJnf4Ua56mvZKJnXAyEFXPQjbUdh3rQ==
X-Received: by 2002:a17:902:ecc6:b0:1c9:cc41:76e4 with SMTP id a6-20020a170902ecc600b001c9cc4176e4mr5988168plh.10.1698049806521;
        Mon, 23 Oct 2023 01:30:06 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.30.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:30:06 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 08/12] riscv: Enable NMIs during irqs disabled context
Date:   Mon, 23 Oct 2023 16:29:07 +0800
Message-Id: <20231023082911.23242-9-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allows NMIs to happen even when irqs are disabled. When
disabling irqs, we mask all normal irqs via clearing corresponding bits
in CSR_IE while leaving NMI bits alone.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 9700a17a003a..42f7803582df 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -54,13 +54,13 @@ static inline void arch_local_irq_enable(void)
 /* unconditionally disable interrupts */
 static inline void arch_local_irq_disable(void)
 {
-	csr_clear(CSR_IE, irqs_enabled_ie);
+	csr_clear(CSR_IE, ~ALLOWED_NMI_MASK);
 }
 
 /* get status and disable interrupts */
 static inline unsigned long arch_local_irq_save(void)
 {
-	return csr_read_clear(CSR_IE, irqs_enabled_ie);
+	return csr_read_clear(CSR_IE, ~ALLOWED_NMI_MASK);
 }
 
 /* test flags */
-- 
2.20.1

