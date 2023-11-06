Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F37E1DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjKFKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKFKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:00:16 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437AA6;
        Mon,  6 Nov 2023 02:00:13 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qzwOn-00EXYf-L5; Mon, 06 Nov 2023 18:00:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Nov 2023 18:00:08 +0800
Date:   Mon, 6 Nov 2023 18:00:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Subject: [PATCH] crypto: jitterentropy - Hide esoteric Kconfig options under
 FIPS and EXPERT
Message-ID: <ZUi5KMUaNkp0c1Ds@gondor.apana.org.au>
References: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <CAHk-=wj0-QNH5gMeYs3b+LU-isJyE4Eu9p8vVH9fb-vHHmUw0g@mail.gmail.com>
 <ZUSKk6Tb7+0n9X5s@gondor.apana.org.au>
 <CAHk-=wh=xH7TNHeaYdsrVW6p1fCQEV5PZMpaFNsZyXYqzn8Stg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=xH7TNHeaYdsrVW6p1fCQEV5PZMpaFNsZyXYqzn8Stg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:32:36PM -1000, Linus Torvalds wrote:
> 
> I think that would help the situation, but I assume the sizing for the
> jitter buffer is at least partly due to trying to account for cache
> sizing or similar issues?
> 
> Which really means that I assume any static compile-time answer to
> that question is always wrong - whether you are an expert or not.
> Unless you are just building the thing for one particular machine.
> 
> So I do think the problem is deeper than "this is a question only for
> experts". I definitely don't think you should ask a regular user (or
> even a distro kernel package manager). I suspect it's likely that the
> question is just wrong in general - because any particular one buffer
> size for any number of machines simply cannot be the right answer.
> 
> I realize that the commit says "*allow* for configuration of memory
> size", but I really question the whole approach.

Yes I think these are all valid points.  I just noticed that I
forgot to cc the author so let's see if Stephan has anything to
add.

> But yes - hiding these questions from any reasonable normal user is at
> least a good first step.

OK here's the patch:

---8<---
As JITTERENTROPY is selected by default if you enable the CRYPTO
API, any Kconfig options added there will show up for every single
user.  Hide the esoteric options under EXPERT as well as FIPS so
that only distro makers will see them.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/Kconfig b/crypto/Kconfig
index bbf51d55724e..70661f58ee41 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1297,10 +1297,12 @@ config CRYPTO_JITTERENTROPY
 
 	  See https://www.chronox.de/jent.html
 
+if CRYPTO_JITTERENTROPY
+if CRYPTO_FIPS && EXPERT
+
 choice
 	prompt "CPU Jitter RNG Memory Size"
 	default CRYPTO_JITTERENTROPY_MEMSIZE_2
-	depends on CRYPTO_JITTERENTROPY
 	help
 	  The Jitter RNG measures the execution time of memory accesses.
 	  Multiple consecutive memory accesses are performed. If the memory
@@ -1344,7 +1346,6 @@ config CRYPTO_JITTERENTROPY_OSR
 	int "CPU Jitter RNG Oversampling Rate"
 	range 1 15
 	default 1
-	depends on CRYPTO_JITTERENTROPY
 	help
 	  The Jitter RNG allows the specification of an oversampling rate (OSR).
 	  The Jitter RNG operation requires a fixed amount of timing
@@ -1359,7 +1360,6 @@ config CRYPTO_JITTERENTROPY_OSR
 
 config CRYPTO_JITTERENTROPY_TESTINTERFACE
 	bool "CPU Jitter RNG Test Interface"
-	depends on CRYPTO_JITTERENTROPY
 	help
 	  The test interface allows a privileged process to capture
 	  the raw unconditioned high resolution time stamp noise that
@@ -1377,6 +1377,28 @@ config CRYPTO_JITTERENTROPY_TESTINTERFACE
 
 	  If unsure, select N.
 
+endif	# if CRYPTO_FIPS && EXPERT
+
+if !(CRYPTO_FIPS && EXPERT)
+
+config CRYPTO_JITTERENTROPY_MEMORY_BLOCKS
+	int
+	default 64
+
+config CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE
+	int
+	default 32
+
+config CRYPTO_JITTERENTROPY_OSR
+	int
+	default 1
+
+config CRYPTO_JITTERENTROPY_TESTINTERFACE
+	bool
+
+endif	# if !(CRYPTO_FIPS && EXPERT)
+endif	# if CRYPTO_JITTERENTROPY
+
 config CRYPTO_KDF800108_CTR
 	tristate
 	select CRYPTO_HMAC
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
