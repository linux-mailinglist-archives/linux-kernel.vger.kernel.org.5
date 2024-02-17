Return-Path: <linux-kernel+bounces-69980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5A859137
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557D81F21F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723FC7D409;
	Sat, 17 Feb 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ovp3k6H4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614C7C6E9;
	Sat, 17 Feb 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188919; cv=none; b=bBaiQJIL6QLJ2qa5oeYw66ISTWiDWumDtbAFYdwRX6OhSwzHkB5l3EA2FYXT00LNzp7+qc3EuT/rc0F7uL93ieNVj6KBQ8uZOGMCnTrZx9q82kgjsm2KmSZNIrNHTTTQoBU3VHLqHqUDEnwDAdF6Z+MSHGYIUTjqe5ea8XRgySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188919; c=relaxed/simple;
	bh=9L2T4+ZtlySPqPq61kCkir5tdMgnFhFQm65A1odzNBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ucv3dj4f+yqwrBpwKbRI/XPn6sBbtmUlE8hm8E87gbI/FFSu+L9EuwU7BQcFxJJpJDZqi5sNEJnXrHfR86vJIpgKO2UKKvgz2UWdpOaDvhglN93j1/RtuJ6kC9LXQFtHjToL2oQqaizLKf2+j+SFOFnPcl+UwHviaT7ZyrzIRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ovp3k6H4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=90UgQsfpfMEcSbHyuDqe399P7Sh3mwMtRxPA2Xv0GXk=; b=Ovp3k6H4sMeZcN6JyPzh8Sr48Y
	Z1inXKVevV0YOiRW9CyzvzqnUNsWFHaSG9krgd/0KteqWx/RIK7FR0e47IbjS7RezgJLkpFDeFK+l
	RLELOfSE5tNxX/tZYqLl8UmubOlsXn2citQZTcaD5nTO7aEOw/845Fi7Vu0XIGN259yZW+bDaEUVw
	Ea8dOKYWDykwVrwLK4CAN+CGfiYZUM+lzgA3RG1Ql1aSwyhAARl+FcQVISPke1bb5rlL01es8wREc
	T/iRWxi15PW7Y4v8706ON0HZLIZMgaVH1+3GEz7N60UJytm1nRNK7b/TotwuNauYK/CuQ+weDQ42v
	FKYpcu6Q==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbNy6-000000062ab-2BsN;
	Sat, 17 Feb 2024 16:55:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Elliott <elliott@hpe.com>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: fix CRYPTO_JITTERENTROPY help text
Date: Sat, 17 Feb 2024 08:55:13 -0800
Message-ID: <20240217165513.24061-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 crypto/Kconfig |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1269,10 +1269,11 @@ config CRYPTO_JITTERENTROPY
 
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

