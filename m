Return-Path: <linux-kernel+bounces-146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06584813CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CB51F22706
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7667B6E2A0;
	Thu, 14 Dec 2023 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELKFiU6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N18HNVVu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D636A34D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7/AQ14CtAPSsdBF4bK1N6nAJCYWmYHbSVQMVRCyl58=;
	b=ELKFiU6QcHpmyjj4y3/ThWrC6NQsGQrxCPGsHKykjs/CeBfb1lK742gwL4JdDM8lCJjxFZ
	w+ymCW6goNmRY5vxbSXxHJ/onItb2M5fnM2QrmKkat5qnFhhrwKT8jrB4n+R6Ukd6zzinb
	1jdOKuWs/T04n+S6Aou6k+sjVMrAS2iMYCfHDme3aNQKFJ3O1cdTPyagsQhPbkVA0wx2gR
	V5HQuORKoXg6WyYNjOyoMgwv1vDu+x9W84Rq46CcnV3SrIbOOOi5+btRwkOr9jrxFKuM2r
	2u4tWmuFFrnavCGbKEMk/FpbZNgfhRGBR/Q8ByC4CaMGJNea1odvqekSvqiJNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7/AQ14CtAPSsdBF4bK1N6nAJCYWmYHbSVQMVRCyl58=;
	b=N18HNVVuiXztnaW/iSDFaWUXfIQT0nam9vm/nj3pVKOO4M1DD9GYxXgV0hGTwzBUbPMjDr
	9e6CQjVJbikgkJCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq macros
Date: Thu, 14 Dec 2023 22:47:49 +0106
Message-Id: <20231214214201.499426-3-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: This change only applies to 32bit architectures. On 64bit
      architectures the macros are NOPs.

__ulseq_to_u64seq() computes the upper 32 bits of the passed
argument value (@ulseq). The upper bits are derived from a base
value (@rb_next_seq) in a way that assumes @ulseq represents a
64bit number that is less than or equal to @rb_next_seq.

Until now this mapping has been correct for all call sites. However,
in a follow-up commit, values of @ulseq will be passed in that are
higher than the base value. This requires a change to how the 32bit
value is mapped to a 64bit sequence number.

Rather than mapping @ulseq such that the base value is the end of a
32bit block, map @ulseq such that the base value is in the middle of
a 32bit block. This allows supporting 31 bits before and after the
base value, which is deemed acceptable for the console sequence
number during runtime.

Here is an example to illustrate the previous and new mappings.

For a base value (@rb_next_seq) of 2 2000 0000...

Before this change the range of possible return values was:

1 2000 0001 to 2 2000 0000

__ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
__ulseq_to_u64seq(2000 0000) => 2 2000 0000
__ulseq_to_u64seq(2000 0001) => 1 2000 0001
__ulseq_to_u64seq(9fff ffff) => 1 9fff ffff
__ulseq_to_u64seq(a000 0000) => 1 a000 0000
__ulseq_to_u64seq(a000 0001) => 1 a000 0001

After this change the range of possible return values are:
1 a000 0001 to 2 a000 0000

__ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
__ulseq_to_u64seq(2000 0000) => 2 2000 0000
__ulseq_to_u64seq(2000 0001) => 2 2000 0001
__ulseq_to_u64seq(9fff ffff) => 2 9fff ffff
__ulseq_to_u64seq(a000 0000) => 2 a000 0000
__ulseq_to_u64seq(a000 0001) => 1 a000 0001

[ john.ogness: Rewrite commit message. ]

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311161555.3ee16fc9-oliver.sang@intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index b82a96dc2ea2..12f60c782e46 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -407,7 +407,7 @@ static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 	 * Also the access to the ring buffer is always safe.
 	 */
 	rb_next_seq = prb_next_seq(rb);
-	seq = rb_next_seq - ((u32)rb_next_seq - ulseq);
+	seq = rb_next_seq - (s32)((u32)rb_next_seq - ulseq);
 
 	return seq;
 }
-- 
2.39.2


