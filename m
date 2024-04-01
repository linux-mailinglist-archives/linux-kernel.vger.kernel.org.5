Return-Path: <linux-kernel+bounces-127097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293658946A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF7B1F22508
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4E56B81;
	Mon,  1 Apr 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbSx1Kih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102856451;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007595; cv=none; b=OHksULmATpQ38ZWlpGbMs7O80ptkUvSsFc4v7GAgibcIEfsPzjZnOpUvcSaUX6uahYEa5kGNxz1B3vwp5spbiRMliBzYwu5P4pSu2nFIytJkIe1n69tkxelRVlTUPV1CxG7fu3dZJvzwgI78qB9BbxnGsVjYB2oFzUHehWTleIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007595; c=relaxed/simple;
	bh=Pey06aLnsLIkF3gQwCE3xye5sHMsA4TvrP5HMpqUzF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qy/lNoxwRBLHRqyrTxYWqyVcJR5U7JFZ1Wbc06L7W17h3K43bAgKCWk8W0+jnVcINkFya7xhl7XJ+hFHEpDF/oDmJZGp1Jl8lUTRk7bxgHeVP36hOEXsjJP4WR4hiJIycuLEJlOyZZ7i6m0KVeF86nUZoPZmmoUClJyf4LMkROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbSx1Kih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E1AC4166D;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007595;
	bh=Pey06aLnsLIkF3gQwCE3xye5sHMsA4TvrP5HMpqUzF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbSx1KihmT9WtPJs586246mVIRQzi+qsjmxTVRaon1gmEjk0lPItmESlYh5QhC9aV
	 Ib69kzvUKgqxWrUKS37wueAgS72+c0IG3W6VRsD8Rw0BBODDuRjhPDbhQfqZbLi5Zl
	 JATJgrTA8tSNHW38sYwH+8Mld9eGwOElgjCvThaJFDHnxG/j+eDJuOEkTfleTqLZ4k
	 y1QSM8JcNE9ztVxnVdm0kUWrjFqLQ0SeDzpR/S9IOhhl12uCVcUqxSkoZLGewk7ILg
	 MLN7wp98ifSjdXgOA2VjujrSZZglP3VEzV9iw6fcTrBjlc8P17TmdKtn40qCad4c9s
	 tbsftMN3dOLtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA97BCE0FF3; Mon,  1 Apr 2024 14:39:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-parisc@vger.kernel.org
Subject: [PATCH RFC cmpxchg 7/8] parisc: Emulate two-byte cmpxchg
Date: Mon,  1 Apr 2024 14:39:49 -0700
Message-Id: <20240401213950.3910531-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u16() to emulate two-byte cmpxchg() on parisc.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: <linux-parisc@vger.kernel.org>
---
 arch/parisc/Kconfig               | 1 +
 arch/parisc/include/asm/cmpxchg.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index daafeb20f9937..06f221a3f3459 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -15,6 +15,7 @@ config PARISC
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index c1d776bb16b4e..f909c000b6577 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -72,6 +72,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 #endif
 	case 4: return __cmpxchg_u32((unsigned int *)ptr,
 				     (unsigned int)old, (unsigned int)new_);
+	case 2: return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
 	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
 	}
 	__cmpxchg_called_with_bad_pointer();
-- 
2.40.1


