Return-Path: <linux-kernel+bounces-108454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85648880ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F7C1C213FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACC15E9C;
	Wed, 20 Mar 2024 05:40:45 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E33EA4;
	Wed, 20 Mar 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913245; cv=none; b=cd0PtrE7kYphMCgoADdxwWBljwQs/r1oozmfFvVuYtE0bMt62hz9ItX02kYDX+ZKggN2sDHrJDnKofqEcFpWdGw/bOyfDB0Kp7eleqL4mIX7tisbxjjHM+0lEGCSnlqVqVoeRZYV5DJXeljLXO7g1JMx3q44B/eMZBWJi8O7mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913245; c=relaxed/simple;
	bh=Bfc7Wsju5l0WRaJyl54eJPl6pzsuIqPCIaOoxiZ/Aho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmUybhhC7lWZH9V6bmZwx1iXsHY+gnvj3cxv5+o+pRWqcExDLV8PWw7Hf5PaQEFMTdmcZQJA0G+2dOuev0YWqFZoZ3bMj+A2GzeSNxtwVoZzQmzS1Cjj7wBbgyw52V5j8WjXIkF9kVUJu8E0kaQzRGUHu5PuGdjoOaqbta57fyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id EA24B300002AA;
	Wed, 20 Mar 2024 06:40:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C46FC44E6C; Wed, 20 Mar 2024 06:40:33 +0100 (CET)
Date: Wed, 20 Mar 2024 06:40:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	bbhushan2@marvell.com
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Message-ID: <Zfp20bLB0onXo7FV@wunner.de>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>

On Tue, Mar 19, 2024 at 08:22:51PM +0200, Jarkko Sakkinen wrote:
> On Tue Mar 19, 2024 at 12:42 AM EET, Stefan Berger wrote:
> > On 3/18/24 14:48, Lukas Wunner wrote:
> > > On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
> > >> This series adds support for the NIST P521 curve to the ecdsa module
> > >> to enable signature verification with it.
> > > 
> > > v6 of this series is still
> > > 
> > > Tested-by: Lukas Wunner <lukas@wunner.de>
> >
> > Thanks.
> 
> This has been discussed before in LKML but generally tested-by for
> series does not have semantical meaning.

I believe that notion is outdated.

It seems to be becoming the norm that maintainers apply patches with
"b4 am --apply-cover-trailers", which automatically picks up Acked-by,
Reviewed-by, Tested-by and other tags sent in-reply-to the cover letter
and adds them to all patches in the series.

Consequently, providing such tags in-reply-to the cover letter is not
unusual and nothing to object to.

If Herbert applies patches with "b4 am --apply-cover-trailers" or
"b4 shazam --apply-cover-trailers" (I don't know if he does),
it is completely irrelevant whether Stefan strips my Tested-by from
individual patches:  It will automatically be re-added when the
series gets applied.

I have only tested the collection of *all* patches in this series and
can thus only vouch for correct functioning of the *entire* series,
hence providing the Tested-by in-reply-to the cover letter is the only
thing that makes sense to me.

Either way, I don't think arguing over which patch to apply a Tested-by
to is a productive use of everyone's time.

Thanks,

Lukas

