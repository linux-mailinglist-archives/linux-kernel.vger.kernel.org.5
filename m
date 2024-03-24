Return-Path: <linux-kernel+bounces-113872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6A889098
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A0DB2FE01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59C15217A;
	Sun, 24 Mar 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBxtaOfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0FE12AAF6;
	Sun, 24 Mar 2024 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320942; cv=none; b=KfbRelJRdqSv2GAyJR0aWvt9YhkhkVAs8VMJYBVAJwWkOtBHEnLxcTSAz7Qx8+vOf+h+nq3vi/rmbHZ+UmVdSm8ffyMLFK1UVdCQJ19ImF8UmyB4VCJHVcLMklzsMSLE846sYiceuWw78ouikGq+0FsJNfMlUNJ8HAnW5L9m6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320942; c=relaxed/simple;
	bh=Q5PokMvx+yqsVWZoRFasbAauWNKXBiHyG0ZpRTC1A9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiKoXVl+BW1W7QKdHTyFPXM8RefqvcxzZ3DnJI+zqbv0nqVLVXia8MPgLhe41JurPN96qd0IrGb3eolzRVyK2RaBmXpLBp4sBehLtlIH/LQl2cTYbEdrVapG14x+kwYrS8GRXr6UZDcsv7sl53ft2n0FQwCTz0OhVPBhkccj59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBxtaOfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA0EC433F1;
	Sun, 24 Mar 2024 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320941;
	bh=Q5PokMvx+yqsVWZoRFasbAauWNKXBiHyG0ZpRTC1A9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBxtaOfLmkPuvG1b5dHW4lLRj8k+T7LStBowGV6SqLXMOehCyWc8N3LaMKgCXgEwn
	 hp05lZuzwjQMiiETOSUmHBYj4TJTRgUEQLex75V86Y9C7arfvBF8mLagwcU41twZsX
	 5Z5B1DVCrUIDFDcMmKXru1UymsPnwibpgkg3qO1E5cD8mgqPWYkNH1nOJ+Ue9y9l0R
	 KWN1nmWhouGDoUvHIEmoW3DOL73Y2QuuGO3hCgIL8xDfB3RbTaUEF4+fkC+8+jk5yv
	 BsVozLp8snTaWmOmFQ2lUz+2HboBmKGOAPVPQp6QDfDJ/Fg1yM7sT+dcUUXgvjUQsT
	 FU4nTvCH0uBqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Elliott <elliott@hpe.com>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 504/713] crypto: jitter - fix CRYPTO_JITTERENTROPY help text
Date: Sun, 24 Mar 2024 18:43:50 -0400
Message-ID: <20240324224720.1345309-505-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit e63df1ec9a16dd9e13e9068243e64876de06f795 ]

Correct various small problems in the help text:
a. change 2 spaces to ", "
b. finish an incomplete sentence
c. change non-working URL to working URL

Fixes: a9a98d49da52 ("crypto: Kconfig - simplify compression/RNG entries")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218458
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Robert Elliott <elliott@hpe.com>
Cc: Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 70661f58ee41c..dd5353c5eb24d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1292,10 +1292,11 @@ config CRYPTO_JITTERENTROPY
 
 	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
 	  compliant with NIST SP800-90B) intended to provide a seed to a
-	  deterministic RNG (e.g.  per NIST SP800-90C).
+	  deterministic RNG (e.g., per NIST SP800-90C).
 	  This RNG does not perform any cryptographic whitening of the generated
+	  random numbers.
 
-	  See https://www.chronox.de/jent.html
+	  See https://www.chronox.de/jent/
 
 if CRYPTO_JITTERENTROPY
 if CRYPTO_FIPS && EXPERT
-- 
2.43.0


