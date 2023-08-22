Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1547E784C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjHVVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjHVVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:31:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34FE7A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf6ea270b2so19519465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692739855; x=1693344655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHNo52jMQHCTTXv1njx0att1y1oc+xWVwUeLIRRfBAg=;
        b=YC0PScEPND5aZfA24ZoaI8wC1TSlRy2EYibMqFd2iUs8w7ZRXT3RKFlha3o6KDnWYU
         nghvF99uhQidPrOCTS7kFbZPlAlehSol1ZWc0mEDaepO6A4obV5tBwUEQIFSbbZWPuUB
         UgSIx4tkrAH1Cw/lnH0Vt27I3n+AIHy+x0WXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739855; x=1693344655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHNo52jMQHCTTXv1njx0att1y1oc+xWVwUeLIRRfBAg=;
        b=WrMP+d5dv80pLf9qHd55a7QAJmTFCH4FScXA8C9wE0z8p6tm07btESKdxGMn+/ayEd
         wtTnbPbAbAfSKRrZmkA6DcqYYylwOhyAKjsO+5bzzrXbvbjWAMK/dZMuCpcdqcMIXtWX
         VTcE6F8R15lnCdSCdtVI8osMW/oHtGUEiLna6C8AUj7K8FjhiREmJwhFxSYA1+L5I4vy
         vVutfiMorpBLFJXY/q2iJFOvD41qkTSgzTKApTFf58X0AEaFCuywuc16cD1OI7bP61GS
         oFXy41dc1RANitDzNDZnUe+SX0tDdnF3qUQM26BRXNNitpI/LHnQBKYOqlU84hQqZkFA
         4P+A==
X-Gm-Message-State: AOJu0YxqN3LQAZOpyWuvo1SuyiSlNtiKgCS6DE+ULtDLGOh4A7G2CCFS
        E617fjmfij9SeTnbuzBzZCYPXw==
X-Google-Smtp-Source: AGHT+IHswwKksNgSxyqElMvXEh66yr67LTxIGthRXPjy6R7WvznnHL9O4TkqksLBbcEBtlvUxYpXTg==
X-Received: by 2002:a17:902:e842:b0:1b8:63c6:84ab with SMTP id t2-20020a170902e84200b001b863c684abmr9273364plg.61.1692739854952;
        Tue, 22 Aug 2023 14:30:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001befac3b3cbsm9451475plg.290.2023.08.22.14.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:30:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/6] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
Date:   Tue, 22 Aug 2023 14:27:00 -0700
Message-ID: <20230822142644.v10.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822212927.249645-1-dianders@chromium.org>
References: <20230822212927.249645-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
handled as NMI. They are very simple and everything in them is
NMI-safe. Mark them as things to use NMI for if NMI is available.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't actually have any good way to test/validate this patch. It's
added to the series at Mark's request.

Changes in v10:
- ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.

 arch/arm64/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 15b66dc1391b..c51d54019f5f 100644
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

