Return-Path: <linux-kernel+bounces-103699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A587C31E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFB81F24C37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCC76055;
	Thu, 14 Mar 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FonB+BZt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84D76020
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442507; cv=none; b=oJh2pljGh4Wdl125qSMdJCu2AyBK23x2lxeteYw5U8NLIX3IRsA22tdCGiPoZ/HuZdEcecZNlh2jgqjHp92LVLxUgy025yemoe9z9bk7x3EFE3WmQx5oGnr4J7DwywOA8SNqDjJ+BqyFtAD2ILYg8fQ1dB5qZn/jrIHrkri/z1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442507; c=relaxed/simple;
	bh=g8+m6wVhn62/YB61tWYmVaCN82OA3SBWyU5t/Mgkl/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+5ODj7MD6HU0En23xi1a2WBM6gDdC991N32eFrsXT9xykGz0sIW8bepVS5ief/4XCnQp9yFXTf7LjSUfMtUce2Xl+nRazZcg2GE7lK25gtCPs90ipwoH9/5iWLju5Dmqr1T81dswbezLXFOwxdAU/Ot/sg2Q+OJgW0YVB47gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FonB+BZt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so1909491276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710442505; x=1711047305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6+Az/OLv9UsNduwOpIQqghv3e+Z9TgGHRylS0Lw0x08=;
        b=FonB+BZtePmgYv5jIv+EUyqLqQ9398WDd1y6lA4H1jBd/Fc8hGwfUjoYIZrUyAKcMW
         5HQFTdFENZ6vAwH2IPsrF9r+xc7qwZ0WQhMwqZRiz6uT1LtljZ3ayjDkgea+iHX8ln1O
         IpE43p01lie9t3vBQADzwSlFT2Vqx5GbJiEK1V6kfxIVn8OiVCixXUke7lQe9ayBt/U+
         v+z9INrzhpjbN6rEjeSemRw5mRBk0ZGryJ4t/p4Z+M6L5fb0WZdDvuh0UP3XOc+tmoGD
         shAzyJSGRSW4dugK2Y8+bSnQA0vvuuujsebFMpN2uEqsp05zLFVyXpRD/msDob7sXkv6
         m29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442505; x=1711047305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+Az/OLv9UsNduwOpIQqghv3e+Z9TgGHRylS0Lw0x08=;
        b=MzoXBkAjwb0Hk8Vag6InRg5yLjMOQK3hRXNedzA2GI6z+s3xvPCQjcCPvwf/WnArwx
         Qvv3lobiZuomd9IumsefvyNPT0/QTMeq22yuOTlAON2/2uFGSW5PiQ+ahTwmyvlf3lx0
         LzUxwqIGb2mqaA+VUJ5V7ZKKGgCIotSr8TgEofN+U22OKBS211+flCBB3eM4OtqnWSHr
         B8kvjuLB87XUlFWtUWIC5RhLbvkn0YBKR00vF0Suwoe6+niOCHFN06ALOYJ0eM9epQGx
         iAn4LB4oaTKP9Eo5DUsHwsTwer29syja/wzKs2NpT6vdqf30vMgAGsea10+Jwqr8Pz0B
         O20A==
X-Forwarded-Encrypted: i=1; AJvYcCWwYe6JFWk3NdrgAgsrT1q2xKtI7wliCV1CZRU0D8TEyyP1cUwyYyLGaoTHc7QxKVsLFKxB1vLcOrgltyZVfYbdiVEeFiK8yxGvFSb5
X-Gm-Message-State: AOJu0YwuUK+KbaFyWgp6/doRb675LTTVCzxk8wasmFYizIZNWfmynw1M
	0YUOJbcEe1v/RWKg41ueolZkGj/sy759uiqzlWk6ayISyKBqMJLN61H808P/KB0mqHPxX1xlZwq
	lMA==
X-Google-Smtp-Source: AGHT+IEhmzPk/UcLVfOZhpWA1P7NVg8eJi7RqkeVDRHqMqz9dDS4VG4S19mrC8/iJZ2xuyNfKfSSOWHjSIU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b91:b0:dcc:6065:2b3d with SMTP id
 ei17-20020a0569021b9100b00dcc60652b3dmr1781ybb.8.1710442505154; Thu, 14 Mar
 2024 11:55:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 11:54:55 -0700
In-Reply-To: <20240314185459.2439072-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314185459.2439072-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314185459.2439072-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: selftests: Provide an API for getting a random bool
 from an RNG
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move memstress' random bool logic into common code to avoid reinventing
the wheel for basic yes/no decisions.  Provide an outer wrapper to handle
the basic/common case of just wanting a 50/50 chance of something
happening.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 11 +++++++++++
 tools/testing/selftests/kvm/lib/memstress.c     |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 4b78fb7e539e..3e473058849f 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -97,6 +97,17 @@ extern struct guest_random_state guest_rng;
 struct guest_random_state new_guest_random_state(uint32_t seed);
 uint32_t guest_random_u32(struct guest_random_state *state);
 
+static inline bool __guest_random_bool(struct guest_random_state *state,
+				       uint8_t percent)
+{
+	return (guest_random_u32(state) % 100) < percent;
+}
+
+static inline bool guest_random_bool(struct guest_random_state *state)
+{
+	return __guest_random_bool(state, 50);
+}
+
 static inline uint64_t guest_random_u64(struct guest_random_state *state)
 {
 	return ((uint64_t)guest_random_u32(state) << 32) | guest_random_u32(state);
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index f8bfb4988368..2d49a5643b71 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -76,7 +76,7 @@ void memstress_guest_code(uint32_t vcpu_idx)
 
 			addr = gva + (page * args->guest_page_size);
 
-			if (guest_random_u32(&rand_state) % 100 < args->write_percent)
+			if (__guest_random_bool(&rand_state, args->write_percent))
 				*(uint64_t *)addr = 0x0123456789ABCDEF;
 			else
 				READ_ONCE(*(uint64_t *)addr);
-- 
2.44.0.291.gc1ea87d7ee-goog


