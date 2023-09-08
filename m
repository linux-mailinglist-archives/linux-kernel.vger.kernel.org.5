Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E747985D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjIHK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjIHK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:27:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346731FDB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:27:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so32000581fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694168774; x=1694773574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzirF41rnUqKpCrHpf0iIc8MJPJsNa+V/TRO9JKyJ8w=;
        b=jvjXqpM7+1aqsRGtMdThWHuTMTyU3BLTxLVASo6Z0ZyDIqzWpamao4ee65bRkngrNH
         iN+8PT2m0btikOqsGnE9/iwLrEPxfwcc/WNuS4ScJJWlMPXSl5EA3y+ef+jMo7PuIKnr
         Q4slLWWztE1dLODASduVuC81Yosigh0rzeVQYFjRjG2rckuNwmKU8v+UuzutlAPIZNrD
         90cIEnWLEwIC9wK0DFW/ldGdJ8t67W83ZvbKywNeAAAJvrLnaEJmb2kZp7dGxxL0nveZ
         egV46pKq1Vshf9DC4+U7h9iNOP1SDkpsuwJa2GbgCRG+/+SAhE4gzcGMwmYdlzcGMrJ6
         TkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168774; x=1694773574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzirF41rnUqKpCrHpf0iIc8MJPJsNa+V/TRO9JKyJ8w=;
        b=miw2D9/15RTBronLlWltbwwLkwaiFO14ZbtPkpbZb4kz8vS5qxjnsls3moxhd4G+se
         xC8mQ4ei78NLTXw19b7U8ptpjjSEiYafLH+GJP7xs6Bm0xhwqOFes9sZvoZq7uGV1CR6
         wqDqHR9AL3gWgS9tjgbU8oOLjw5QcpuT/58qQ6pSxBFnekhkcpFltkMiwnILzmAD7Bh1
         z5hY71lpE/5n2oTbQYHL3jutXeqIH+18jIsInnuUNaglBq0aYnVNjChyyLaJOudH/iTH
         bVZPgkN9GLHt7aV95CfSD5W499NfUybhXuCwNimn+CTx/5MPP940TfwglEcLvImVOvN7
         zKbA==
X-Gm-Message-State: AOJu0YxkUnPtzoDSGRMmGscI5rEne8kI0TdtJETXtH6maZLL7i7OXE4d
        JZk4paJNHjOgUlmfY80O3k2DZagvPm2z4l5jmCw=
X-Google-Smtp-Source: AGHT+IEcb6V0yih75oVWWeDE9YCVheVESKk0yVeRdT2afa8x9RlbRO0O7uqXrN4UesergTgOWUMvRw==
X-Received: by 2002:a2e:9ace:0:b0:2bd:ddf:8aa6 with SMTP id p14-20020a2e9ace000000b002bd0ddf8aa6mr1383716ljj.23.1694168773889;
        Fri, 08 Sep 2023 03:26:13 -0700 (PDT)
Received: from bell.fritz.box (p200300f6af456100ee66353b07eac200.dip0.t-ipconnect.de. [2003:f6:af45:6100:ee66:353b:7ea:c200])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709064c8800b0098963eb0c3dsm844056eju.26.2023.09.08.03.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:26:13 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     linux-hyperv@vger.kernel.org
Cc:     Mathias Krause <minipli@grsecurity.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org,
        Saurabh Sengar <ssengar@linux.microsoft.com>, stable@kernel.org
Subject: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under Hyper-V
Date:   Fri,  8 Sep 2023 12:26:10 +0200
Message-Id: <20230908102610.1039767-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
non-Hyper-V hypervisor leads to serve memory corruption as
hv_vtl_early_init() will run even though hv_vtl_init_platform() did not.
This skips no-oping the 'realmode_reserve' and 'realmode_init' platform
hooks, making init_real_mode() -> setup_real_mode() try to copy
'real_mode_blob' over 'real_mode_header' which we set to the stub
'hv_vtl_real_mode_header'. However, as 'real_mode_blob' isn't just a
'struct real_mode_header' -- it's the complete code! -- copying it over
'hv_vtl_real_mode_header' will corrupt quite some memory following it.

The real cause for this erroneous behaviour is that hv_vtl_early_init()
blindly assumes the kernel is running on Hyper-V, which it may not.

Fix this by making sure the code only replaces the real mode header with
the stub one iff the kernel is running under Hyper-V.

Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: stable@kernel.org
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 arch/x86/hyperv/hv_vtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 57df7821d66c..54c06f4b8b4c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/desc.h>
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
+#include <asm/hypervisor.h>
 #include <asm/realmode.h>
 
 extern struct boot_params boot_params;
@@ -214,6 +215,9 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
 
 static int __init hv_vtl_early_init(void)
 {
+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+		return 0;
+
 	/*
 	 * `boot_cpu_has` returns the runtime feature support,
 	 * and here is the earliest it can be used.
-- 
2.30.2

