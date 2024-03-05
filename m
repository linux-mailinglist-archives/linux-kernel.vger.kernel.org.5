Return-Path: <linux-kernel+bounces-93019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026087297C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A591C2177B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFCE12CDBB;
	Tue,  5 Mar 2024 21:32:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228965491F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674376; cv=none; b=BRGL3zJjKRwtgkMkyjl3WlX/w+IhwywpFYg12OQ3d0X3QNjW3dflUhF+WG1DK0z/Bh6zxtZGrfHbvurITneAbDLzRH6bm8h8H4/D3y2AkV+n7dz1n1UmnEtrc+A0S9JBGvj3wLrPfzcKsM86Gil77XnpP+UPzLixQ2M4XL2buFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674376; c=relaxed/simple;
	bh=l2rCHmnwafa4rvavnT7HtRmxniTVygw6GJI1m6R/+8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sERYOTnN9wi7ANvXniSo5EMgPRGstafFCuwpZyvuZD43+OqM1d/e8XQkT+LqZxv8O1cB95r/jyOqv6KUzVU4RA7Sl8OOnP2PnSzkT+LujRC+T7QXFwn6Yqrf1prAVIv//g/wKgfBwiKA2teQjTolb9EXmj7vbLaJWTgJ7S5eNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOf-0006r4-C4; Tue, 05 Mar 2024 22:32:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-004cmE-32; Tue, 05 Mar 2024 22:32:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOd-000ISt-3C;
	Tue, 05 Mar 2024 22:32:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 0/3] reset: Convert to platform remove callback returning void
Date: Tue,  5 Mar 2024 22:32:02 +0100
Message-ID: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=l2rCHmnwafa4rvavnT7HtRmxniTVygw6GJI1m6R/+8U=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTn/cHfv9WntvveOimT7GDR80N7+z8NVmXdxBOrnwbHR 7zWjvPqZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi1rIcDO18v1PyboSsFzky 29rO+CBLtGLm7vMVsifKUjSMnOTeHGkIv/0g4eASPV5d6fvmB/uWVS71YVaVbgidLyDxeumMD41 fTC90zDgyyUayartLSmeFV8M39eUuTPbTgg5f1cl22NQ+96tp9tvFgjMT/K99UhIxnJ9oHz6nS8 vFU3e71szOmlij3Xnst1Xvy5U8vdi5QGSLZ/a/hreFGU7S1pLrf092f7RymXHejbVecwJ+HpvSp xyvHhmR+WDy3WzLT3k3l9RtYTb3/dD9NFiwyq3lDNO/7jQ/rx9HvrBsz1D4ZNi+JTK8dt6iTpHo DxViabL7Z1htcziy7viexs9bFBoX3mBcO8s1+qWBTm4iAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/reset to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

All conversations are trivial, because their .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. But I'd hope that they get picked up all
together by Philipp.

Best regards
Uwe

Uwe Kleine-König (3):
  reset: meson-audio-arb: Convert to platform remove callback returning void
  reset: rzg2l-usbphy-ctrl: Convert to platform remove callback returning void
  reset: ti-sci: Convert to platform remove callback returning void

 drivers/reset/reset-meson-audio-arb.c   | 6 ++----
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 6 ++----
 drivers/reset/reset-ti-sci.c            | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


