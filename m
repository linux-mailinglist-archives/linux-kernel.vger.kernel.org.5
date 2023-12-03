Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245268028F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjLCXUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjLCXUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:20:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92184FC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 15:20:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso5756095e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701645642; x=1702250442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOzPbwmzOzmza0UhjuLR6+wHBK/5W4fSzHoOkFgrGaI=;
        b=iO6iB61NJAQdg59dTUY8uR3gqgylC10D5BcGmY5dilrWiasKGM2xNOn8FtoNKjn5fg
         BAw/uRbiCNWIIVhoh3NWe3drGcIue2nGjFrkpebtAEaSkRgokMnE2NKQhMJ7nn5KhzIU
         qiLb+GpExiRhLvhvl6xF+uuOhnvspEDlwbMa6qkSyR7Qsu1X7J2+0j8sON1o7Xo+JE84
         Oz/Sv6PChKgFAFz/LoCu8z19ObDfezyvrhnqyUAsRTUHqnErNEg36xPs8xRBqtfB9ei2
         8HmEKYE80H0Mnw7msV7U2zOfg23M+d0TbJQR2vxTJ2VToH5RBKimjTiKkblkEnGTaUME
         JA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701645642; x=1702250442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOzPbwmzOzmza0UhjuLR6+wHBK/5W4fSzHoOkFgrGaI=;
        b=E27gU1SlTkNEkB+Aae1IXXwWwl9FIBsJ2EOsrObd2i8SoQi7N+znpuwnUXCm+4iwpH
         SOM8t80pQhjLFSHQHNQlESxQKm2ieGgWw4ONr/6WmhXcEqL7OOSwGDEzxpGK2GzKryRr
         2KMaLYiGEYr86pYp45hdmilINgDBO5FKO5trSIU3ITHOm1v7IJtic6tlA7saMyWlBgYc
         Dc47f2lLCc/hQj3NSkFIZjH5fRlFR2rwUi5U8MntuDr4CoBCiFqAAX7q+fb9yvXqn5eZ
         a/8JE/LswgJvIjMNgqiopurPD/Um5eP+Bma48tpwZxJFhwuOcdjR+Wv+qxKA4wH8d9Nl
         RRng==
X-Gm-Message-State: AOJu0Yw93OD7XSzVDg9tvw1q+vekegT3HS01+fJF7CioDJreP0JKy/fz
        iP0CULkpPN4xEnTYKvUtFp4=
X-Google-Smtp-Source: AGHT+IGrqpvv/BAvlagb2kPjUCAZBWMVaIyCYV5jP+dxrQoQuAd8R3T0ju1WMvFVsKLcND7SC0zHNw==
X-Received: by 2002:a05:600c:5008:b0:40b:5e22:985 with SMTP id n8-20020a05600c500800b0040b5e220985mr2331500wmr.116.1701645641790;
        Sun, 03 Dec 2023 15:20:41 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm11566222wms.34.2023.12.03.15.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 15:20:41 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip v2 3/3] x86/percpu: Avoid sparse warning with cast to named address space
Date:   Mon,  4 Dec 2023 00:19:40 +0100
Message-ID: <20231203232017.994963-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231203232017.994963-1-ubizjak@gmail.com>
References: <20231203232017.994963-1-ubizjak@gmail.com>
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

Currently sparse does not know about __seg_fs and __seg_fs named
address space qualifiers. Avoid thousands of warnings about unexpected
keyword at the end of cast operator by removing named address space
qualifier from __my_cpu_type() when __CHECKER__ is defined.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 3859abad19ec..cc4212d1491e 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -96,6 +96,15 @@
 
 #endif /* CONFIG_SMP */
 
+/*
+ * FIXME: Drop this hack once sparse learns how to ignore
+ * __seg_fs and __seg_gs named address space qualifiers.
+ */
+#ifdef __CHECKER__
+#undef __percpu_seg_override
+#define __percpu_seg_override
+#endif
+
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
 #define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
 #define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
-- 
2.42.0

