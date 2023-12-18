Return-Path: <linux-kernel+bounces-3741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F2E81706C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F329282DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD333768F0;
	Mon, 18 Dec 2023 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AcDH1kEU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767B129ED9;
	Mon, 18 Dec 2023 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CbJYyBnHSJO5HpsM1rF1MdLZBV/rqZTitFQxv3HNgg4=;
	t=1702905496; x=1704115096; b=AcDH1kEUKaxt8lKZRCfQ5cFR1//iEBJV6PdxXPYUNWUIQ0/
	/kr5IkqwjsWTdTGpb7rCYRlnsEjz1YWqeraGkuv7ipRzu1j/x1JIi49y2QTtpsPKBJZCrBBKpZ5uG
	NJfEILTqzbVmKpf8JGMJ2LUofZLYaBKwtJ4Fy1qalX+PVCrZ9YGprDPn2biaI5jJirmv6E7XVaGI9
	apsMZxZqf8E7esShfqSKyFmsXGp2XSvROrN5PkXVSojGIj4NRficzE2Vmzxm2Sq2O7JiNLh6x8pds
	hz0sqfe6zrZEq/6567MDaiIL8hWxyHQaw+gbiprCLORGHsrngEQ7bU6wG2j7PQ2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFDVR-0000000GE7Q-0yMv;
	Mon, 18 Dec 2023 14:18:01 +0100
Message-ID: <26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net>
Subject: Re: [PATCH] bcma,ssb: simplify dependency handling for bcma and ssb
 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kalle Valo
 <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, Arend van
 Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, Hante
 Meuleman <hante.meuleman@broadcom.com>,  Michael Buesch <m@bues.ch>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com, 
 SHA-cyfmac-dev-list@infineon.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 18 Dec 2023 14:17:59 +0100
In-Reply-To: <20231218115802.15859-1-lukas.bulwahn@gmail.com>
References: <20231218115802.15859-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-18 at 12:58 +0100, Lukas Bulwahn wrote:

Dunno, I'm not super involved with this but ...

> +++ b/drivers/bcma/Kconfig
> @@ -1,12 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -config BCMA_POSSIBLE
> -	bool
> -	depends on HAS_IOMEM && HAS_DMA
> -	default y
> -
>  menuconfig BCMA
>  	tristate "Broadcom specific AMBA"
> -	depends on BCMA_POSSIBLE
> +	depends on HAS_IOMEM && HAS_DMA

[...]
>  config BRCMSMAC
>  	tristate "Broadcom IEEE802.11n PCIe SoftMAC WLAN driver"
> -	depends on MAC80211
> -	depends on BCMA_POSSIBLE
> +	depends on HAS_IOMEM && HAS_DMA && MAC80211
>  	select BCMA

to me it kind of seems more obvious for example in this case to say
"depend on BCMA_POSSIBLE and select BCMA" rather than open-coding the
BCMA dependencies both here and in BCMA? Now granted, they're rather
unlikely to _change_, but it still seems more obvious?

johannes

