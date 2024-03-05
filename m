Return-Path: <linux-kernel+bounces-92918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07487281A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD85528D730
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33241292C3;
	Tue,  5 Mar 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJjY8iz0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F252128805;
	Tue,  5 Mar 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668680; cv=none; b=SMnA0BFSiBQ9V2FSodDWXI1xgQKPr8iSMhVM+5NS81y6Dh0GgatjiE4FYreAIyW4f4xScjosJc3rRnfJHnlmyg/82r/POmk5CEMgLcmwDPeADnLZu7j8OrRg97aIBamHWruhANhWeE5+2DCqt2MgmdjxMMTARag5LleRLbWVrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668680; c=relaxed/simple;
	bh=rNMn2F0pebCQ/PygWwODGmBr/a9yxmXD0UeqpVN1H0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2tI0aRC4CBmeO5ZY3AZdGbGu9hUubdH16Y58Hue6at8gy9g3AyIFqa+5kYLrUaUNxuANKJ32TLylUcd9FFeu47gopZhDATslAvLXixmZwQvLS+9305ZmUd7/0nFNQzuqOQQbcsYKXPnsNpUIR5vDJJWm8RJ2+6xMickDjnk3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJjY8iz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A0C433C7;
	Tue,  5 Mar 2024 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709668679;
	bh=rNMn2F0pebCQ/PygWwODGmBr/a9yxmXD0UeqpVN1H0Q=;
	h=Date:From:To:Cc:Subject:From;
	b=NJjY8iz0KVr4KZyCQYfXEhTBa2fC97LgEopVwE00q7YpN91Iu+3ETp+DTDf0e4cuC
	 ZPPvBCYxqlcVPp/m/f1hw3YXoH/6X+Eg0BZ8bjjfiVaOEY5lmUOeVu5CMHhuQ755bc
	 6RAFRCboyzMjdjjzvXvZizEpB57HNRQdytpIyYtScjTspW2J5YT57how0cawvnSJ5o
	 J1U/whwqlHFKYn9ZIoxt+Nz3rqAQEIj2ShxBs000QrQuxLiDV8FNCEllsJtb4w2H/n
	 9/pbhI0yb/pXY9DyekiOfEvrMgBs0Tv5BruUCbFN0qRJQ2bDJicvygkuZfEof84rNT
	 CNswwlAQcCzfw==
Date: Tue, 5 Mar 2024 13:57:56 -0600
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
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] crypto/nx: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <Zed5RIGqPgxUt/9T@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally. So, we are deprecating flexible-array
members in the middle of another structure.

There is currently an object (`header`) in `struct nx842_crypto_ctx`
that contains a flexible structure (`struct nx842_crypto_header`):

struct nx842_crypto_ctx {
	...
        struct nx842_crypto_header header;
        struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
	...
};

So, in order to avoid ending up with a flexible-array member in the
middle of another struct, we use the `struct_group_tagged()` helper to
separate the flexible array from the rest of the members in the flexible
structure:

struct nx842_crypto_header {
	struct_group_tagged(nx842_crypto_header_hdr, hdr,

		... the rest of the members

	);
        struct nx842_crypto_header_group group[];
} __packed;

With the change described above, we can now declare an object of the
type of the tagged struct, without embedding the flexible array in the
middle of another struct:

struct nx842_crypto_ctx {
	...
        struct nx842_crypto_header_hdr header;
        struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
	...
 } __packed;

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible
array if needed.

So, with these changes, fix the following warning:

In file included from drivers/crypto/nx/nx-842.c:55:
drivers/crypto/nx/nx-842.h:174:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
  174 |         struct nx842_crypto_header header;
      |                                    ^~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/nx/nx-842.c |  6 ++++--
 drivers/crypto/nx/nx-842.h | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

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
index 7590bfb24d79..25fa70b2112c 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -157,9 +157,11 @@ struct nx842_crypto_header_group {
 } __packed;
 
 struct nx842_crypto_header {
-	__be16 magic;		/* NX842_CRYPTO_MAGIC */
-	__be16 ignore;		/* decompressed end bytes to ignore */
-	u8 groups;		/* total groups in this header */
+	struct_group_tagged(nx842_crypto_header_hdr, hdr,
+		__be16 magic;		/* NX842_CRYPTO_MAGIC */
+		__be16 ignore;		/* decompressed end bytes to ignore */
+		u8 groups;		/* total groups in this header */
+	);
 	struct nx842_crypto_header_group group[];
 } __packed;
 
@@ -171,7 +173,7 @@ struct nx842_crypto_ctx {
 	u8 *wmem;
 	u8 *sbounce, *dbounce;
 
-	struct nx842_crypto_header header;
+	struct nx842_crypto_header_hdr header;
 	struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
 
 	struct nx842_driver *driver;
-- 
2.34.1


