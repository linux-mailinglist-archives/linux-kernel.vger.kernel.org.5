Return-Path: <linux-kernel+bounces-31950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A1835420
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716881C2115E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24435EEA;
	Sun, 21 Jan 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="ZR9JZhk2"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C8358B6;
	Sun, 21 Jan 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705801752; cv=none; b=s6BPpm1547FagIbUqAI//7jV4rZkPyP5cvYXMUtqAcQ4ofD44xBd4k7Lj0csy1nZJtypO2byuxKBAEMGGuKB5vjNMp423ArVOVcHPcCLD58Gro/suPKStIlVBDeueJ8JB3LhxT3rJekuxu7C/PTzblimUljHYAkpyMcNBPyv87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705801752; c=relaxed/simple;
	bh=lFIqsnnmUm8gQKiSj2GC3PO1blzYyWDVthX2nkDrJt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIOCS6YtmFtnG6Xjc7EgBd00DwJoOYGLeROLxM4KxJwkEwFWK0J66yUR7bQAYoh4e3pK/zDrFzNUpevSIcDf3W5CYS6chxiMovkBvjh/R2uHl3vcNiGqmo8ivdDYDja0/KKIbQmalQ3mugDaFgS6XXuTJrofE6ihm2OAVRFpPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=ZR9JZhk2; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id C2CAC461AA;
	Sun, 21 Jan 2024 01:43:36 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Quentin Schulz <quentin.schulz@bootlin.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/3] power: supply: axp20x_usb_power: prepare for external power delivery negotiation
Date: Sat, 20 Jan 2024 20:39:58 -0500
Message-ID: <20240121014057.1042466-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705801417;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding;
	bh=SUQPnMTPVVJvLjAXL1KekIRGdmuwaL5YumbY1tWBkMk=;
	b=ZR9JZhk2/blbXE/e6m+mphDfCN5nw4cC9HX5H8uEcJmbx2YTYeyPzowmvHIBFx1qnO3mDN
	HPomL04xccYct0+qqciKHFLT4lUYMA02vGW3rzKsv/oEc1H1ha55S8E5sLqLGyapsk6DpY
	LY57b5qGCZ8PX0oPB0HezauxU1dQZnQ=

Being able to set the input current limit will be necessary to implement
usb power delivery on the Pine64 PinePhone. The PinePhone has a separate
chip (anx7688) that handles usb power delivery (among other things), so
we will need a way to apply the current limit which that negotiates.

The first two patches were originally based on code Ondřej Jirman
wrote[1], but I have almost completely rewritten them.

While working on this, I also discovered that the axp803 pmic sets a
current limit of 3A on the usb port without any negotiation if it
doesn't detect a battery.

1: https://xff.cz/git/linux/commit/?h=axp-6.7&id=3dcd33dfd1ae58db159427365dcb6d0d2b12f06d


Aren Moynihan (3):
  power: supply: axp20x_usb_power: add input current limit
  power: supply: axp20x_usb_power: enable usb_type reporting
  power: supply: axp20x_usb_power: set input current limit in probe

 drivers/power/supply/axp20x_usb_power.c | 192 +++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 2 deletions(-)

-- 
2.43.0


