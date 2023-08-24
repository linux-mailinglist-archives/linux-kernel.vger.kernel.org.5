Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EFC787450
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbjHXPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242233AbjHXPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:33:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE225CEE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:33:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso3409089b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692891190; x=1693495990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U+ZFko4eaNVS/k5E5YRzxI9X7/KmekX/8rZmWNkCMw=;
        b=cS5jIetqAgvoNwttMKW4WTIdVltP+nOpZ6stPUmuzAoBmw/eX/rT/dZLOJ/PnUdndx
         3mg0vSOMLBUhFA54TJJKRCLbXxOTgJJLu2+gL3A90a8w+BPukvfIq7bN6HtW0VmGnhFw
         6NSUkj9cgyvYTfuGsfZ/V/hb/l98o3t6zQmQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891190; x=1693495990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+U+ZFko4eaNVS/k5E5YRzxI9X7/KmekX/8rZmWNkCMw=;
        b=YuxfgRZ9L4E3JksZnOMVtXBiKIj1ZhnyRr2/DP36t/nb/nlC5YBvG8W9iLaOnJ0eom
         P+UbubG8jTIx1EQkos+62DXluhEo5vddWTR54ktK3Ojc4SWYHoXFySLrIRUaFtIugTBy
         FXXaD9Jit7weZN32mvtMd9ftlays/cpGJrAGJNwJbZXL7/cNSAYmhS7qmHigyYmHBpLf
         SJ08nPu95eKNOfFe2jYuGaeVxGD0YfW7OFtx4bh9JnbTt7boedFrx+S2YgpUoBbuEgzu
         9d0rQZ8ffhxqQYJ70t0zuJniZtOMJVaPDrqgpluMG8xE1DDt9iqgTcj3dwJSiwDg2+Fw
         ffIQ==
X-Gm-Message-State: AOJu0YyfbEgZXHsBPwr02R4X2O/baraZhJk1icu+P6HScm5TQzhVbBzL
        EC9IDRMgaap2ZvcLugrEILM5eezj3OXF5f9tkOCH2zLf
X-Google-Smtp-Source: AGHT+IHaSpjbeAQ9UzHqXXC2nf4Z9xB3fbVm9xxQZ6RsAAdQhINpMo2utUL4uLzKK7MxM211qE78FA==
X-Received: by 2002:a05:6a00:124b:b0:68a:582b:44c4 with SMTP id u11-20020a056a00124b00b0068a582b44c4mr9603241pfi.3.1692891190414;
        Thu, 24 Aug 2023 08:33:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:afa3:fcf5:1b7f:f7e2])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b0056365ee8603sm11631337pgc.67.2023.08.24.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:33:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 5/6] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
Date:   Thu, 24 Aug 2023 08:30:31 -0700
Message-ID: <20230824083012.v11.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824153233.1006420-1-dianders@chromium.org>
References: <20230824153233.1006420-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
handled as NMI. They are very simple and everything in them is
NMI-safe. Mark them as things to use NMI for if NMI is available.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't actually have any good way to test/validate this patch. It's
added to the series at Mark's request.

(no changes since v10)

Changes in v10:
- ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.

 arch/arm64/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c8896cbc5327..4566934aaf9f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -946,6 +946,8 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 		return false;
 
 	switch (ipi) {
+	case IPI_CPU_STOP:
+	case IPI_CPU_CRASH_STOP:
 	case IPI_CPU_BACKTRACE:
 		return true;
 	default:
-- 
2.42.0.rc1.204.g551eb34607-goog

