Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F877F380E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKUVUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:20:05 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A82DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:20:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc5b705769so53527265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700601602; x=1701206402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgh0uBFCCexs3X74tOvJ4nUeduxVPgSncyExFdlszoE=;
        b=NWrvpVlRJSXz5Wnq1IjLlrZtLgt4/VEF/YlAuegMrTBp2xz1ycAONpLL2vTC20MKl4
         VWfe5gFJY7TDzrAaJCuttj7hu6DI5KwCWnbDCDQIK5G0FxyqH0hmQjU1T3qAQhRtk0Hh
         bgReLgODRrvtDw2Umy6GWZ23KATTAizL3DDZgOFUqjW8fMgawNmbp4XPbodoeaOzzpz9
         skgj9mOLzm+ywPuaHF3brWxUmC9Pi+7KGE1eUxNULtWNZJDLXTzO2aEwjGqV90MkXfWX
         yLQKnbLG/ChooGqHuvvueY1lsnvtMA66lSmgM32rgUZSCVoU/Vnjr1Ve2mkLw+exmx2Q
         AdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601602; x=1701206402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgh0uBFCCexs3X74tOvJ4nUeduxVPgSncyExFdlszoE=;
        b=R0R+HAu85cnqSwmLf0VbvYXbXoEAZ+IXd2yLtTxasU14zEjaK3NvdPbf/6tQKkYM76
         jOX3w6/BWANvAC8ORonXPhAjhfA5Q53qlCHWBUt4e20bp2P9ma1gHWmI0TM1oYZvEMrY
         GDkwF61zxooOEN+couNsunRbYM5jKRCEC/dGYIShbdzwJy6+mcdvgc0+eI7JMsfVPVFu
         MxsaakhklgAESVplJXYm0v05gJ24ZtPK7Jb1tIUu/rs4IcboUOcgu9Qn8Pwjp+cZLj7H
         ANF9e9nggiHSC18HCFDAd8XSnZ9KQDl2U40GZIqHoF4xWqa9GOaBH4VVyxyYtYUPtmX0
         5lLg==
X-Gm-Message-State: AOJu0Yy4+RBw6pLjuic9nKAWRddyh3fgAhaiitFXBYoPM1/a9O9Ho3h/
        +haUW4DiP4H3ZM+7NW+ADHW18A==
X-Google-Smtp-Source: AGHT+IH7LCfW7pTDQ78ElXfcTV37jEIPXch7qDRXDGAYWklJ2EMCEyweA+opQIBlNxj7jsdRKkdq7g==
X-Received: by 2002:a17:902:aa8e:b0:1cc:2f90:6291 with SMTP id d14-20020a170902aa8e00b001cc2f906291mr367179plr.54.1700601601956;
        Tue, 21 Nov 2023 13:20:01 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902a40700b001b53c8659fesm8333270plq.30.2023.11.21.13.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:01 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix SMP when shadow call stacks are enabled
Date:   Tue, 21 Nov 2023 13:19:29 -0800
Message-ID: <20231121211958.3158576-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
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

This fixes two bugs in SCS initialization for secondary CPUs. First,
the SCS was not initialized at all in the spinwait boot path. Second,
the code for the SBI HSM path attempted to initialize the SCS before
enabling the MMU. However, that involves dereferencing the thread
pointer, which requires the MMU to be enabled.

Fix both issues by setting up the SCS in the common secondary entry
path, after enabling the MMU.

Fixes: d1584d791a29 ("riscv: Implement Shadow Call Stack")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b77397432403..76ace1e0b46f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -154,7 +154,6 @@ secondary_start_sbi:
 	XIP_FIXUP_OFFSET a3
 	add a3, a3, a1
 	REG_L sp, (a3)
-	scs_load_current
 
 .Lsecondary_start_common:
 
@@ -165,6 +164,7 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+	scs_load_current
 	tail smp_callin
 #endif /* CONFIG_SMP */
 
-- 
2.42.0

