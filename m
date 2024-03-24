Return-Path: <linux-kernel+bounces-113301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED088833C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B350283964
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058A191067;
	Sun, 24 Mar 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsAa1NWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAC191044;
	Sun, 24 Mar 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320102; cv=none; b=MfeDEso5w2CQPTNbveTjA26e5hmhVG5rxYH5LLQ/wTG3TkihaIm/OK6qbsfNAnb0RepenwoMcwGMOtmyV9TC+XbgeWdbd2GwQLjrQJTLf9Ern6q56RjntCee1jA46JL+eghqDmSuJMVWNGYrwcOTEyW2TyJKpHUy4XwryPIpahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320102; c=relaxed/simple;
	bh=jmu23GktzhpBdA3rPY3ZLQOVWrFuA9mTgWTolJwlTE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA5zvsp6/b8E1nSsMdBbyu3/HtFK16ZJzdYBSY8BfaGO1Hpfr/JekCyf7wo5Jg7OcII+a2d1hMZrGicazrtrrmChwtwP8jLGrzzUq5RkfFEdeVV2h/jpRFglz4Fj+y5quuT0+XrvS7OGkxMGphiKBHs3dw5a7niZNW/lrltJMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsAa1NWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DEAC43394;
	Sun, 24 Mar 2024 22:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320102;
	bh=jmu23GktzhpBdA3rPY3ZLQOVWrFuA9mTgWTolJwlTE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsAa1NWd1rqYALgSUPa6l7DVfGEFASDeOOOKZ5oYKFebJ1Xu9fTSv7I9vbcqXUpN+
	 q/QLDQOykmNc90HmLZL6+jI8qv088oAL1JOyeFbUxOKXjeomo+T5PvmhSTfWEd6n/h
	 pJMHEIZy6L4x7gXXwkw4kPW+2GMeM374Yzm4s09SdgoOOAqmYzOHfgYi5twvmcAkmL
	 0glsKA6GG2YUO8Chg97Lfu2oSba6WJTaay856WmrEljzZy7jGv9u4lsbLNiXhGN4M4
	 Pdw9XXT9Dt5XpQT88/hv0KINYuiv8qefcU6DgOOOFDzNb9/HlmdQoDAzlf532ocn5h
	 kGocEGPg3N+Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quanyang Wang <quanyang.wang@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 411/715] crypto: xilinx - call finalize with bh disabled
Date: Sun, 24 Mar 2024 18:29:50 -0400
Message-ID: <20240324223455.1342824-412-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Quanyang Wang <quanyang.wang@windriver.com>

[ Upstream commit a853450bf4c752e664abab0b2fad395b7ad7701c ]

When calling crypto_finalize_request, BH should be disabled to avoid
triggering the following calltrace:

    ------------[ cut here ]------------
    WARNING: CPU: 2 PID: 74 at crypto/crypto_engine.c:58 crypto_finalize_request+0xa0/0x118
    Modules linked in: cryptodev(O)
    CPU: 2 PID: 74 Comm: firmware:zynqmp Tainted: G           O       6.8.0-rc1-yocto-standard #323
    Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
    pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : crypto_finalize_request+0xa0/0x118
    lr : crypto_finalize_request+0x104/0x118
    sp : ffffffc085353ce0
    x29: ffffffc085353ce0 x28: 0000000000000000 x27: ffffff8808ea8688
    x26: ffffffc081715038 x25: 0000000000000000 x24: ffffff880100db00
    x23: ffffff880100da80 x22: 0000000000000000 x21: 0000000000000000
    x20: ffffff8805b14000 x19: ffffff880100da80 x18: 0000000000010450
    x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
    x14: 0000000000000003 x13: 0000000000000000 x12: ffffff880100dad0
    x11: 0000000000000000 x10: ffffffc0832dcd08 x9 : ffffffc0812416d8
    x8 : 00000000000001f4 x7 : ffffffc0830d2830 x6 : 0000000000000001
    x5 : ffffffc082091000 x4 : ffffffc082091658 x3 : 0000000000000000
    x2 : ffffffc7f9653000 x1 : 0000000000000000 x0 : ffffff8802d20000
    Call trace:
     crypto_finalize_request+0xa0/0x118
     crypto_finalize_aead_request+0x18/0x30
     zynqmp_handle_aes_req+0xcc/0x388
     crypto_pump_work+0x168/0x2d8
     kthread_worker_fn+0xfc/0x3a0
     kthread+0x118/0x138
     ret_from_fork+0x10/0x20
    irq event stamp: 40
    hardirqs last  enabled at (39): [<ffffffc0812416f8>] _raw_spin_unlock_irqrestore+0x70/0xb0
    hardirqs last disabled at (40): [<ffffffc08122d208>] el1_dbg+0x28/0x90
    softirqs last  enabled at (36): [<ffffffc080017dec>] kernel_neon_begin+0x8c/0xf0
    softirqs last disabled at (34): [<ffffffc080017dc0>] kernel_neon_begin+0x60/0xf0
    ---[ end trace 0000000000000000 ]---

Fixes: 4d96f7d48131 ("crypto: xilinx - Add Xilinx AES driver")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/xilinx/zynqmp-aes-gcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/xilinx/zynqmp-aes-gcm.c b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
index 3c205324b22b6..e614057188409 100644
--- a/drivers/crypto/xilinx/zynqmp-aes-gcm.c
+++ b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
@@ -231,7 +231,10 @@ static int zynqmp_handle_aes_req(struct crypto_engine *engine,
 		err = zynqmp_aes_aead_cipher(areq);
 	}
 
+	local_bh_disable();
 	crypto_finalize_aead_request(engine, areq, err);
+	local_bh_enable();
+
 	return 0;
 }
 
-- 
2.43.0


