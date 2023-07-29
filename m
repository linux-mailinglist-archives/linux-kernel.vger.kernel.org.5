Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA057679C5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjG2Ai4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjG2AiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:38:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61EB5589
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:37:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso2417036276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591033; x=1691195833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jFbTWBnTo16fnwIdUW+NlD/5fy0AI1YGJZRG7rO31c8=;
        b=YbzMbVhpY6NSduIpNQdD3qQlyt9xdigEOx+DaMLJ+/1005/m6d0mQJHJ2zPdXnnIGV
         PHn40LYSFNzYKhu59r32RQyeDajteY1wVPJtsfB/vWe3BTFWN071SEBzc0fNOwPO1eRa
         Spa2H8YIfF5YdZ+xaHx46GKzIR3aKDxlq3sDHHB/UuG/fN3nAvyJSYBPjFjamloZN9VD
         qV1s0UpIMQ9KALXTP5UIutnvC6+eEr47bajzg1NdQv4o7QKOcrtCYaYLEP6HB9i0pgdF
         yccbRzKsSb90kWq3a9BqtOl9xadE/NDJQ/2KS4MDV9xqG2w2KUqOy8WhnlrcioLq9b6q
         /xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591033; x=1691195833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFbTWBnTo16fnwIdUW+NlD/5fy0AI1YGJZRG7rO31c8=;
        b=IB0T6K0dOm83QcG3dSS9vdArWSSCp+0kRizZi4pDkhTOONJNqOZvXnvstosXFJcF/h
         46ZJFzJmQomfSSihdqyqCARbuWhNe5C0i1ieHPBhwQRPt5308XQRjf0mm16+TqjTT8LR
         Oqj3gzq33nY91UXzTAPxRgaBgbGdoQotrIdmUKfd3axbNBBNWZ+V6gSDhKKEFBJFM92k
         rnR3EEQ1GYnk7sXyPhroiX0UdxyJ8Q8kILHmH1eKdatQZ46y/iyYavNHnX+vJxrKSO7r
         bXWJIYbbFKwqTRidYRpMG3uDhwNxMp+y7esfpR5z88shGA/dQxoo9ZZgr8DzktMCgR89
         oP5g==
X-Gm-Message-State: ABy/qLYdDCs50yGn55qVQbloeK0eCL5xvF6m5Mnwx5L2624FcHSh9cAt
        8TwGrPALenGHPCxCFx/Ge9wdy1EcLi8=
X-Google-Smtp-Source: APBJJlFOFAvzGLqZ3WhMfPIFqSf7CLYIGldBh6TJ0ra7wfq/Bxr6Fucq0mI7ZF8VYXYP5klQu5yNzrY8ia8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100f:b0:cf9:3564:33cc with SMTP id
 w15-20020a056902100f00b00cf9356433ccmr24231ybt.13.1690591033359; Fri, 28 Jul
 2023 17:37:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:23 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-15-seanjc@google.com>
Subject: [PATCH v4 14/34] KVM: selftests: Convert ARM's vGIC IRQ test to
 printf style GUEST_ASSERT
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Thomas Huth <thuth@redhat.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use printf-based guest assert reporting in ARM's vGIC IRQ test.  Note,
this is not as innocuous as it looks!  The printf-based version of
GUEST_ASSERT_EQ() ensures the expressions are evaluated only once, whereas
the old version did not!

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/vgic_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 90d854e0fcff..67da33aa6d17 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -7,6 +7,7 @@
  * host to inject a specific intid via a GUEST_SYNC call, and then checks that
  * it received it.
  */
+#define USE_GUEST_ASSERT_PRINTF 1
 
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
@@ -781,7 +782,7 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 			run_guest_cmd(vcpu, gic_fd, &inject_args, &args);
 			break;
 		case UCALL_ABORT:
-			REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
+			REPORT_GUEST_ASSERT(uc);
 			break;
 		case UCALL_DONE:
 			goto done;
-- 
2.41.0.487.g6d72f3e995-goog

