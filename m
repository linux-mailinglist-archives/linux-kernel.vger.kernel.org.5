Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D5809C05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573229AbjLHFzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHFzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:55:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E0171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:55:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d069b1d127so13126025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014906; x=1702619706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqG7sh4TEQnomN1Pb8iughMffScuejFKYmgaMeTCLmM=;
        b=OQ4gmhmBPL0W5BEgW+wQeXghXZv4uH3M9RVBmJrBXd23gYpG6UtKr30pzNrZRWvRLZ
         OeCByuJhUIYj9o7x0VgIP9JySXtTdl/un9zeWq7D5j6aFqeISRPeb89P4Znq8qbN7RT0
         NZKA4dCgx77EMwBuWvyMQkXcFdNib+PJDk0DBYRk5D1jGv+3+z3MwGFNzIMhK1Z4nqD4
         7Hnl+vjpCVMvPUTLEtPb+APMw7yzLFQ6mzVZL6Z4IS53yjgDAhn9r6t+gkrVKDeCWC0M
         CRnjvINgwKkAvBxH3QMZUtC0jWDdzhYZmSAdUUoWVmlBJ2g2R7Gy9pvn1RbHjqUjXrjr
         oeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014906; x=1702619706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqG7sh4TEQnomN1Pb8iughMffScuejFKYmgaMeTCLmM=;
        b=dUtSQMSpZ+BIxMkChpxlGnflFncWas38IaWf3PIJQwwXqvRXIc45R/+LJ2/zmSmhEN
         5fXSqeNKOFRtsKEGGcJYOdCknwy0QPlp/+cvtyqIBkSpXC8KKJMYXEQfTIazs4yoe5rs
         nY4ez1Q2AUZxYEhaRXS7brXu/KvbYggybv34mXdE6gtevZXh+6/gmvA5k7zNYAx+dFlu
         PvOJ7zRJwR17yoSxlw0jSkY59RomdCM6lNnJyeWBfcF2+BJkwUkiE1Q2bQk3kOQA6lpN
         z4zirYj9F3J10c+3PciG5lHNf1rQ5DBVwj1OdqtT+ZKUMrx09oWPJgEIWMsHZnFgY2TI
         Wung==
X-Gm-Message-State: AOJu0YyhzyL6JYhJCXm9CNxwP1ABB/r3gf4XPgpArUynDNjLaR05QaeD
        mhLgBmkYsYSvadElHb4ACWqU0A==
X-Google-Smtp-Source: AGHT+IFmoFC5Jy7QDutaZzebMhgROVCbFnFB+FkSDZrKf0b9QQV81pWWj0y7Aq09xAemAJ7UXgVmYQ==
X-Received: by 2002:a17:902:ee45:b0:1d0:6ffd:f205 with SMTP id 5-20020a170902ee4500b001d06ffdf205mr3064563plo.91.1702014906581;
        Thu, 07 Dec 2023 21:55:06 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:06 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 03/12] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date:   Thu,  7 Dec 2023 21:54:33 -0800
Message-ID: <20231208055501.2916202-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/arm/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..0ca5aae1bcc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,8 +40,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
+  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
-- 
2.42.0

