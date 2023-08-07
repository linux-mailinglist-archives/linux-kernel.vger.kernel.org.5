Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C10771C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjHGIrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHGIrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:47:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F21722
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:47:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686b9920362so2673127b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691398027; x=1692002827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ce2RfRSWjXvPESxYUjf188ztXlpWHuHBGpioVwB/nU=;
        b=G5vcEbYx+xBn8cSL1PvNGGagpI004mry0a3I3zcBtA1G7Du69F2p0iOcVExMfTWuFQ
         NT7ZHEpTXoAjGcsCReHEZr/jZDkfl039Q7Im6z7q84WVhII9UKsfS+xM7y+4DEDZKVLP
         lI12gML978RAxgLt7zp899crgYgwdfZRiOsXYWSjtBf61R6BOqaSQeVcGbWp3ZLnKdpR
         lHPVyRTCcRXdeW1iyECcJF00QUEAHo1E8H/YaqKMZk4RISOh9xchvj8QqlMkmPNa+UMF
         wGdGIXMDEfjqXd/Guy2s+r0P6a4jBeLsNJibh4/GkJnOu7mi03h9yB7LsZhanHjE4892
         ns5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398027; x=1692002827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ce2RfRSWjXvPESxYUjf188ztXlpWHuHBGpioVwB/nU=;
        b=QQUO46KXNa6budUEAYN5Xnxy+NklXjAeoiMhwe+GO+2z8JWJ2ZhSZgslfMot4dDZs1
         7Ol/ktwQxZBWA+uByfZJCJnYR/UGnLK6P5lHMBrEReWHGaqfHaert9fBYqoSxELCv0LI
         NJ/YFvR+S56M4MsNsr6bqhT2OLTYJfo4NWh8oR9lZIxiJ6lTlNFY4xt8DgouNKKRt47P
         GIsckEmAiDKc/1mtFmAUFwCB/7gqQENFUxAXzGXFe0yUB/nl9O1Fm4+TSUVUTN5qd1wJ
         EZjyEHuS/C/hbVOqyK3/YlnUUHo/DY2l3HwydFNbvnfPtyCUxPPzaZOflVLAvennI0KQ
         5lGw==
X-Gm-Message-State: AOJu0YxVQxwppJCakmaRFMc2H1Nws0pr5Tc7wHfqAx8MH5VNHh5AbSO/
        /0HaHoYG60COIz9J2+HPhoXNehDEsahHMg==
X-Google-Smtp-Source: AGHT+IGA8glFGIk0g+/Sje6FOOO0SoMWRkacBh+SELgcGDBuu3+R8gUjR/vXqaw/dbBo405GUAmEdQ==
X-Received: by 2002:a05:6a20:650:b0:12f:bb22:ad3b with SMTP id 16-20020a056a20065000b0012fbb22ad3bmr6205667pzm.62.1691398027134;
        Mon, 07 Aug 2023 01:47:07 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b0064d47cd116esm5614053pfe.161.2023.08.07.01.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 01:47:06 -0700 (PDT)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joerg Roedel <jroedel@suse.de>, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/head: Fix incorrect size value of startup_gdt_descr
Date:   Mon,  7 Aug 2023 16:45:47 +0800
Message-ID: <20230807084547.217390-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Since the size value is added to the base address to yield the last valid
byte address of the GDT, the current size value of startup_gdt_descr is
incorrect, fix it.

Fixes: 866b556efa12 ("x86/head/64: Install startup GDT")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 49f7629b17f7..cfd70939a099 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -80,7 +80,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
  * while the kernel still uses a direct mapping.
  */
 static struct desc_ptr startup_gdt_descr = {
-	.size = sizeof(startup_gdt),
+	.size = sizeof(startup_gdt) - 1,
 	.address = 0,
 };
 
-- 
2.41.0

