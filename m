Return-Path: <linux-kernel+bounces-47650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF158450BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC51F2A4C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9623CF43;
	Thu,  1 Feb 2024 05:33:01 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED929403;
	Thu,  1 Feb 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765581; cv=none; b=C8bKCZtOumXWQZy7HwNykHCUhpwwJO1Y5sO+nY9ttq2xQyn5BhBGV37KOPjBeWEHui5GyGusopSPOa9xP2YjmwPK4JOg7EWX3rOMVxGjhJWcb88/n0tAwRwMhLkRsFzXzGK7jHjorGYdvDsRXcKYl5aHBa/OBNVerNu1gSwFu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765581; c=relaxed/simple;
	bh=NWi1hpkvHCFH0KErOmhqssdjDvssGBxw/+ZCVEXNFdM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfBPYhr2T5MXuVNpfYPm5H0kCdfmwJUV4/avhOJSZG1FNgXMuUrXIUDBrpaIuCNxRHCHr+PDXhxZycJsEjQ9M6szAe74Cx/Pk2L7Eu9JZdxUmeKoSKkzcAPuFMO2DlUIcHzHHVj7aIu90rQ+TfA8RGhUfZ7TZ65qXGL3IXZuEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVPgm-008UIj-9O; Thu, 01 Feb 2024 13:32:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 Feb 2024 13:32:53 +0800
Date: Thu, 1 Feb 2024 13:32:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.8
Message-ID: <ZbstBewmaIfrFocE@gondor.apana.org.au>
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>

Hi Linus:

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p2 

for you to fetch changes up to c5a2f74db71a849f3a60bc153d684d6d28a0c665:

  crypto: caam - fix asynchronous hash (2024-01-26 16:35:55 +0800)

----------------------------------------------------------------
This push fixes regressions in caam and qat.
----------------------------------------------------------------

Damian Muszynski (1):
      crypto: qat - fix arbiter mapping generation algorithm for QAT 402xx

Gaurav Jain (1):
      crypto: caam - fix asynchronous hash

 drivers/crypto/caam/caamalg_qi2.c                    | 7 +++++--
 drivers/crypto/caam/caamhash.c                       | 7 +++++--
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

