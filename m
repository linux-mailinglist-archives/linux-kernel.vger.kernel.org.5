Return-Path: <linux-kernel+bounces-70860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF07859D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CB2283286
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7220DE9;
	Mon, 19 Feb 2024 07:46:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CF208CF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328801; cv=none; b=j39cp5AvSWPt1Tn7FdeAyp4hTLmqWyNFCmzHjlVwPdVZXaEmXrtEtFzdUsl2FShHcs0TGZ0C15dUZILC/MMjH/ckZ3u8n1VKpR7rnvVuJJ+BAESWo9A02ESbYIE+WqlNaxxtQhlgVrhgstSGMtIYdt6uVkj7YZ4hShjwlo6X/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328801; c=relaxed/simple;
	bh=JfG0uoYUT2Yb7KnUa8vgB5iLyT96E9pNxJMpHnbFr5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljXpdzd/QWZVuWmAjgvay+GWIEDwV/EV9ov0mkp46VmvO5c+PX29/Vv617UujyGiyyYgKm5r0QTqo94Y1KSNnzGU1qrJQ1j/EH6nysNSF1nPMdIkvAMLENO/MsphKyhj+oZR9Gxi0Ia+kv5TW37cFnBPYSkMD0GdCkl1TI2aEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-0000QC-Pq; Mon, 19 Feb 2024 08:46:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-001bHr-Ai; Mon, 19 Feb 2024 08:46:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-007bvR-0n;
	Mon, 19 Feb 2024 08:46:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] siox: Move some complexity into the core
Date: Mon, 19 Feb 2024 08:46:28 +0100
Message-ID: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JfG0uoYUT2Yb7KnUa8vgB5iLyT96E9pNxJMpHnbFr5E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0wdV5KoOVMYV9bbk4yCGhmy4C2xnPdssud5f9 chkfG9LUUaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdMHVQAKCRCPgPtYfRL+ TsOWB/0fqeYeL2v7P/VZWwf3v5HhWDGKQVZlro6QvTILEh9pD435WgE9aJpUxQ8xJUovs3EB+1j bxO+AxoKOfKgbDR4wsoPKDTPire/NnQghaxNthlIGXxHqXjqz0DBXpig6jKvk7DAjqalQxFctu+ oqOUB9mDRSvLBxEwyVQ/1/+h0n+Z4iE2O3mNEtOKpZSNO0Cfz1Nsl4FFlMzStyupFl2klJ5wPl0 DEzFXau5B5PSJOKTQfTpFBS+As0FDDdmckAKtzgY5VOfXRdah0UWwp/y1iXnFjcxVDC9LBGWXm2 +HTRtSqPv3HG3zklFqNpevbFw8aTBbez/tMtqqxlsfUL7WNs
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

the reference handling in siox is a bit strange. With
siox_master_alloc() to get a reference on the master that is passed to
the core calling siox_master_register(). So until siox_master_register()
is called successfully the driver has to call siox_master_put() in the
error path, but on remove siox_master_unregister cares for that. While
that technically works, it's unusual and surprising to use. This serie's
first patch cleans that up and then introduces devm functions to make it
even easier to use.

A nice (and intended) side effect is that the gpio bus driver gets rid
of it's remove callback, so I don't have to adapt it for my quest that
changes the prototype of .remove().

Best regards
Uwe

Uwe Kleine-König (4):
  siox: Don't pass the reference on a master in siox_master_register()
  siox: Provide a devm variant of siox_master_alloc()
  siox: Provide a devm variant of siox_master_register()
  siox: bus-gpio: Simplify using devm_siox_* functions

 drivers/siox/siox-bus-gpio.c | 62 ++++++++++++------------------------
 drivers/siox/siox-core.c     | 45 ++++++++++++++++++++++++++
 drivers/siox/siox.h          |  4 +++
 3 files changed, 69 insertions(+), 42 deletions(-)


base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
-- 
2.43.0


