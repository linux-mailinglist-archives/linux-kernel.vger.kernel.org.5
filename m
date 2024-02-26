Return-Path: <linux-kernel+bounces-81589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E617F8677DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E941C26256
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3312EBC7;
	Mon, 26 Feb 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ba7gGwNi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B312A163
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956476; cv=none; b=Wg22WpDEQQODjJYi8runFBFliBx1QhWu/lg747ZJ+x4DCVmo/Uj7PXc5SiTvdDhOcC6Nmmq6EW+4ec9iIbHkY5oNk+uIQtXWGTQdhS7nh0G+dhQcLDwD68L4XgXeSuw/IGhmPLnAabcjqr47fTXQh9FmTabnYJZC5gtRfmWcfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956476; c=relaxed/simple;
	bh=nweeBOvRgRi9dgBd4ttPVYmzQlmi56/EZ7L4CdCmq5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLY1wsp8H+NRVn4GvNnqw3TvgK8rqKZHHmXgFce4jYv63ryPnAkB+b0m55ilmfaoQXc5vTTGkx6VAG5Augnl6ixTMsLeOS98fDAgwf+vUZN1x7l5JMgacUnh+nYbNoPkwgr790Ysi327HgN5WJp/U0GbsyX3Q392ZCotHq8zBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ba7gGwNi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41288100ecaso2024835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708956473; x=1709561273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3cft7Ypg0legv2IgemzKJux6J8rPPIzvMpQQPbvnK0=;
        b=ba7gGwNiKehdqNn2xV00BT7UtUukS8aX/MAK56gKLACsP6j/W3AtkWbFlvNJV5+vUC
         qDvBOBugbs+XPoIvFHAuAx4c0JCSy3Fzui579YhXIwG/IMKy5HDlxRO3rKh4SB3xByXR
         6r8iEIhNnruf5s79bei9l0+b9LssV7UMGIChiR4DAxnzdbD7J1RPYJEJ0Sta+Xfvs3Vh
         ugv4ilMteSYOWFvP1tTyooDogqiWryDw5w7qY1CYu2636WPWzeXgbm8e3xv1/QaeEVCs
         XzEwK9S4wqPLYZXzdPu5FU7TjoGNxoAlmWGFTQUpYJmjtPtY7yNzBRSjDHqI4+KmeIz+
         eetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956473; x=1709561273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3cft7Ypg0legv2IgemzKJux6J8rPPIzvMpQQPbvnK0=;
        b=d4Lf8nSICgP1D4tEiK9Z0TymxZVDK7w8MwXohuz4ofcre4Oa19ovAvU4g4BQcWKgc7
         TGUpzLxlvL+pvTV6QHG2NX+0OJ50EZyAm7ROp/2nFZ7C1R/9JELzAqOA7bAfx6Yt2EZ1
         YEGT2zxXv+mZYWc2QUxw/Qybx88RX3BIqcIW2loPPWuxDKYBz5ArPYorwuKn5KZymoZk
         MgbqLIiW1rwVjGMqEXGyt+j1ifoRm4sN667M9u61zTjAUy+0SU87aZ2mf1TC7axzlbwV
         /0ltl9r6VDx724muL1nrZ21SmxIbzS3WpNlWejvyAJECaB6Ruvs1vDNZYFy/t9/Qm2kZ
         jzDA==
X-Forwarded-Encrypted: i=1; AJvYcCXxy9f4arUlVqVmNxv0oxovXZiIwW8hsYlYzyH5080bFrVTYzoD2qhIRchhaeKiEe2CYEVXb53b0W7WR0Y0sPNZ7E2HWpOtkumX0Dtl
X-Gm-Message-State: AOJu0YwmidT1AS+Gu36UddX3j5r73bcyzd8NYt0k0cQ8mNuX/zh8t8Tn
	vO+nxkZxja4kuqepoqKr9iRZBt/SKp/N31ug0aOuQEvIPz5AYdqEbtwC+Y+pekY=
X-Google-Smtp-Source: AGHT+IFWeLyABthKnQh82+1HfoBCkHmIx/VTkUVLqqzwuzyCNDGWVehu8nc5ISMY2K+88EhoRCllng==
X-Received: by 2002:a05:600c:3ba6:b0:412:2b7a:6816 with SMTP id n38-20020a05600c3ba600b004122b7a6816mr5168803wms.0.1708956472906;
        Mon, 26 Feb 2024 06:07:52 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:83a3:2c00:c690:18b0])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c261300b00412a30cd127sm4802196wma.7.2024.02.26.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:07:52 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH] riscv: deprecate CONFIG_MMU=n
Date: Mon, 26 Feb 2024 15:06:46 +0100
Message-ID: <20240226140649.293254-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Deprecation of NOMMU support for riscv was discussed during LPC 2023
[1]. Reasons for this involves lack of users as well as maintenance
efforts to support this mode. psABI FDPIC specification also never
made it upstream and last public messages of this development seems to
date back from 2020 [2]. Plan the deprecation to be done in 2 years from
now. Mark the Kconfig option as deprecated by adding a new dummy option
which explicitly displays the deprecation in case of CONFIG_MMU=n. This option
is selected indirectly by CONFIG_RISCV_M_MODE since an option can not
select another one directly with a "select" in case of such CONFIG=n.
Additionally, display a pr_err() message at boot time in case of NOMMU
build to warn about upcoming deprecation.

Link: https://lpc.events/event/17/contributions/1478/ [1]
Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/WYRRylTwAAAJ [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 arch/riscv/Kconfig        | 8 ++++++++
 arch/riscv/kernel/setup.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..8da58c102d3f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -221,6 +221,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
 # set if we run in machine mode, cleared if we run in supervisor mode
 config RISCV_M_MODE
 	bool
+	select NOMMU
 	default !MMU
 
 # set if we are running in S-mode and can use SBI calls
@@ -236,6 +237,13 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
+config NOMMU
+	depends on !MMU
+	bool "NOMMU kernel (DEPRECATED)"
+	help
+	  NOMMU kernel is deprecated and is scheduled for removal by
+	  the beginning of 2027.
+
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MMU
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4f73c0ae44b2..8799816ef0a6 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -295,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
 	riscv_set_dma_cache_alignment();
 
 	riscv_user_isa_enable();
+
+#if !defined(CONFIG_MMU)
+	pr_err("RISC-V NOMMU support is deprecated and scheduled for removal by the beginning of 2027\n");
+#endif
 }
 
 bool arch_cpu_is_hotpluggable(int cpu)
-- 
2.43.0


