Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F737F00A4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjKRPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjKRPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:29 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA11985;
        Sat, 18 Nov 2023 07:51:31 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7fb84f6ceso29711467b3.1;
        Sat, 18 Nov 2023 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322689; x=1700927489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWIlOk1FsRTd5Pg1eEMJS0d0MbiyZx68JIVX7B57ps0=;
        b=mXAB05eHIJUK3SjzKjiL/jMGPGujkItEHsnP4JJFtHV57ZvtkIiEdaTnoDuv1Hs+PV
         q+RK/R0TZffv6D/9MK8vRCS/tu/WtD0ZU4maYuIQPvmu03BJRHoNnjg5bVNFBtyBBh+F
         pTjRxP8YTIsxyUnwv8dltoKsA6Hd6DzZbvkrNop+hsS9NicxayHvVTc5wU4w3ZY5oPvb
         R5Q2Ipe3rm4pvAwQolwXK2TFIKUpkc2zbbaxrRlHFo2m7rPa9Gj9HrS5Cq3/B61TBpMD
         Du9r4Obt9Cnfgv9N2PfJHRg8uxbiycN2uAbLYN0/uMVaT9EDs1RGmOPO6W79HNKEodfB
         8Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322689; x=1700927489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWIlOk1FsRTd5Pg1eEMJS0d0MbiyZx68JIVX7B57ps0=;
        b=tr5nUVMepAS5806kNAfiJvw17Ug5+cV96trbomLUI6k/U/4tGwSlVYsIRRsgn+Xitt
         MnCq8qNrMnnavztvIBGQwvwVyD6Wt4XXDnS4WB7KFhPuGAhLEKz3pQzKt855Mc0B4Kdt
         /CkxHQA7+a/dKliqecawq974HYnGhdYTiuLvE7X08MmoXL//GI7cv/qwhv4s1/O/uPWm
         vIVwrc9/1ZPu/lgWBO7yWo4BYgNg7oRC+ORkAuLfBc7dqhvKCh8btFn+BykAjY/q3FyR
         gCGTMb0NYUeNgHGsv5i0e+aLxrcsjUXLlz5c7D5iDjcetI8eWMInfKyS4G543oY0D6EM
         IRvQ==
X-Gm-Message-State: AOJu0YyRJRAOANLV/nOITrWhUmxTZRto3nmONas9CLQ74T1GXCB/1jz+
        oNNTxrPgSKS1Y2jFW9osoLvNrdxtjgRcCiNI
X-Google-Smtp-Source: AGHT+IGM85S4GNCgRoD8WoDgmR9Ki8qfWYn/7CM5VU5/glkxSq8H/jTUlGTWdHNMh5JLlxbaM2B3cg==
X-Received: by 2002:a0d:d54e:0:b0:5a7:ba53:be73 with SMTP id x75-20020a0dd54e000000b005a7ba53be73mr2010066ywd.15.1700322689525;
        Sat, 18 Nov 2023 07:51:29 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id k186-20020a0dfac3000000b00559f1cb8444sm1186208ywf.70.2023.11.18.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:29 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 13/34] KVM: x86: hyper-v: optimize and cleanup kvm_hv_process_stimers()
Date:   Sat, 18 Nov 2023 07:50:44 -0800
Message-Id: <20231118155105.25678-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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

The function traverses stimer_pending_bitmap n a for-loop bit by bit.
We can do it faster by using atomic find_and_set_bit().

While here, refactor the logic by decreasing indentation level
and dropping 2nd check for stimer->config.enable.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kvm/hyperv.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 238afd7335e4..460e300b558b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -870,27 +870,26 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
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
+					ARRAY_SIZE(hv_vcpu->stimer)) {
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
+		if (stimer->count) {
+			if (!stimer->msg_pending)
+				stimer_start(stimer);
+		} else
+			stimer_cleanup(stimer);
+	}
 }
 
 void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
-- 
2.39.2

