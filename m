Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A3794127
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbjIFQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbjIFQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:06:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516601BE1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:06:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so2776593a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694016380; x=1694621180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7sZUrbu7G8VVQgLzNpnSnYE3JCJ+QM4RpfgS9EDo7w=;
        b=fTITKjWHuNwPaMG5Bbb3tbNI6m4C6WJNjR2nFWMlMxZSOh67vWPbxzbTeXz4cCy+IO
         vL2huY9lBhIr8g7Sp+5VPyIrLi71+9bir1lDCN9DCMmmRpowRQqMPibLz9j4eMVb6eYp
         lAmg4Q0Y1QchZpLAMd5Fr16NfRiZa8iS1Ushk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016380; x=1694621180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7sZUrbu7G8VVQgLzNpnSnYE3JCJ+QM4RpfgS9EDo7w=;
        b=MrlbuTkVbalGKFfxYnftACl36F+37zB3f198Wfm5kXQSvNArtCgJYilZpJVry2wBs2
         YAPsnn/0bxfbh9CK8fvbC15OKndPyZJbkYxo5QIisJGcxiGR49sL9NGmFjlqPktOg2mn
         ul5BrTPtu6tA5Wo4M2EJffrM3zy//+xy9MjmdJtnzO9Sms1YiM7AKPDisrCRedPWOvid
         +DPpzvop/Szr7CWyZo6RccvWyHaT3NJXPq+gfBJV/wVrBwE1cu0KCaQnpc8zrdkfcv9R
         MhLZeE6s50J9G7i57QxirPVWm258MzgeXEsZN3QMmZJC5UkWokitrKO4L4+5dtICet2U
         WhRg==
X-Gm-Message-State: AOJu0Yw/FjBfgGbvJRt1CEC4fODOqVw2kVImpCuv6fDvBMsRPq2/6cOb
        bk0dasiHe2ZKWCx/Wb4BOIu0IQ==
X-Google-Smtp-Source: AGHT+IE0tkbtilqmUzzNEAhkV7dwTH/WxCurwss0zjvA7YEgARbTqJ+cA+mwAwgj3wZJVcvv0hbP1A==
X-Received: by 2002:a17:90a:ec02:b0:267:f1d0:ca70 with SMTP id l2-20020a17090aec0200b00267f1d0ca70mr16136072pjy.47.1694016379780;
        Wed, 06 Sep 2023 09:06:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4a07:e00a:fdae:750b])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001b8c689060dsm11338859plb.28.2023.09.06.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:06:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephen Boyd <swboyd@chromium.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, scott@os.amperecomputing.com,
        vschneid@redhat.com
Subject: [PATCH v13 7/7] arm64: smp: Mark IPI globals as __ro_after_init
Date:   Wed,  6 Sep 2023 09:03:02 -0700
Message-ID: <20230906090246.v13.7.I625d393afd71e1766ef73d3bfaac0b347a4afd19@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906160505.2431857-1-dianders@chromium.org>
References: <20230906160505.2431857-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the three IPI-related globals in smp.c as "__ro_after_init" since
they are only ever set in set_smp_ipi_range(), which is marked
"__init". This is a better and more secure marking than the old
"__read_mostly".

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch is almost completely unrelated to the rest of the series
other than the fact that it would cause a merge conflict with the
series if sent separately. I tacked it on to this series in response
to Stephen's feedback on v11 of this series [1]. If someone hates it
(not sure why they would), it could be dropped. If someone loves it,
it could be promoted to the start of the series and/or land on its own
(resolving merge conflicts).

[1] https://lore.kernel.org/r/CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com

(no changes since v12)

Changes in v12:
- ("arm64: smp: Mark IPI globals as __ro_after_init") new for v12.

 arch/arm64/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1a53e57c81d0..814d9aa93b21 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -84,9 +84,9 @@ enum ipi_msg_type {
 	MAX_IPI
 };
 
-static int ipi_irq_base __read_mostly;
-static int nr_ipi __read_mostly = NR_IPI;
-static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
+static int ipi_irq_base __ro_after_init;
+static int nr_ipi __ro_after_init = NR_IPI;
+static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
 static void ipi_setup(int cpu);
 
-- 
2.42.0.283.g2d96d420d3-goog

