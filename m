Return-Path: <linux-kernel+bounces-153462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778AE8ACE65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37C9B21FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549231514C0;
	Mon, 22 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SoyugVe8"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4B150998;
	Mon, 22 Apr 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792969; cv=none; b=ehz32+O/XVtQrvKDe9K1G45fS276b9HuQ4CSU7ZffglBQwWMKP2SEZR+RfNNMza0HWd2txGB6gbCQrKA02L5zrpwYscbVgWVEagBjcVmi/ygR7fXVR9VHzzaNopxzOX/IzKMPSEoTVK9ogOvr4fs4Q6CqdGMfHAi+GiY6ISXLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792969; c=relaxed/simple;
	bh=DSpN4DUiWw1VWWK68hFOR1pAWnk1KzB0p8F7igZSIWA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hRwmyZYJW+IrBhezddnzDmeKYwp1OqFoZsC9jaALuPYE7xDwZnP79qrX46a8sw0lt3Q3jSHncl613v9LvJ7GjocHaREp6FfXGy87JEoGeoKNtHx/bHfFmmwFt+dVMIdBEFoI1XYi81FJatbRz6bE2JfLOEgrEAF0HcvowIkpDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SoyugVe8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18A861C000E;
	Mon, 22 Apr 2024 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713792960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ff50EefoMppUWXejFckN0DHpbXeEqXQWITFvnQ4Aaww=;
	b=SoyugVe8lGW/cncgNQqgtGlz4CefnRtI4PQro5IglZgC5rzHYhapaLku+ewoc+k7DQFvVG
	TDj1ltVx2dWma0jNnYX0CtE9lbnbnNtpBTO3PZguyF1FFOMz7sCb8wrU+NC/NtphXeKDZH
	sD3ApRoJ8vPIVlumYZyvZyRBZbcS9pQE7BH29Fn5AY4ZkonVWYhJW8AtMrNXd/m1aANQ3I
	MABMqKCe5s3E08g9ptPizE1+8EFhlo3V0yGxLcE8tmeAXjWOVlCGrbcej8om4JSQZCHGDM
	WDk6VnRdkoHQzSybR4ENxImYpkWoa+kPJ80Ris4N9aSKpZnLji0giykK6ZEYwA==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 0/3] net: pse-pd: Fixes for few small issues
Date: Mon, 22 Apr 2024 15:35:45 +0200
Message-Id: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALFnJmYC/2WNQQrDIBBFrxJmXYsOgWpXvUcJIeqkGWg1qISUk
 LtX3Hb5eJ/3D8iUmDLcuwMSbZw5hgp46cAtU3iRYF8ZUGIve0Qx8z6ukYSXs0WDznhNUNdroqp
 a6QmBigi0FxiqWTiXmL7tYlPN/9U2JaTQSjntpDV+uj1sjOXN4eriB4bzPH/8NSpQqgAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series fix few issues in PSE net subsystem like Regulator
dependency, PSE regulator type and kernel Documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Remove "Dent project" from my sob.
- Link to v1: https://lore.kernel.org/r/20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com

---
Kory Maincent (Dent Project) (3):
      net: pse-pd: pse_core: Add missing kdoc return description
      net: pse-pd: pse_core: Fix pse regulator type
      net: pse-pd: Kconfig: Add missing Regulator API dependency

 drivers/net/pse-pd/Kconfig    |  2 +-
 drivers/net/pse-pd/pse_core.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 6a57f091622a1251c2826f7380577049199b80ea
change-id: 20240422-fix_poe-d0fb292c9d8e

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


