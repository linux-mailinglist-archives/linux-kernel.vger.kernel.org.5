Return-Path: <linux-kernel+bounces-165604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BB8B8E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7B4283D56
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB27F9FE;
	Wed,  1 May 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WJ+er+MT"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883A3234;
	Wed,  1 May 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582182; cv=none; b=dEs7Th7RPzQYh+RkcJj5Ejmb4zHyx5vDaKimJeKbZqTV28xXO59+erpMzQJPux5KlA1qPrE/gNDEjtV8C1e6ms1CCxxLukNlMUznYNe60tUrfBzU2XnGWhfqHuMrHVMwLPQQeyL7UV4JoI1hwEnUBrs9f8oUSgL4ZM2cBrGZ90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582182; c=relaxed/simple;
	bh=FZMQ03OE2dVwRULQmtasFPwBmMsxXHQORdwqCxwaB3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYrW68LrxtD6g8cjtQq11SsvCrmlIunbxMKBx23RGXLhZRXKbTb+6KzrgU/Nbd+rCJs37VCiALRhR8KQVSEWye2nDnOQvYqpywhardmioaR0x7Nvn8KB6l2Eto9xbF/86CuSwpy+dbnWYq7msBh8Jx0Y4pRPBK164FyWvIqRwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WJ+er+MT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YoQcSrLgDO3sGG9HI+F8+nZqKLMLQWyLPbnNUjuhnoE=; t=1714582178; x=1715186978; 
	b=WJ+er+MTLs/9NEP9o/VRd2TNPgjItjydK51JMaMrWaFEKkvOEfztbFRPNgUbA7/5tUrahEiZkRY
	UH0/5PaNvps6Tnf4/hph35f93fFowrwWuSccW1qZRS7KXc1+UP0DbKMetbfdrvrYqLA7Ywq3u4OfO
	QxMZkh5sCzlymM2TCt/6CsyMk36sLCcwCv7/WYtLJS5Xt86TrTFTvJGee8GK8AJorjW7h4ld0tpRC
	3rTa1H3rZQo/L2CbejvIXCmbOvqWzghWuOxaFMbAcGbIs24/lEo19UwKOJF1aQEQpVY8MRtZi7aUK
	kNPxQbu+thJtFFZ4SNAredhM4sfPq/f++4aw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2D9B-00000001qfv-30rF; Wed, 01 May 2024 18:49:33 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2D9B-00000001b6e-28JC; Wed, 01 May 2024 18:49:33 +0200
Message-ID: <6f677ca5ac2a7a2635ee3aa88182f906a56c3305.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/7] sh: Fix missing prototypes (part two)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 May 2024 18:49:32 +0200
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
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

Hi Geert,

On Mon, 2024-03-04 at 20:10 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series fixes more "no previous prototype for <foo>" warnings
> when building a kernel for SuperH, and is a follow-up to [1].
>=20
> This has been boot-tested on landisk and on qemu/rts7751r2d.
>=20
> Thanks for your comments!
>=20
> [1] "[PATCH 00/20] sh: Fix missing prototypes"
>     https://lore.kernel.org/r/cover.1709326528.git.geert+renesas@glider.b=
e>
>=20
> Geert Uytterhoeven (7):
>   sh: cache: Move forward declarations to <asm/cacheflush.h>
>   sh: traps: Make is_dsp_inst() static
>   sh: mach-highlander: Add missing #include <mach/highlander.h>
>   sh: mach-sh03: Make sh03_rtc_settimeofday() static
>   sh: sh7757lcr: Make init_sh7757lcr_IRQ() static
>   sh: sh7757: Add missing #include <asm/mmzone.h>
>   sh: sh7785lcr: Make init_sh7785lcr_IRQ() static
>=20
>  arch/sh/boards/board-sh7757lcr.c                |  2 +-
>  arch/sh/boards/board-sh7785lcr.c                |  2 +-
>  arch/sh/boards/mach-highlander/pinmux-r7785rp.c |  1 +
>  arch/sh/boards/mach-sh03/rtc.c                  |  2 +-
>  arch/sh/include/asm/cacheflush.h                | 12 ++++++++++++
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c          |  3 +++
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c          |  1 +
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c          |  3 +++
>  arch/sh/kernel/traps_32.c                       |  4 ++--
>  arch/sh/mm/cache-sh4.c                          |  2 --
>  arch/sh/mm/cache-shx3.c                         |  1 +
>  arch/sh/mm/cache.c                              | 14 --------------
>  12 files changed, 26 insertions(+), 21 deletions(-)

All patches look good to me, so for the whole series:

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

