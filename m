Return-Path: <linux-kernel+bounces-14966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DB822569
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE04B2279B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF81774C;
	Tue,  2 Jan 2024 23:13:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C81772C;
	Tue,  2 Jan 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rKnx0-0001EK-1z;
	Tue, 02 Jan 2024 23:13:35 +0000
Date: Wed, 3 Jan 2024 00:10:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next] net: pcs: pcs-mtk-lynxi fix
 mtk_pcs_lynxi_get_state() for 2500base-x
Message-ID: <ZZSX_oNUIQr6R9FU@pidgin.makrotopia.org>
References: <20240102074408.1049203-1-ericwouds@gmail.com>
 <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
 <92190426-3614-4774-9E9F-18F121622788@gmail.com>
 <74223164-ab50-4d6d-a4f4-561b0a70d396@gmail.com>
 <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org>
 <6666EB36-984E-4898-A41A-2D9713DE4DB0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6666EB36-984E-4898-A41A-2D9713DE4DB0@gmail.com>

On Tue, Jan 02, 2024 at 11:13:58PM +0100, Eric Woudstra wrote:
> I believe the general idea is that phylink should be aware wether to use inband or outband negotiation in order to setup the hardware correctly. Speaking of a situation where there is a PHY attached.

Well, SGMII speed/duplex AN is not defined for 2500Base-X by any
standard and not supported by the hardware (unlike e.g. RealTek
which came up with their own proprietary extension called HiSGMII).

So we should simply never set the SGMII_SPEED_DUPLEX_AN bit if using
2500Base-X on MediaTek LynxI PCS -- in-band link status will still work,
and as 2500Base-X anyway only supports 2500M speed at full duplex it is
not a problem that speed and duplex are hard-coded in the driver in this
case imho. And that works fine for SFPs with and without
present/discoverable/accessible PHY.

Surely, having phylink take care whether SGMII_SPEED_DUPLEX_AN should be
set would be even nicer.

I believe that source of confusion here is simply that

in-band-status != SGMII_SPEED_DUPLEX_AN

We *do* have in-band-status even without having SGMII_SPEED_DUPLEX_AN set
with 2500Base-X link mode (as in: link being up or down and link, duplex
and speed is fixed anyway for 2500Base-X).


> 
> On January 2, 2024 9:01:23 PM GMT+01:00, Daniel Golle <daniel@makrotopia.org> wrote:
> >On Tue, Jan 02, 2024 at 08:33:32PM +0100, Eric Woudstra wrote:
> >> [...]
> >> 
> >> So if phylink_mii_c22_pcs_decode_state() should not set the speed, then it is not correctly set somewhere else.
> >
> >Yes, but the fix should go to pcs-mtk-lynxi.c and you don't need to
> >change phylink for it to work.
> >This should be enough:
> >https://patchwork.kernel.org/project/netdevbpf/patch/091e466912f1333bb76d23e95dc6019c9b71645f.1699565880.git.daniel@makrotopia.org/
> >

