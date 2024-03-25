Return-Path: <linux-kernel+bounces-116932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3A88A542
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC0288E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D211BCFC0;
	Mon, 25 Mar 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO7CNTxY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60D157498
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365838; cv=none; b=Vu16PHBciOyID56y0l1ez2lIWzldE9pG7KFDkNz1XBoJAGgUPA3OXj+9FGRT/QRi8l/egno9sHx8CsTXfx5SeSkeBr1s3ddOB1/D5usv080mVP3wEVF/zpty6THyhlpUVZpuhox8Z2ZrMzh0IHOs0/7vXljn5McRFmbhARmOkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365838; c=relaxed/simple;
	bh=Hcvo8TwKTObsbxJiMa+DCZVgn0Ppw92GI2jy5pNrT8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI1eaBORYwU6ju/f2xMNM2eML5hk1yM5FFiRUlHKvMgxdhbaiMMDG1XCf+E4f06Ll2tikbef39co25DOO3RqzMOv5COiWm7R608pUlP+2+Pv4Ka0dN0g2+2FBhWJQMCZk/IgWORb7tGKjN4iGBPqHClltsz8MAPZYvuza5KjWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO7CNTxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A096BC43390;
	Mon, 25 Mar 2024 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365838;
	bh=Hcvo8TwKTObsbxJiMa+DCZVgn0Ppw92GI2jy5pNrT8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jO7CNTxYsgsZN0RpxKG0TpN4fr1dM9M9yxv+ojbrGrYYXRCbxXahb8xuDan7vP8sv
	 WZyGX8W3kdx6Sxf8n/Z4HZurOBXMK+LrW4JFiFNZmBOFzKzLm6Y+42MyT6FMGmF1fk
	 Z4AzEMBU5CArTOI6LXvuNA7YziuXIF6N0YwuTB/vevJAcO9LNJ1TXwdeOvrXoKYkyk
	 mvUEqRJG9njKVzoKQ6AEE2XMd8qCvc3/TwmTk3Ad5CsAAPU13aPUHfPI4yoTpIEagU
	 XjpT785o1D9K11kj7r5hzg5D287Bfzs5kdqvojZ0NEF0zfwweC6jBN/aGINOws2wxp
	 B/O4bxQ5adlbg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 RESEND 2/2] riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
Date: Mon, 25 Mar 2024 19:10:38 +0800
Message-ID: <20240325111038.1700-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325111038.1700-1-jszhang@kernel.org>
References: <20240325111038.1700-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After selecting ARCH_USE_CMPXCHG_LOCKREF, one straight futher
optimization is implementing the arch_cmpxchg64_relaxed() because the
lockref code does not need the cmpxchg to have barrier semantics. At
the same time, implement arch_cmpxchg64_acquire and
arch_cmpxchg64_release as well.

However, on both TH1520 and JH7110 platforms, I didn't see obvious
performance improvement with Linus' test case [1]. IMHO, this may
be related with the fence and lr.d/sc.d hw implementations. In theory,
lr/sc without fence could give performance improvement over lr/sc plus
fence, so add the code here to leave performance improvement room on
newer HW platforms.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2fee65cc8443..f1c8271c66f8 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -359,4 +359,22 @@
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
+#define arch_cmpxchg64_relaxed(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_relaxed((ptr), (o), (n));				\
+})
+
+#define arch_cmpxchg64_acquire(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_acquire((ptr), (o), (n));				\
+})
+
+#define arch_cmpxchg64_release(ptr, o, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_release((ptr), (o), (n));				\
+})
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.43.0


