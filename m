Return-Path: <linux-kernel+bounces-138047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13FE89EB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C56B2855A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D0213C9A0;
	Wed, 10 Apr 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MgcVDYb9"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258113C902;
	Wed, 10 Apr 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733061; cv=none; b=jrs01wT468UzrsOfO/VSPRA4Msgr2jvkTTzhLhOa/2ujVXEhIXVKPwD6Xp3ZKfLCeggXg2gom6niVMlPa0pxI77Y1tQIU6HI8Vp22KeWCxAx9uBhO03RBhnVan7CzEfQKMEWagKfS47mlB3oL6np496DpmU2IT9ndshYOxSUMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733061; c=relaxed/simple;
	bh=iT1Aa/LQUufay8mm+6B75a/+Jn7rOT3IEQyjuP1iiqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S3YXLAhHioTMeiwVwxQ8ffXuILxv16XP3TS5sQ9lDLR60n2gg/LaDksY967U0yfUteTpPzujXXodozf585Q5CKj9nMPzWEyqZxfk7ugWMGNs0IsURJtYFHj2Pt09MIZEZbgsKpK3oTn0X7MSMMA2m0H4mrpgNsa9skBDqo3SXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MgcVDYb9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 451A6E0005;
	Wed, 10 Apr 2024 07:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712733057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=341uR6qlkwbHnr/7IQaStkQef087xGpxi+6/6rr/DAs=;
	b=MgcVDYb9mQXi843fhwVeIo5RJc96Jy357/buBrTdIzzPLVkBP82xyCV7VfqBUOQdQjDH08
	m7R+gwcXUDRag7smKMq+gf2z/GZF2NVTv4f40ObQTO53QcXRVEMWS7Y9caA9o61Bdf7dGe
	tb71xyLAJIr1Pk9QEiJ5QkClPAsIuV5g4OfPLRuhr6je8thNWq0KOfZC4bgQSKjRL+49d4
	F7R+vPIwEIetZycLWNgVX6zA7zHA0hgFjUJT/x6gGUBHMi/xy9IZLJyuOAwk1bs9wf18Pz
	qxLzfDeS76C/Z8+k5RUhx6NG4+hs98PX2Nuv++sgPH6ltesI8dBYNahyriAYfA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/2] wifi: wilc1000: use RCU instead of SRCU
Date: Wed, 10 Apr 2024 09:10:32 +0200
Message-Id: <20240410-wilc_srcu_to_rcu-v1-0-a9ff5b10feaa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGg7FmYC/x2MywqAIBAAf0X2nKBrdehXIiR0q4Wo0F4Q/XtLp
 2EOMw9kSkwZGvVAopMzr4uILRSEqV9G0hzFAQ2WBhH1xXPwOYXD76sXaGNrFyvXY4wOJNsSDXz
 /y7Z73w/iKH5cYgAAAA==
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

This small series is a follow-up to [1] which fixed pending SRCU warnings
in wilc1000 driver, and raised the question of why SRCU was used in the
first place and if it is really needed. Since no technical answer has been
provided in favor of keeping SRCU, switch back the driver to classical RCU to
simplify RCU usage.

[1] https://lore.kernel.org/linux-wireless/20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com/

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Alexis Lothoré (2):
      wifi: wilc1000: set atomic flag on kmemdup in srcu critical section
      wifi: wilc1000: convert list management to RCU

 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 41 +++++++++------------
 drivers/net/wireless/microchip/wilc1000/hif.c      | 17 ++++-----
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 43 +++++++++-------------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  5 +--
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  5 +--
 5 files changed, 46 insertions(+), 65 deletions(-)
---
base-commit: bd53dcabb6d8211d5e2994d7acd000d203e1e031
change-id: 20240222-wilc_srcu_to_rcu-0163d53a2dd3

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


