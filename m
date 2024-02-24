Return-Path: <linux-kernel+bounces-79374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624E862151
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10581F25D68
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29817FE;
	Sat, 24 Feb 2024 00:50:10 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8FEDF;
	Sat, 24 Feb 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735809; cv=none; b=XYfjKN4ZomdmnpOjZ3TQcUOEALTPXq1QfuXbJ78XWP6ZIjv1RUV2ds0JYNgWntHcB+nkFqk4LQhwykAzWCm3JRS6kUqjL+kzoGbqWG6fYV6Oy4iEXS/D/rnNYzsx7jtKRn4Pzz2W64pw7nM0+T5dJtVhrHiKhZgUfDoc1gfJBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735809; c=relaxed/simple;
	bh=iECHTxNDwkUlCGebZh3m3aXMznwI8B5GScF3a8/3nY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNM6YYP1LLYrnYlu/e78xkZ7IC59lS1jAvXXURggTrlv5fmy4hs4OUgDCY1EvpWGGqz/cKleLIKuLztsG1etNI87GjmnRurYIqjf2uLXA7NL/d23XQCiasXma7c1ArGhe2z6RzNw4aD+cTX1iNnMb6f2MsF0vZDcee6iGqhIjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rdgEs-00HDvE-Iz; Sat, 24 Feb 2024 08:50:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Feb 2024 08:50:17 +0800
Date: Sat, 24 Feb 2024 08:50:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
	"open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..." <linux-crypto@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Tim Van Patten <timvp@google.com>
Subject: Re: [PATCH v2 1/2] crypto: ccp: Avoid discarding errors in
 psp_send_platform_access_msg()
Message-ID: <Zdk9SQMV4tyxyTEU@gondor.apana.org.au>
References: <20240213173429.43748-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213173429.43748-1-mario.limonciello@amd.com>

On Tue, Feb 13, 2024 at 11:34:28AM -0600, Mario Limonciello wrote:
> Errors can potentially occur in the "processing" of PSP commands or
> commands can be processed successfully but still return an error code in
> the header.
> 
> This second case was being discarded because PSP communication worked but
> the command returned an error code in the payload header.
> 
> Capture both cases and return them to the caller as -EIO for the caller
> to investigate. The caller can detect the latter by looking at
> `req->header->status`.
> 
> Reported-and-tested-by: Tim Van Patten <timvp@google.com>
> Fixes: 7ccc4f4e2e50 ("crypto: ccp - Add support for an interface for platform features")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Update tag for Tim
>  * Reword commit message
> ---
>  drivers/crypto/ccp/platform-access.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

