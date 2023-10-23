Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83EE7D4190
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjJWVRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjJWVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:41 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7C3DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2cf67be2so2554492a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095859; x=1698700659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsKN0vAWTPkRoeR+0eW+M/Vw4EKK+fkuLodskFQx/7g=;
        b=gb/vSNEg2Q3s9/RrpcxJ/PtZ+1dOQPa4zedcpnbt85vl6tkTXAscaEzDw4hBWiF26O
         yiAdYXpvedx6LZkLrQRPBlD/iuoyg+5uy8Qp0NCiB0AAaDvROCn5FpL1p2d6KU9JLiRh
         bd5Ymt3CHFzb1Il5M/JJCYLBr26SAKYsRFCpwPfXQuJ56xvpsxy74IsN3nGTxxu0mkXs
         F0vNG/wZAADbvRTWHdllufTyTZO2qOgPp+lUNhYM+vs26DuZjCqg/gJVIVck7eCcWjnE
         1zzeL+LJrAZ8o6iF9gHxuvxwfu1Lpcy8bcnWmfi9MQRk5sbMvcX3/mkLX5aR/l05RGD6
         KpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095859; x=1698700659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsKN0vAWTPkRoeR+0eW+M/Vw4EKK+fkuLodskFQx/7g=;
        b=MwQQ8CYUTLQzQCWa/6nXyYj1HrnkRRrss7BzXUfIOZWFi3PskjmJ3VQCxhinAqXxCj
         s6e16O8glXNdeKsN89W4pYv1nmSfHFcF0iHXsZ3PMTthjvu/Wf2Z3WLd3jNFvl0qQZDX
         RAKc1UgFpBHkSeLOj9xv8iVFmTDByh/v2r+Y/M9LxLVy+2utn9ysQgq31fj3hBombVj9
         oJTSQhFXbtx528HNIef+E6YuEdMLJADEKYkfEo87FajwGK/vo4ad1nYta/Li+uXN9yvk
         WOI6nVC6a1EnO0TX0EAP74e/PZC9WL/Wb7vMdZE8GseJxOXXkuv9DfqyTVqXjEh/AJLG
         QcNA==
X-Gm-Message-State: AOJu0YzEakWl3WAte0wf8AX+4aEQfa2r6bBUzMsw+FmGaywD7mEkIe7r
        djdda5+P0zr4M74GmTTds3P3ajmZTw==
X-Google-Smtp-Source: AGHT+IFGCsDY1j00sDubUeu+xN5JAqbbkLtbYh2lmq2KOxK8rzEhbH4+UVROCUmvg5OoGxxWK2V3oQ==
X-Received: by 2002:a05:6830:2b23:b0:6be:fe1e:c13 with SMTP id l35-20020a0568302b2300b006befe1e0c13mr14809191otv.0.1698095859110;
        Mon, 23 Oct 2023 14:17:39 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:38 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/9] x86/boot: Disable stack protector for early boot code
Date:   Mon, 23 Oct 2023 17:17:23 -0400
Message-ID: <20231023211730.40566-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023211730.40566-1-brgerst@gmail.com>
References: <20231023211730.40566-1-brgerst@gmail.com>
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

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before userspace is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..aff619054e17 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -39,6 +39,8 @@ KMSAN_SANITIZE_nmi.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.41.0

