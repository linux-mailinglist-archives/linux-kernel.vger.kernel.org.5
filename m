Return-Path: <linux-kernel+bounces-89604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660AB86F291
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A111C2153D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CFB41766;
	Sat,  2 Mar 2024 21:36:14 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309D1F16B;
	Sat,  2 Mar 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709415374; cv=none; b=kO+8k4fgZ/agSDodANBJwumVJdsFFP/AdA1o2qooNY618hnewkwq7IqHNcQKQeia+b6qL2l3uq1ANzSvKhnzkp2Ijt8qlKGNSXl4Qp/OAvxW5DazkJsZzgmqKCiJnQSxzvTiXv7qX7sO6txUx2r8vNRmh/PNxCdSUIZm55d+w5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709415374; c=relaxed/simple;
	bh=SOgGtqCOG6kLc+wOCnICsfw03Np5zFBG8Isa7pVYA/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPjn4fYHYFn4y2m16/i6XUqmJ7mXomoqpFe1L5IvU0CHApcO5MTlnOd4HN5jCwHdXDgH82gz8hPXogL+CDq9J7BzuiRwYbl1T9AKbvtDgquZXeEivIwYozr5zI6/qyUYcxaERApAUQYVXoK0QfwWVXYm5EkFR7zCo/NgNJm7pPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1F698300002A1;
	Sat,  2 Mar 2024 22:36:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 157B42E09D; Sat,  2 Mar 2024 22:36:09 +0100 (CET)
Date: Sat, 2 Mar 2024 22:36:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <20240302213609.GB30938@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
 <20240302140001.GA3095@wunner.de>
 <f5dacc38-bf53-4dc7-95cf-54b8b13dd1d7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5dacc38-bf53-4dc7-95cf-54b8b13dd1d7@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Mar 02, 2024 at 04:19:49PM -0500, Stefan Berger wrote:
> On 3/2/24 09:00, Lukas Wunner wrote:
> > Maybe eliminate the for-loop as well?
> > 
> > 	unsigned int o = nbytes & 7;
> > 	u64 msd = 0;
> > 
> > 	if (o != 0) {
> > 		/* if key length is not a multiple of 64 bits (NIST P521) */
> > 		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> > 		out[--ndigits] = be64_to_cpu(msd);
> > 		in += o;
> > 	}
> > 
> > 	ecc_swap_digits(in, out, ndigits);
> 
> Will take this for v5 with your Suggested-by:, ok?

Sure, feel free to, but better test it because I haven't. :-)

I'll look through the rest of the series tomorrow. %-)

Thanks,

Lukas

