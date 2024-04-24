Return-Path: <linux-kernel+bounces-156718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4B8B073B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54A9282531
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1147159578;
	Wed, 24 Apr 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Cs4Jp7Hd"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D800158211;
	Wed, 24 Apr 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954262; cv=none; b=hgSc0Te/E42RiSAy3KD1aUJp/VyZ4mM8n0QR3NW3X834juIdqVYpywISvYYeHCxZOenpBsDmzW1jhaOsUIHhZB1P4GDHOW9rQ/1C9GzwXgPsQqs85HklCwT6lrKbPR92GuB0EDgLb4uR86G9ZQXOnjpocnpSkDbUSccuM/Z8caI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954262; c=relaxed/simple;
	bh=Dr5dwzcjqw7dSzyi89UvoPy4zSpLCzrvPxvOavEG0FI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEfz9+6fvJ5pSHbT/enfyPyJUHjRGaqsTVFrxrYrtpdrFrrSN8qfIUKhgxCvKhdCmRFd6fS8X2sHyBr+1bzPiVsLIVgTjDYTgXmgn/XH9i0BQL9z/uHgVsY8yKuqY70bxtrZ5bvqRjGB7zdrCCu3BFDj8ziEHzsiBwXhZULNij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Cs4Jp7Hd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d/MD22uaUm8+BoL9TbUyYnjmK+2qYuIFAbrMDBfUVbA=; t=1713954259; x=1714559059; 
	b=Cs4Jp7HdCyicJnycDLC4R7+83WTpkwmSTYKtstZd73WXn35NDWHYm4s5pg0N6PzIpFIUBzNDz0T
	API3bAm2+NZz8KI7yAADJqZS5d19EijRkMFzzN1hucKXuhX7o8SFu7n8BrEyUoWpczraZmt1Vqteu
	gIRhrJIcic/KWwIlOs6KDxfeNJR5SIgeVfj3Ig02Iwmoust/nYDF18Zb6/OTVMoLTUMAgbcRJBz+O
	JOFWlmBFqyQXwOoK0cz3ZukHW5hNMn1FgiN5AA2Ud3Z+WNRhP+XAyBvBk2SM89YnsFV+dFLZlGoqP
	gSMx1C1SVWlT3zQQPjOltSW6aVAe/eb+1vSg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rzZnU-00000000GUH-0cmV; Wed, 24 Apr 2024 12:24:16 +0200
Received: from [80.95.105.245] (helo=[172.16.2.143])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rzZnT-00000001u5A-2sRA; Wed, 24 Apr 2024 12:24:16 +0200
Message-ID: <7dd171cc41474871408f06326aea5cb87923e454.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Markus Elfring <Markus.Elfring@web.de>, Oreoluwa Babatunde
 <quic_obabatun@quicinc.com>, linux-sh@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, kernel@quicinc.com, Rich Felker
 <dalias@libc.org>,  Rob Herring <robh@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Date: Wed, 24 Apr 2024 12:24:14 +0200
In-Reply-To: <f74fdb82-5d66-48f2-830e-3874570f022e@web.de>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
	 <f74fdb82-5d66-48f2-830e-3874570f022e@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2024-04-24 at 10:45 +0200, Markus Elfring wrote:
> =E2=80=A6
> > Hence, move the call to paging_init() to be earlier in the init
> > sequence so that the reserved memory regions are set aside before any
> > allocations are done using memblock.
> =E2=80=A6
>=20
> Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?

I'm not aware of any bugs that have been reported in this context.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

