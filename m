Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A057F6CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjKXHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjKXHKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:10:39 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3A10C8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:45 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d648679605so839850a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809845; x=1701414645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=R68KGrbIaJYIomN32UdqqUn6UGU+BEMrtCUfuRHxXdoUKL2fMqMf9znVGzX5FLsrEh
         Fne0BMUwWty2fL9+gL5NtXSPWQhCaY5jmmzKo08l41f5YFlDgcb9dZJCH/4xUxgcPSSa
         0o3z0Kiwkexmbb+uLKr9OpZH5RIOlfs7WiJiVYbMp3ockTRLnPP+0sU23dQASxpaIiJc
         6W+GeYgZtbxK5cCw7F3JBcoG1aDSdb7/qFciMrHgXui8NWCHhiiaEVePSfSM9LLxj0f7
         gEgDBttK3v2BUWIgzXD+MDirlFkOC7brQG/Mz/JCpJPD3RIgYKG2Q1q5IfwmN0IuYVHH
         6j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809845; x=1701414645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=art9YUgKYpPufk7vubhh+2++jw2FkDXvM2Kz0Q00cj9x/q39C7SRG72Ve4Rdq4aPgI
         Xg1bDrgUM4ZQ3scVHbLOxNUpeiYgKfBYogBA+AZMpRY0ywcEOBTa3hfKwcZTyou9rYON
         Z7Rfg7rpP3VP1LPaftjhT8M/lwAA8ztPgQgOSD6ZLRt9B1XRxOerY2bfjt45QDtISMvC
         VhYFnfZVWwsZ8Eiyrzw3q8OL0zIktz8cMucnA+lzxEyA8i+VBYL/XcmL/ACmaYBPHObF
         sTrEzTbo9C+E9ibDXmwhC4gH5s7DIHEJ8DasxNt56pDMedcqeJCZjEAHcBSAGWtIaoAn
         JprQ==
X-Gm-Message-State: AOJu0YycD/jcRk5gg64xEB0Vxd7g/QvaTAoJulzX8gLYaLE7a4JyXbgQ
        fi6Tc8Zr2laxQTi7jWpthrGdhonvQ5A7UsalgoI=
X-Google-Smtp-Source: AGHT+IGGDyExhQ3zRmOy5VYh2TdS7wOyXrHh9UCot+XT8qVfR5TFj+v/PJ24bsMRy6r+bIsB3Xrfng==
X-Received: by 2002:a05:6830:18f1:b0:6ce:4035:b801 with SMTP id d17-20020a05683018f100b006ce4035b801mr2096169otf.13.1700809844751;
        Thu, 23 Nov 2023 23:10:44 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:44 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 5/5] RISC-V: Enable SBI based earlycon support
Date:   Fri, 24 Nov 2023 12:39:05 +0530
Message-Id: <20231124070905.1043092-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let us enable SBI based earlycon support in defconfig for both RV32
and RV64 so that "earlycon=sbi" can be used again.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 905881282a7c..eaf34e871e30 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1

