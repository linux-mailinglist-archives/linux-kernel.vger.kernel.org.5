Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052467FD33B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjK2JvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2JvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:51:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166D19A0;
        Wed, 29 Nov 2023 01:51:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so555417b3a.1;
        Wed, 29 Nov 2023 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251473; x=1701856273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ+LDwQ3Bi2N8eKNE7wHcwQgSEsXHaXC33trFiDy14A=;
        b=C8LMXvadrV0O1RBJGUBUQK+4otduMBx/iuXvPRjuMVVijERfNwUYvIWFiEEQsp8//U
         AB2pshEPz6c0z/sfOTyUW641dwu6IIsxK4PgvzF+QASdrZmqzInSyNScKvC8kTka3nV+
         q6q2RSF2z9gPyPzqWmCnhzdSlWzu3CTOLGhT0k/RV26icKX+c1+SHIVkQRyYcZiQr6i3
         /4MqXlwewDDH9URVLEGWsih88nG8DMYS1/hl19uR6IG41tzL2XQ475Gl+/3B8CneE+3Z
         zcYafS1Qbae2qBB898NoJ+u/W5dCAlCnknHYrk3fa77Ty9typdkz3fHUSIeS4CC5WP5l
         IOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251473; x=1701856273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ+LDwQ3Bi2N8eKNE7wHcwQgSEsXHaXC33trFiDy14A=;
        b=ZU3meDAX7AbQrXChEXrnwGDbVhRuFRPYfCMjiTyD+GaJ/ycGNkEwLmDSnlQVECefb5
         ttseXXybHtLEiRqPKD5qNs80K0A4O/DPQNRWw6z5XuHRmP+Ubpn9Lu77cnBRUtRV7bSb
         HvO8Mxvorxs/GYToQhh4Bp0Lk5yVUUbayYR90ZETAhJlpFpPxXVytV7TNfv/MVCQJ4a9
         YwwXmsp7zUfaHzNCYMg2AC3P8BeeDIgFYijCZozEVuUzRT55xNACjO+obIU5O9Zf/pQP
         L8YaUJuKdJLVCrJfY/C15r/6bEPQLA12T3YxfM/2Y0rItiVgj1qn9yUPEmA5XPswaeWX
         rQnA==
X-Gm-Message-State: AOJu0YzQ4vd7RfNY3PS5JlTBX1UyX9BBeFOiC+hAsV9+R8xiwjVV6P3S
        0+D1b7tS8FHIx3ISqeOsoTp2QtPvpPBZKg==
X-Google-Smtp-Source: AGHT+IFpJ3hbbirJvJcO0PH2i+MFHeaYEpCKvtbNeWEu+FvLJW+FrPzyTw1o93Y56hSatIM/rtCNWQ==
X-Received: by 2002:a05:6a20:8e1f:b0:13f:13cb:bc50 with SMTP id y31-20020a056a208e1f00b0013f13cbbc50mr23216894pzj.25.1701251473085;
        Wed, 29 Nov 2023 01:51:13 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id j21-20020a62e915000000b006c34015a8f2sm10692761pfh.146.2023.11.29.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:51:12 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/pmu: Prevent any host user from enabling PEBS for profiling guest
Date:   Wed, 29 Nov 2023 17:50:55 +0800
Message-ID: <20231129095055.88060-1-likexu@tencent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

Stop using PEBS counters on host to profiling guest. Limit the range of
enabled PEBS counters to only those counters enabled from the guest PEBS
emulation perspective.

If there is a perf-record agent on host that uses perf-tools events like
"cpu-cycles:GP" (G for attr.exclude_host, P for max precise event counter)
to capture guest performance events, then the guest will be hanged. This is
because Intel DS-based PEBS buffer is addressed using the 64-bit linear
address of the current {p/v}CPU context based on MSR_IA32_DS_AREA.

Any perf user using PEBS counters to profile guest on host is, in perf/core
implementation details, trying to set bits on cpuc->intel_ctrl_guest_mask
and arr[pebs_enable].guest, much like the guest PEBS emulation behaviour.
But the subsequent PEBS memory write, regardless of whether guest PEBS is
enabled, can overshoot guest entry and corrupt guest memory.

Profiling guest via PEBS-DS buffer on host is not supported at this time.
Fix this by filtering the real configured value of arr[pebs_enable].guest
with the emulated state of guest enabled PEBS counters, under the condition
of none cross-mapped PEBS counters.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/events/intel/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794a0e79..17afd504c35b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4103,13 +4103,19 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
 	};
 
+	/* In any case, clear guest PEBS bits first. */
+	arr[global_ctrl].guest &= ~arr[pebs_enable].guest;
+
 	if (arr[pebs_enable].host) {
 		/* Disable guest PEBS if host PEBS is enabled. */
 		arr[pebs_enable].guest = 0;
 	} else {
 		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
 		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
+
+		/* Prevent any host user from enabling PEBS for profiling guest. */
+		arr[pebs_enable].guest &= (kvm_pmu->pebs_enable & kvm_pmu->global_ctrl);
+
 		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
 		arr[global_ctrl].guest |= arr[pebs_enable].guest;
 	}

base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
-- 
2.43.0

