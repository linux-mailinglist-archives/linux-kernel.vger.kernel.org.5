Return-Path: <linux-kernel+bounces-77584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671488607CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98653286A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350ED2E6;
	Fri, 23 Feb 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9DH6Gm+"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66CBA28
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648989; cv=none; b=L0z4IuV94uiqo/pZY6J1fSS4HlfvtXa0YyOscQ+fmnqfE1deN8S9oRoynnCfFxnlzfXWf/6Fbj66a75A/SYrwm7hPkpzSKMKLh4Zacv874/Ho3Q79mBcf95NMfxMZergdEBAS1wX2jQM+emn3J1IINjq6HK+UmTTgv9FOa4BT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648989; c=relaxed/simple;
	bh=LW9qJDJFMZKoAzuMjM4EnMGD9KOMiSIoIkVhiiIE6n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UcAQSLqNONsIb1TQDLsoZ4Uzkk7j9C03ZySOSU0VXSGSWfSeLRh6AXJ6judsgcX6cY17OC306JYIqi7Zhlnlg/XUWqy7WSPOFWTkr8nyqX1AD4I6KKPLhFyMjR2OePQZIpqrGVyNYoOa5LXOnt/wL0nWqU2WeE/lkVDmr/JBp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9DH6Gm+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so259698b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708648987; x=1709253787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jhSBUfusWJ3ofLKWMGpg2YDRgo1XDnuJP2HRidQqwH4=;
        b=B9DH6Gm+C1X6H3ks87B4mfBgcd9wrOAVOYx/XLoU3zt5slGPbI/pgo0jjo+yt4Nwdw
         Wz85tdd0ojV9EgE3ccGgA5+2lkUmmnmrSYx+tpsSBbmdezCatTEAoP6pwSExWNvIUnQF
         NQUKEFL8v0FM2Oj1S12koT0uc1vdPpxgJVUK7qSZxdk2yJcrBw5oXcG+jWjRh504m5jg
         pSncjC1jPFGfNMAo2sZ6hA82ct9ONR47tX+iptXOqSoDjFZwOO2ZNUQ+eU+J6/y+IgZO
         9r6QxDfl2C1Je6cforf+10ZtutDNe8LKpAkEm5JyiqFWQ8hsPZjSR20seimLstRlrm5B
         JZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708648987; x=1709253787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhSBUfusWJ3ofLKWMGpg2YDRgo1XDnuJP2HRidQqwH4=;
        b=QeXQPh6XtecFGOUK2PzzDdy41YhRzNq+6jX1/s2Gkb3APyNX6T3liyT9+1d/41uzcV
         cuLpV0vn6v7l9h2l3JB6gYCLaU3yZWI/lWxIwIJw5hoedPkfsroVuOr/Zy3FUGn+l4rL
         ROeImY/8mYwXNtOociH6yhHWcqxlanumHJR9emJNJGFufI5JRgyw9pYpDNj/xkCA3k1f
         8FmupiwZgIZBgvgzLIZm76/x9doVhWJJ7+K+NZR6pt7tPgTB0CigloLhgoFRZVROIEcd
         2ov5+RiCzGDiM/b3TGBF0881e2XodHWKyCNxXMfzBWu/D51gF7ZkXcxGYIFMj8QU3piV
         oM2w==
X-Forwarded-Encrypted: i=1; AJvYcCWBgs5dHkLV8NwHVfEysl2YmPQXNYVJduuSYTyXE4IFSE8WdYsCDCs9sNcjnBpUu6hsxQJpY5B7Ap7VN4uh7HIABZ40MLc0uG6GK1vp
X-Gm-Message-State: AOJu0YyJe8Kuxo0WcH14E1WrcRKzsCY9BGvgM/0DXGrtrGRjLwAN7LGo
	1jdk173F9F4TbYEu+EDuI3XNuVmwohOONynk8tNsYrdTa+OI9X8SVXLqabPm7bRdHscTqCJdAj0
	KKQ==
X-Google-Smtp-Source: AGHT+IHIxuf373oGf69Al+lWSIf6Q+TRpWLvL/aYM1tJ8IvZSlPzsioXOjltEzRkvK0lvpvWJZPUowBn/iU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:22cd:b0:6e4:643e:e215 with SMTP id
 f13-20020a056a0022cd00b006e4643ee215mr24254pfj.3.1708648987517; Thu, 22 Feb
 2024 16:43:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 16:42:50 -0800
In-Reply-To: <20240223004258.3104051-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223004258.3104051-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223004258.3104051-4-seanjc@google.com>
Subject: [PATCH v9 03/11] KVM: selftests: Add a macro to iterate over a
 sparsebit range
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Peter Gonda <pgonda@google.com>, Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Add sparsebit_for_each_set_range() to allow iterator over a range of set
bits in a range.  This will be used by x86 SEV guests to process protected
physical pages (each such page needs to be encrypted _after_ being "added"
to the VM).

Tested-by: Carlos Bilbao <carlos.bilbao@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
[sean: split to separate patch]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/sparsebit.h | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/sparsebit.h b/tools/testing/selftests/kvm/include/sparsebit.h
index fb5170d57fcb..bc760761e1a3 100644
--- a/tools/testing/selftests/kvm/include/sparsebit.h
+++ b/tools/testing/selftests/kvm/include/sparsebit.h
@@ -66,6 +66,26 @@ void sparsebit_dump(FILE *stream, const struct sparsebit *sbit,
 		    unsigned int indent);
 void sparsebit_validate_internal(const struct sparsebit *sbit);
 
+/*
+ * Iterate over an inclusive ranges within sparsebit @s. In each iteration,
+ * @range_begin and @range_end will take the beginning and end of the set
+ * range, which are of type sparsebit_idx_t.
+ *
+ * For example, if the range [3, 7] (inclusive) is set, within the
+ * iteration,@range_begin will take the value 3 and @range_end will take
+ * the value 7.
+ *
+ * Ensure that there is at least one bit set before using this macro with
+ * sparsebit_any_set(), because sparsebit_first_set() will abort if none
+ * are set.
+ */
+#define sparsebit_for_each_set_range(s, range_begin, range_end)         \
+	for (range_begin = sparsebit_first_set(s),                      \
+	     range_end = sparsebit_next_clear(s, range_begin) - 1;	\
+	     range_begin && range_end;                                  \
+	     range_begin = sparsebit_next_set(s, range_end),            \
+	     range_end = sparsebit_next_clear(s, range_begin) - 1)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.44.0.rc0.258.g7320e95886-goog


