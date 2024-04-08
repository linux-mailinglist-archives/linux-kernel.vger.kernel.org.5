Return-Path: <linux-kernel+bounces-135024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C189BA10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742761F22BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C82E84F;
	Mon,  8 Apr 2024 08:22:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BE2D796
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564525; cv=none; b=I+MYTGLINU0GDuCMilEBSjDCntRjj8P4VAGaYylBkJu0Cd2OP7CusCdIx32ZldzH9NTYIfhIoXbqE+oBlgoJ4LC0W75HK8Cdx1s9KmaAlSPEgyygx9ZK53L0eictOyCx0mi8ufylHpf7FWj+WWUQh623Ly+Bb+KXVEoSI4Dm8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564525; c=relaxed/simple;
	bh=cMd1gwnz0UOQxewqSWZR27Y7MV3H7URencCBIZpFZ08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PF7p2+5ZPGaqGZM/B6yB0L/NgDhF6uFsL0J4OCqN6a9LphWEG+8ks494LevfLKCfm8/xTK7bXwguTXAXX6WfbXIbbFCtzRLqnvg8rRN2tjaHRC0+MXgPDTcM9GQZ43UVjfHLEccfbDTGM77YeLuRegEF/nQz6kGM8pGsLsA1ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rtkGC-0005va-HW; Mon, 08 Apr 2024 10:21:48 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rtkGB-00B4mH-Hy; Mon, 08 Apr 2024 10:21:47 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rtkGB-0003Lx-1e;
	Mon, 08 Apr 2024 10:21:47 +0200
Message-ID: <f01cdd910ab35316b8012795f73fd2b34c8e6f8e.camel@pengutronix.de>
Subject: Re: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's
 code to separate module
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>, Jan Dakinevich
	 <jan.dakinevich@salutedevices.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Date: Mon, 08 Apr 2024 10:21:47 +0200
In-Reply-To: <e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
	 <20240328010831.884487-2-jan.dakinevich@salutedevices.com>
	 <1j7chfiz8e.fsf@starbuckisacylon.baylibre.com>
	 <e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org>
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

On So, 2024-04-07 at 19:39 -0700, Stephen Boyd wrote:
> Quoting Jerome Brunet (2024-04-02 07:52:38)
> >=20
> > On Thu 28 Mar 2024 at 04:08, Jan Dakinevich <jan.dakinevich@salutedevic=
es.com> wrote:
> >=20
> > > This code will by reused by A1 SoC.
> >=20
> > Could expand a bit please ?
> >=20
> > >=20
> > > Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> >=20
> > In general, I like the idea.
> >=20
> > We do have a couple a reset registers lost in middle of clocks and this
> > change makes it possible to re-use the code instead duplicating it.
> >=20
> > The exported function would be used by audio clock controllers, but the
> > module created would be purely about reset.
> >=20
> > One may wonder how it ended up in the clock tree, especially since the
> > kernel as a reset tree too.
> >=20
> > I'm not sure if this should move to the reset framework or if it would
> > be an unnecessary churn. Stephen, Philipp, do you have an opinion on
> > this ?
> >=20
>=20
> I'd prefer it be made into an auxiliary device and the driver put in
> drivers/reset/ so we can keep reset code in the reset directory.

Seconded, the clk-mpfs/reset-mpfs and clk-starfive-jh7110-sys/reset-
starfive-jh7110 drivers are examples of this.

> The auxiliary device creation function can also be in the
> drivers/reset/ directory so that the clk driver calls some function
> to create and register the device.

I'm undecided about this, do you think mpfs_reset_controller_register()
and jh7110_reset_controller_register() should rather live with the
reset aux drivers in drivers/reset/ ?

regards
Philipp

