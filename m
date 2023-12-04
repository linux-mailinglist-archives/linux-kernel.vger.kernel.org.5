Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C58040AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjLDVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjLDVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:03:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6D8D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:03:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so15771845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701723811; x=1702328611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VebkBDMF/S+hhLyx5vGUP5fSN93fqMXIrRDSIFqms58=;
        b=fh0ncSORLsag1xlHHoBu+ZbyKpj7QgvX/lsMosTSiRmT5z/B1Wy0TyBEVcjybxhNnV
         xHhab3heY/XiYgUndWUU7v41oW2JZJKPM6J9mly5+4jiOeANkTNZrNEKfS7G3kPZHQnP
         ZVBsUm93hM4aGkCx8MqBjC37Oz6TlBlYdL9fnipKrmWLZ5/0IIvxrlGaoN1HkISOFTXb
         b9bSpSu7uBZK/33tY2XKblKqxotMsBKV8R1Lqq8675sh/2Fx88qoH9lIMcf8+9jlBZ1k
         657MShICYZpxCUfAq2DOrDSYFldq90GWRKtzlbBZN+cVXRWTKCio5IRtDYpDXFh/Hdup
         pZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701723811; x=1702328611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VebkBDMF/S+hhLyx5vGUP5fSN93fqMXIrRDSIFqms58=;
        b=Iq/9G+Sy+iWK8ArOthDddVTkeBLbodQt2OVVzZkHIDhnBMZ0rHf/8XA2/6KziMNxc0
         m5FYYfP6ZUvUzPPGUB+Lb07oTnOIERqZQjR7k1qV812Kzgi+ffLxVNhzDBJ3LCOtqN/y
         XuIIEmCVQpo81CGYJAIDwYvcTtnRDwFoAr8hxZDhseD1pnoKDsCzm7/Qugm+p0Blydbv
         bo378CJBJQk5iY3gGyYdAzR70pwhemsWYTW7ZPf9lblsL6Gub5/yvslBuEi30e7JlcMV
         ren86KDhBKo03Z5tNoGTPhEWZoSdeJoanPeIWhTRmuR1BL3tKsBkUX4wc8SY7IsD9FRo
         3fJg==
X-Gm-Message-State: AOJu0YwqPBNcFKy2wO6PnFn9F+AiFOvhTT/LEBcHzNQ9dWwqwCIFqpwe
        XZgFPrJMtp+Ftl29m0WH2Cw=
X-Google-Smtp-Source: AGHT+IENLha03CaneorBKhBhBlL5Ve72I9yg21Beq3R6fwRZPlejTeaR4XytI74fgWV7/CwnQZn+KA==
X-Received: by 2002:a05:600c:4fce:b0:40b:5e22:983 with SMTP id o14-20020a05600c4fce00b0040b5e220983mr3576905wmq.114.1701723811205;
        Mon, 04 Dec 2023 13:03:31 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b0040c08567bbfsm7414815wmq.17.2023.12.04.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 13:03:30 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, kernel test robot <lkp@intel.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip v3 3/3] x86/percpu: Avoid sparse warning with cast to named address space
Date:   Mon,  4 Dec 2023 22:02:31 +0100
Message-ID: <20231204210320.114429-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204210320.114429-1-ubizjak@gmail.com>
References: <20231204210320.114429-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach sparse about __seg_fs and __seg_gs named address space
qualifiers to to avoid warnings about unexpected keyword at
the end of cast operator.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v3: Teach sparse about __seg_gs and __seg_fs qualifiers instead
    of removing these qualifiers when __CHECKER__ is defined.
---
 arch/x86/include/asm/percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 3859abad19ec..e56a37886143 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -36,6 +36,11 @@
 
 #ifdef CONFIG_CC_HAS_NAMED_AS
 
+#ifdef __CHECKER__
+#define __seg_gs		__attribute__((address_space(__seg_gs)))
+#define __seg_fs		__attribute__((address_space(__seg_fs)))
+#endif
+
 #ifdef CONFIG_X86_64
 #define __percpu_seg_override	__seg_gs
 #else
-- 
2.42.0

