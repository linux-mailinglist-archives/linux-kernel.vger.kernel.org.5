Return-Path: <linux-kernel+bounces-71401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80385A498
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321391F22634
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD136135;
	Mon, 19 Feb 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcOWv2kV"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636D36122
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349262; cv=none; b=hegILF6PW5aq01Prx9iuls5XWqf7liCugK8qc58EFPjPOo/cn9zU+a0RjhF8iWXLvwANGR9NgklVQp8aI1Xv+ZUAC2JeNLFoh5RaTobdRXnxQEJcEOnA2OaOh4Uec+SNq5J87JFIG0wmaKtZY/+y2Y/F7Rc8Z5B0CE9rw2OS2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349262; c=relaxed/simple;
	bh=iA0Is1XYfjjlwAR8FaMzAAPWwQuFg/KJiorU3xxER7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IvN/IaQfnRsnCWXl9tdLhGV/4GefFUHG511VcEl77F48I2lzz5IqiWmQFZVzDukLawdj9yt+nwIFqlisyspOEuXTHxSVzLWUchxtHyCySwP35GOVHEyCPaMXTcZe63BjlukszWTBU71o1c8moZCxHNH3vZdfJmpIPGWphP4YtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcOWv2kV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso1242051b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708349260; x=1708954060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMHiM4QPZrDUPF1UxskxpR9lemcTVzesVXtS3NXsMak=;
        b=QcOWv2kVbxyY0eg/LTjK82nzdiy9l3GuP+nqjQWp/KzzRZIG9v/ISNVWJ7g3vnrMXT
         lzDv4F+3/o8YUDz5jjPEhWmDr+rZAPNvIzEL0Yq6YxdSelEpnub7tASlIq1JLIoBP8rl
         DIJ01n9y5xGroTgG+jreZf6esyGcIpdhmFwLxUmjWl9rrHNyJGUJA3GDY8xRitLcWmFM
         2tqT1gjz3qf8TBfXjk/lvxT80kdRvFHDo+E+UThCsrURwug4rN8+IzfKDksyDc4ud5NA
         m/e6Hqu70enT5FQIclrU00RhybSmxGZyPnsgFqg1oFUWUh6wK+wwxxVhHvIO7jmk1Inn
         OuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349260; x=1708954060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMHiM4QPZrDUPF1UxskxpR9lemcTVzesVXtS3NXsMak=;
        b=uHtQpHGhJnkibS0xj5uZHdgxhxfxV8ZuBATK0tYAtHfqzfgayf5Qo780qQj1hD6/FZ
         Ng1I/3xR8JgNvJURIzOndEP6uRLagGztnwBGXG77oZEGdkN5p2EcLKeCSU5eQy0n+Ghn
         X40orINR8N2NZDoH4Nb85UUdC0lRc74OmTnEIY0dT6733NlAi6ZeJzlW4ikicsW58YDk
         lyW+0K6eVOb2sV9VGrWA2ACwA6m7GdjWgc66vUbn+uj6h7aiVvL7sU+fajYijJUemPah
         g20EVAgWzFXJvnHU+RuXny78iySblUUtusRcXKjpnDxlDqe/p6oRLVkO1X7VFoVL1T/8
         lMNA==
X-Forwarded-Encrypted: i=1; AJvYcCUfrqasXQ+7QpWLXIJq0wfCUSr8uUMjabXp/VHb2U8kR2rp75h8Z87Svvxnbg95u0IgEUG6GwV1V210WtqGRGQ++4x/7oL7MaQGmFvI
X-Gm-Message-State: AOJu0YzdX2wq8OFMXNOmd1DvxOW8ldgVtlBcKRMxWbSDbiTrbjS1YZ7t
	oxGDKWVe5QrX3Tr2hv6UhrwDnvoCCw8lQSx5Y96AZXvGSIlv2Wib
X-Google-Smtp-Source: AGHT+IGuiybDrq271/fR4+4PoWmxRL7iSDJvZ4JkNoAz8tJgiJZqbqmYXI+PAhLi9Nr7VPzpccbwRQ==
X-Received: by 2002:aa7:8698:0:b0:6e2:b25d:a999 with SMTP id d24-20020aa78698000000b006e2b25da999mr6232405pfo.34.1708349260028;
        Mon, 19 Feb 2024 05:27:40 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id c4-20020a62e804000000b006e46047fe04sm2192198pfi.204.2024.02.19.05.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:27:39 -0800 (PST)
From: skseofh@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	rmk+kernel@armlinux.org.uk,
	tglx@linutronix.de,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daero Lee <skseofh@gmail.com>
Subject: [PATCH] arm64: remove duplicated early fixmap init
Date: Mon, 19 Feb 2024 22:27:32 +0900
Message-Id: <20240219132732.2493485-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <skseofh@gmail.com>

We call early_fixmap_init() in two places.
- early_fdt_map()
- setup_arch()

Because early_fdt_map() is called before going to setup_arch(),
early_fixmap_init() can be deleted from setup_arch().

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 arch/arm64/kernel/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d60..ce45f4a9ac4a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -305,7 +305,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	arm64_use_ng_mappings = kaslr_requires_kpti();
 
-	early_fixmap_init();
 	early_ioremap_init();
 
 	setup_machine_fdt(__fdt_pointer);
-- 
2.25.1


