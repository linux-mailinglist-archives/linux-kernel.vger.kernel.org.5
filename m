Return-Path: <linux-kernel+bounces-122900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82C88FF31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8371C2820E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDE7F481;
	Thu, 28 Mar 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mKB8vWPv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B064F208;
	Thu, 28 Mar 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629611; cv=none; b=O8FSiCkzAfJFw3d0KuPc/HAEc8sIC6LCGUylIWMhddqnJsOPgYEWHttw3dsJBi/ijd2Xsw7w718EpEprrJPw0y3EkUFg/H7L9KgZ00VXS/ENhq44YP5wDaBO+luH4d3YbGjlVN/ajoOeNpd6ExJ0tpA3HDS8p7UTbfUky6OllHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629611; c=relaxed/simple;
	bh=oZOsfm72DJFPdo+Ma1cBA1aIH+t/Ab5Yx45MSHSwUlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGRuRX1rpLMRIpkUeZ4iN2H7suwhKU307ZMzd8yvro5gV9hA6lGzp5WezBrcU9TIZkZce2nnDAHG2VtcPPf/CRZ489RAjMPyP7ety7iHof0b1Qo3AkQqTC+ZWcO3PD/AAwCKu7FoXhlM4a+OlxyYcTDu7GeveQoIVa6Qnkzq/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mKB8vWPv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JXm7K82jLtWg1VPIcy9g3aAbs1bY6vhIc6AnyNaOJ/A=; b=mKB8vWPvqezitANxKHzqo/ndrR
	DRYKB0GMxgDF/Zilsy2tgDkup6uo9bWJd93JMRzkMyD9EXwj6202WEeWZSn8EfESZ948Ki5sXt/3O
	NmsyP/lrFSrhQGDPjPHR7kWec1fMitA65R6fHd6W4309RrevvkX+Gxj77l31kop1//T0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpp2m-00BUsX-UA; Thu, 28 Mar 2024 13:39:44 +0100
Date: Thu, 28 Mar 2024 13:39:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Simon Horman <horms@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
Message-ID: <cca25c3d-a352-4531-a8ae-5a0fb7de44df@lunn.ch>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
 <27d960ed-8e67-431b-a910-e6b2fc12e292@lunn.ch>
 <c94815f8-798a-4167-8f69-359b9b28b7ce@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c94815f8-798a-4167-8f69-359b9b28b7ce@ti.com>

On Thu, Mar 28, 2024 at 11:39:33AM +0530, MD Danish Anwar wrote:
> Hi Andrew,
> 
> On 27/03/24 6:05 pm, Andrew Lunn wrote:
> > On Wed, Mar 27, 2024 at 05:10:54PM +0530, MD Danish Anwar wrote:
> >> Add support for ICSSG switch firmware using existing Dual EMAC driver
> >> with switchdev.
> >>
> >> Limitations:
> >> VLAN offloading is limited to 0-256 IDs.
> >> MDB/FDB static entries are limited to 511 entries and different FDBs can
> >> hash to same bucket and thus may not completely offloaded
> >>
> >> Switch mode requires loading of new firmware into ICSSG cores. This
> >> means interfaces have to taken down and then reconfigured to switch
> >> mode.
> > 
> > Patch 0/3 does not say this. It just shows the interfaces being added
> 
> I will modify the cover letter to state that.
> 
> > to the bridge. There should not be any need to down the interfaces.
> > 
> 
> The interfaces needs to be turned down for switching between dual emac
> and switch mode.
> 
> Dual Emac mode runs with ICSSG Dual Emac firmware where as Switch mode
> works with ICSSG Switch firmware. These firmware are running on the
> dedicated PRU RPROC cores (pru0, rtu0, txpru0). When switch mode is
> enabled, these pru cores need to be stopped and then Switch firmware is
> loaded on these cores and then the cores are started again.
> 
> We stop the cores when interfaces are down and start the cores when
> interfaces are up.
> 
> In short, Dual EMAC firmware runs on pru cores, we put down the
> interface, stop pru cores, load switch firmware on the cores, bring the
> interface up and start the pru cores and now Switch mode is enabled.

This is not the Linux model. Try it, add an interface to a software
bridge. It does not care if it is admin up or down.

You need to hide this difference in your driver.

> > I keep asking this, so it would be good to explain it in the commit
> > message. What configuration is preserved over a firmware reload, and
> > what is lost?
> > 
> > Can i add VLAN in duel MAC mode and then swap into the switch firmware
> > and all the VLANs are preserved? Can i add fdb entries to a port in
> > dual MAC mode, and then swap into the swtich firmware and the FDB
> > table is preserved? What about STP port state? What about ... ?
> > 
> 
> When ports are brought up (firmware reload) we do a full cleaning of all
> the shared memories i.e. SMEM (shared RAM). [1]
> 
> Vlan table and FDB table are stored in SMEM so all the configuration
> done to VLAN / FDB tables will be lost.
> 
> We don't clear DRAM. DRAM is used for sending r30 commands [see
> emac_r30_cmd_init()], configure half duplex [see
> icssg_config_half_duplex()] and configure link speed [see
> icssg_config_set_speed()]. r30 commands are used to set port state (stp).
> 
> Now when the interfaces are brought up (firmware reload) r30 command is
> reconfigured as a result any changes done to port state (stp) will be
> lost. But the duplex and speed settings will be preserved.
> 
> To summarize,
> VLAN table / FDB table and port states are lost during a firmware reload.

So you also need to work around this in your driver. I think it is
possible to get the network stack to enumerate the configuration. Take
a look at the Mellanox driver. If i remember it does something like
this, but i don't remember the details.

      Andrew

