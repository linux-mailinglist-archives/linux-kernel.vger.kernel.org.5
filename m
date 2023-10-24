Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E327D43D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjJXAQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:16:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9902F10C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:16:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af53bde4so53769537b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698106609; x=1698711409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jq7rtvs1J7SUa9QYH0420MH6Fu/kuIgYkCbKvTY6XYY=;
        b=SjvGOKPcCTxWApoChHPHp/hxH4zxspSqapH2ECYLSyOZllFII4jQ93D3yk8bLRq6wt
         pec5GR9sq+shHUclsbw/cIHLvcJYCgAkViHQprjbbJdekNXvPSqVAaioTuo0OYsmJhWL
         u/JA8zeE5RmuEcWVloySqUa2CxOeYjegZJfQm8eQiCdD2MIOXbUGL3m+y/+09/iQPVEN
         uxdaB7w35KFBiIzLBcboVzVaBi7+e8C0pQQ/CKIkMrN0Xa97ZNZjF6ja6bGf465oO88n
         KqYaWUYi2XFkf9IG7IwWBBIXxP6A8f4Vvd3vng2yZwH5bekMVHJE3g3LBpGFVHSYCWrg
         zIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106609; x=1698711409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jq7rtvs1J7SUa9QYH0420MH6Fu/kuIgYkCbKvTY6XYY=;
        b=tQrEF/MCScfabPTCiTflvlnYsd09bouAmoh7ZRt6ywjs2bZG8LQcssBmApJZviFeGj
         3wE98JTlGMdpgzRLR6GYZiRuN0KX80y2OnDOaw7xn6AxuT2lkSN2iykh4ooXHsO5ZAdM
         ImCmvEI/3C3JFQGbT9gCZxE/mUpdsDWRYZuPrIhN6juDf62qlh5RtX7OHl6rrTSZ6A59
         +2qtFuD3BtDkju8EHLIFhNSgK3p1d5jbUb+a484CrvI8iUffVZifSdXIRqNfo+3tFGNS
         G1i6RtYj9sc40R1/1pFYkPwAz0Sf7aJpCVTpq6GyQoklnPCtReqTTSOrSQjz4xaDtWsu
         cwRg==
X-Gm-Message-State: AOJu0YwlxBPAjnsxtcXdXDqAq6eQCDVk1qZKEiBWAo9s8RxODM+3OOl1
        JFkjWl1zCFrX5nB4X72gqoVoKy8nONZxRA==
X-Google-Smtp-Source: AGHT+IGZOfAFi3nsQR5p7LrthXVc6u/3+9MpxGGoTkswf4ocigRZqDS76dU33/LXsGZUeCrGq6xqVytNnVYEqw==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a0d:cc91:0:b0:5a8:15c4:5314 with SMTP id
 o139-20020a0dcc91000000b005a815c45314mr234855ywd.4.1698106608846; Mon, 23 Oct
 2023 17:16:48 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:16:36 -0700
In-Reply-To: <20231024001636.890236-1-jmattson@google.com>
Mime-Version: 1.0
References: <20231024001636.890236-1-jmattson@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024001636.890236-2-jmattson@google.com>
Subject: [PATCH 2/2] KVM: x86: Use a switch statement in __feature_translate()
From:   Jim Mattson <jmattson@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "'Paolo Bonzini '" <pbonzini@redhat.com>,
        "'Sean Christopherson '" <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler will probably do better than linear search.

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/reverse_cpuid.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 17007016d8b5..da52f5ea0351 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -116,20 +116,22 @@ static __always_inline void reverse_cpuid_check(unsigned int x86_leaf)
  */
 static __always_inline u32 __feature_translate(int x86_feature)
 {
-	if (x86_feature == X86_FEATURE_SGX1)
+	switch (x86_feature) {
+	case X86_FEATURE_SGX1:
 		return KVM_X86_FEATURE_SGX1;
-	else if (x86_feature == X86_FEATURE_SGX2)
+	case X86_FEATURE_SGX2:
 		return KVM_X86_FEATURE_SGX2;
-	else if (x86_feature == X86_FEATURE_SGX_EDECCSSA)
+	case X86_FEATURE_SGX_EDECCSSA:
 		return KVM_X86_FEATURE_SGX_EDECCSSA;
-	else if (x86_feature == X86_FEATURE_CONSTANT_TSC)
+	case X86_FEATURE_CONSTANT_TSC:
 		return KVM_X86_FEATURE_CONSTANT_TSC;
-	else if (x86_feature == X86_FEATURE_PERFMON_V2)
+	case X86_FEATURE_PERFMON_V2:
 		return KVM_X86_FEATURE_PERFMON_V2;
-	else if (x86_feature == X86_FEATURE_RRSBA_CTRL)
+	case X86_FEATURE_RRSBA_CTRL:
 		return KVM_X86_FEATURE_RRSBA_CTRL;
-
-	return x86_feature;
+	default:
+		return x86_feature;
+	}
 }
 
 static __always_inline u32 __feature_leaf(int x86_feature)
-- 
2.42.0.758.gaed0368e0e-goog

