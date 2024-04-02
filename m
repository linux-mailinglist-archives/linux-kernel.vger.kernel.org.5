Return-Path: <linux-kernel+bounces-128488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1413895B78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F8F1F226B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0615B0ED;
	Tue,  2 Apr 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ypqi/Njw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707F15ADAC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081384; cv=none; b=d1R9VVjNJUA++m22pb6aUMZOnbudg9wAuFbo5ftElrAzO+1JbcCxXww8c27goM89mY4DY5ctHhZz5V4gUeHIQiLr0+Uhm8vLGzDXB+f7O336VuYkRfNQ1KoCPw7YUh+jwrvIJI2fHAH5bG+zsEaXd2RBKSMabpSc0vCPxRcct/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081384; c=relaxed/simple;
	bh=IhhMTuUF4I1RrsCKiK+mrn7pbcjFVg70m8/FZRI+vXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxyPZagbRvdk7iIEZUUwADJnr3GI7sfTRWt6g+ieeLXenRI42LLJwk8fcehiuGHwMBTgUsGpM6cYRoP+n/JRY+mTuG1aodWyAwdTzB4W8ihiGUXOIxcwogIr8J7wpTfFEiPhZmIHEl5jp9c3WcPUWY/65l6VRXEWpveIkOExF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ypqi/Njw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610c23abd1fso100940577b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712081381; x=1712686181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7C4RwjluY6PPV2k/DozaBVNL1O8v9kM1LCRIQo+73s=;
        b=Ypqi/NjwUxBVLpk+2oHDSLAnOYty2CNV9YpeTpo5zFvhQ1qvHv2+Fsxxq2Xi+g/lLE
         zXpD/nzmSl4HlySBpiFmxzny1jNM3V0EkyXy+RfdDaHiwXIw1n9N0IEnVmpArqsYXaNh
         Qqtp23DKCBb2FqU64/bSJDo2RFcZ/GaHYGybXbyQmGwPDxNG777apBY4fg4tVaLqFjZp
         7CwkCS05qZ1b1SDEgdm1wG8skNSmbwbB9BJZ0ZNJk3Uvi/ZxtTVKnkxI0KpmCfl3A8PE
         S4swpHl2Do78RttJo9shxfqdhCDETEtg9RJgGYgCuOLiPUMC/2KHKXFU7stYIEYoLP4E
         M6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081381; x=1712686181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7C4RwjluY6PPV2k/DozaBVNL1O8v9kM1LCRIQo+73s=;
        b=F6UEs5tDcSy5lIfaRjWdGMchqbH9LoJ9eljaP83zuWKj7RGb6a2mrv8kricEdCh9NB
         7NZGebUDjQOtAw9f5OD70soDGrio9UP05vjACAl5UfvDofsP3GHRzjCw4H1Nprx6S+6G
         B3P9Byk3ylm2+XhOCUz+SP6ShvyetAijQQRMnT3rTV4zS7ug1jc/ZvEWuLxoH0WylW2V
         1DTVQL3ezGXR5uyfdSpqKtJM5jzHc4fNsmcByzf3cVIPEe76bnmWDJdFoRH7LpyXEx6Q
         C6CoqWh038s7UAtVesAlgZ/BJ6bqB6gty9PMEEiVOOStXYJnCadWkwjJ71JMMxgDDkpi
         hURg==
X-Forwarded-Encrypted: i=1; AJvYcCVQUjOCEr70p1WUeuZFuN/66MnI1hoct7fJfVOWBNh8rOM+zEL/6NarM2ZwDcI7DrrOoiIhFSw6yggHNaoKg/BkiZLPPrcVKHF/H15t
X-Gm-Message-State: AOJu0Yxw5So4+ANLeT8EJE883Ox0ulWIJKl0NTDvPZjjtT7CT09WWeq/
	8q47i1S76mD4ncshvqlDveUYbnebPmpg0C/oTfDq+CsCsUA2xi03fSKxdi7ZInoQ7K8OhMsUeoH
	Eow==
X-Google-Smtp-Source: AGHT+IH3Fmk0th3GoFLxNFXqVaLYsG7FFuYRdZ/faT2X8t4SOTXORLSLx8MolmKfz8ERrCJB0nZ+KvX3iNo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:61fa:96f4:c395:2882])
 (user=surenb job=sendgmr) by 2002:a05:6902:1613:b0:dc6:eea0:1578 with SMTP id
 bw19-20020a056902161300b00dc6eea01578mr4184874ybb.13.1712081381432; Tue, 02
 Apr 2024 11:09:41 -0700 (PDT)
Date: Tue,  2 Apr 2024 11:09:33 -0700
In-Reply-To: <20240402180933.1663992-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402180933.1663992-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240402180933.1663992-2-surenb@google.com>
Subject: [PATCH 1/1] lib: do limited memory accounting for modules with ARCH_NEEDS_WEAK_PER_CPU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

ARCH_NEEDS_WEAK_PER_CPU does not allow percpu variable definitions inside
a function, therefore memory allocation profiling can't use it. This
definition is used only for modules, so we still can account core kernel
allocations and for modules we can do limited allocation accounting by
charging all of them to a single counter. This is not ideal but better
than no accounting at all.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403290334.USWrYrMw-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 14 ++++++++++++--
 lib/alloc_tag.c           |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 100ddf66eb8e..e867461585ff 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -68,9 +68,17 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 /*
  * When percpu variables are required to be defined as weak, static percpu
  * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
+ * Instead we will accound all module allocations to a single counter.
  */
-#error "Memory allocation profiling is incompatible with ARCH_NEEDS_WEAK_PER_CPU"
-#endif
+DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
+
+#define DEFINE_ALLOC_TAG(_alloc_tag)						\
+	static struct alloc_tag _alloc_tag __used __aligned(8)			\
+	__section("alloc_tags") = {						\
+		.ct = CODE_TAG_INIT,						\
+		.counters = &_shared_alloc_tag };
+
+#else /* ARCH_NEEDS_WEAK_PER_CPU */
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)						\
 	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
@@ -79,6 +87,8 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_alloc_tag_cntr };
 
+#endif /* ARCH_NEEDS_WEAK_PER_CPU */
+
 DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e24830c44783..b37e3430ed92 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -10,6 +10,9 @@
 
 static struct codetag_type *alloc_tag_cttype;
 
+DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
+EXPORT_SYMBOL(_shared_alloc_tag);
+
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
 

base-commit: d4cd6840d1dc25963aa10ef5e5b1d01876baebf2
-- 
2.44.0.478.gd926399ef9-goog


