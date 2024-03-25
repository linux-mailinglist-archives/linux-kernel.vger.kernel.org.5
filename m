Return-Path: <linux-kernel+bounces-118005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464B88B23A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583731C3E1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84815EE64;
	Mon, 25 Mar 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBgTU9iN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E055B697;
	Mon, 25 Mar 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400520; cv=none; b=Zx2CXPf6cU0AM6SXOKzoPPbP7C93UCdRsywyoJYwuzZZAhq1TQvGN4CMW9S+w6YtLh4RVsC3I/V4GHUVQLbgdSKdR5KfLZKFDPn87vPdfyvh3ne/BbiRJShrnn6ipnocZoKb4fUP+I15XrSpBms9MdD9+AnvTSqiuz6lim8t3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400520; c=relaxed/simple;
	bh=QD9mCtSDgTE2JsbSwKtRCG1cdUsU99jd/s3QwXZpqus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ed8MCoxDfTl1+A0HCN86uFKq0ptJm/GCVZ26kDxSnel058qzpQKnbQJ4wgkaaBUp6qQvaw1E28LzdjTkXtpjIU8XSTNcx3E4Xg+4/fCSJlgDj54PlSqa4YlCSKo4iyicOe0TleEDZcTKzBpTG9R0Adv6TLWHgkFdVv4LvS6ffWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBgTU9iN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D7C433F1;
	Mon, 25 Mar 2024 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711400519;
	bh=QD9mCtSDgTE2JsbSwKtRCG1cdUsU99jd/s3QwXZpqus=;
	h=Date:From:To:Cc:Subject:From;
	b=FBgTU9iNOaz8qPBzGSWWoDVReoNp0jN5qTpOswGPS4eGm651fe0T54SFbWjY+owWY
	 BpnOpx4XS3msKcfrWN2y9C2nwABMQnB0oQ2GRnZ6E1Sn2bC+UDSi29eWBYaiLP+NiP
	 IeHCPcKrRb3eIokeKlPugwlb57toS3+9YXL3BPxjcQlNszVNqN6A9lrZbHKAF9IPcV
	 SWIibznPWrHgBxhG+vxRdwAcyHW+jgmoM1XrEOI5ooX1PlODH9qJxNGMaztuFaZ8IT
	 flwhznFsFZLp7osHcRoElffSsnQPPEen/7rhBVRT5LnHMwXpyF2+H2RsRPp3MO972S
	 im2fvCsWO6q6Q==
Date: Mon, 25 Mar 2024 15:01:56 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto/nx: Avoid potential
 -Wflex-array-member-not-at-end warning
Message-ID: <ZgHmRNcR+a4EJX94@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Use the `__struct_group()` helper to separate the flexible array
from the rest of the members in flexible `struct nx842_crypto_header`,
through tagged `struct nx842_crypto_header_hdr`, and avoid embedding
the flexible-array member in the middle of `struct nx842_crypto_ctx`.

Also, use `container_of()` whenever we need to retrieve a pointer to
the flexible structure.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/nx/nx-842.c |  6 ++++--
 drivers/crypto/nx/nx-842.h | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 2ab90ec10e61..82214cde2bcd 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -251,7 +251,9 @@ int nx842_crypto_compress(struct crypto_tfm *tfm,
 			  u8 *dst, unsigned int *dlen)
 {
 	struct nx842_crypto_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct nx842_crypto_header *hdr = &ctx->header;
+	struct nx842_crypto_header *hdr =
+				container_of(&ctx->header,
+					     struct nx842_crypto_header, hdr);
 	struct nx842_crypto_param p;
 	struct nx842_constraints c = *ctx->driver->constraints;
 	unsigned int groups, hdrsize, h;
@@ -490,7 +492,7 @@ int nx842_crypto_decompress(struct crypto_tfm *tfm,
 	}
 
 	memcpy(&ctx->header, src, hdr_len);
-	hdr = &ctx->header;
+	hdr = container_of(&ctx->header, struct nx842_crypto_header, hdr);
 
 	for (n = 0; n < hdr->groups; n++) {
 		/* ignore applies to last group */
diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index 7590bfb24d79..1f42c83d2683 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -157,9 +157,12 @@ struct nx842_crypto_header_group {
 } __packed;
 
 struct nx842_crypto_header {
-	__be16 magic;		/* NX842_CRYPTO_MAGIC */
-	__be16 ignore;		/* decompressed end bytes to ignore */
-	u8 groups;		/* total groups in this header */
+	/* New members must be added within the __struct_group() macro below. */
+	__struct_group(nx842_crypto_header_hdr, hdr, __packed,
+		__be16 magic;		/* NX842_CRYPTO_MAGIC */
+		__be16 ignore;		/* decompressed end bytes to ignore */
+		u8 groups;		/* total groups in this header */
+	);
 	struct nx842_crypto_header_group group[];
 } __packed;
 
@@ -171,7 +174,7 @@ struct nx842_crypto_ctx {
 	u8 *wmem;
 	u8 *sbounce, *dbounce;
 
-	struct nx842_crypto_header header;
+	struct nx842_crypto_header_hdr header;
 	struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
 
 	struct nx842_driver *driver;
-- 
2.34.1


