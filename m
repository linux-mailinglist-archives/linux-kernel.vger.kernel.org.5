Return-Path: <linux-kernel+bounces-91064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D2870921
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2028646D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD862142;
	Mon,  4 Mar 2024 18:10:12 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698226293;
	Mon,  4 Mar 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575811; cv=none; b=GxsigLePETG/nKgqkJ2ZIxU2TyAdgLHhd4gfbmIDfp5Ji+diNDPE+x2aY4xWSSKMIZocJ1gR5BJRnmPfGRwKZffVGX0q0uvppSzAdPpwjZvUgccjCZ1g2m1k3CLQjhjgDmv8naV5I4U/edolm3WbhIbhVFQfnMg5ucQghJnWylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575811; c=relaxed/simple;
	bh=x0eZK5rcwQvEGrW6u7NlGUZQo+NZ9PROPEyyThAMNXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpWNjO1SLg48qt1HE9S0OPsyaodT9mT+yLFU3x0DozI6mLXUn9fFJ5qMslpVRpMcnyS0RnPwIPgTucsbPVwXpGOosXYxUJnaFrL55inatP4ttrs2vR5WLbjms95ZsvW1atnUHMQQwO3xHqnavIWSZ/kH6PvgELXfdxsexIaJrz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 33F293000094C;
	Mon,  4 Mar 2024 19:10:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2D7FD31A6D; Mon,  4 Mar 2024 19:10:04 +0100 (CET)
Date: Mon, 4 Mar 2024 19:10:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v4 00/12] Add support for NIST P521 to ecdsa
Message-ID: <20240304181004.GA14180@wunner.de>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301022007.344948-1-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 09:19:55PM -0500, Stefan Berger wrote:
> This series adds support for the NIST P521 curve to the ecdsa module
> to enable signature verification with it.
> 
> An issue with the current code in ecdsa is that it assumes that input
> arrays providing key coordinates for example, are arrays of digits
> (a 'digit' is a 'u64'). This works well for all currently supported
> curves, such as NIST P192/256/384, but does not work for NIST P521 where
> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> converting byte arrays to digits and adjusting tests on input byte
> array lengths to tolerate arrays not providing multiples of 8 bytes.

When respinning this series as v5, feel free to add my

Tested-by: Lukas Wunner <lukas@wunner.de>


I cherry-picked the commits from your nist_p521.v5 branch...

https://github.com/stefanberger/linux-ima-namespaces/commits/nist_p521.v5/

..onto my development branch for PCI device authentication...

https://github.com/l1k/linux/commits/doe

..and tested against qemu+libspdm that an emulated NVMe drive
is able to present a valid signature using NIST P521 + SHA384
which can be verified correctly by the kernel.

I needed to fix up two of my patches, one which adds P1363
signature format support to the kernel and another fixup to
add NIST P521 support to the in-kernel SPDM library
(two top-most commits on my above-linked development branch).

I performed this test against your f81547267725 head and notice
that you pushed a new version today (with "curve->nbits == 521"
instead of strcmp), but I'm confident those two small changes
wouldn't alter the outcone, hence my Tested-by stands.

Thanks,

Lukas

