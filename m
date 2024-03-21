Return-Path: <linux-kernel+bounces-110327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C7885D47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ADE1F24C47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27E12CD8E;
	Thu, 21 Mar 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeXUxJ7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F512C7FD;
	Thu, 21 Mar 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038000; cv=none; b=k2jzrKU0H5dIQdu7yXpJju7eq6A1LbcX2EkDw7lJuHc9crGuRf7uoEWNdF9VWyOcFN4UV0Gak/2b45TYKRutrtB5bvphxPtdA0Q0DHJvb7CjlEaZrfcqq1ZV7vGim35bfiWe926A8MebSMz3Qqd9BgR69TyYu9Ek/Hba7gYj6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038000; c=relaxed/simple;
	bh=cw0xFQH2DJGFteeL3Rk+RfTx2SeLml2rDG34W3UbhJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RKEi5wmoP/Y/1IWi18UBIiErDJdp9kzzhulCbKGtfmlaSJpZlXPvS7PYF1S4cOaduIrjsLOMbufR5dto0QrJ5rESQImfrZdEFwDNEthG9+nrw/azS7/kemeLF8Vhd6YZ0rsQTiflobGUOBf57OVmm2mcgJqD6GgftbmaTVZrC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeXUxJ7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A139BC433C7;
	Thu, 21 Mar 2024 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038000;
	bh=cw0xFQH2DJGFteeL3Rk+RfTx2SeLml2rDG34W3UbhJ4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VeXUxJ7gly7e89nCNfjnoffFAXoqvt0NaaJvHvQxHAyZvcHDh3NzOluNfe4me99jx
	 2iNB1mXfe9KYEEcGApvs8whH/iWfV6LTNWQy/D2563cYMW/T60sfLovQxznKDt+VCl
	 UG072CQ8007J0hsBmjE6tCIdZhoC0bFyuI99E2ltFAsvhz/my0QvLvB1ARSBHEIn8v
	 tdJRATlPCVRSopn3x0fvcn2PmULJ2puIb7YqmS448JgwGN/5hAjcRqVSKDOT5JlnRw
	 SSBpkoH/NWcC53tp4cKjadd39d3WUQIkHNCxvUYgjozFWMaEJdYfDy4RKBaNvR8nrc
	 /N2lkhY5BIuug==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:19:54 +0200
Message-Id: <CZZKCJGKVP5N.3GUU48O4Y62KQ@kernel.org>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, "Stefan Berger"
 <stefanb@linux.vnet.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <saulo.alessandre@tse.jus.br>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Konstantin Ryabitsev"
 <konstantin@linuxfoundation.org>, "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.17.0
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org> <Zfp20bLB0onXo7FV@wunner.de>
 <20240320-quirky-truthful-manul-da6eb9@lemur>
 <CZZKAZB5K1PD.2UKMDD28AUCEC@kernel.org>
In-Reply-To: <CZZKAZB5K1PD.2UKMDD28AUCEC@kernel.org>

On Thu Mar 21, 2024 at 6:17 PM EET, Jarkko Sakkinen wrote:
> On Wed Mar 20, 2024 at 4:41 PM EET, Konstantin Ryabitsev wrote:
> > On Wed, Mar 20, 2024 at 06:40:33AM +0100, Lukas Wunner wrote:
> > > If Herbert applies patches with "b4 am --apply-cover-trailers" or
> > > "b4 shazam --apply-cover-trailers" (I don't know if he does),
> > > it is completely irrelevant whether Stefan strips my Tested-by from
> > > individual patches:  It will automatically be re-added when the
> > > series gets applied.
> >
> > Applying trailers sent to the cover letter is now the default behaviour=
 in
> > 0.13, so this flag is no longer required (it does nothing).
> >
> > -K
>
> The whole policy of how to put tested-by in my experience is subsystem
> dependent.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> Official documentation only speaks about patches so perhaps it should
> then be refined for the series.
>
> I'm hearing about this option in b4 for the first time in my life.

It is also pretty relevant to know when you read the commit log e.g.
when bisecting what was *actually* tested.

If you put tested-by to whole series it probably means that you've
tested the uapi and are getting the expected results. Thus in this
case it would 13/13 that is *actually* tested.

Putting tested-by to every possible patch only degrades the quality
of the commit log.

I don't see how this is "irrelevant".

BR, Jarkko

