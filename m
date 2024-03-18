Return-Path: <linux-kernel+bounces-106627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF287F125
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9855C1C214C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE8250EC;
	Mon, 18 Mar 2024 20:32:15 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8E1862C;
	Mon, 18 Mar 2024 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793934; cv=none; b=PsST1OMaReDSp3M8jPksWwRkXn/LhGNT3iAUKZ4EfBOVxi6/8FUDJX1KQ0J6+dTmS75pkDFOeHUEE8yfZxC4vql4fwC9BJaE1ynLAkSViFCTKhzx5hy0Bk2ZNwbf0OQl5T2xx0ZRDR0+Hzh8l3R/5a+hDcR0dJqlmU2ZAn5Q0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793934; c=relaxed/simple;
	bh=vceyYmbAy7tWecXsdFzfdfLb/afM7QOoYmaWc8dBrHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4Bo2fo+0YBNcOPAeHFSHXHpgG45G5+EEazbh60vRJU8DOE2VDBLo03i848ILQRkw7Wye4/+/Zs/eojkxRIrz2QHTIrvU89fz2zbXTVuHyrVOL22kZOOGgtNAu/X+xcRIMHY91h75IOZp6fK439Xt8m1pnYaEkmnEEbq/bpJNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D6E12100DCEFE;
	Mon, 18 Mar 2024 21:32:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9687F3A1A1A; Mon, 18 Mar 2024 21:32:02 +0100 (CET)
Date: Mon, 18 Mar 2024 21:32:02 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br, bbhushan2@marvell.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 03/13] crypto: ecdsa - Adjust tests on length of key
 parameters
Message-ID: <Zfikwi0v0_R58uNT@wunner.de>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-4-stefanb@linux.vnet.ibm.com>
 <CZX5OW9RVXGQ.2MBG8AQKHRKSE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZX5OW9RVXGQ.2MBG8AQKHRKSE@kernel.org>

On Mon, Mar 18, 2024 at 10:25:26PM +0200, Jarkko Sakkinen wrote:
> On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> >
> > In preparation for support of NIST P521, adjust the basic tests on the
> > length of the provided key parameters to only ensure that the length of the
> > x plus y coordinates parameter array is not an odd number and that each
> > coordinate fits into an array of 'ndigits' digits. Mathematical tests on
> > the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
> > invalid keys.
> >
> > The change is necessary since NIST P521 keys do not have keys with
> > coordinates that each fully require 'full' digits (= u64), unlike
> > NIST P192/256/384 that all require multiple 'full' digits.
> 
> This sentence is not really comprehendable English sentence. Can you
> just write the rationale in understandable form?
> 
> "fully require full digits (= u64)" is something totally alien to me
> tbh.

It is proper English, but requires an understanding of how large integers
are handled by crypto/ecdsa.c:  They're a sequence of u64.  For P192, P256
and P384 all u64 in the sequence are used to their full extent because the
key size is divisable by 64.  That's not the case for P521, where the most
significant u64 is not fully used (only 2 out of 8 bytes are used).

Thanks,

Lukas

