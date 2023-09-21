Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46E7AA107
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjIUU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjIUU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:56:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348DC333B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81486a0382so1795916276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328438; x=1695933238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iAecZcdPmeU17yYV8Y2t9q6VIXYShcA0VY6qsAlVigg=;
        b=l27JPRust67iglFCZrlA1cuXvzJaR3MpW2D1Xh+UOiTFHfamI+BAuN7dmuiOyylmEj
         HNyWSWpcRpNfVg41FVEw7qlT4qulyyZj/44JdIAeaN2fv6Qn5We7fZrY/KpKmUBttKxn
         fC2AQwg+tmGbFUdRSVAVDrPBSwq4xtIENgG116kBptSxEQHYslFHDWIwLEqkJlgOqCtS
         XOMv50Kkwhl9Cr+EF10KI5aaDEV1KnIpi6ETp/afFUQpSS3Bq1H9U8w34Q71wvBaD22p
         qElp5IgKAY12O/RnQYcGwrs5+hibOFX5c4kocjIlCcEfuZjmkYxD800dby/Zag1ZXWVN
         V3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328438; x=1695933238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAecZcdPmeU17yYV8Y2t9q6VIXYShcA0VY6qsAlVigg=;
        b=TjVs+pmuxrLLM3zK2Nd9m3y58SQqpOwpsqNyKYwDqLOVymh32v5D5bv144fl8Jhjvk
         Y4xvvP/denf7gPIiJ/xOzhR4Qamzif1syAnsJQ06N06LTUL9+mcCTsJGeAVyIkITn9K0
         zsg+CVMbyFscIGagsAzpnEDAKbZ9Uhr1VIbAlBal+vKGnIz8Ly2zYLcCsR1ITPEZt0cP
         2WQdt5KLcY9BpPHaXUHod172oy0AHMKauNT2H1zJHrqltgbnWKLi1BiCKnz9uqI03Mbv
         XCcvluIv+NfF82jmPeW36ljE7/Y95vf/16p4fET/XSz4Z7qWaTFvgW450Ic6Wd/Jvr+j
         +7qg==
X-Gm-Message-State: AOJu0YyUJbbv1B1p4D0SmsZ6KKv3m5PypqbdzjusdipP3SgS3hxE399n
        bZz1gJKmFt1bDnOzfw3NC77T3iDgp8I=
X-Google-Smtp-Source: AGHT+IE6+oUdUlgLe9Ic7Hw4ijB8WbACCZNGhCwO/O53pnCY6EuyFornjYkRYInhosH4RMqIDwwt4GOWGFE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6894:0:b0:d81:7d48:a459 with SMTP id
 d142-20020a256894000000b00d817d48a459mr89384ybc.8.1695328438609; Thu, 21 Sep
 2023 13:33:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:30 -0700
In-Reply-To: <20230921203331.3746712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-14-seanjc@google.com>
Subject: [PATCH 13/13] KVM: Rename guest_mem.c to guest_memfd.c
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guest_memfd.c for the KVM_CREATE_GUEST_MEMFD implementation to make it
more obvious that the file holds more than generic "guest memory" APIs,
and to provide a stronger conceptual connection with memfd.c.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/Makefile.kvm                   | 2 +-
 virt/kvm/{guest_mem.c => guest_memfd.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename virt/kvm/{guest_mem.c => guest_memfd.c} (100%)

diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index a5a61bbe7f4c..724c89af78af 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -12,4 +12,4 @@ kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
-kvm-$(CONFIG_KVM_PRIVATE_MEM) += $(KVM)/guest_mem.o
+kvm-$(CONFIG_KVM_PRIVATE_MEM) += $(KVM)/guest_memfd.o
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_memfd.c
similarity index 100%
rename from virt/kvm/guest_mem.c
rename to virt/kvm/guest_memfd.c
-- 
2.42.0.515.g380fc7ccd1-goog

