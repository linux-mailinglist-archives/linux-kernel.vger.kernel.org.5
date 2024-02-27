Return-Path: <linux-kernel+bounces-82471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D48868508
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C342D2851F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5D610D;
	Tue, 27 Feb 2024 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DReMv1vj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A74689
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994198; cv=none; b=dEi0uL02vIir5rSQgjQxwuER2q2kORw7nc5TM9BcIinZJq7dcARIApCngEFCCFmW7ndZRjaFhCu9E7a3nb/4Kx1/2aSt+bf++aq1RRlpowsq181ujziCPjnw2c/4sjRHL2Dm9pqpC6gPVx3k5EoUaEFlehAjEgZ9af6lBUUcHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994198; c=relaxed/simple;
	bh=48/PSeN1dqxJlNE4djxwYvziDIjYXncGoOaPbOyotlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY44aRc/avqZ/iLpxb7d5j8QdvCokoHl/07il18Pzt9PajFVak75mptasTtU5P0DJ5k7p0kGtEHw4hcFcbWL0q5rxPljWdTKYvEXE2acuZmJEU2hmG6caAC0yXbIQ+ej/TNYXJS0/LO9yLg+mTIU/yRWMFDJrDdstxJZYsI+Zdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DReMv1vj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so2190283b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708994196; x=1709598996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DgT08L+OHu5JWWVgI2Bop+R/swEzoI3UepBE4dcuzQ=;
        b=DReMv1vjMXx9ymqkiB+xEnL363aaTLF7R/UsxCmt66RKmkSsZ/3ok2FFe1NtQaSyM3
         sy0W4Pu7UXeZMwGqP2+hZFSMenZMJ+trlps1Z0ZgtVLlTNMJTylfqB/WvkDFz1Eoeb0j
         bndO+GEo3QOIVAxjhkVHfuylrt0I6POlcBMxaN/8m6n0TBMVkkAZqWgf6m5mHiJ5jici
         wOpRGufS8KocfUQqyzKEMy6QTc5dBUANXqBJTvEyAakGWbJSTzNZQaRbuXvy/gyW4Gke
         QqkmqcCbJgfpvfXH8l0GFbQ0rY790qvk+8HAlr5e9mCRC/vHSMYoDNfeaVCx9dOgfW37
         eWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994196; x=1709598996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DgT08L+OHu5JWWVgI2Bop+R/swEzoI3UepBE4dcuzQ=;
        b=W0s0wrTYDR5yEEyL4R2w1NxzEnFNtiZT8W7v+qKHY8uD3Q2pidEyUjQJibuO5e0Sky
         ZpruUDnTcmwJVOTJ9tNUAuFe3rjeLXB8s4H+yD3R3cOEhE5PAzPnqTVOrK+z2DRY4bvq
         5+fbmH5h6QebmmrqoTSoz6mttoYgqFZL9syYpwwELr2VrM5Rf+/KTj4i5brxs2qWCie+
         bF3Ku6LieUVEGhLBAEGpRKZgnZCOVoLlAJJ7VNO22KdFhcA+hRtWuw5/rX0y3c1QBtHs
         4efy41k+B1VqqU4iYLsNk2XB3WJbtP3w1SP+FXahgBD7W+6yXvKfshzl35m1JE6yppXg
         JipA==
X-Gm-Message-State: AOJu0Yw6btuaHfdO7737F1fqk0w4ZqQEvRbWHQOA5huGCqk6BKfyMabx
	0ITJR3zW0W+GiureFg4qAEcNcVDmdpEz4CUUyRTzHXUnmCYH0Ob0iJqqw4TFs43U+3epKcA4tgy
	x
X-Google-Smtp-Source: AGHT+IHpBABr/kwuIBit9b2KbLax70vI2KtrkrHOQQ7ijJ8O9ipFow5FWGR8xS5tvdhxrGR/HHYC6Q==
X-Received: by 2002:a05:6a20:6f01:b0:1a0:c3e6:3135 with SMTP id gt1-20020a056a206f0100b001a0c3e63135mr907151pzb.28.1708994196622;
        Mon, 26 Feb 2024 16:36:36 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020a631919000000b005dc85821c80sm4504117pgl.12.2024.02.26.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:36:36 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/4] riscv: Remove MMU dependency from Zbb and Zicboz
Date: Mon, 26 Feb 2024 16:34:48 -0800
Message-ID: <20240227003630.3634533-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zbb and Zicboz ISA extensions have no dependency on an MMU and are
equally useful on NOMMU kernels.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..ef53c00470d6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -581,7 +581,6 @@ config TOOLCHAIN_HAS_ZBB
 config RISCV_ISA_ZBB
 	bool "Zbb extension support for bit manipulation instructions"
 	depends on TOOLCHAIN_HAS_ZBB
-	depends on MMU
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
@@ -613,7 +612,6 @@ config RISCV_ISA_ZICBOM
 
 config RISCV_ISA_ZICBOZ
 	bool "Zicboz extension support for faster zeroing of memory"
-	depends on MMU
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-- 
2.43.0


