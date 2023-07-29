Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC27679E1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbjG2AkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjG2Aju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:39:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073484EDB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:38:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbbc4ae328so20188995ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591060; x=1691195860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MF+bXwxuzawTID7VRrTPOhSciVZgdU/b6cmoH5k6//k=;
        b=3XTnvyalsgYeWNIfRKpoVdZ9znRrqsMtDLiXzSBNXaL9ulyyhk9kCqs4X/p4w5FS6j
         Pnv8yfYZMfdH2C/ay8U7ENPGEFJhc7w/CuemxdRRz8eH86xSNifWP5ZwzANBP9/oB3HR
         3sWZhNhDLBgeMvHiiHeOED7DQdTXZjwa5JfxyvUZpfD5ac2/IpwN7YHxBboIFfGzXvwu
         rcJeMPbFvOsf9vMaE1lIRBQYFMqbPiazr3IJt7WvHcHc9CpIVXngyazah+wdv3GVsiVp
         hpSJlgpGel/1zstInYMbykQhPKknMzf1f8cRcpRQ06xGV39obcipHA+c6rQln+Jb9MQN
         WYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591060; x=1691195860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MF+bXwxuzawTID7VRrTPOhSciVZgdU/b6cmoH5k6//k=;
        b=Nf+fraJqoeb+nX6btAnMIZ3nXLBTGtQeZ+NL5Wv4X0fOI5iAmXNoFg+WRVepJHriNR
         1fpm/a186EJUQD3cexj1+fROBfnxbLLAaWOMAxEoAXJr53tcJFUDpC2JBbMWn6WLa49L
         jwnokcWY7Ff3btIbRb1C+izclX5dnqrQq4DqagTTThwuWGSNci227BrPN1YTB1dc4+uX
         rKhUqTt5R9hCrjjkvJRdn36Fe4QhEXS3F2rec85MsPo2JZcucSGrCR792jyMjigAwltx
         vht4LILm567zhlYdJ2tzYrr8G0zvd3lFX/pQ6aBskm4rxYwG88dtlJwDMALB6K/S37ZI
         tVUw==
X-Gm-Message-State: ABy/qLbArxnf5PXOagYvozeJvb+GlpjHDzekAfhTxF8VURPFcVN8hpEA
        uPY0QxvL4gf9ixenJm3k9qyIwCEd5Js=
X-Google-Smtp-Source: APBJJlFmabRF0RxzQGT8BcVKXP0SGH0X5me+cEjliMepzv+strLs30XZHxwmIQzJ9Engiax0UKUvH6M/avo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:eccc:b0:1ba:1704:89d1 with SMTP id
 a12-20020a170902eccc00b001ba170489d1mr13265plh.10.1690591060423; Fri, 28 Jul
 2023 17:37:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:37 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-29-seanjc@google.com>
Subject: [PATCH v4 28/34] KVM: selftests: Convert x86's TSC MSRs test to use
 printf guest asserts
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

Convert x86's TSC MSRs test, and it's liberal use of GUEST_ASSERT_EQ(), to
use printf-based guest assert reporting.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index 9265965bd2cd..cf9114f70e1c 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -4,6 +4,8 @@
  *
  * Copyright (C) 2020, Red Hat, Inc.
  */
+#define USE_GUEST_ASSERT_PRINTF 1
+
 #include <stdio.h>
 #include <string.h>
 #include "kvm_util.h"
@@ -84,7 +86,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 		ksft_test_result_pass("stage %d passed\n", stage + 1);
 		return;
 	case UCALL_ABORT:
-		REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
+		REPORT_GUEST_ASSERT(uc);
 	default:
 		TEST_ASSERT(false, "Unexpected exit: %s",
 			    exit_reason_str(vcpu->run->exit_reason));
-- 
2.41.0.487.g6d72f3e995-goog

