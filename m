Return-Path: <linux-kernel+bounces-117798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC688B1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B4B3C6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51901773A;
	Mon, 25 Mar 2024 19:18:50 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137112B6C;
	Mon, 25 Mar 2024 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394330; cv=none; b=tdk2FJOEc8+Rc2NGZGm/nwwBNaSxFhclfJVoh5QDxExSO5qZOAcXL9MNjZ8RjG+3QfJsWkss3kV5okTLhUwi93r1fRYJGn/JR5kxeETQwhUuws/hP5HVk6UTpzkl3QG4HT+KuqnaCQ115uanc346Cqod4x2bPtYTNG1/IcZUQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394330; c=relaxed/simple;
	bh=eo8SEgIiydINJpLrrNpDWriCqpURl3Xcf6eqpBDXGTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWO4QxFu5lBkxc45NKuBWlFGNRCK8DsOdAQ7vl0om1Geh6YVHnPD3rYRS+7rGS1iPkLTnYWNAIZXTdB1TQEqeSa88VmBa3QG5i0GfAqnnXeQW2mcEOzY5oSE8ULguF2NvZau7dc/tY8kFmgV696c2dYeN4+FSePU99quO3U/HMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 899E82800BBDF;
	Mon, 25 Mar 2024 20:18:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 744B170E41A; Mon, 25 Mar 2024 20:18:37 +0100 (CET)
Date: Mon, 25 Mar 2024 20:18:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	bbhushan2@marvell.com, jarkko@kernel.org
Subject: Re: [PATCH v7 00/13] Add support for NIST P521 to ecdsa
Message-ID: <ZgHODQL-XLxTDO4b@wunner.de>
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <5c6c5f51-125b-4cc7-ac27-5a5358d514c7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6c5f51-125b-4cc7-ac27-5a5358d514c7@linux.ibm.com>

On Wed, Mar 20, 2024 at 08:44:52AM -0400, Stefan Berger wrote:
> On 3/20/24 07:47, Stefan Berger wrote:
> > This series adds support for the NIST P521 curve to the ecdsa module
> > to enable signature verification with it.
> > 
> > An issue with the current code in ecdsa is that it assumes that input
> > arrays providing key coordinates for example, are arrays of digits
> > (a 'digit' is a 'u64'). This works well for all currently supported
> > curves, such as NIST P192/256/384, but does not work for NIST P521 where
> > coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> > converting byte arrays to digits and adjusting tests on input byte
> > array lengths to tolerate arrays not providing multiples of 8 bytes.

I've tested the whole series successfully on v6.9-rc1 by authenticating
a PCI device with a NIST P521 certificate using my PCI/CMA development
branch: https://github.com/l1k/linux/commits/doe

Tested-by: Lukas Wunner <lukas@wunner.de>

