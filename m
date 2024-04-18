Return-Path: <linux-kernel+bounces-150862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81508AA5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD51F21DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F6358119;
	Thu, 18 Apr 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bA31r1wB"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCD3D64
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482766; cv=none; b=All+j9UU9aGeSc1nF7WhdYIGt6px8+fgIMF6LUy8V4AG9NDzFuvhiaOgi23RRDIozTQoQhnXLLiPU7TFa+yQOW0KH9+WGDKGtc9fvfIzoEFwI5Pp6fSHKFp3T+o3UmL8r+pM0gb3bGUrUL2AAePE35WCuIdMQFxfEA/QnC1HSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482766; c=relaxed/simple;
	bh=n2UHL99uaGsfsj1oKBoMTKFPOIfdpWMIG66YRfhg+Og=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZKAbObxj8lxow8cst9oRnlIF/AZieuAGLIl7Z24Dg/9n0WC+qPOz4zlEAZlZNZz9yaSb80Ck8RwAR5qEZxxlpCAnO9kGrYpql999lC12gfQ7DRETPcsqlh7VHK9ZVfTMQILHj7ekFpX3+HaxXbMNby8cibeYgSfBozgvm2PWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bA31r1wB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CC2AA20154;
	Fri, 19 Apr 2024 07:25:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1713482756;
	bh=n2UHL99uaGsfsj1oKBoMTKFPOIfdpWMIG66YRfhg+Og=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bA31r1wB447iXQ2yDGpqa1bbUh9uR+qnkVQ/92tPZS3uNBn4D3mV8iP0iU6upmWEG
	 WFmUVk/uQGTuA/cPGu7vOtQdHb3Al21lTpu7p3mVyhkyJdmVD3Qwlws4vdFb/IrjAJ
	 zfrM/02NxB30VXsDXV7mDXMYpVR4GPc++0utrCaNcu99+iiqdyDvXlIQcN4Ceuh8Ja
	 sjaTKQrws3SspkZxw7rG5KgJQTFWhODLC3Dugpdj+IqdBoRzVc+XyPZW7Atn5Zp9qO
	 yxn/XAjCflkO2FaU18NbvszRaBxaUEsHpqbJQTFK1cPyNLpFVC7OaR4sOjMc0eOvTz
	 W1J5wGfQCwsdw==
Message-ID: <1583360debaee14a988e4019cf30250f6eb4d8da.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: aspeed: Clear clock_divider value before setting
 it
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>, 
	"linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "billy_tsai@aspeedtech.com" <billy_tsai@aspeedtech.com>
Date: Fri, 19 Apr 2024 08:55:51 +0930
In-Reply-To: <7520ac6ef7afae66f9b1636e5806ff2bfd93584d.camel@intel.com>
References: <20240417134849.5793-1-iwona.winiarska@intel.com>
	 <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
	 <7520ac6ef7afae66f9b1636e5806ff2bfd93584d.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 13:41 +0000, Winiarska, Iwona wrote:
> On Thu, 2024-04-18 at 09:11 +0930, Andrew Jeffery wrote:
> > Hi Iwona,
> >=20
> > On Wed, 2024-04-17 at 15:48 +0200, Iwona Winiarska wrote:
> > > PECI clock divider is programmed on 10:8 bits of PECI Control registe=
r.
> > > Before setting a new value, clear bits read from hardware.
> > >=20
> > > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> >=20
> > I think it would be best to add a Fixes: tag and Cc: stable in
> > accordance with the stable tree rules. Are you happy to do so?
>=20
> Hi!
>=20
> Technically, the initial value of this register should be 0, but I've add=
ed the
> clear just to be on the safe side and to not have to rely on that.

Yeah, it could cause havoc with an unbind/bind sequence if people are
messing with the clocks in between.

> I don't think we're ever programming invalid values in the real-world sce=
narios,
> and because of that - I don't think this is stable material.

Right, I don't expect people are doing the above in environments where
stability is a concern.

Thanks for elaborating.

Andrew

