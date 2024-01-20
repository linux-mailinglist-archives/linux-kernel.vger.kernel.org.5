Return-Path: <linux-kernel+bounces-31684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC583327F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AAB1C213AF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549F15C2;
	Sat, 20 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZBtEHOe"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E998ECD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719060; cv=none; b=TyLJ5aEXP0TRGPTykgxG0xaecSdYEOB92v3ZuDQ37O6kPVz0Oo1LweJxbytiCdzoLkaphKef6njDOQxYqTwdKLiq8iFO4v/vzD5l9F96cnXElLjdIoXcEUK9306RSKaQs4ehxkqv9sPDLmYK9kqPeVFe24t1eE5+d2AV4DWC2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719060; c=relaxed/simple;
	bh=SVwOa745y/p7doJwcbG2VSsSKIR/sIktsJ8KB1vHWPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2owwEFmf3ocAnKkzA3b4eLl2qqxfWT9EXsPko9RAJvIqzaHbfKOkl3pg+HBRLBbjCBHAqipVFiyZRfvbnlWE+0irM0tMwb7A1Wd9Wq3foTgAVaHbnQZr91LraWZut0slrZ9Cq93cFrPw+8591g27cyuaNAZlWZznun2TbWKAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZBtEHOe; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ebca94cf74so13947847b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719057; x=1706323857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=cZBtEHOeuUjLoazd/HsZGtCtBfAy7fB5HFRlygF6yNS7WO46pqoen4IkeqB4b/5VV/
         QmH/Wm0FQmSqcawq9G4riJbsPGm73YjmYfyQpELavf1+Sp5WvGZEBGtnoJKsbkflAcFm
         Er4J+38+3JUcQNpRSW3E/Z8htroQouIssP9+Kob9hz7RAHjpeke7RJBxlplcZpISHyML
         2C91epABEvwST5Co9Azz5lsQ7Eq+WL3SG4+M7W3s0bWkZNyPEaeheFQoP/vKwlnvuXCz
         5hZyb0yREa7+caL8kihNmYtbVD36jDB4HyuDUE+P12NB6NqrYNbCsj/c/vVpRPKz1abk
         x5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719057; x=1706323857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+ncE/Ke8W/9eSicUFGfjAMk7XfHt6TzmaC+XB67O8c=;
        b=ZZRp2/WT6YOnN0To871NwYbkeM4yUoCGudlHKvVXkJ0Xd6j1w52/rSjV4MdbVXq1v2
         x6jCVDrE3DMZDG2idoQdg5/6aFneQ9FK8aAvSqUMgqRtZXvJmoCCO7CKGTwc3GAv1kXN
         187GOzjAQHjryPQgbn1y6DIeCm1+0aw9Q0vGZfFaIOTySNfbXNJMBUTBlaQtJMS+rhEs
         i86Ihc4d5OqWrgHvNQA3SLCE+D2PRtLacRX18vi5t8NI47HcjfSY3iY1OrPFIC4yeeze
         CoWIG/r3hDI7sFzSRL9COn0gTzY4xzltVGW9SWXSil132wRn686KabP4MHV6tkOOKEHI
         pwuw==
X-Gm-Message-State: AOJu0Yx/KyjZ6AhURcef6L8JR8gCTaUkVKQfsOZhGvJwxdqK3Pz4RXfr
	zYGIyr2hb6qeIBSvU3c5KKzi66tId4asc758GP3WELMMkSf6y0LX
X-Google-Smtp-Source: AGHT+IEBemjBN9YRLuTBhZtFCGVJr5mUhG1n1vsbhUWd+Ve5XrfNo27NIhoncvmYKmUNx9+bet0s7g==
X-Received: by 2002:a81:7bc5:0:b0:5ff:9b17:8cd7 with SMTP id w188-20020a817bc5000000b005ff9b178cd7mr735066ywc.71.1705719057453;
        Fri, 19 Jan 2024 18:50:57 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id s4-20020a0dd004000000b005fb0d1afc7csm7925684ywd.120.2024.01.19.18.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:50:56 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 1/9] cpumask: introduce for_each_cpu_and_from()
Date: Fri, 19 Jan 2024 18:50:45 -0800
Message-Id: <20240120025053.684838-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120025053.684838-1-yury.norov@gmail.com>
References: <20240120025053.684838-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
which is handy when it's needed to traverse 2 cpumasks or bitmaps,
starting from a given position.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 11 +++++++++++
 include/linux/find.h    |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..73ff2e0ef090 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -332,6 +332,17 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
 
+/**
+ * for_each_cpu_and_from - iterate over every cpu in both masks starting from a given cpu
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_and_from(cpu, mask1, mask2)				\
+	for_each_and_bit_from(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
+
 /**
  * for_each_cpu_andnot - iterate over every cpu present in one mask, excluding
  *			 those present in another.
diff --git a/include/linux/find.h b/include/linux/find.h
index 5e4f39ef2e72..dfd3d51ff590 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -563,6 +563,9 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_and_bit_from(bit, addr1, addr2, size) \
+	for (; (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size); (bit)++)
+
 #define for_each_andnot_bit(bit, addr1, addr2, size) \
 	for ((bit) = 0;									\
 	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
-- 
2.40.1


