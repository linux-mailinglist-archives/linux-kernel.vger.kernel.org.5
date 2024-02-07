Return-Path: <linux-kernel+bounces-56652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFD84CD39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11AB1C23984
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBE7F7F6;
	Wed,  7 Feb 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDUxzYaH"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB457F7E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317366; cv=none; b=jFELrAnREB93lztQdayKXvYesBSK3StODyg/fqh0brSWqFMHRs4fRHJgT/UnMo9SVnjWEy574Oswzt17sExbYicZ4Xt8x7xipZLO6bUQLhX6FeBU3GTl/kt/0jxhDOrqRIqOyHlpGh2L97gmg+jlo/qTV/uRHfsTZkeI6rSvtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317366; c=relaxed/simple;
	bh=iJoX6VotvrSCPb1HffuAPKumVXhHe9gdUehIpt69Ano=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCk8TutNYjuwfjQada492bHGc7zBpmAYHcFtIyWVvkMtog0HVB/yaLgxTDDk4Io536wuanRAbyMGQ3YZ2oHHn0TQgZcKJfOFqHr1dgNmXJB5bkPnCSXAZCZ/vbyutjVe7BArO/mLjD4Oi9ZwWxGlkQmy4/Pe9d3tVqii9TLpVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDUxzYaH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40fb1690f94so3405085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707317362; x=1707922162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tIUh8e7+u6fe/L9d2IoiyaWpJieVgDcIoakNbd8hrU=;
        b=hDUxzYaHy4XiCBGOtzRrhQPnCE2Jd4DbQH3cY+fS2coIWL3hUpvC0SU2Y312FA3vrK
         Xqacv3u51TAKXdkONKQwSjAd7Ahdmu1QfZ9Wf4VefRfYYkSnV4vJgJDFW8cCsUtPZ/SG
         1nuaJ86vvabbVoSiP6fUZoH1RW3kKauwIeBXIZjr/lYE0KuZ8kzGV0GCkv0qLaL4Wmbz
         jpK78nnAEMHUwkrBGuRHRnmhYE50K4mH4/hhvNGMgaUW7QJDD6yPknIkCiJ+gPGhjFSy
         nL4WTj3iGkxivncPImHxCHvqU6R/7cVlXi247ouVXfKqX7g4ieGPl/3mSfw8yfZ7v+Ae
         QVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317362; x=1707922162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tIUh8e7+u6fe/L9d2IoiyaWpJieVgDcIoakNbd8hrU=;
        b=k6uL4BiWb1GNCexUd42+E1JsZDbCHnOdscAQE97Y2RkizVeY2tE7Edk3b0AELBU3dr
         ZcU5suNI28LdNeinyNjJalruVrDPxpnYwxzWtGZA75fFONjjrnKHiL/f+w5raki8UOZv
         268d0yWejcseBPCrbt5a5acNk2RT5GOrAkmHoivtJq4iN51WDZ+31ENfd6XL3Qsx2Vu2
         4CMgDuZ0+UleLKnt/xepX8frD31bzeWm6vEyEQnTMeZO66S1b41Mu+bNld58S9ME1vjL
         V+2dO6NU8m7z0Kowfp39BMA/30VtkSWg9l3oY8ZFVQnUmQzUj7cKTwevJyXgba+0S6eX
         94dA==
X-Gm-Message-State: AOJu0YzzL+c2RZhh6Hmi5p6uPQGkJpu+hq87Q5FJsewGqc4dfTSbB1Ip
	ijLP6t3wXxifDVGYcF872bLVAvMan92rLQyUR3/2hGajTJVB9oJ8Wj99xnkt2zM0YTFc3Mv8ngv
	OcmcxGMZIuc9sOortVccW3XZnQA==
X-Google-Smtp-Source: AGHT+IHZWozJw6iEdHYJvbi8rYI97x/8VSLY+PehA27Gu1vNkYuY53+7wudnkk76X2VvuGrFo0tvrbQt62XM8gjTJX0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:518b:b0:40f:e205:9868 with
 SMTP id fa11-20020a05600c518b00b0040fe2059868mr158210wmb.0.1707317361885;
 Wed, 07 Feb 2024 06:49:21 -0800 (PST)
Date: Wed,  7 Feb 2024 14:48:31 +0000
In-Reply-To: <20240207144832.1017815-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207144832.1017815-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207144832.1017815-4-sebastianene@google.com>
Subject: [PATCH v5 2/4] arm64: ptdump: Use the mask from the state structure
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

Printing the descriptor attributes requires accessing a mask which has a
different set of attributes for stage-2. In preparation for adding support
for the stage-2 pagetables dumping, use the mask from the local context
and not from the globally defined pg_level array. Store a pointer to
the pg_level array in the ptdump state structure. This will allow us to
extract the mask which is wrapped in the pg_level array and use it for
descriptor parsing in the note_page.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |  1 +
 arch/arm64/mm/ptdump.c          | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 23510be35084..4e728d2a1f2c 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -45,6 +45,7 @@ struct pg_level {
  */
 struct pg_state {
 	struct ptdump_state		ptdump;
+	struct pg_level			*pg_level;
 	struct seq_file			*seq;
 	const struct addr_marker	*marker;
 	unsigned long			start_address;
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 64127c70b109..015ed65d3e9b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -220,11 +220,12 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	       u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct pg_level *pg_info = st->pg_level;
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & pg_info[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -250,10 +251,10 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			unit++;
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+				   pg_info[st->level].name);
+		if (st->current_prot && pg_info[st->level].bits)
+			dump_prot(st, pg_info[st->level].bits,
+				  pg_info[st->level].num);
 		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
@@ -284,6 +285,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	st = (struct pg_state){
 		.seq = s,
 		.marker = info->markers,
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
@@ -321,6 +323,7 @@ void ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
-- 
2.43.0.594.gd9cf4e227d-goog


