Return-Path: <linux-kernel+bounces-77218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76686023F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C8828C8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918236AF84;
	Thu, 22 Feb 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLljWQbj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4506AFB6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628800; cv=none; b=DrgzQMU2F0kaUwGiSZh/i7s1U2/H0Vuzdvg4swu7CWTUJMkl882FcJHWg9JMTfbvZe/K+u9WDmHpUb7f+WmsFmYJoCBr9BRqLnTVF86dJ6bWRRZIkE5ZI1vDyhevKyvQ+LXV6pKk+oacQXIKfDYz6cJDLMC6ujUBA2PxQXsx7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628800; c=relaxed/simple;
	bh=cIWRw/ciFRHors/2oYNTTCOVc0HlamGjl6dwJRVdN1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7IjpGcFUKKYogeSUi/Ha3Vce1bdLuL5IgYA1YUh9QrQKBCdd+HvQ0aZw8nKvl/UddV1uyN3AfFNaWi7zP6PQ4t+e9qpS6m0WAXi24G2uUFVVxwvt5qCGxbbuhInkpCoY8Y3va+skr2C5W9bi7ZaShIvYb+8S2A6+uCxbQFxPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLljWQbj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso15390997b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708628784; x=1709233584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=riJ7HRTQ7IsaxxoiPw34+GvPTL1t25LYSZ+Y64H+IpU=;
        b=ZLljWQbjVNJupQi4T7YcKqIFlPrh0x02R8ZFdng1L4U7qgPX5tTi/GPKxJ9C0LoR2f
         83g0utNm9hSd1Wup7EYKEOEpGJaF3BeVw2h7Hy5988W6GPYsEBG6UVvBhNMQaUsZO/BP
         luOqsxWQh3v0SAmJRuGPOK2SWqb7Z2LKXu/6/W+ncXDQpZUg7TofywmfOym86q4Yghox
         HT3lvegL5RwwidfHxf0vDstfrVg5WQosaDsG3k+wiuRip5bHaDEL9qLl+dLpvr2mPWHT
         7LwN1s24y+0eezpMWFFzjmNiJF+UtIHR68fDYFPHvZ0axoWkBScqnMbToTeSAwW8FqOv
         pCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628784; x=1709233584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riJ7HRTQ7IsaxxoiPw34+GvPTL1t25LYSZ+Y64H+IpU=;
        b=XovANwIeOfZXf6mCmDiqludy6ALQ8oaZAN0tu56HO99cRHk79mjhnQT6ZQKuqhP3my
         JIT3AldQfXqoyszXXEKnzriBKSzeiHutKXQJRlvCDbxEI2x+37fGtWTefMIsWVEX9qjn
         2JQECqo4x+iyp0+ozV7D2sJPKRZAqMpB+Je5+hzDo9CxlGEP80WrnDX1NiW/+/QzqIu2
         qwxiaskxfeVxiFbP0QfPqfM09x7IUEwQePZ2vlFnuKKAG2jukEZ1SZY6rhzqJG8dwMe2
         NfCkYGFfuD22zFbo5Iys0Ip8eeGpC/w/0lwY7A8iSVmjICZF/iYV4flYQV6gHUDgX3h/
         VQpw==
X-Forwarded-Encrypted: i=1; AJvYcCVMpyVqVQcq27+Sg+6QLcAXWLA8i1vddcDUalS/v53ZenGGi76O9UGgYEqaD5mFDBnkY9lgjuK4m1lhoL3fXRZAIWjUOD1AEH0GH0CU
X-Gm-Message-State: AOJu0Yw4NaqsVtWE2+mQ7W0PjKAKUviegkn3gvdC+9mjkZuckwYE5+yy
	ObR1Wl7MGrf61ptfSI3a8IYWsITySaMA92m5FBTN/A4zAIvXAqAyZnRBI57epgkvFKMlTAqYQOX
	M5A==
X-Google-Smtp-Source: AGHT+IHK+000I6aYNhYwLooXEmohmYz3fy083+ikkdIHowbT0ZCvhybvYWO5SGzJhGJoTQp8dbEOocVxQ4A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2846:b0:607:f42f:70e1 with SMTP id
 ed6-20020a05690c284600b00607f42f70e1mr737848ywb.4.1708628784418; Thu, 22 Feb
 2024 11:06:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 11:06:12 -0800
In-Reply-To: <20240222190612.2942589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222190612.2942589-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222190612.2942589-6-seanjc@google.com>
Subject: [PATCH 5/5] KVM: selftests: Add a testcase to verify GUEST_MEMFD and
 READONLY are exclusive
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend set_memory_region_test's invalid flags subtest to verify that
GUEST_MEMFD is incompatible with READONLY.  GUEST_MEMFD doesn't currently
support writes from userspace and KVM doesn't support emulated MMIO on
private accesses, and so KVM is supposed to reject the GUEST_MEMFD+READONLY
in order to avoid configuration that KVM can't support.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 9df4b61116bc..06b43ed23580 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -375,6 +375,12 @@ static void test_invalid_memory_region_flags(void)
 		TEST_ASSERT(r && errno == EINVAL,
 			    "KVM_SET_USER_MEMORY_REGION2 should have failed, dirty logging private memory is unsupported");
 
+		r = __vm_set_user_memory_region2(vm, 0,
+						 KVM_MEM_READONLY | KVM_MEM_GUEST_MEMFD,
+						 0, MEM_REGION_SIZE, NULL, guest_memfd, 0);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION2 should have failed, read-only GUEST_MEMFD memslots are unsupported");
+
 		close(guest_memfd);
 	}
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


