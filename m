Return-Path: <linux-kernel+bounces-106635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F361887F147
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951541F23D64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6747C5810B;
	Mon, 18 Mar 2024 20:39:18 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85558101;
	Mon, 18 Mar 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794357; cv=none; b=u10sBwwWVsioxm3eD7OQjFngFxbP/qkb++57bBjkWdBtix8FK+OiZwGuwsqLKOCnExmb+sctiIu78SP1SXGMX8GkreWpE5CQSKYHZUYGvxo3+320z7Zx/UHfxB6HFvzV3IpNLSGUbB0x/XZ5NUFBB7xt+IuJsLQSrN2KZUHPg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794357; c=relaxed/simple;
	bh=ReFqyHxcEKeh7w/BK0VTSDZ0C9vGF4T9kJDfsz3o/xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+KYui6QjMkHULxmWgtschbVjmrOxyOmZWQm/5tArdFf5jF8DQc6ivWaaMhEGGeaAwPcw0mezTYKg4rEHTz4QPyNAF13wnZmk170X8dnUVbdprGNQsqOfVYFvW+PoQ3wTs4vxK6Xm1az7njl1I36ulXARd49efnavpo49wedYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1BC9D2800BD88;
	Mon, 18 Mar 2024 21:39:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0719C5931A7; Mon, 18 Mar 2024 21:39:13 +0100 (CET)
Date: Mon, 18 Mar 2024 21:39:12 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br, bbhushan2@marvell.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 04/13] crypto: ecdsa - Extend res.x mod n calculation
 for NIST P521
Message-ID: <ZfimcDtBNQ42UEqB@wunner.de>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-5-stefanb@linux.vnet.ibm.com>
 <CZX5VA5Q4NYY.34VCD8R3ND3KL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZX5VA5Q4NYY.34VCD8R3ND3KL@kernel.org>

On Mon, Mar 18, 2024 at 10:33:47PM +0200, Jarkko Sakkinen wrote:
> On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Tested-by: Lukas Wunner <lukas@wunner.de>
> 
> What was there to test in this anyway? I see only comment change below.

The full series was tested, irrespective of the content of the individual
patches.

Thanks,

Lukas

