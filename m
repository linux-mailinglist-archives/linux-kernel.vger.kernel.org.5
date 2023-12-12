Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4D80E195
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbjLLC2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjLLC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:29 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18875EB;
        Mon, 11 Dec 2023 18:28:15 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3c7ef7b31so50137907b3.3;
        Mon, 11 Dec 2023 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348093; x=1702952893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/w+UoxD/rATekKz3kzzyyo/gV2+D7OB+OCxe3PED0k=;
        b=W/eegcIN10Rnn2BviWHG0Zukugi4o/JFzdrwNGmFIvlsmT2w41ebE24natTUeeM9rp
         pU0FNrLWq8BrQHRD8il+n+0k+8LzVvkkHv5YA6Ic8AxEBF6cQw4SVcXwwlvd0NwCpIji
         WRjc0IvTUFw+QMLimpy9Mct3Jo+aBoRCo/8D+f5WtGEI4p1sKhMVFWnZTCtm24V1s+0T
         reWbxXABJTbONitmi11H0hFTTCM7AoARFr0FAJwjRhY1V7f70k1+zHNGwFUpEEo6Wuk5
         FMs23q7LGfErQdarDoKGNkPjY2+dBJ+VFj/JVJKF9ZwWxlAS8qDHUQpcjeJlUM6atWXi
         TWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348093; x=1702952893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/w+UoxD/rATekKz3kzzyyo/gV2+D7OB+OCxe3PED0k=;
        b=Iup93Thm2uxmYhB0QPMxBc2y0+d8Z0UL2TP8F4cdOdcdxlUx5nqMUDVK4/ZRBXhF11
         vrPCBJ8f/l++/CTjkf5NLiWYjI3NZjShxEXMXRoAmkYAjrrnvyai/bChlckrvuFMO6Pm
         1wiwNNTxd/Vzr+AP/wX8RACne80LLHAzZ3tjZ1W8mIiXbaHArQkaWC0QBAK2wQapZdSN
         82Muxjl3GFhEKh0y6AWD5uw1g9R6/gSXov8h91bxvmEScL0U0Dy/Btg7MfCkkRZ5o0zd
         XECakM6tGYAB7kTkGMNg3kyHDr7GHqW18fUkKu072tzJFmuKrkzUuEPo5atwhyxqkEZ/
         KdAA==
X-Gm-Message-State: AOJu0YzF5C21X5vz65DDhP5Nelq/QEd9WPfYf+TDQH7DEIV7ZurfGtSD
        4uYfa/FO92mEgeVgze6OdWZtRStTmzpwnQ==
X-Google-Smtp-Source: AGHT+IHET26fjcr/yQa1Q7ifmcXbI2D2kgfYmLSYnfbmSlFE4Qg2ZvcwqMAfWHDr3XMQSvwnLTacBg==
X-Received: by 2002:a0d:c907:0:b0:5d7:1941:3578 with SMTP id l7-20020a0dc907000000b005d719413578mr3549874ywd.95.1702348093356;
        Mon, 11 Dec 2023 18:28:13 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id c127-20020a0dc185000000b005d4035e6135sm3435201ywd.74.2023.12.11.18.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:12 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 13/35] KVM: x86: hyper-v: optimize and cleanup kvm_hv_process_stimers()
Date:   Mon, 11 Dec 2023 18:27:27 -0800
Message-Id: <20231212022749.625238-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

The function traverses stimer_pending_bitmap in a for-loop bit by bit.
Simplify it by using atomic find_and_set_bit().

While here, refactor the logic by decreasing indentation level.

CC: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 238afd7335e4..d541524ca49f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -870,27 +870,27 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
 	if (!hv_vcpu)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
-		if (test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap)) {
-			stimer = &hv_vcpu->stimer[i];
-			if (stimer->config.enable) {
-				exp_time = stimer->exp_time;
-
-				if (exp_time) {
-					time_now =
-						get_time_ref_counter(vcpu->kvm);
-					if (time_now >= exp_time)
-						stimer_expiration(stimer);
-				}
-
-				if ((stimer->config.enable) &&
-				    stimer->count) {
-					if (!stimer->msg_pending)
-						stimer_start(stimer);
-				} else
-					stimer_cleanup(stimer);
-			}
+	for_each_test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap,
+				    ARRAY_SIZE(hv_vcpu->stimer)) {
+		stimer = &hv_vcpu->stimer[i];
+		if (!stimer->config.enable)
+			continue;
+
+		exp_time = stimer->exp_time;
+
+		if (exp_time) {
+			time_now = get_time_ref_counter(vcpu->kvm);
+			if (time_now >= exp_time)
+				stimer_expiration(stimer);
 		}
+
+		if (stimer->config.enable && stimer->count) {
+			if (!stimer->msg_pending)
+				stimer_start(stimer);
+		} else {
+			stimer_cleanup(stimer);
+		}
+	}
 }
 
 void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
-- 
2.40.1

