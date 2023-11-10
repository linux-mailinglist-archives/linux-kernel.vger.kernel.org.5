Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD76A7E7780
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbjKJC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbjKJC33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:29:29 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C247A3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:29:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5be72cd8d11so23178807b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699583360; x=1700188160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nldJcIoxrE7izfzF9tusQOHRIp84adzxmoDFeEutDYo=;
        b=zRKh4SLVVccVIIY2w+/ksNwChGdMHeCC8urKg8hX1Uj3SHDFS47SJachQQiZoLiAi2
         3s805g1nae/9qvvqbpBJ2GIyQENa1+ZDSQh+1zy/rPE3tcYTR5TXpKm1MSrxzjAyvHUh
         ndqcyEOvOMqSH6/ANOnVHKCjMoMLczgOIrqI0KoYOtIIS4tIOMZjXceHGG/4EU8SIU3e
         ah0a/KwctVPF0JUX7KP3f8863qrBcqBZiFmFi/3XjWQ7od3sLF2YSV9XmUO+JmhlV6aY
         J//CueNrqVCQcXng1Xey/Ro/sOGdMlxnmiG8736ASI7XEarduldYXGzV3a/uWzQHfSh+
         iNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583360; x=1700188160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nldJcIoxrE7izfzF9tusQOHRIp84adzxmoDFeEutDYo=;
        b=solVveqCX5m7Z+wb/qDUNuH5Jc2AOYjiDsIPUovQN5xP07SdgxOxzHVJn6lNYkWwPF
         AY4c2xRyS5e8YlmmkZPe00571Q0VEHsYZcl9c08u0nWJfi6WmPgCo6u4vtAOjZ/5ErFF
         ea83Nw8UeBVqg6N2qBhWBCZSjhHMpayws1mfbsitKaeVPUOYW8L8z0AWmc7DyVMcFDFb
         o/mKU2ncyarqvm3k+bswo7U3EcjvwYklYdNlJeW/RaVdG8G2pYVObtvASfeBDcx8VEwZ
         oUojCPOXMQgyfpWr+2IGVFi6hKGnSF9gfXd0t2iz9byFQQai4FJYpY/hxzmFfwkKtJwe
         lFgw==
X-Gm-Message-State: AOJu0YwAD2KBq41Y6oNkuAFUQpFOsDVQvSAaflicf70zF/C/AB4gG70k
        YB4adMw7f935nI1Q2y9C4ZJsgwCBi1o=
X-Google-Smtp-Source: AGHT+IFi2OuUxDtj5dLEyBOq5j0Fpq5odHUnkilHEMHd4jTjkDkeO9IJsflGDTKbTVEEKP8m+JUs86IyIw8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9286:0:b0:595:5cf0:a9b0 with SMTP id
 j128-20020a819286000000b005955cf0a9b0mr173826ywg.9.1699583360474; Thu, 09 Nov
 2023 18:29:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:28:57 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110022857.1273836-11-seanjc@google.com>
Subject: [PATCH 10/10] KVM: x86/pmu: Avoid CPL lookup if PMC enabline for USER
 and KERNEL is the same
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't bother querying the CPL if a PMC is (not) counting for both USER and
KERNEL, i.e. if the end result is guaranteed to be the same regardless of
the CPL.  Querying the CPL on Intel requires a VMREAD, i.e. isn't free,
and a single CMP+Jcc is cheap.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a5ea729b16f2..231604d6dc86 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -828,6 +828,13 @@ static inline bool cpl_is_matched(struct kvm_pmc *pmc)
 		select_user = config & 0x2;
 	}
 
+	/*
+	 * Skip the CPL lookup, which isn't free on Intel, if the result will
+	 * be the same regardless of the CPL.
+	 */
+	if (select_os == select_user)
+		return select_os;
+
 	return (static_call(kvm_x86_get_cpl)(pmc->vcpu) == 0) ? select_os : select_user;
 }
 
-- 
2.42.0.869.gea05f2083d-goog

