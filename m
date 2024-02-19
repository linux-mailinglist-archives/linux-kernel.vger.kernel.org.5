Return-Path: <linux-kernel+bounces-71640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A153E85A834
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261D6B22880
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52793C467;
	Mon, 19 Feb 2024 16:08:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0413308A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358902; cv=none; b=V7CW1nse6ZVAw7/k3rXzlGYJHwKc++X2XxADmFKI+UinHFUc15QBZ4BsB5veGHZEOH/JjJQK7PqmDf7nOU+Ue0AMJ534Qnlm4UNHUuTT7zzfnehuIkWZj3h0a1nhEfod8snTbcTP0NLJ0zCpWs8GxVWZPKR/Lb+/wta3pg/pKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358902; c=relaxed/simple;
	bh=5t4JB3wAVHCHNA7BJWB1aH8LGEeC36ChXJ5ADZLD5QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3YwC86VvARSAcpJNX+YyYmHVRsE3zrcu2q3Oj1jndJXHAXO+o1Y/9GVOUzPl+M6mvXNrq9pwj52ruHm5EVqT48rgnZEI7kCf9K+962eiA7BiRSug/WTv9tpR3pVLOM+sdFUnrchPsIZSjkfOUs2QITa8ykyhZSdEX7uMV1FGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rc6BH-0001n7-M6; Mon, 19 Feb 2024 17:07:47 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rc6BD-001gUj-U5; Mon, 19 Feb 2024 17:07:43 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rc6BD-00FvZo-2d;
	Mon, 19 Feb 2024 17:07:43 +0100
Date: Mon, 19 Feb 2024 17:07:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <ZdN8zypeUp0MmzcP@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
 <ZciUQqjM4Z8Tc6Db@pengutronix.de>
 <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
 <Zc3IrO_MXIdLXnEL@pengutronix.de>
 <65099b67-b7dc-4d78-ba42-d550aae2c31e@lunn.ch>
 <Zc8TAojumif1irE-@pengutronix.de>
 <20240219153106.19e83213@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219153106.19e83213@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2024 at 03:31:06PM +0100, Köry Maincent wrote:
> On Fri, 16 Feb 2024 08:47:14 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >
> > > So, either somebody needs to understand 1000BaseT and can say the
> > > proposed binding works, or we explicitly document the binding is
> > > limited to 10BaseT and 100BaseT.  
> > 
> > I asked the internet and found the answer: Some PSE/PD implementations
> > are not compatible with 1000BaseT.
> > 
> > See Figure 33–4—10BASE-T/100BASE-TX Endpoint PSE location overview.
> > Alternative B show a variant where power is injected directly to pairs
> > without using magnetics as it is done for Alternative A (phantom
> > delivery - over magnetics).
> > 
> > So, we have following variants of 2 pairs PoE:
> > +---------+---------------+-------------------+---------------------+--------------------+
> > | Variant | Alternative   | Polarity          | Power Feeding Type  |
> > Compatibility with | |         | (a/b)         | (Direct/Reverse)  |
> > (Direct/Phantom)    | 1000BaseT          |
> > +=========+===============+===================+=====================+====================+
> > | 1       | a             | Direct            | Phantom             | Yes
> >            |
> > +---------+---------------+-------------------+---------------------+--------------------+
> > | 2       | a             | Reverse           | Phantom             | Yes
> >            |
> > +---------+---------------+-------------------+---------------------+--------------------+
> > | 3       | b             | Direct            | Phantom             | Yes
> >            |
> > +---------+---------------+-------------------+---------------------+--------------------+
> > | 4       | b             | Reverse           | Phantom             | Yes
> >            |
> > +---------+---------------+-------------------+---------------------+--------------------+
> > | 5       | b             | Direct            | Direct              | No
> >            |
> > +---------+---------------+-------------------+---------------------+--------------------+
> > | 6       | b             | Reverse           | Direct              | No
> >            |
> > +---------+---------------+-------------------+---------------------+--------------------+
> 
> Maybe we could remove the polarity column on this table as it does not bring
> more information. It is also already explained on the PI pinout alternatives
> table.

Ack. I'm still not sure if "Phantom" is correct description.

> 
> Also we should document that a 4pairs PSE supporting only 10/100BaseT (which
> mean no magnetics on pinout AlternativeB) may not be compatible with a 4pairs
> 1GBaseT PD.

Ack. s/may not/is not/ :) and 4pairs PSE is not always compatible with
PoE4 as well. I assume this  kind of knowledge we will get from PSE
driver.

Regards,
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

