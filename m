Return-Path: <linux-kernel+bounces-38881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7EE83C7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235B31C20DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC55129A7B;
	Thu, 25 Jan 2024 16:18:42 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CCD7318E;
	Thu, 25 Jan 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199521; cv=none; b=P9eROeXNQ/gHsH7d0mapOC0lK/7seRwh4K7lZ+wplngqZ1g7ndlFaJt46lwWv5wqIKcg3wacMKx2WenT2194UpHtKY2wPEhBwoymMJP3MmxwABxtx9FWeGN62quf2OuzowVHhHyDDA6kWcEk5mJxet3tqDAm0EJJMXKJhmPWNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199521; c=relaxed/simple;
	bh=9xmud3hWROwS5ZH7I5o8uHA2wJye2HObu5w653tAJfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meIn8synbLtZVNZbuUGTA/dyzEZ9rMkyrQ5rDWuwnDmOJe1AN5BOyHrXzvY49okJ5ROTN1X8TRBMmW5Yjkwnhm28OtUOyqid/y3SUTQ/1cin/nXnkC0QUkRlpQBu04RPY1eu1j0OCfe9fsAY6sfh91pLdTyTfRLstv8FjgbXGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rT2Qi-0003de-0p;
	Thu, 25 Jan 2024 16:18:16 +0000
Date: Thu, 25 Jan 2024 16:18:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
Message-ID: <ZbKJv84vGXInRIo1@makrotopia.org>
References: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
 <accda24c-9f12-4cfe-b532-a9c60ec97fca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <accda24c-9f12-4cfe-b532-a9c60ec97fca@arinc9.com>

On Thu, Jan 25, 2024 at 12:49:19PM +0300, Arınç ÜNAL wrote:
> On 24/01/2024 08:17, Daniel Golle wrote:
> > Setup PMCR port register for actual speed and duplex on internally
> > connected PHYs of the MT7988 built-in switch. This fixes links with
> > speeds other than 1000M.
> > 
> > Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> I'm wondering why we manually set speed and duplex for these interface
> modes in the first place. I don't how it works for
> PHY_INTERFACE_MODE_INTERNAL but, at least for PHY_INTERFACE_MODE_TRGMII and
> 802.3z interfaces, phylink should already supply proper speed and duplex.

It's true that duplex should always be set to full-duplex already by
phylink. However, speed could be 2500MBit/s (2500Base-X) or 2000MBit/s
(?, TRGMII) and we yet need to program the PCR like if it was
1000MBit/s.

Regarding the INTERNAL case: it was added by mistake. In case of
MT7988, all ports of the switch are connected via INTERNAL links,
however, the PHYs still need adjustment of the PCR register just like
on all other MT753x switches and the CPU port is setup elsewhere
anyway.

