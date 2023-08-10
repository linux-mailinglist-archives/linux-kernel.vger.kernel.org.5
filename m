Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5E77754F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjHJKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjHJKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:02:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503130F1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:00:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so6074505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691661633; x=1692266433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hyWCQj1VFZir0J5tFHC26PNMN8Fpz4TbDRq9ePuNQVk=;
        b=Fem+dpFTOLkPoQ/HYBycK9gwX8nreVFMvVy+LkfhbeFACvnT+iJNaiRq3msCN7swqQ
         EPGI/MgEFWLETMIdCcXeFoWdr29aS3RYqOFyn8dG6I2dCYMiCttBWj5OPTtlG+jiBzwt
         1tkoBZeP9vdz547fc+4fZw1Jcm5ZnTjSPeUnQOxYMkNNyVohkW/70wDfHmsaIRyHt/vK
         y/hSbE+i8HfrOq93J4kzI0P0vAPvJVvaJGYFb7ydyVgDxyBlTGt98/VTWJYnv7aL+xLv
         uQ8eZ9Itf8vqiVKzisMvlnRSF+Hx6X6XvG6vVuOQlgzSHz0GumlQ08iEhEQsHQGKvCZ4
         A/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661633; x=1692266433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyWCQj1VFZir0J5tFHC26PNMN8Fpz4TbDRq9ePuNQVk=;
        b=agC2/btxVPwjejqyEtGc67UtUXOH3ujdaijQEJtWurLza04scDBKuxxre8WVgDttHE
         YNPFMMN8QLkMWbhhYtoLYKIol3oJXa5vNwb9CL5eM65JgO4gl5xr9Oars5rG+XzINKCT
         9dTbFHhR1SZ9e9Rn7nX1Duja912jFNDNbOsUShYmqrQwppUvHpjC99z609b/Qd+zGsRh
         Rg3BPClj5swQLrlh8eVWoGht5aNaeJENT5jT0nMIpi69QwU0T6ojsIRdAba10yOB3JfY
         GiRs1sgkit9Qw4+e2CmhMrMTFHpEHKwuSnch4UWX81LgqUIxSJ34i4aHgfKwbMH6JySg
         2szQ==
X-Gm-Message-State: AOJu0Ywz4xV/e0UhCcf1eUMo4UOXAY3NJq/SNxbXfz3O+BwhaSeapcBI
        LiDQQkP6rPuKnWQqXndpz6A=
X-Google-Smtp-Source: AGHT+IG0LVLrBCzof/Mtv/16PkPd+YZm+kdJ67WwSPcGLdrHyiQzDZkhr/1qilHNNTidxyDgFC/efA==
X-Received: by 2002:a1c:790d:0:b0:3fb:ffa8:6d78 with SMTP id l13-20020a1c790d000000b003fbffa86d78mr1419067wme.36.1691661632954;
        Thu, 10 Aug 2023 03:00:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:bf0:119:1769:73c:3a5b:50c8:ae3e])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003fe11148055sm1640762wml.27.2023.08.10.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:00:31 -0700 (PDT)
From:   Max Ramanouski <max8rr8@gmail.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     max8rr8@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Date:   Thu, 10 Aug 2023 13:00:11 +0300
Message-ID: <20230810100011.14552-1-max8rr8@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems that use HMM (most notably amdgpu driver)
high_memory can jump over VMALLOC_START. That causes
some iounmap to exit early. This in addition to leaking,
causes problems with rebinding devices to vfio_pci from
other drivers with error of conflicting memtypes,
as they aren't freed in iounmap.

Replace comparison against high_memory with is_vmalloc_addr to
fix the issue and make x86 iounmap implementation more similar
to generic one, it also uses is_vmalloc_addr to validate pointer.

Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
---
 arch/x86/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d27932..0b596a1d2 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -457,7 +457,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;
 
-	if ((void __force *)addr <= high_memory)
+	if (!is_vmalloc_addr((void __force *)addr))
 		return;
 
 	/*
-- 
2.41.0

