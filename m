Return-Path: <linux-kernel+bounces-159886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EF8B3577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8FF1C20EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA0143890;
	Fri, 26 Apr 2024 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gDWHDdDk"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF0208C1;
	Fri, 26 Apr 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128185; cv=none; b=bLNO8qPdZi493LS5obQkYxdh+l42Y5gJ5kxqd1q4nzt8fvSuGArdbQvEXHq3LuyZ6/0YQqLDkZprsigCO0bmJcmxFY+qH6/wo7dvOGOfzcHojVH0cavOjPzxjiOTZBx/hbC25X765A1s3crbp81uKogSBy/E0zY+pOUy/z0Uhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128185; c=relaxed/simple;
	bh=l9M9y8mTaldAbg5u0/6ac4j2ZFOV7tnyNBMnzNQAWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y8Etm0YGRDlJ7SE/4yVGMlKfo3K90M6VxAxM0XoGyfjsqiWFvmQUGVA/PgkXTE/Qmgf4efu6yQTyKj2E7dIKXYuEgSDzkdUold1iBlcFYWcjv8NgFiYcKMRHn3w4Pycf/+Xp/C6u4/PmOHWlEnvJOiPAw4228ioeLwNR1cMhaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gDWHDdDk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 613AA1BF205;
	Fri, 26 Apr 2024 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714128175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L7xhI9ZrjJNWdo2TagCqPAYtwGPHErlpEEibcx2hB4s=;
	b=gDWHDdDkS7waIwPFEXOxTClYvhS4BmaksN4/b+EBN8J3yuHd4D04fEORMPe4uo0K7os+Km
	6msw5Jtzlg9/jBBDBNj+LjOesL857sb2pmKtZSjihiUzSDiMd//0uEKM9smMc8/pc8wsrG
	NUC9nX1o/D1OngRKGJ4GltEYD7AQSVQ5/9GQiM/xL6Lixxy4gujW+9eB7TOTJ9UpcStfg3
	tc2sRtwdsc2n0QjxFz8bKwgjXFOltJENhse3etX7FwXck7si8oe1VG+nB2lIDzUM0uKCDW
	m9x7uMGKhkZlrGN1DwpOv5eXbpl43iIi2hRdMzqyKdvTmDDKhQsjdxM0uL2PcQ==
Date: Fri, 26 Apr 2024 12:42:53 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Kyle Swenson <kyle.swenson@est.tech>, Liam Girdwood
 <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: PoE complex usage of regulator API
Message-ID: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Mark, Oleksij,

Now that PoE support has been merged, I am digging more into the PoE featur=
es.
We decided to use the regulator API inside the PSE (Power Sourcing Equipmen=
t)
API because PSE and regulators are quite similar as exposed by Oleksij in t=
he ML
before: https://lore.kernel.org/netdev/20231221174246.GI1697233@pengutronix=
de/
We designed it to have one regulator provider registered for each PSE ports
as described by Oleksij.

I am not really familiar with the regulator API and regulator controllers s=
o I
have few questions and one issue using the API.

Let's begin simple, in PSE world we are more talking about power.
Would it be ok to add a regulator_get/set_power_limit() and
regulator_get_power() callback to regulator API. Would regulator API have
interest to such callbacks?

Port priority, more complex subject:
Indeed a PSE controller managing several ports may be able to turn off ports
with low priority if the total power consumption exceed a certain level.
- There are controller like PD692x0 that can managed this on the hardware s=
ide.
  In that case we would have a regulator_get/set_power_limit() callbacks fr=
om
  the regulator parent (the PSE contoller) and a regulator_get/set_priory()
  callbacks for the regulator children (PSE ports).
- There are controller like TPS23881 or LTC4266 that can set two priorities
  levels on their ports and a level change in one of their input pin can
  shutdown all the low priority ports. In that case the same callbacks coul=
d be
  used. regulator_get/set_power_limit() from the parent will be only at sof=
tware
  level. regulator_get/set_priority() will set the priorities of the ports =
on
  hardware level. A polling function have to read frequently the total power
  used and compare it to the power budget, then it has to call something li=
ke
  regulator_shutdown_consumer() in case of power overflow. =20
- We could also want to manage the regulator priorities fully at software l=
evel,
  in that case it will be like above but saving all informations in the dri=
ver
  or using regulator generic functions.
This priority support could bring lots of issue and complexity like unbindi=
ng
regulator children driver at runtime if regulator parent overflow its power
budget. In the other side it could be interesting in the global management =
of
power if power supply can vary, like battery or hot-pluggable power supply.
What do you think? Do you think it is worth adding it to regulator API?

Last point, the PSE issue with regulator counters:
In regulator world we are using counters to not disable a regulator if chil=
dren
are still using it. In the PSE world the regulator providers describing the
PSE ports do not want such counter to exist. We do want to run enable/disab=
le
commands several times without increment/decrement the counter. So I added =
an
admin_state_enabled PSE intermediate variable to fix that.
https://lore.kernel.org/netdev/20240417-feature_poe-v9-10-242293fd1900@boot=
lin.com/
But in case the port is enabled from Linux then shutdown from the PSE contr=
oller
for any reason, I have to run disable and enable command to enable it again=
 Not
really efficient :/
I am thinking of disabling the usage of counters in case of a
regulator_get_exclusive(). What do you think? Could it break other usage?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

