Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B574F7D2CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjJWI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJWI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:29:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD21DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so3015102b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049767; x=1698654567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC7lpeLF6zJ2U1K9d3gKHK6RO2c15uLNrRvH89Y0oYM=;
        b=EgA7QFtiTyRVdMGiCGCgsrhZUC5LD1B6etQWLWgwXgHdvjpSJa+aWvlsQ/7yM+0Q8C
         +xy6om9MYlRelRiI9CAkL+Uk0NMl9Er5BenQHs6PXthbl4v5P2mKEbSdtBu5G+uGVgo2
         HqruKzYqnjweoAZG0ghGoeQ3gCanp4xy/KTRr7qjxyMVO/OW2EfR4Y5H1siQliUPBYkh
         70HLB8D7mR14EJrWIKLU8BrEwEwsYlIVVq+SWqmpjj8NY9PEL85qnyECZAjMWOnjx68U
         Qrkzla17YSfr7nqGYOl2jlD6hjOTLuZfZkhTggK1qzfcEdT2HyMIcU3G9Yz6xZLpcPUS
         tuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049767; x=1698654567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yC7lpeLF6zJ2U1K9d3gKHK6RO2c15uLNrRvH89Y0oYM=;
        b=jTzG76B4VveQz8c0/JkfMw3bHZzHfdtrYYGXtgd7GH2wnYbUhV2O9Vw531l7MijM0H
         FkStwogxVXG6GgGJ9rPY/ZtBaQXdjpeZO8zvKsaWvcRDymbqrbXRGJ+K1Fp3nwrMazvG
         00OefDb9cJFi8Rd3QCKGFQiY0zthzL9TKYnO1cy5ljzM9slkDmhg8Y5HhWsmVTKvTlyl
         reei8S2pnIGg1/9BlVQc8hRJZFknFT5BDgIo3ZJqjp1Chx6vibHQeO2/O/gNbMLM9wYF
         VbDFFrwjY9sWynpMQtUlGc3YMl+FCexxcnNxnoGvBQJm+Og+80MrzDhhvMfiraBfAoSR
         I7oQ==
X-Gm-Message-State: AOJu0YysldadpmPuQyXdK9UPUuu8J0GipwmA8oAqcrHqPYSS0WWbGt6p
        iZQy83Hzubfgfa4+HYalgHDUjg==
X-Google-Smtp-Source: AGHT+IHCH1nMZJNeGDEKv3u1kEAVWCuStY+cy0vOx97pHNcDM4nqv54AkAVkcpOIZIr2dvR9THZ/jQ==
X-Received: by 2002:a05:6a20:a108:b0:14c:daa9:5e22 with SMTP id q8-20020a056a20a10800b0014cdaa95e22mr10514808pzk.45.1698049766796;
        Mon, 23 Oct 2023 01:29:26 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:29:26 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 01/12] riscv: Introduce CONFIG_RISCV_PSEUDO_NMI
Date:   Mon, 23 Oct 2023 16:29:00 +0800
Message-Id: <20231023082911.23242-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a new config RISCV_PSEUDO_NMI to control
whether enabling the pseudo NMI feature on RISC-V.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..487e4293f31e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -669,6 +669,16 @@ config RISCV_BOOT_SPINWAIT
 
 	  If unsure what to do here, say N.
 
+config RISCV_PSEUDO_NMI
+	bool "Support for NMI-like interrupts"
+	depends on !RISCV_M_MODE
+	default n
+	help
+	  Adds support for mimicking Non-Maskable Interrupts through the use of
+	  CSR_IE register.
+
+	  If unsure, say N.
+
 config ARCH_SUPPORTS_KEXEC
 	def_bool MMU
 
-- 
2.20.1

