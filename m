Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF257DF9CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjKBSQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjKBSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EB0193
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX9pDYhUv0xNWCwt2hkI8FAcvsPw051Wv1MARO9LEh8=;
        b=FOVvAT9jGjFKOX7lJDq9F37aroIE+8WU6feEIfqXeISriC1ts5Xx3602+JtGBl6a+jpUhe
        wJG4UQo5iy+gzT/q86rTsO/05Qw3QKtc5uh4nqhDXNBDDUJfXHMmWuKrjD8Pwpnbbx5Ft3
        eCC03cX6M/SyNxrwuNcgAINoQ27spyo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-WYQY4-eEMGiSE7At3GEVbA-1; Thu, 02 Nov 2023 14:16:02 -0400
X-MC-Unique: WYQY4-eEMGiSE7At3GEVbA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c56c75ea84so2546641fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948961; x=1699553761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX9pDYhUv0xNWCwt2hkI8FAcvsPw051Wv1MARO9LEh8=;
        b=hNxZKbsPbFE0mdpukCGclcphJjVba8bcrU53IpzeYjcxjPrOdt+fsOHNtS3ym2Cq+5
         E5QoWsx47mgvS300tlplOkY3i2OcJPjUoH2FvTfz98pphalsUJmIwrOy4Ozx92dXQ5C7
         NQbSpAM8VSNBzkSku/sLyFsFWhPilLVtcKd0FLFm2bylTbwIwsijPMZhgslidAdPui/7
         5SIwXAX/EOgbF6mnWjlu7gPKAorhaVjCWHz97dMhG0HgnV+56V/juzcz0lmP5VIP9Giq
         VrYJQu8mxBEpzDUCfDek9omAtDY2aDRBKds50fHYhjSUTWCcERa7CDtFy24ehALFuLAf
         WD1w==
X-Gm-Message-State: AOJu0YzrYGgT9fPYuzyHEAxzi8boyXIT6VNXZxVZb8Ad7FO/97hA52tl
        12pK9p+qJFVz8wYwrb/rBh/5o+CvzakIz6YRTKSJZftDL2O4hUNEuYpoU2AG++kbXkzq0xr/ZhZ
        L2WTHuxjaqApUtZtJk6rCHJkf
X-Received: by 2002:a2e:b5cd:0:b0:2c0:7d6:1349 with SMTP id g13-20020a2eb5cd000000b002c007d61349mr13191938ljn.0.1698948960946;
        Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA9GFg/9wbEsQk9hiRtyKr5Sw8+tU0lzjpfffLtjFPJgequPAx/iZqfrIIRwYQeDUno1rPwQ==
X-Received: by 2002:a2e:b5cd:0:b0:2c0:7d6:1349 with SMTP id g13-20020a2eb5cd000000b002c007d61349mr13191934ljn.0.1698948960612;
        Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 1/3] arch/x86/kvm: copy user-array with overflow-check
Date:   Thu,  2 Nov 2023 19:15:24 +0100
Message-ID: <20231102181526.43279-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102181526.43279-1-pstanner@redhat.com>
References: <20231102181526.43279-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuid.c utilizes vmemdup_user() and array_size() to copy two userspace
arrays. This, currently, does not check for an overflow.

Use the new wrapper vmemdup_array_user() to copy the arrays more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 773132c3bf5a..4a15b2a20f84 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -467,7 +467,7 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 		return -E2BIG;
 
 	if (cpuid->nent) {
-		e = vmemdup_user(entries, array_size(sizeof(*e), cpuid->nent));
+		e = vmemdup_array_user(entries, cpuid->nent, sizeof(*e));
 		if (IS_ERR(e))
 			return PTR_ERR(e);
 
@@ -511,7 +511,7 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
 		return -E2BIG;
 
 	if (cpuid->nent) {
-		e2 = vmemdup_user(entries, array_size(sizeof(*e2), cpuid->nent));
+		e2 = vmemdup_array_user(entries, cpuid->nent, sizeof(*e2));
 		if (IS_ERR(e2))
 			return PTR_ERR(e2);
 	}
-- 
2.41.0

