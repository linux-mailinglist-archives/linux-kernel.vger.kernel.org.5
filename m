Return-Path: <linux-kernel+bounces-146798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B28A6B22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602F81F21E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14012882C;
	Tue, 16 Apr 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VMSi9Vjh"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191F128398
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270956; cv=none; b=jloA1rz4PGQ2VsFfFop1eRSDpHrlq5H1GCg8A2mlT4uCvxCBfO5A5/hq7adc+0gcgEEVXZ6g2po2jmPpkzQbyxelI6DHj8jp108QlBRGnXSFtrqDSeFYYi2aLHitrJEQte9bxElaMlf6iPA/e8F80J2M4uQ4Dn5de/Yee1COsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270956; c=relaxed/simple;
	bh=QzaXJp3fRmgFSdc4E+CBAgut+j23yvZ7rxM6Zesvzy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEXmkULBRxacY/NzLzitxCwDv96ogdD/BxjoSJSh/Bl0TyUuxhwb2JO0YkoasNFmfdnalAFnLEoS2xPFtA8wM3BekwJbHi09vBT3AoZtOtviEtxWoPHzE+urk6yC6jUs6FlfVDKIYg238HwC+R1bQejTThof5mrjK0w2Ip5Vk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VMSi9Vjh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=G4irgf2RtW4Ubq
	PlxZoWpsEr8xGEeaVxEao1976prvY=; b=VMSi9Vjhpm2RFEtcaoMJWhCmXPuCT3
	l22DoSWa+Amf9+HXYhilSot5sxoZbstyg62fOpR5Nu0CmaTxr2joHayeN+ReED1Q
	U9XWgD1WlJ4xtqqySCx7yC+0NBo1wniBo+MtylJMkxCFVJOZBF/cmpvyWi9ygK5U
	INrDyls99BGpcX9TKfzbbD20qK7MeCXXmvXIyq1qrdodoB9WxS2i9B8w7LKKzKmi
	erm6xYQlBvvRTRGAQtsR1vnJmwW1i71cVXjJeR817/Jm9HzqVuX7RyDBRpG7m+Zf
	1w6zGmb5/GKsyFyNOnBKVJ/z5Y7KoFNefiYQcJap4oFpPHhcnznacfew==
Received: (qmail 2408439 invoked from network); 16 Apr 2024 14:35:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Apr 2024 14:35:51 +0200
X-UD-Smtp-Session: l3s3148p1@JgJ1+jUW3psgAwDPXxiyACzheF6dGXh7
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 0/2] serial: sci: fix OOPS because of wrongly running hrtimer
Date: Tue, 16 Apr 2024 14:35:46 +0200
Message-ID: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dirk sent a very interesting bug report[1]. This series is what I found
out by reviewing the driver. It is not tested yet because I couldn't
trigger the code path yet. The console still works normally with these
patches. Still, I am already curious in hearing your opinions, so here
is what I have...

[1] https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de.bosch.com

Wolfram Sang (2):
  serial: sh-sci: start hrtimer after setting up DMA
  serial: sh-sci: always cancel hrtimer when DMA RX is invalidated

 drivers/tty/serial/sh-sci.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.43.0


