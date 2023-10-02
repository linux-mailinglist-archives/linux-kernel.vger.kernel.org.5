Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065507B5846
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbjJBQqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbjJBQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:46:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A229B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:46:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577e62e2adfso11189385a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265176; x=1696869976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OYydoz0zgcPlyOphP3bRXT7u9ruoeqId11POu4ytwI=;
        b=A0PpqRnWe9hxuBSn9hu2LQiXhYaWfLEJZuOpcvD2rQxNrISuxbpapn8UDC5+fEg5LS
         jM8MTn1mCpyflrtIU6ZjbfReR0SkbUlu38t5f9aRir7YeaJgu34QkQijqkeTdKjKw/bT
         Pu5gZwMgSq07KXhaq/hOH+1T4o8nVkSoItn90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265176; x=1696869976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OYydoz0zgcPlyOphP3bRXT7u9ruoeqId11POu4ytwI=;
        b=so+yJrdHUxzp+Trxs0s4pxdAV84+rFlg/eKQ9VQnVTLsmQ00fOv6JWIgcb+vE+cdaG
         d4mIDYMF51yuFwohT7L26vKtRY8Jzxl5TYdbnxZ7TDY9lm2CnH/AZNFMcydmd0iN9Er4
         21V5s1Gfyoxl5n0XCa6KiNN4njUo20BqGza/RGlKbm0h/uZit6yAaq1kxgyZXl+R+t0a
         TR9w1Ms5xzsj9gmBepaSazBoTYMCKY73hQgGwosa3Y2KbS7yBHIt0ZHjahFAhkCU4kE2
         N1bSNCSeDXYKX+79vfb0Xcu3EJsPUyP2oJOHKJ8ZDin+rbg6fqVN4LNHIQ++VdKBjOn8
         fh1w==
X-Gm-Message-State: AOJu0YwyCY/OLFb3w+fCD3wCjtame+ZCkrGJj7giAYrwwuWOzV0yeUJY
        GGMu+h/q8w/NH0e8MjXF5248Ag==
X-Google-Smtp-Source: AGHT+IHLivOZAOPYQoFyzGuRgSJcfrcRS4DH8AgOzW7A69owybG54PttqaXKEA5bmpeD5DDV61nKAQ==
X-Received: by 2002:a05:6a21:47cb:b0:163:e1a1:5a16 with SMTP id as11-20020a056a2147cb00b00163e1a15a16mr4527290pzc.31.1696265175774;
        Mon, 02 Oct 2023 09:46:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:bb:b2b6:1831:5edd])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b001c737950e4dsm8455904plc.2.2023.10.02.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:46:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: smp: Don't directly call arch_smp_send_reschedule() for wakeup
Date:   Mon,  2 Oct 2023 09:45:30 -0700
Message-ID: <20231002094526.2.I2e6d22fc42ccbf6b26465a28a10e36e05ccf3075@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2b2d0a7a96ab ("arm64: smp: Remove dedicated wakeup IPI") we
started using a scheduler IPI to avoid a dedicated reschedule. When we
did this, we used arch_smp_send_reschedule() directly rather than
calling smp_send_reschedule(). The only difference is that calling
arch_smp_send_reschedule() directly avoids tracing. Presumably we
_don't_ want to avoid tracing here, so switch to
smp_send_reschedule().

Fixes: 2b2d0a7a96ab ("arm64: smp: Remove dedicated wakeup IPI")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't 100% know if this is correct and I don't have any hardware
that uses the "ACPI parking protocol", but I think it's right. My main
incentive for this is that it makes it easier to backport pseudo-NMI
to kernels that don't have arch_smp_send_reschedule(), but I think
it's also more correct.

If for some reason we truly did want to avoid tracing here, please
shout and we can drop this patch.

 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 0a6002243a8c..b530d8ef9c1d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1063,7 +1063,7 @@ void arch_send_wakeup_ipi(unsigned int cpu)
 	 * We use a scheduler IPI to wake the CPU as this avoids the need for a
 	 * dedicated IPI and we can safely handle spurious scheduler IPIs.
 	 */
-	arch_smp_send_reschedule(cpu);
+	smp_send_reschedule(cpu);
 }
 #endif
 
-- 
2.42.0.582.g8ccd20d70d-goog

