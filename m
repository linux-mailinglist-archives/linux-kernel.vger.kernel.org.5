Return-Path: <linux-kernel+bounces-149496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BB8A91FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646D61C20DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFE548EB;
	Thu, 18 Apr 2024 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkdehfC1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E03BB47
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413988; cv=none; b=qgQS/OxDMVMqQ34Mgdao6gLCYw9KYq19aff/NCCs7lARM2PBEWjZRIqBdG+YGCR20W6xwUemfNoDqBptRk1UjkI3Jv8kYWh00gBPptOtyJCKVc+Ul62Z5A4XBvr9eJW4J+ZaZfXc81GVX4zGczEIzi5zTvduYa0UCZmuZE+4+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413988; c=relaxed/simple;
	bh=JU9BTI1MrHJ+HXxKMP5mhE1x6VZ9eJmARphiqqhovm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlYbVcwnOdCX65NDaoRKHKsYG8aijsU94fqBmk/biCdcKbY8mpt975LAcA3WDoLTAA88s68NdnzuWAFf5lwBl1VQMnJ5wKy/DYRFH7ghFBEnh0npqfqBQlr/9c30/mjhjWpiHFLxLKA/BO1BIcMoG+w+QBT49kn+upNV7ogSgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkdehfC1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-349caee176bso243444f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713413984; x=1714018784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Y11HnVWixyfEe0bcf5/JRUXikGy6bahbpNWEd9E0A=;
        b=KkdehfC19cotrGWvBnjiAVVfouj7mZMyRLkTJ0hXRQ2z3aIWFSdd1bKxbWtNeYB+wq
         kSB/XiR9tJ6MwkzsZsOu3IPr7e7GR35tYqpYcVWcmx6XnLdglx40RoMHvwOHrJl+hax/
         c7rzQrOC9WQDzti2GocAS3TXGLv63MbHdGPPuA6At5bhxR6asep+OYQ5YxhMetgm4uxQ
         TUtrXbIJCnI/bjdWpEARL8Kb1Hq/U5Pj3SU6gTE3neKAsLVT5xB9Dgm5lbm8AQCH82fa
         jorqUq0TV+m4kmdEBUtySjBDCKIsMdtS+7dma59TxLHt+5DhGnr3C9Nd7R4QSBfIuNlc
         DX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413984; x=1714018784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4Y11HnVWixyfEe0bcf5/JRUXikGy6bahbpNWEd9E0A=;
        b=DbJ6IsRp5WNkHHa/lr3ZMlWx6PyBpVwhbik86LFBWCMc5hUzQ4ph2q83+XoUKiZQ6r
         82+Bkf31JS4y3TsSaCETMeFwZUTyf0OGadEv7GxCBLbgZPRzsA/4N1t59TDl9TSasgM1
         8FOacaddeh+3qX/Ba/hNnp4qDP08LyH0kCJbfZfwnf3yvHXUKuhaYF1f09I90mrYvZdD
         JBjQNt6KyDOrrlop5i0BQZq1l8KjuFg20FaO+6wTOxrG+tRcf/rXxJTRBOgovZDZ0Lly
         MxL3AU0rgIE1ljIa5Qsj/fQ/wrWQOD6KPiAk+S/KiB8fDIJ6UH6pjX7wZdL9PBMI1lMv
         smRw==
X-Forwarded-Encrypted: i=1; AJvYcCWwGy4ozrW9IkQbHuZycRGUiN49C099G8UlpiGk3/t9eHUAkPOxKIKPnQRUTbDNG9A0u+iiP70iVW2FuuCTCk+zH2KBY+4rhZGOkRJ3
X-Gm-Message-State: AOJu0YwR6G7lWkZHZ8FBm5+LRhnEFHErQ0GWncrRuyrvgFG3vhETV81m
	BLn58Wl08hf39tMEIzB63xQQKY5mYhw5nFxD0yJeYJdQYtV4FgXs0RPp
X-Google-Smtp-Source: AGHT+IFZIKlig6BormDC7pPdyf9wNadlXDk5NrMtIjGhQq0OTz7gToGR797TNmk/qXlGf+plHAQb2Q==
X-Received: by 2002:adf:e0c9:0:b0:343:826a:7a36 with SMTP id m9-20020adfe0c9000000b00343826a7a36mr670412wri.58.1713413984124;
        Wed, 17 Apr 2024 21:19:44 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.150])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b00418595096bdsm1137451wmq.35.2024.04.17.21.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 21:19:43 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org
Cc: adobriyan@gmail.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpu: memoise number of possible cpus
Date: Thu, 18 Apr 2024 07:19:27 +0300
Message-ID: <20240418041927.3903-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_possible_mask is fixed after boot, so it makes sense
to calculate number of possible cpus to
a) make num_possible_cpus() faster (distros ship with _large_ NR_CPUS),
b) unscrew codegen elsewhere replacing function call
   with simple memory load.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/cpumask.h | 3 ++-
 init/main.c             | 3 +++
 kernel/cpu.c            | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 04536a29f10f..a98843ca6131 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1106,7 +1106,8 @@ static __always_inline unsigned int num_online_cpus(void)
 {
 	return raw_atomic_read(&__num_online_cpus);
 }
-#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+extern unsigned int num_possible_cpus;
+#define num_possible_cpus()	num_possible_cpus
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
diff --git a/init/main.c b/init/main.c
index 881f6230ee59..fe0291b44d78 100644
--- a/init/main.c
+++ b/init/main.c
@@ -904,6 +904,9 @@ void start_kernel(void)
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
+#if NR_CPUS > 1
+	num_possible_cpus = cpumask_weight(cpu_possible_mask);
+#endif
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 	boot_cpu_hotplug_init();
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07ad53b7f119..4a75f95fec82 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3106,6 +3106,9 @@ EXPORT_SYMBOL_GPL(cpu_bit_bitmap);
 const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
 
+unsigned int num_possible_cpus __ro_after_init = 1;
+EXPORT_SYMBOL(num_possible_cpus);
+
 #ifdef CONFIG_INIT_ALL_POSSIBLE
 struct cpumask __cpu_possible_mask __ro_after_init
 	= {CPU_BITS_ALL};
-- 
2.43.2


