Return-Path: <linux-kernel+bounces-86440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7486C55F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ACF290B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0B5DF26;
	Thu, 29 Feb 2024 09:34:25 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C765D91B;
	Thu, 29 Feb 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199264; cv=none; b=H8GLn/TR/wDOyN6r7MU9E8wD/gkErSI19ZIswF9T5893r08I9MYZmuk0sb79bIMr/DdRNFp1VVWnP7L4lpeyHTckO4J3oRLryuVlFDQnXf+o5blXjyFDT7zoVpE8/bmqKy8G63oX0Es4h16yH81Fyg9GLv0WlYdDLSDITG0KLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199264; c=relaxed/simple;
	bh=AIypsgqbCFGVRElhXEqL4dlDKOmK1OT1uzTwp7CIJHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/H5QPT2jakk3kkQ22LItn7COFF8BHYHDr6Fnv7SyEVFL1h8Rj7kHZWcFMFBANeqBsVT7faSYxoluxwzQOeek4+Ox37KT7ljANNpNqrel8EZ2On1k8pxevwbSZeK1Iswx8GYW3TChLv1Im5VdkDG4Uw3TCUyDuwSqE7+gk2Cgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C45012800BB90;
	Thu, 29 Feb 2024 10:34:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B787513B544; Thu, 29 Feb 2024 10:34:19 +0100 (CET)
Date: Thu, 29 Feb 2024 10:34:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 00/10] Add support for NIST P521 to ecdsa
Message-ID: <20240229093419.GA32424@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223204149.4055630-1-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 23, 2024 at 03:41:39PM -0500, Stefan Berger wrote:
> This series adds support for the NIST P521 curve to the ecdsa module.
> 
> An issue with the current code in ecdsa is that it assumes that input
> arrays providing key coordinates for example, are arrays of digits
> (a 'digit' is a 'u64'). This works well for all currently supported
> curves, such as NIST P192/256/384, but does not work for NIST P521 where
> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> converting byte arrays to digits and adjusting tests on input byte
> array lengths to tolerate arrays not providing multiples of 8 bytes.

Don't you also need to amend software_key_query()?  In the "issig" case,
it calculates len = crypto_sig_maxsize(sig), which is 72 bytes for P521,
then further below calculates "info->max_sig_size = 2 * (len + 3) + 2;"

I believe the ASN.1 encoded integers are just 66 bytes instead of 72,
so info->max_sig_size is 6 bytes too large.  Am I missing something?

Thanks,

Lukas

