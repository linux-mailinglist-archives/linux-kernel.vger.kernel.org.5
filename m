Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAB7679B2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjG2AhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjG2Ag7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:36:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9776735AB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:36:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5843fed1e88so26716337b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591014; x=1691195814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Pu8s+tZVLEYyiWqFZT+4FnWB/kYWBw56lgxTY04lg=;
        b=QhOCz4agpP5D5cbpsEZdNZlI5wRey05iapUs6eqbsCyeWw7ESGDEaWL+JAIY5SreVo
         j4pjb93sMrM6hSxu6w1NyfTe0JbHBmnKzcSv8XEHiOxiqzRovWo0kdaZNgOMIaC1LEmO
         uBeX0ALUqhXhfo9xI+4stfGH9a4o+HD2bd3H/Z2c/1xXwHy1QrfRssnf1Gu3oPEy3rvP
         Cp4Y2ayDWQqnOoPjgFaSM4cN0ajnTBpyLN0nMdsGRL7mNczp8jpfjXG/KGcgbQSSClEe
         jHWhHsMP3HKknY07k/h2dlQ/7+/Qp8Z/7Ko2t314af5vv9Hv0O/jrmNV/8FUZdmWsODb
         9/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591014; x=1691195814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3Pu8s+tZVLEYyiWqFZT+4FnWB/kYWBw56lgxTY04lg=;
        b=VXSpQDbar+xbBKFn940zP9ALWZnn67b/SA6vRXn0/8DGLuMPmLr0lpfdHx05Di6ESi
         1iGUC5ik8eETGyVdG+mIbdodkzPDf5DvcvKXjvXd6uyc3sGd47F35nKdjZvV4+gScaQ8
         +IVODpnzL42r6EFtEKBgnFTLnhnRuNZXArfLsDsOk+z3ZyJ7euguzzToZI7vWFly4NTl
         +cTcqIQmdvygNAvCyJXNl93xofqHF5E7KH3BPz3qfRc0h6vbO4Fmiah2GxAapKSiT2K7
         3/PBeMyYRm3zOEv3BADjC0Vnw62dIw8/BHyse0raQU26BOKDsvbFDs+Yt6TpuKnmuucl
         BBRg==
X-Gm-Message-State: ABy/qLYJ9W90ryKcSbUbrBgtA4x3atpdC4PrJJrYsj/FAjHt5D9DCiib
        y1Go34vdxWF2FmSbAVWFW+5IZV8lKLs=
X-Google-Smtp-Source: APBJJlGW0fmejVcH9KMrFQrUYFzrJ+xt9BpeDmhOtEq6gjiJBZGY9QsusOFgjsma9PSCF+gN7f3Yz2Qr00k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad27:0:b0:581:3899:91bc with SMTP id
 l39-20020a81ad27000000b00581389991bcmr22355ywh.6.1690591013864; Fri, 28 Jul
 2023 17:36:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:13 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-5-seanjc@google.com>
Subject: [PATCH v4 04/34] KVM: selftests: Add strnlen() to the string overrides
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

From: Aaron Lewis <aaronlewis@google.com>

Add strnlen() to the string overrides to allow it to be called in the
guest.

The implementation for strnlen() was taken from the kernel's generic
version, lib/string.c.

This will be needed when printf() is introduced.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile              | 1 +
 tools/testing/selftests/kvm/lib/string_override.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c692cc86e7da..f6c14ab476ac 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -204,6 +204,7 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD\
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
+	-fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
diff --git a/tools/testing/selftests/kvm/lib/string_override.c b/tools/testing/selftests/kvm/lib/string_override.c
index 632398adc229..5d1c87277c49 100644
--- a/tools/testing/selftests/kvm/lib/string_override.c
+++ b/tools/testing/selftests/kvm/lib/string_override.c
@@ -37,3 +37,12 @@ void *memset(void *s, int c, size_t count)
 		*xs++ = c;
 	return s;
 }
+
+size_t strnlen(const char *s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
-- 
2.41.0.487.g6d72f3e995-goog

