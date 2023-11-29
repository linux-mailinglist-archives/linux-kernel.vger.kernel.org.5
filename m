Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF827FE35B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbjK2Wkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjK2Wkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:40:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D112F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:40:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cf89e16993so5319465ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701297647; x=1701902447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+v1jFIXf64LmcoETe5BxvZaUtddzr4bC5h258OJRYc=;
        b=PHKVRTCknguXhqDUmvoRRFUu4bSAKjEzdVDF949SKeNHF7yvgSn279Prc1jFx7Df3G
         oDikiZ1EweFDjkDjVUTYQnqZ6T8jCXgaoWtXA5sdDYzOmdBzZaRAAqAWVVrAsvxA4Usv
         /xpYFWXiGj070fds/8A9+g8uy3SMkBpPM8aWbr7cL4ghCTl8pSMj32wPQqHfcZO27bu4
         7rNjtoBVHXkuKp3xuhLAht0bJpI4u7Gr8m1FRBoy0xm8klWuGX8nmsJIFUuP/QJkxVbY
         zEmhyX8NbZz5dC3AaLH6Q5deLoF05Wys23HWYmS8wKoyy/N/Jb2rvhLdHMl0cR+0ZQo9
         7n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297647; x=1701902447;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+v1jFIXf64LmcoETe5BxvZaUtddzr4bC5h258OJRYc=;
        b=j++wQnAXFyaTZtzTB4xHEOaR/NQRyMx83yONwfwQTEmb4v535pc2WNNsLwiyQihMu7
         Jy2fG0mcY90UxKTmj/8WNlaWJhQdsoKHj9ebmRs5zTG67IviEOMd4kGhZbNOK4RIEyFA
         sfyQBfEfzqoDEc5SoxQxtumauCY5S4eF6KB0gZ/4wHz+pmI+baUa39zAu5p2Xa/1qy0u
         Q2RTTVbysO30PO267w33enArVUVTuWIW2WLe3z6PfxIGNb40Q5/dihpCoQEiJeLCi2Uo
         qnpnKCRMvMalxx3LJGN4AAZCX+KUDo4NO0x8zYV/0AuA0FztibeevqOV3dwUUIGpgB/2
         2vGw==
X-Gm-Message-State: AOJu0YyEaEVT24MNmCTbV0V+U3q1HanD27cbrP/2TzMevv2bImo8XJLn
        fr7vlyokh60NuwlPDjUQNENUcvfpWWM=
X-Google-Smtp-Source: AGHT+IE5FIx8aj45AxYw5oGrpfmlhBTeeHtp2XvpoNiWQUQ3HX1upYM4wJ2O05QcEx+FY+pXbc9cnIHteb8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f68e:b0:1ce:5c2d:47e with SMTP id
 l14-20020a170902f68e00b001ce5c2d047emr4791132plg.5.1701297647010; Wed, 29 Nov
 2023 14:40:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 14:40:41 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129224042.530798-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Reword the NX hugepage test's skip message to
 be more helpful
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the NX hugepage test's skip message regarding the magic token to
provide all of the necessary magic, and to very explicitly recommended
using the wrapper shell script.

Opportunistically remove an overzealous newline; splitting the
recommendation message across two lines of ~45 characters makes it much
harder to read than running out a single line to 98 characters.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index 83e25bccc139..17bbb96fc4df 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -257,9 +257,9 @@ int main(int argc, char **argv)
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_VM_DISABLE_NX_HUGE_PAGES));
 
 	__TEST_REQUIRE(token == MAGIC_TOKEN,
-		       "This test must be run with the magic token %d.\n"
-		       "This is done by nx_huge_pages_test.sh, which\n"
-		       "also handles environment setup for the test.", MAGIC_TOKEN);
+		       "This test must be run with the magic token via '-t %d'.\n"
+		       "Running via nx_huge_pages_test.sh, which also handles "
+		       "environment setup, is strongly recommended.", MAGIC_TOKEN);
 
 	run_test(reclaim_period_ms, false, reboot_permissions);
 	run_test(reclaim_period_ms, true, reboot_permissions);

base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
-- 
2.43.0.rc1.413.gea7ed67945-goog

