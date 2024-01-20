Return-Path: <linux-kernel+bounces-31688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD88833283
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A2B281BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A900CA64;
	Sat, 20 Jan 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR7Fsljj"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D44433
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719065; cv=none; b=IbfYKpS/eamyfeM8OI4cYepUQPZ0VyAkulNJh4Xw4qQ4xikASBsDLhsjRDFd1uQBkxu+vNBUB922N2Wg+1EzGcNcqDsw2+xj2ALcXU1o/rEKdQsZHljLiSKhah6biRRzwekICTKP9G0WpJqxDYrgF+9UNtkvL0zjjlbRLcJVjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719065; c=relaxed/simple;
	bh=WqwHpejzHYLP9GNl7XmZ/L5b8WXSUZCU6xYAFELj57w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpYxqk/x0ZLVRd1p9RK//ZRyirUp2bvNTUrwFN8YJk9skHu3q5ArL1E3whEUYxku+PfL8TBNUAfauzaLUex9Ife/OrGX+nvZe1addi+PgQIB6Zkz/R628eXkcehOt18EdcbDO6hDZ5zDkiOgGTqLV0wf2XmR/f2AEULZvfiGBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR7Fsljj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so14586417b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719063; x=1706323863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiqg7NMTo1hnms2N+QcuxP30iXk/HvqGHex9PC1KYAY=;
        b=bR7FsljjrtlFfdBUEufn68brwa6QZ2Cbjj0mM7BgpD++YIOOZAy3UEg7Mb/w+Bn7sW
         ABo6PH30H8eQfbKQYyfahgUXtAJjJTGPHig8uUVoV7xkW7zsMbEPlZrDTuKq1OYe9HNy
         /Yd0lTQ2/NuRu8/dcTMC7VSpYJr1r+33wGu3mGGc/qZFqOZ+Hyse2/8BL79z/SsCaxlK
         i7AcuWhzBh+ftZrqbqqwTAExCngt0YItF9haoOHxapuTIEPVmQGjDgBP4GXGpt15CMhZ
         sIMKzpqEZCfsJUGUYSetQ0bA49GFNLWP7xBVPzcs+vrgUxdM4wkyl9CuVQStxUllGq3U
         FqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719063; x=1706323863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fiqg7NMTo1hnms2N+QcuxP30iXk/HvqGHex9PC1KYAY=;
        b=AC4ManXu9+vNcpCZGRaqLSgbATXmmpySK0uR2oJ/XSw1k/dn2oeBkNQZ4nHYeIPeHX
         p0yRNMzqg/0KWHyd8/yBth8GcsgxrshbR39niaXGXEmuTv1ZH7xE83WBDayII6uPKbrz
         nb3slFNYJsi0omilEwTdwfiXEW2NvQR4E9t5HR/7lQJ+pthrmTFx+yXDzMYw790ffTOv
         x/p1AqpNfnU8Cyy4IStR4NL1sA61Kg7JtWJDyQ6DFfVEMJqGuxLBy5pvdLceXqdJ7eM/
         uumldz/TIfQ/tYb+a1VVYpsaziuxTyW8mItmi9tzCW7WIyvDbQzOQ7hyYmCJW4Dy3jtC
         kpgQ==
X-Gm-Message-State: AOJu0YwFkms9W0GIQhlERpfaTM0a+DhXpXcZywFbK3gkYAQ+hesVVBBn
	oWFI7dnj4jlWOEnIchL6/5lKAspUJZH9UFUZzo2iWu+0iNI0v4QG
X-Google-Smtp-Source: AGHT+IFC2tSqmIiaWyrRaXDHNWjgaK4WhQ/sNI5EmVTZGnIlREFdxO1hY35x17WHyCYRLZbZOqcW0A==
X-Received: by 2002:a0d:d4d2:0:b0:5ff:63e0:885b with SMTP id w201-20020a0dd4d2000000b005ff63e0885bmr787726ywd.76.1705719063162;
        Fri, 19 Jan 2024 18:51:03 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id s204-20020a8177d5000000b005ff8c88bea0sm1537740ywc.14.2024.01.19.18.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:51:02 -0800 (PST)
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
Subject: [PATCH 5/9] lib/group_cpus: don't zero cpumasks in group_cpus_evenly() on allocation
Date: Fri, 19 Jan 2024 18:50:49 -0800
Message-Id: <20240120025053.684838-6-yury.norov@gmail.com>
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

nmsk and npresmsk are both allocated with zalloc_cpumask_var(), but they
are initialized by copying later in the code, and so may be allocated
uninitialized.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 952aac9eaa81..72c308f8c322 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -354,10 +354,10 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	int ret = -ENOMEM;
 	struct cpumask *masks = NULL;
 
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
 
 	node_to_cpumask = alloc_node_to_cpumask();
-- 
2.40.1


