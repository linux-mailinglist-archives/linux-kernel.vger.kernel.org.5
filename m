Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20897679CB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjG2AjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjG2AiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:38:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED55593
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:37:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d052f58b7deso2516084276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591037; x=1691195837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngl8lC+/wGQlijkr13PT2tPWtqTwIZBUn/V8pQLJnsI=;
        b=jTQgJijvaSA87s20WcW+DJNYcBr6iycXkShWiPEyn+ZHzYOOnQWRcWv0EDcUck3WSB
         dDF9I/Q1ySsvk1kWojQd9tEW8CDUPb3rTBRDLk/39KSQDC1qIvUaOTYBgFEBQSQG5ATK
         8R4xRcct2Y93O33tOsGnfxwy3mlvnE7TbvOuNpUzxRO2IweGEzpWlv7WtggKrSBIcfG9
         sEllWKhZpl8xKL/qkLMA6jfKxBkcLUU8sa+YBP7gnqHUx9AQjq6pptXGY8yhdC+XrS3V
         Cvu0hwoiZQ5M1a1Zqzfe0E2sT4WnjUBLlClEx7LF5ZDnUPi2DLOSqL0+TuJZZvycUOll
         a2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591037; x=1691195837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ngl8lC+/wGQlijkr13PT2tPWtqTwIZBUn/V8pQLJnsI=;
        b=fxyZ0bd/qRgKc9X83OyZFIaduzLoSP8duvRDjxC7vYuaC/A0ibMNyjDT8BXwRRC2KY
         D/rDv3e4ulzhUNLGVutEONxXV5CgnsM9BXvuPRvoKJGv+XDikTGa0bf5ah/ekKdRVCTZ
         GcfwGfhxgIPB0iJqbJ6Nj7qwQOIqHUoz1/dxTrXwbprJiEhMuQLFXr3qQ7nbOna3eWsq
         +fKwt2M226ru6VYKNdlRqNpk/dKmmdUgjWVqlqGXCAM2psZwgslMSiBKtpiYLwreu/P3
         ZVNE8lJgEpB6DawQvg/iew991JsswKbGewCvXnyaSBAHIvSZVnxxBbeS2kJqtXOdTyA+
         8TqQ==
X-Gm-Message-State: ABy/qLZ41ujaTkUnTxvPB19A8ImJNL34VORAOzIZ9SBTH1TrJkn0c5zw
        hu3JvWKka2M4xFhDGtQC4yyMxU9Ho2I=
X-Google-Smtp-Source: APBJJlFyvjHiUTrdRegL0ZLMZ9b9mCjMN4KTPZtSt6e6xxSeT5N2o2AAxi3EjqMwYiXS5k9L3PQ7RQatewc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:20c3:0:b0:d11:b0d5:cd01 with SMTP id
 g186-20020a2520c3000000b00d11b0d5cd01mr17235ybg.8.1690591037120; Fri, 28 Jul
 2023 17:37:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:25 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-17-seanjc@google.com>
Subject: [PATCH v4 16/34] KVM: selftests: Convert s390's memop test to printf
 style GUEST_ASSERT
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

Convert s390's memop test to printf-based GUEST_ASSERT, and
opportunistically use GUEST_FAIL() to report invalid sizes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index de73dc030905..a49173907cec 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2019, Red Hat, Inc.
  */
+#define USE_GUEST_ASSERT_PRINTF 1
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -279,7 +280,7 @@ enum stage {
 	vcpu_run(__vcpu);						\
 	get_ucall(__vcpu, &uc);						\
 	if (uc.cmd == UCALL_ABORT) {					\
-		REPORT_GUEST_ASSERT_2(uc, "hints: %lu, %lu");		\
+		REPORT_GUEST_ASSERT(uc);				\
 	}								\
 	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);				\
 	TEST_ASSERT_EQ(uc.args[1], __stage);				\
@@ -469,7 +470,7 @@ static __uint128_t cut_to_size(int size, __uint128_t val)
 	case 16:
 		return val;
 	}
-	GUEST_ASSERT_1(false, "Invalid size");
+	GUEST_FAIL("Invalid size = %u", size);
 	return 0;
 }
 
@@ -598,7 +599,7 @@ static bool _cmpxchg(int size, void *target, __uint128_t *old_addr, __uint128_t
 			return ret;
 		}
 	}
-	GUEST_ASSERT_1(false, "Invalid size");
+	GUEST_FAIL("Invalid size = %u", size);
 	return 0;
 }
 
-- 
2.41.0.487.g6d72f3e995-goog

