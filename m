Return-Path: <linux-kernel+bounces-138389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305789F09D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37949B22121
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C951598E1;
	Wed, 10 Apr 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jT0Gk8bA"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3C1598E9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748310; cv=none; b=lIeSRD7oIbhddplwZcB7LfGcDQbKxfxKZU6EPmWmxM+EgasG5XI0yVT/InKx4DuWU9TbCIJmKz9qEWlS7Eh1X9dj+xLv5m4F2NjWzzoo/dyPiQXDMmZRzqJS0MEPdeTjt0gqvPwhM6UAce3hq0MPWgRqJPRHSPtO964oCkJdLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748310; c=relaxed/simple;
	bh=/oCMXaEKV0wQv6hyJYOzYspxu2mEEpt92nD4lJq5TVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3zCf9zIrysieh5w/03cSJSR7Xx2ieU0O65+YYBnyrIKUT2IDW8lG913e7v1oBIb9iFlToJGl2THWy/ub9zRpgsvgImvg1tKBcU5WK3yr5r6WldiEKxA2fTkd5oEalkVVPIXDYx8W8HKyVWSFMnTQBTIedUtJk/lxaco9kyAe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jT0Gk8bA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=RNanGQGWfzY8Ld
	dZN9BtmYbNVKTZHZwObn8fItBAqK8=; b=jT0Gk8bAMORCC3fi5dKtBczdT+SWtS
	Ur90S3Q1uouDlicdfEpBcNSLJfpzszbswwlEqlBkKEo/gJqZgyTYwNnT/l42kg1u
	jCKNParrdoy5IN5KtrND/ODxJjODWMBThyQKunrC8uL76dtK8cijYPbbgs6iM+X9
	oFSOW30Rsp/9ZLXlttGMTaO3E08kWFL0hNIfEIBjQBW2sZJeRUSQge0X2s3omTnq
	n5piJX/YYxgLyxigGcxQANsKl+wdagoI2ckzGc5M+DvPUuA1l9Tehh4xQfo48iZJ
	eKCIINO7NvQHjCrr8EVgyW1i2doKHn0NqksAVd/TzyZNURLygSmZfMGA==
Received: (qmail 521287 invoked from network); 10 Apr 2024 13:24:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Apr 2024 13:24:57 +0200
X-UD-Smtp-Session: l3s3148p1@pzTdSbwVgwhtKPEL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 00/18] i2c: remove printout on handled timeouts
Date: Wed, 10 Apr 2024 13:24:14 +0200
Message-ID: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on another cleanup series, I stumbled over the fact that
some drivers print an error on I2C or SMBus related timeouts. This is
wrong because it may be an expected state. The client driver on top
knows this, so let's keep error handling on this level and remove the
prinouts from controller drivers.

Looking forward to comments,

   Wolfram


Wolfram Sang (18):
  i2c: at91-master: remove printout on handled timeouts
  i2c: bcm-iproc: remove printout on handled timeouts
  i2c: bcm2835: remove printout on handled timeouts
  i2c: cadence: remove printout on handled timeouts
  i2c: davinci: remove printout on handled timeouts
  i2c: i801: remove printout on handled timeouts
  i2c: img-scb: remove printout on handled timeouts
  i2c: ismt: remove printout on handled timeouts
  i2c: nomadik: remove printout on handled timeouts
  i2c: omap: remove printout on handled timeouts
  i2c: qcom-geni: remove printout on handled timeouts
  i2c: qup: remove printout on handled timeouts
  i2c: rk3x: remove printout on handled timeouts
  i2c: sh_mobile: remove printout on handled timeouts
  i2c: st: remove printout on handled timeouts
  i2c: tegra: remove printout on handled timeouts
  i2c: uniphier-f: remove printout on handled timeouts
  i2c: uniphier: remove printout on handled timeouts

 drivers/i2c/busses/i2c-at91-master.c | 1 -
 drivers/i2c/busses/i2c-bcm-iproc.c   | 2 --
 drivers/i2c/busses/i2c-bcm2835.c     | 1 -
 drivers/i2c/busses/i2c-cadence.c     | 2 --
 drivers/i2c/busses/i2c-davinci.c     | 1 -
 drivers/i2c/busses/i2c-i801.c        | 4 ++--
 drivers/i2c/busses/i2c-img-scb.c     | 5 +----
 drivers/i2c/busses/i2c-ismt.c        | 1 -
 drivers/i2c/busses/i2c-nomadik.c     | 7 ++-----
 drivers/i2c/busses/i2c-omap.c        | 1 -
 drivers/i2c/busses/i2c-qcom-geni.c   | 5 +----
 drivers/i2c/busses/i2c-qup.c         | 4 +---
 drivers/i2c/busses/i2c-rk3x.c        | 3 ---
 drivers/i2c/busses/i2c-sh_mobile.c   | 1 -
 drivers/i2c/busses/i2c-st.c          | 5 +----
 drivers/i2c/busses/i2c-tegra.c       | 2 --
 drivers/i2c/busses/i2c-uniphier-f.c  | 1 -
 drivers/i2c/busses/i2c-uniphier.c    | 4 +---
 18 files changed, 9 insertions(+), 41 deletions(-)

-- 
2.43.0


