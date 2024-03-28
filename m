Return-Path: <linux-kernel+bounces-122792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CEB88FD57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04BBB2390D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7457D096;
	Thu, 28 Mar 2024 10:46:39 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DA65191;
	Thu, 28 Mar 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622799; cv=none; b=QXzlRdC0tqBRhV3HAdhhRytfihx0Ho0xMFwQ4Pm5OQjaLsYxICF3mErJsA8TQzbIsa6/NN4FtueerrPlr+FJEU7mXido+rXFdIiJR2HYuUC2Hi82KIjiFmASleGzTGsTmv4oKXMgkaIsANDEHBSFiT3cfdQJIQe0DS7ytJfSrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622799; c=relaxed/simple;
	bh=rKu1tsv5K7dEoAL7vdn4WAgQFMagRaTK7+berfHVyo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9vzmGrauiP0gyzzepT0UGPwFIzSjl4vVON+a3rTSo3VLkpYraZCE4qvOYt9/U9N2sLn/OQy+3bJ522yL30DjUigcopsDp2TZQougKHfMoyr2rQIeN3G9RKTkkkGS28zpBW6yHz1mj3+LpuHkkuFpa0Lo7cbk+Tu77+bMSeTxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnGx-00C8E0-FJ; Thu, 28 Mar 2024 18:46:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:46:32 +0800
Date: Thu, 28 Mar 2024 18:46:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] crypto/nx: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZgVKiK2A+of/+vGr@gondor.apana.org.au>
References: <Zed5RIGqPgxUt/9T@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zed5RIGqPgxUt/9T@neat>

On Tue, Mar 05, 2024 at 01:57:56PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally. So, we are deprecating flexible-array
> members in the middle of another structure.
> 
> There is currently an object (`header`) in `struct nx842_crypto_ctx`
> that contains a flexible structure (`struct nx842_crypto_header`):
> 
> struct nx842_crypto_ctx {
> 	...
>         struct nx842_crypto_header header;
>         struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
> 	...
> };
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of another struct, we use the `struct_group_tagged()` helper to
> separate the flexible array from the rest of the members in the flexible
> structure:
> 
> struct nx842_crypto_header {
> 	struct_group_tagged(nx842_crypto_header_hdr, hdr,
> 
> 		... the rest of the members
> 
> 	);
>         struct nx842_crypto_header_group group[];
> } __packed;
> 
> With the change described above, we can now declare an object of the
> type of the tagged struct, without embedding the flexible array in the
> middle of another struct:
> 
> struct nx842_crypto_ctx {
> 	...
>         struct nx842_crypto_header_hdr header;
>         struct nx842_crypto_header_group group[NX842_CRYPTO_GROUP_MAX];
> 	...
>  } __packed;
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible
> array if needed.
> 
> So, with these changes, fix the following warning:
> 
> In file included from drivers/crypto/nx/nx-842.c:55:
> drivers/crypto/nx/nx-842.h:174:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>   174 |         struct nx842_crypto_header header;
>       |                                    ^~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/crypto/nx/nx-842.c |  6 ++++--
>  drivers/crypto/nx/nx-842.h | 10 ++++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

