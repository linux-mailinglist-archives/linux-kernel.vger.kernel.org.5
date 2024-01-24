Return-Path: <linux-kernel+bounces-36707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738183A54D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C74290A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7111947B;
	Wed, 24 Jan 2024 09:22:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F14182DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088138; cv=none; b=BgrDVKp3xpbvjCdKSvaRllkTeY+97MrRn2WXx+HUeEBOsGZaX15TqPaldw5fICurYt8OzK3SztmIU+8AsxiCKe1WtxvLzOTV2k4pqk7RHileCjyb9+89ffuCxxU9Ks5TtZqSoxKEZfL95znOZ+IFJ+ULNPuDIRcDq/iwwDHwXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088138; c=relaxed/simple;
	bh=rYHqyZ6VL1pQ6PgAeDLvU2CKn3G6Ibhl7AcNOl8byn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d3LnThqVoVngYdRV5lstnaD71A7THXx3IHdahtldtq8xPD8pQXprD6CBQiTTZ8hECyo5kOBnHUVLiz9/fth9Bdm/PugkGawffJ2+XpUODhudtskpzY4cevvSDRzy6Lc8vo845SdHUY4Yfoj5wB8E8rFbJbo0OJr+Hxr56NokZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSZSW-0002bS-PC; Wed, 24 Jan 2024 10:22:12 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 0/2] drm/etnaviv: Disable SH_EU clock gating on the i.MX8MP
 NPU
Date: Wed, 24 Jan 2024 10:22:07 +0100
Message-Id: <20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/WsGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyMT3dSSvMSyzDLdvIJSXTMj8zQzCwtDYyOjZCWgjoKi1LTMCrBp0bG
 1tQAUD+Y9XQAAAA==
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.13-dev-f0463
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The vendor kernel sets a previously unknown clock gating bit in the
VIVS_PM_MODULE_CONTROLS register to disable SH_EU clock gating.

Import new headers from rnndb for the definition and set the bit
for the VIPNano-Si+ NPU on i.MX8MP.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Philipp Zabel (2):
      drm/etnaviv: Update hardware headers from rnndb
      drm/etnaviv: Disable SH_EU clock gating on VIPNano-Si+

 drivers/gpu/drm/etnaviv/cmdstream.xml.h |  52 ++++++++++++++--
 drivers/gpu/drm/etnaviv/common.xml.h    |  12 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c   |   4 ++
 drivers/gpu/drm/etnaviv/state.xml.h     | 101 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/etnaviv/state_blt.xml.h |  20 +++----
 drivers/gpu/drm/etnaviv/state_hi.xml.h  |  28 +++++----
 6 files changed, 174 insertions(+), 43 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240124-etnaviv-npu-627f6881322c

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


