Return-Path: <linux-kernel+bounces-49407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBF846A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5501F2ACB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BA81802E;
	Fri,  2 Feb 2024 08:03:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515217C91
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861028; cv=none; b=VmDg2Jz3oWTYBKFurakzSzDtbW8iOMPicCgB8qdL6gIg7vPZ2E3yDDE2Zx3ym+vm6dEjDcUCBZJySeLH2cWlEC7d8Bla7E2jJFA78l9ngWMOYoM18Lc4Tg16+JQf1iF/2gr9CKI9AjfHncQpmMRLd4rXRFdE92xTY5sgPYvMAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861028; c=relaxed/simple;
	bh=/5I0jzeisO58TwpJV9NIkaSdOuEb7mJd1QjkNcmrsI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quloXX1V276PKflP+stDOtY5vRYPLpl6nKCkwaX5E+3eLe5B0EfVouyb+lV8m/8zY1gVvWDKAIEiwcl6Iqoif7dmnuSqRfFq0vkDYo5UPpYOFVnhW266T9+GdvrU86j05C87RETWfsrdettQ/HiDtXDaDQXhlHa4z0AL/Fifigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rVoWD-0006a5-Iu; Fri, 02 Feb 2024 09:03:25 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rVoWC-0041cJ-Gg; Fri, 02 Feb 2024 09:03:24 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rVoWC-0003Le-1S;
	Fri, 02 Feb 2024 09:03:24 +0100
Message-ID: <1769b56a52263060feb5d6810b43821bb19172ab.camel@pengutronix.de>
Subject: Re: [PATCH v3 6/8] watchdog: rzg2l_wdt: Rely on the reset driver
 for doing proper reset
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Claudiu <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org, 
	linux@roeck-us.net, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Fri, 02 Feb 2024 09:03:24 +0100
In-Reply-To: <20240202075849.3422380-7-claudiu.beznea.uj@bp.renesas.com>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
	 <20240202075849.3422380-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2024-02-02 at 09:58 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The reset driver has been adapted in commit da235d2fac21
> ("clk: renesas: rzg2l: Check reset monitor registers") to check the reset
> monitor bits before declaring reset asserts/de-asserts as
> successful/failure operations. With that, there is no need to keep the
> reset workaround for RZ/V2M in place in the watchdog driver.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

