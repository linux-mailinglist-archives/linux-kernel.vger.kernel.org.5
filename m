Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110847F3B51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbjKVB3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjKVB3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:29:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBA90
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:29:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CBEC433C9;
        Wed, 22 Nov 2023 01:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700616575;
        bh=RpIunAZsbi17XYTLNqesJHhN+XFXcX0D4F+MccBdkJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrbdFQ6bgw6z7RfWZ45V2si4KCzEBQBQGNtYt+ijIY0vU2ZyG5yoLqrd10A3ZQYk6
         PaQn8LxCVvuVH8DQScs7rtrAhF+4vXJkdkF/BKVJzBBxeDoEUxUxddctrxqo9kaqa9
         FP0s2LUG+VOQ/zMn34itUt3qFv3mdLZnDLU6yUK/YpdS+L6kRyz+NaaOPnK4N32h4T
         m8SNMDlcEa4MXDgpTG3pTLvWEJ7GeZMZurLJKlKCIIM5ZGZv21x+OY7yMc7EICMoms
         WUEoKBkMAZCEBg3Wfrz4/RW+dPymXm7HTwya4ChSJja62mGU024QnF9t1m/FBQPi3r
         FWJQkNhUYPOHQ==
Date:   Tue, 21 Nov 2023 17:29:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
Message-ID: <20231122012933.GG2172@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025183644.8735-13-jerry.shih@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:36:44AM +0800, Jerry Shih wrote:
> diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c b/arch/riscv/crypto/chacha-riscv64-glue.c
> new file mode 100644
> index 000000000000..72011949f705
> --- /dev/null
> +++ b/arch/riscv/crypto/chacha-riscv64-glue.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Port of the OpenSSL ChaCha20 implementation for RISC-V 64
> + *
> + * Copyright (C) 2023 SiFive, Inc.
> + * Author: Jerry Shih <jerry.shih@sifive.com>
> + */
> +
> +#include <asm/simd.h>
> +#include <asm/vector.h>
> +#include <crypto/internal/chacha.h>
> +#include <crypto/internal/simd.h>
> +#include <crypto/internal/skcipher.h>
> +#include <linux/crypto.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#define CHACHA_BLOCK_VALID_SIZE_MASK (~(CHACHA_BLOCK_SIZE - 1))
> +#define CHACHA_BLOCK_REMAINING_SIZE_MASK (CHACHA_BLOCK_SIZE - 1)
> +#define CHACHA_KEY_OFFSET 4
> +#define CHACHA_IV_OFFSET 12
> +
> +/* chacha20 using zvkb vector crypto extension */
> +void ChaCha20_ctr32_zvkb(u8 *out, const u8 *input, size_t len, const u32 *key,
> +			 const u32 *counter);
> +
> +static int chacha20_encrypt(struct skcipher_request *req)
> +{
> +	u32 state[CHACHA_STATE_WORDS];

This function doesn't need to create the whole state matrix on the stack, since
the underlying assembly function takes as input the key and counter, not the
state matrix.  I recommend something like the following:

diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c b/arch/riscv/crypto/chacha-riscv64-glue.c
index df185d0663fcc..216b4cd9d1e01 100644
--- a/arch/riscv/crypto/chacha-riscv64-glue.c
+++ b/arch/riscv/crypto/chacha-riscv64-glue.c
@@ -16,45 +16,42 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-#define CHACHA_KEY_OFFSET 4
-#define CHACHA_IV_OFFSET 12
-
 /* chacha20 using zvkb vector crypto extension */
 asmlinkage void ChaCha20_ctr32_zvkb(u8 *out, const u8 *input, size_t len,
 				    const u32 *key, const u32 *counter);
 
 static int chacha20_encrypt(struct skcipher_request *req)
 {
-	u32 state[CHACHA_STATE_WORDS];
 	u8 block_buffer[CHACHA_BLOCK_SIZE];
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	const struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk walk;
 	unsigned int nbytes;
 	unsigned int tail_bytes;
+	u32 iv[4];
 	int err;
 
-	chacha_init_generic(state, ctx->key, req->iv);
+	iv[0] = get_unaligned_le32(req->iv);
+	iv[1] = get_unaligned_le32(req->iv + 4);
+	iv[2] = get_unaligned_le32(req->iv + 8);
+	iv[3] = get_unaligned_le32(req->iv + 12);
 
 	err = skcipher_walk_virt(&walk, req, false);
 	while (walk.nbytes) {
-		nbytes = walk.nbytes & (~(CHACHA_BLOCK_SIZE - 1));
+		nbytes = walk.nbytes & ~(CHACHA_BLOCK_SIZE - 1);
 		tail_bytes = walk.nbytes & (CHACHA_BLOCK_SIZE - 1);
 		kernel_vector_begin();
 		if (nbytes) {
 			ChaCha20_ctr32_zvkb(walk.dst.virt.addr,
 					    walk.src.virt.addr, nbytes,
-					    state + CHACHA_KEY_OFFSET,
-					    state + CHACHA_IV_OFFSET);
-			state[CHACHA_IV_OFFSET] += nbytes / CHACHA_BLOCK_SIZE;
+					    ctx->key, iv);
+			iv[0] += nbytes / CHACHA_BLOCK_SIZE;
 		}
 		if (walk.nbytes == walk.total && tail_bytes > 0) {
 			memcpy(block_buffer, walk.src.virt.addr + nbytes,
 			       tail_bytes);
 			ChaCha20_ctr32_zvkb(block_buffer, block_buffer,
-					    CHACHA_BLOCK_SIZE,
-					    state + CHACHA_KEY_OFFSET,
-					    state + CHACHA_IV_OFFSET);
+					    CHACHA_BLOCK_SIZE, ctx->key, iv);
 			memcpy(walk.dst.virt.addr + nbytes, block_buffer,
 			       tail_bytes);
 			tail_bytes = 0;
