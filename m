Return-Path: <linux-kernel+bounces-117515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8188AD40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE462C65618
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B8F4E2;
	Mon, 25 Mar 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1xjklQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1E6AA1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385619; cv=none; b=m1hrDyhGcMtQFz3GXHSMTszL8spA7TX9st/mowAVWH6eTucd5Mu+svDaFYs18Xb3OSq1QP2cfscZ6O9hvRQhXzIAjkklawapfaGgC5xwWdyQPUeR1zr01BvE/G3fylvKhYfNMMdVuh2uZ6/K/ZL70oDgCigHOIuBoABd+BPmhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385619; c=relaxed/simple;
	bh=vNJUUGgBYsqzd1U+c0XNtNNwoWAwHgq0i6v5JcQYy7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/WBTYpf9S3A/7GLOr8PjtmejaEurQk14s3AX4LpcLXvWBUbt/MtSWTv3cIJjizfbpTFrD5wIshEDXwoP/3z+EUOBUcASIx+RvLYlc0YWiQ9ib3CtAnbRAvaFanHJs0tbjlQ4xheFqAFmONjJhUnvBywcfuu5rfaL88YTkeP2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1xjklQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A506C43390;
	Mon, 25 Mar 2024 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385618;
	bh=vNJUUGgBYsqzd1U+c0XNtNNwoWAwHgq0i6v5JcQYy7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1xjklQ9T3CUCWED7yfG2ZMg+v7PSjM3W4B+DkuMr25oQbcUGTDaIrKYJdh3ggagm
	 /xhQgXW0roNkItDioF6LE49k7MEfmjwU+knmOqmuoh4VKTFM5T68nKzKidhNR1oxNK
	 Jy340vIkQYcantibiT87kBrAZhlsSq6dI/Ch8NywMF5SUtB2Ywz8P/SliUSjpNz9TM
	 JYuvx7BYR1UikX4XBeXLuMArHIgUOs+WzYLygvAYlpjBZz/lPo9L0efBqBHh3IFWr4
	 WmFIC4zK/kEZ/KsIUTbtFcWrBTKU9t+/V8KG0BJ73eoKMPnAh1LqWL0nKfZtKujtxN
	 oQUreGyV/GmxQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] riscv: nommu: remove PAGE_OFFSET hardcoding
Date: Tue, 26 Mar 2024 00:40:17 +0800
Message-ID: <20240325164021.3229-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325164021.3229-1-jszhang@kernel.org>
References: <20240325164021.3229-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
there's only one nommu platform in the mainline. However, there are
many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
the hardcoding value, and introduce DRAM_BASE which will be set by
users during configuring. DRAM_BASE is 0x8000_0000 by default.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7895c77545f1..afd51dbdc253 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -247,10 +247,16 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
+if !MMU
+config DRAM_BASE
+	hex '(S)DRAM Base Address'
+	default 0x80000000
+endif
+
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MMU
-	default 0x80000000 if !MMU
+	default DRAM_BASE if !MMU
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
-- 
2.43.0


