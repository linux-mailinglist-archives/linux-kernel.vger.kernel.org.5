Return-Path: <linux-kernel+bounces-136274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CD89D228
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D71B22D42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717027D062;
	Tue,  9 Apr 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tqPiCtAS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588777C09F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643129; cv=none; b=fV1yniMNYRP7uZ62msRRGxlVtjNhlFptfpm5UzCJlxLl2TveqqWU5h37vFws4EsJKEVQ43NgI20cDMyozaadxaiafNpT6c2HzYQhGVB3vhNdjj/oFZzBfETGgQzHfXm55zH8iDZKwNEnFR+cJ3oFbnTwIE/UUFdyj7+zGom+2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643129; c=relaxed/simple;
	bh=pgcQ0O7mGTa5hgvj/DeLVv7bktEQUMChSoIMdpY1ek4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ccP6RCKKyqIKWy53S6HcH+I0twxWh1dM0u+7f/uc5Ku117e/kvVDMujMJYyOZRrGiKvTMi/8b9fwyKEC59Kp5Sqgiq9DDQMwx6pYFw/hAVPtHOEU0uwf7aiTVYaaVmkKRLkWXcqgeGnXqqybLL3vvWDO8/+fRyc/sl9KtXnMC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tqPiCtAS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e244c7cbf8so43834635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643127; x=1713247927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjtTgkYtpD1hbyyXFcP/z2jvjrG+SfaQnLJvf/Uiuoc=;
        b=tqPiCtASiXnXGorqyjbe4+xJHmXuYnt+x3HFOvlV3sLiotp/0nInmaoedlSZykK2w6
         57UU6BLbn4usAEOtA6pCCrZKDSYgDuYkxfYfMxyfQanRqjCuQoz6a/wkddH7k7R0oKER
         4ub06+6zCoBBKqJFExywlYkaIsKtJ453Xq2aN9TL2TeYLnyQ2vDr/nORCpC/vzT0tQnu
         gHu7UOR3Oq+Yt+wHRH9NeJ/+pkumwvMKSWv454SBSmDMLTFuXtbaOze1EMcLsw1SfptP
         UGOM79uRiHXTxHIqo6yiSiZrRoEEGio6jdMEaC+8TSiSDK3pfTsTSIcJ1Jt2PaP5gmav
         5fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643127; x=1713247927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjtTgkYtpD1hbyyXFcP/z2jvjrG+SfaQnLJvf/Uiuoc=;
        b=ozvr+n1dAZmXf5QtYer8Z/0IZ8SqF7zDSAaic/55SDdfNxumuOVjl8bNx9XkwXUXR/
         bewo6DDIUp4sy6PAEeCNydFVlSxkzQjWBCttzPVZEkPU/NRgXV3Vr4gghx65raqG5FVd
         wiM6JSCs3CqwhqEjRRIqlgKA4lYnecbb+gNNLlSJFFpzQ7p4PJ1cbKK5pxOdZDKFX4K0
         HE3Nxv3Lh4Bbe4twvgQHgqadx1VTScLQHEw4Sy3jrkyX+NBRVd2Jg9mDa2iLWkh5PSZk
         n7QRL5KN7DxCeI04SXTK1PIj8FdCUx13CIYeLzfDYYw7m6/yAlfn8250uuX9wjHuWlgG
         HH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUKeHxg9BzksQnfsyWBG6I00j5nprNJ5pGPaWDPLELSnrGPtXo64wAgpi6HB4MCW9W3MF3zYPp4gf5/XoCE9IXCuYQxc07bbLIDOB9J
X-Gm-Message-State: AOJu0YyIzj743XYyMmY2NQPTHP64meMt1kx60rAV9vBWeUurowYfTNZN
	eIVWivgr/2gfmWceZTM7bK2VBFgi3/0czTEQamlvzmJzcMd+5fOnE5W7iVYaFOw=
X-Google-Smtp-Source: AGHT+IE/zrYmmP+jRMmProhU7OrEkAtvl+lojCdG3T5dMALi5Qk/NiBMoaQSS094JtfcnVR7MBKxhA==
X-Received: by 2002:a17:902:e945:b0:1e4:363b:1d42 with SMTP id b5-20020a170902e94500b001e4363b1d42mr4916637pll.3.1712643127547;
        Mon, 08 Apr 2024 23:12:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:06 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 05/12] riscv: fix certain indirect jumps for kernel cfi
Date: Mon,  8 Apr 2024 23:10:36 -0700
Message-Id: <20240409061043.3269676-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handwritten `__memset` asm routine performs certain static jumps within
function and uses `a5` to do that. This would require a landing pad
instruction at the target. Since its static jump and no memory load is
involved, use `t2` instead which is exempt from requiring a landing pad.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/lib/memset.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index 35f358e70bdb..e129ebf66986 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -56,12 +56,12 @@ SYM_FUNC_START(__memset)
 
 	/* Jump into loop body */
 	/* Assumes 32-bit instruction lengths */
-	la a5, 3f
+	la t2, 3f
 #ifdef CONFIG_64BIT
 	srli a4, a4, 1
 #endif
-	add a5, a5, a4
-	jr a5
+	add t2, t2, a4
+	jr t2
 3:
 	REG_S a1,        0(t0)
 	REG_S a1,    SZREG(t0)
-- 
2.43.2


