Return-Path: <linux-kernel+bounces-136992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59689DAD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E53DB277B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495DF1304BD;
	Tue,  9 Apr 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJ2CPw9B"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7A12FF6E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670019; cv=none; b=Gi+Yeqz2+/4hgQbIPV6LECFuP88z1UnRA8d+/TD9oj4rZbdAti+OkyoxYsdkpfIxqZtIbtFYcLbzjNy6tgXpAeFvFkiD3kPdtnfCun58+ipmdtwIoZFXvtmtG07JL9OWM+DqP6fH5bgn7h3+3z9vuBXXpBAX/9ruAs9cbMnS58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670019; c=relaxed/simple;
	bh=Z/U6MkL66HxoT+vTZDuph/p77ad7akTXVDFy/jh9Y9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUgy+KtL0m9QxKgE5Pruu8CFfRWDxGFpoYeEB7IhHfippEDIdIAIdxmQ7erJ/p9WvBU6/miIdLrfuGl2nya45nRlKdiHoyO++5uj2a6GRETAEvwyaHeLigLLwKR2XLJWQ+MJcLGiUGrMX0Baa+qgaEULNlkZvUWMk9jT7oGW2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJ2CPw9B; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ecec819962so5482298b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670017; x=1713274817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+kM2gskGXg+GS3w8WpbJGsHCOXskkusBzj+iWlJPXA=;
        b=mJ2CPw9BkId3qp9fNuFQ+ew/E9oVpyfjfK6HsBw9B9Eaiv4wov0Zv3bGRU4UGoGevd
         ANGMA5Mq3MzOcpbLCVvhueQJd4Atbad+m1DehApuaQHwr/uL5R97koBHq1oKAzJTjQ5C
         Vp4ocrI5NrXBfHqLklLH9P3qvNC/nUNl4xVttNg7B5e6OmKkZRJWgv4NsPxeiOmkOePv
         iNs2iNYhtzhE0I3ageEDHE+KlPUqu36HTxGVkyaUmMyVy3DzwgCSFGN8lexYKApiYQad
         O1ZmAC6dhPZmQQuWdsiAcmAttU3sx+VayVLXp5kd8ChRLMT3Qh0CuMkIdlKDPF/MPWrC
         N4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670017; x=1713274817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+kM2gskGXg+GS3w8WpbJGsHCOXskkusBzj+iWlJPXA=;
        b=qb6WJSroc+uTQeAuYhxL59NPz9sERREG9xRcNmBFzJ9LczRv1AKK8+L3UpbhKYFZLB
         JZIBc2aQo8AgF8oF9T1G+2QZ9JTMwsUGWDcB/vUeND/K8YyEw5CYydkT0DyJ0YPJrWmg
         3AOeGJcVfOmgZNfKu9+r1HE/4GyNLxwpbSWctPuGPqQzSxS0bJU/CwC3z30yGaYuTter
         I3f3yMx9m4ExdUHHBM8M4GGewka0f4Yu3oCTdefcSAYbd7j6QWm0CajmdOuPctGWZNdu
         jDCN38R2FyFzvJEmW1TZ5aITD9doqr2dFDzQqPvYfX4znf8jxoEvu502b+/PAuDpqKWL
         /KlQ==
X-Gm-Message-State: AOJu0YxPY1CXX+NI1EBhU5RwI7+jqi4IZHuMVsFNzb60+TpZJjaLlOR3
	16xlWfglUy2y7T3zc1JgTd+ECmBGk3smrSX+G1KB8hqKIY5VFAqG0yIXUlDdLUvBiUoCnqMeFe2
	aRg==
X-Google-Smtp-Source: AGHT+IGBuHKLW5PWmsVZ2jiNCEZO8Az0aSwA/6HN0OwslonsXsvkheLB/AwbPsX6Z63jLae7+p8c0qoEseg=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:2353:b0:6ed:4203:bdc8 with SMTP id
 j19-20020a056a00235300b006ed4203bdc8mr198689pfj.1.1712670016967; Tue, 09 Apr
 2024 06:40:16 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:54 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-2-pgonda@google.com>
Subject: [PATCH 1/6] Add GHCB with setters and getters
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the GHCB definitions from svm.h to the tools/ copy. This allows the
SEV-ES selftest to use GHCBs which are required for non-trival VMs to
paravirtualize NonAutomaticExits (NAEs) when SEV-ES is enabled. GHCB
getters/setters have a warning with address-of-packed-member, so removed
this using the CFLAGS.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 +-
 .../selftests/kvm/include/x86_64/svm.h        | 106 ++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c75251d5c97c..95fa0cead256 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -221,7 +221,7 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP \
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
-	-fno-builtin-strnlen \
+	-fno-builtin-strnlen -Wno-address-of-packed-member \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index 4803e1056055..fbd8d29c15a8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -323,4 +323,110 @@ struct __attribute__ ((__packed__)) vmcb {
 
 #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
 
+struct ghcb_save_area {
+	u8 reserved_0x0[203];
+	u8 cpl;
+	u8 reserved_0xcc[116];
+	u64 xss;
+	u8 reserved_0x148[24];
+	u64 dr7;
+	u8 reserved_0x168[16];
+	u64 rip;
+	u8 reserved_0x180[88];
+	u64 rsp;
+	u8 reserved_0x1e0[24];
+	u64 rax;
+	u8 reserved_0x200[264];
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u8 reserved_0x320[8];
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_0x380[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u8 reserved_0x3b0[56];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
+} __packed;
+
+#define GHCB_SHARED_BUF_SIZE	2032
+
+struct ghcb {
+	struct ghcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct ghcb_save_area)];
+
+	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
+
+	u8 reserved_0xff0[10];
+	u16 protocol_version;	/* negotiated SEV-ES/GHCB protocol version */
+	u32 ghcb_usage;
+} __packed;
+
+/* GHCB Accessor functions */
+
+#define GHCB_BITMAP_IDX(field)							\
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
+
+#define DEFINE_GHCB_ACCESSORS(field)						\
+	static __always_inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb) \
+	{									\
+		return test_bit(GHCB_BITMAP_IDX(field),				\
+				(unsigned long *)&ghcb->save.valid_bitmap);	\
+	}									\
+										\
+	static __always_inline u64 ghcb_get_##field(struct ghcb *ghcb)		\
+	{									\
+		return ghcb->save.field;					\
+	}									\
+										\
+	static __always_inline u64 ghcb_get_##field##_if_valid(struct ghcb *ghcb) \
+	{									\
+		return ghcb_##field##_is_valid(ghcb) ? ghcb->save.field : 0;	\
+	}									\
+										\
+	static __always_inline void ghcb_set_##field(struct ghcb *ghcb, u64 value) \
+	{									\
+		__set_bit(GHCB_BITMAP_IDX(field),				\
+			  (unsigned long *)&ghcb->save.valid_bitmap);		\
+		ghcb->save.field = value;					\
+	}
+
+DEFINE_GHCB_ACCESSORS(cpl)
+DEFINE_GHCB_ACCESSORS(rip)
+DEFINE_GHCB_ACCESSORS(rsp)
+DEFINE_GHCB_ACCESSORS(rax)
+DEFINE_GHCB_ACCESSORS(rcx)
+DEFINE_GHCB_ACCESSORS(rdx)
+DEFINE_GHCB_ACCESSORS(rbx)
+DEFINE_GHCB_ACCESSORS(rbp)
+DEFINE_GHCB_ACCESSORS(rsi)
+DEFINE_GHCB_ACCESSORS(rdi)
+DEFINE_GHCB_ACCESSORS(r8)
+DEFINE_GHCB_ACCESSORS(r9)
+DEFINE_GHCB_ACCESSORS(r10)
+DEFINE_GHCB_ACCESSORS(r11)
+DEFINE_GHCB_ACCESSORS(r12)
+DEFINE_GHCB_ACCESSORS(r13)
+DEFINE_GHCB_ACCESSORS(r14)
+DEFINE_GHCB_ACCESSORS(r15)
+DEFINE_GHCB_ACCESSORS(sw_exit_code)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_1)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
+DEFINE_GHCB_ACCESSORS(sw_scratch)
+DEFINE_GHCB_ACCESSORS(xcr0)
+
 #endif /* SELFTEST_KVM_SVM_H */
-- 
2.44.0.478.gd926399ef9-goog


