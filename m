Return-Path: <linux-kernel+bounces-64412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B897853E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D34CB29960
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31169627F1;
	Tue, 13 Feb 2024 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZeB9Z/VI"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C362170
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861784; cv=none; b=TtfKQDX0T1TnHdrJpo8WbZi/zpzZ45EQAf9TwS6XehG50J6Fi5VkBhJHVeJu0Rt9OX4pGftFzfs7YMplbdb5caat8QeiJo+3ES0JYKI/Kkrlx9Yp4XHwHetNHkm48HzNVZHD7WuVgirY9ctJ2AKTkugvbETZJY8iMABXbyMK8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861784; c=relaxed/simple;
	bh=dTcGTtqdbZA4erTLuvTwLwtSQUi1k4iRTLZhhl/FYAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnYD6sOFt4+E/kBsEpNjQYPVRzOKnMdHqoUWa7SQR4osZvGz+b1IBu/LeBC/BMt/QQDln4pfGAj4tgdBqyqvnAwbBKvdrxboJe1k6C/Yc3RA5huXoVFvTOGDRL7UUWwE1G7z9Ary8j+ahqnMYpfpKARVz7wr//ZC44IgCMvJqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZeB9Z/VI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=/NUhHNjae2O0Nh
	Aftu2aHYvtnNBPmBB2IpHF4VE84/M=; b=ZeB9Z/VIPSSUJj/7hZXT/YXiGy1Yhb
	z+mQGWo2ooLrKzjvwOM6mR9nUcrNlT6VzV28ZNqmjYVpsAQajuWne9rgHuYiQDpw
	Elwi2jVfUdpDMOkKBIVy3+vp55pHmia0HYp4E26GTTPKzM3j+N2eAoDNOWzi9D6Y
	u5sPoQv+gH8j4ylLeT1IrKmyyg8miimf+VW5kMv2ciQGy+ZMG9P2OM3s9/1iMQtZ
	OMTR+JjRFQETiHyO/XsxGzB9+P0CoEpnW+kwoqEQNaf+jmxts45xENuE9STzdUzF
	JLaPjT4D2xceu2HWfnWbkugeUkMnDJTY0dpq0S4t/bSckk3vWYwqhrLw==
Received: (qmail 1211711 invoked from network); 13 Feb 2024 23:02:50 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Feb 2024 23:02:50 +0100
X-UD-Smtp-Session: l3s3148p1@b3gljkoRvN8ujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH v2 0/6] mfd: tmio: simplify header and move to platform_data
Date: Tue, 13 Feb 2024 23:02:19 +0100
Message-ID: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:

* rebased to rc4
* collected all needed acks (Thanks!)
* capitalized first letter in commit subject

The MFD parts of the TMIO have been removed by Arnd, so that only the
SD/MMC related functionality is left. Remove the outdated remains in the
public header file and then move it to platform_data as the data is now
specific for the SD/MMC part.

Based on 6.8-rc4, build bot is happy. Branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification

(just missing Adrian's ack for SH which came just now)

We agreed already that this should go in via MFD. Thanks!

All the best!

   Wolfram


Wolfram Sang (6):
  mfd: tmio: Remove obsolete platform_data
  mfd: tmio: Remove obsolete io accessors
  mmc: tmio/sdhi: Fix includes
  mfd: tmio: Update include files
  mfd: tmio: Sanitize comments
  mfd: tmio: Move header to platform_data

 MAINTAINERS                                   |   2 +-
 arch/sh/boards/board-sh7757lcr.c              |   2 +-
 arch/sh/boards/mach-ap325rxa/setup.c          |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c          |   2 +-
 arch/sh/boards/mach-kfr2r09/setup.c           |   2 +-
 arch/sh/boards/mach-migor/setup.c             |   2 +-
 arch/sh/boards/mach-se/7724/setup.c           |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c          |   2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   5 +-
 drivers/mmc/host/tmio_mmc_core.c              |   3 +-
 drivers/mmc/host/uniphier-sd.c                |   2 +-
 include/linux/mfd/tmio.h                      | 133 ------------------
 include/linux/platform_data/tmio.h            |  64 +++++++++
 14 files changed, 81 insertions(+), 147 deletions(-)
 delete mode 100644 include/linux/mfd/tmio.h
 create mode 100644 include/linux/platform_data/tmio.h

-- 
2.43.0


