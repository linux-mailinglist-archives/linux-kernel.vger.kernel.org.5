Return-Path: <linux-kernel+bounces-162295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B798B592B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA581C211CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05F575811;
	Mon, 29 Apr 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bOSOhH5d"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7F56B86;
	Mon, 29 Apr 2024 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395160; cv=none; b=em8z2AvztmLkfYQoTnL725b6VxVNynXtDH0dZMM0X2qlo+zSQJQ3n8KNmgFNlL1jK4Tpi4Ao0YH8Y7/i0OB74+v5qlINE7IkQq+Buo0WpUQxw+LPdjvLlU3V38/ss9Au9r0Acfkj/xxhJkMmu4Nugq4nsO0pHD0bp9QNYzzxjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395160; c=relaxed/simple;
	bh=sOroVgqC/w1tUucj6tNKHsi5HT9K5C19JpFpvbwP2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAfmkiw60TH1mCn5Juv3+QzZLfyzXxW+zIxnaRTCVGJjCm8J6w+ergNafBAzZ+Kj1y/fW9PDChetK5TU4vJpJqK0Rq1PvLYU2PeAWYrVVByP4pa/21QNip8ZAwHcF4dsBJpj6IWNbphUE89+jbfq2eNGIWaqEi36zQEPdXrKwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bOSOhH5d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=8MVhRe8G79LvDZ3usBPXPwC4vS3hYNB2ai5wwNsHxlg=; b=bO
	SOhH5dd3HJ9bdS2W3InhsYvFumXuNOIk210c0R7CGcAgdwia7ZQxS9U0T712J6f1SPW58SvZViFcx
	ulqo6nmkewY4g4yX8DmOHv2Iv0O99FpDG0QgzmavM2LzMihf1rHVSymgIbymFO1vvqVbdn7xbVoe2
	KZ8dKQyEGyQhN7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1QUZ-00EFfK-WE; Mon, 29 Apr 2024 14:52:24 +0200
Date: Mon, 29 Apr 2024 14:52:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: do not set MT7530_P5_DIS
 when PHY muxing is being used
Message-ID: <b0368cc8-927c-45ec-8adb-253c141943e2@lunn.ch>
References: <20240428-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v2-1-bb7c37d293f8@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v2-1-bb7c37d293f8@arinc9.com>

On Sun, Apr 28, 2024 at 12:19:58PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> DSA initalises the ds->num_ports amount of ports in
> dsa_switch_touch_ports(). When the PHY muxing feature is in use, port 5
> won't be defined in the device tree. Because of this, the type member of
> the dsa_port structure for this port will be assigned DSA_PORT_TYPE_UNUSED.
> The dsa_port_setup() function calls ds->ops->port_disable() when the port
> type is DSA_PORT_TYPE_UNUSED.
> 
> The MT7530_P5_DIS bit is unset in mt7530_setup() when PHY muxing is being
> used. mt7530_port_disable() which is assigned to ds->ops->port_disable() is
> called afterwards. Currently, mt7530_port_disable() sets MT7530_P5_DIS
> which breaks network connectivity when PHY muxing is being used.
> 
> Therefore, do not set MT7530_P5_DIS when PHY muxing is being used.
> 
> Fixes: 377174c5760c ("net: dsa: mt7530: move MT753X_MTRAP operations for MT7530")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


