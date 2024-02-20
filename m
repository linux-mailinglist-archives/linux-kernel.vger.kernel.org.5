Return-Path: <linux-kernel+bounces-73223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9185BF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCDFB22501
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AE762C1;
	Tue, 20 Feb 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO9wEC1s"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3776042
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441899; cv=none; b=G43yCCl9fI+oM5F6w+q88Fj+ik6EckIoftQNJ/Mq4ppq+sttHkFZJj3BxxVfkIYI06e/Qvduw/6iz0aG/8pPsf9bhBpksmICDVLL72mfeeElCfu95ZAmx9x5eYtNjsUqzMvjVuLyozLasJH4F73+IADR06dtlXD1LQdBHWFONzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441899; c=relaxed/simple;
	bh=NJa1BLuTC1M9IXyS8cUBmrPvfsMqCbFinRO8836TETA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mhtOPd5ka9VS+5uqKrlnx4lpt/3J1wWZyEIzScM05DXHlnBgTWtskQxe2QF7MwLyAB6GjkrZ6S6miBi78BZSeroq9nHZhhGqBJnM92M5REWZbZyxUQGCZjNsE6GXcpbAdcDuIvM1stSVCGni5P26H41SF2IrTTlrfexnUznck7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO9wEC1s; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so33832377b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708441897; x=1709046697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0gsyti8lKhCK+AHvAHuyBhR7vYZPhP9z/P4jDBYvrE=;
        b=rO9wEC1stMjKD+nC93Wopn4tp7d/GfLbZcL64kamuL+nXtFGG6xu09gUwZGOkfVub3
         SM6PVwkUAcx5CxwgTnlArj67Omb3jQj6OK63++xXva4RgKd4dLl3fkygoL0d/W25Cno9
         bhw6Y3ieKBJi8mBmRdK5SiF4sevZ7DCpy1s/9UOyTpUQtLFsZxdAz1zA369GUbev/rA0
         u9+s2xarpbRTsusZC1Z+MLDt1tcLFMhjKVtey93fPC+5FIuqCQ+SySofOkfLxH41nlPy
         IZ+P1nThKRRITmujBCKx+y6OxEAxO7nUkRkFZmP9fozOdkEba3MwF+jWXGpBhXVc1OFp
         W1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441897; x=1709046697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0gsyti8lKhCK+AHvAHuyBhR7vYZPhP9z/P4jDBYvrE=;
        b=vQzgWRlsbc0KlgqCeXMiW+sqN1tcke3KsRt1inCGuEKtlRy+9kO4as9ZJ+ktwx8uSe
         ErkIVmYkK2Dw3oc5c6bsYyoJ6W4rvt+F6IOUT8idNjXJzdfPK1GTBl+2I2VBgEgj1g+S
         /CaDJUrK85GyarG6Ub2QneLGMQhLYl5K19Vrt6a21JF6rfXOga319dQv8O0/RdSMId36
         OkMVSeOTzpB/hHUiJaUePFqysd3xxAZH0IMbfhkuGRCFTT3U87yWIC1RsNvRD30eFlup
         7qyBa7J8tjkSgDuUSGYyd9ZSEVxdQcEWxrpmTgDr+7bwJkcp6e+TGONoyKdFHdCKNeee
         pxJw==
X-Forwarded-Encrypted: i=1; AJvYcCURGlFqUiBp+H/45Ju6FCxcCAjKIV7b1Dp2512LwqjGnWQxxJrnDoF5ejvPvqZgujrppMe3RgIJndoPttG4slfaKtfwswS/cgjP+1z8
X-Gm-Message-State: AOJu0YxyaRuTpF4lSAJh/Bn3w1zjzdC11s9o7uuAtCXKZcR6yxlmpJpZ
	j4lNu0i6HQ/b6yxoeAbFHC25FaN3WtrqgfFrcvDPolQrKidDuDRqQPBpWyizchNE2jIB4+k7v2s
	Z6ecInHLyKkK8WoewSV2g3+nuyg==
X-Google-Smtp-Source: AGHT+IG+jlQa4S4iBavS25d/TUrwEAyS5uvZXS9pyLoDz2YsufCK6yJuxUh5mwLf78C/X5obDHvN6CN7NkZOThXn3Fk=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:1008:b0:dbe:a0c2:df25 with
 SMTP id w8-20020a056902100800b00dbea0c2df25mr871279ybt.8.1708441897282; Tue,
 20 Feb 2024 07:11:37 -0800 (PST)
Date: Tue, 20 Feb 2024 15:10:31 +0000
In-Reply-To: <20240220151035.327199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220151035.327199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220151035.327199-3-sebastianene@google.com>
Subject: [PATCH v6 2/6] arm64: ptdump: Expose the attribute parsing functionality
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com, 
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev, 
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com, 
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org, 
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

To keep the same output format as the arch specific ptdump and for the
sake of reusability, move the parser's state tracking code out
of the arch specific.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h | 41 ++++++++++++++++++++++++++++++++-
 arch/arm64/mm/ptdump.c          | 36 ++---------------------------
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 581caac525b0..23510be35084 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -9,6 +9,8 @@
 
 #include <linux/mm_types.h>
 #include <linux/seq_file.h>
+#include <linux/ptdump.h>
+
 
 struct addr_marker {
 	unsigned long start_address;
@@ -21,15 +23,52 @@ struct ptdump_info {
 	unsigned long			base_addr;
 };
 
+struct prot_bits {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+};
+
+struct pg_level {
+	const struct prot_bits	*bits;
+	const char		*name;
+	size_t			num;
+	u64			mask;
+};
+
+/*
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the pte entries. When the continuity is broken it then
+ * dumps out a description of the range.
+ */
+struct pg_state {
+	struct ptdump_state		ptdump;
+	struct seq_file			*seq;
+	const struct addr_marker	*marker;
+	unsigned long			start_address;
+	int				level;
+	u64				current_prot;
+	bool				check_wx;
+	unsigned long			wx_pages;
+	unsigned long			uxn_pages;
+};
+
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val);
 #ifdef CONFIG_PTDUMP_DEBUGFS
 #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
-#endif
+#endif /* CONFIG_PTDUMP_DEBUGFS */
 void ptdump_check_wx(void);
+#else
+static inline void note_page(void *pt_st, unsigned long addr,
+			     int level, u64 val) { }
 #endif /* CONFIG_PTDUMP_CORE */
 
 #ifdef CONFIG_DEBUG_WX
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index e305b6593c4e..64127c70b109 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -66,31 +66,6 @@ static struct addr_marker address_markers[] = {
 		seq_printf(m, fmt);	\
 })
 
-/*
- * The page dumper groups page table entries of the same type into a single
- * description. It uses pg_state to track the range information while
- * iterating over the pte entries. When the continuity is broken it then
- * dumps out a description of the range.
- */
-struct pg_state {
-	struct ptdump_state ptdump;
-	struct seq_file *seq;
-	const struct addr_marker *marker;
-	unsigned long start_address;
-	int level;
-	u64 current_prot;
-	bool check_wx;
-	unsigned long wx_pages;
-	unsigned long uxn_pages;
-};
-
-struct prot_bits {
-	u64		mask;
-	u64		val;
-	const char	*set;
-	const char	*clear;
-};
-
 static const struct prot_bits pte_bits[] = {
 	{
 		.mask	= PTE_VALID,
@@ -170,13 +145,6 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-struct pg_level {
-	const struct prot_bits *bits;
-	const char *name;
-	size_t num;
-	u64 mask;
-};
-
 static struct pg_level pg_level[] = {
 	{ /* pgd */
 		.name	= "PGD",
@@ -248,8 +216,8 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      u64 val)
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	static const char units[] = "KMGTPE";
-- 
2.44.0.rc0.258.g7320e95886-goog


