Return-Path: <linux-kernel+bounces-106748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066F87F30C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A581C2169D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A035A11C;
	Mon, 18 Mar 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B74FdZsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72E59B6D;
	Mon, 18 Mar 2024 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800409; cv=none; b=earTfEpdNLavHxcfLYOmje4iVRbh6PSrJl3suiNoh9CNHZaawD2InUYymupUlD9DHp3T0/Z2AfdeuGXDK1N0/XmFQS79xlbUiuBVi9Nj/+5EL2VXb0L4YdfD0zbymab8vRmEPolBwJsHYusWpPqdbmQf+Pbemnql1OPabqYzJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800409; c=relaxed/simple;
	bh=E62rwNnWbLm7BmIPgdrHo59FO1p56mZz1LHCN0tkevI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I6h4Vh3taFhPIJtNhwoBEpXe7I7h3fw8wJAM1R0UAfcHy/VYJDHIYvdc0/PiSvUVhOXfonU7/HJp8ixhi7i7CGxcrnCB5KHquQ/PE6K4uemSAiFmFiabQz7fmTGf7EFHfo+Q8RCqoV14ufSt+IMV0wm196h8A6a5LjOJPmTjlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B74FdZsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD29BC433C7;
	Mon, 18 Mar 2024 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710800408;
	bh=E62rwNnWbLm7BmIPgdrHo59FO1p56mZz1LHCN0tkevI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=B74FdZsxE/w7FtLv4AYor6UzgasmliWij2hKnS5xUwCHq9ApNT8yZKk5zNzrKvKVZ
	 Ev72nJ4oGmXiNhGHoo2sOVc/mJ7ucgeakpiQTJH3hGbf/qVrMycC+coq2eIBNRR6yl
	 6wBU/Tsp/HgnlVueSqGA8ISMBHF1qJ8sfGgSTtT6NotXWn1t3ErwTEsy6+PXRBWTRO
	 D/nXaXJVJqL5BA9cSol1N505I9mgCcIMXu8RD70t7D+jjdJNzuXJFGLtmaIudq4PMe
	 /fupo3Xe81D6+yek0HQR4+dRTobnkApS1d7v5xENH1C9nt7NbjMcXZ2it8T2yNEcCZ
	 n8/TQ4PovLOkw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 00:20:04 +0200
Message-Id: <CZX84O4NDOC0.3FH6VACA5ET9@kernel.org>
Cc: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>, "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 02/13] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-3-stefanb@linux.vnet.ibm.com>
 <CZX5LR621YXT.A2MGGVPKINOG@kernel.org> <ZfilpAf4UE2T3lXn@wunner.de>
In-Reply-To: <ZfilpAf4UE2T3lXn@wunner.de>

On Mon Mar 18, 2024 at 10:35 PM EET, Lukas Wunner wrote:
> On Mon, Mar 18, 2024 at 10:21:20PM +0200, Jarkko Sakkinen wrote:
> > On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > >
> > > For NIST P192/256/384 the public key's x and y parameters could be co=
pied
> > > directly from a given array since both parameters filled 'ndigits' of
> >=20
> > We "could" do various things but a commit message should describe the
> > gain or motivation of doing something, even if you think it should be
> > obvious.
>
> "could" is past participle of the verb "can".  We were able to copy
> directly but no longer can due to the odd key size of P521.

OK this clarifies, thanks.

BR, Jarkko

