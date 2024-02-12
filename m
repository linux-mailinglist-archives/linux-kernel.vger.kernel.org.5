Return-Path: <linux-kernel+bounces-61403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB808511F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D5B216E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161CC38F8F;
	Mon, 12 Feb 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StBktxvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E617752;
	Mon, 12 Feb 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736532; cv=none; b=oFH9rdnlYuzdlIGgJ3v2gm2CHWItCYxp8EA3JjqBtEZPoGKmcrP0fMhSqZksf2ZSyTT2Am/siYUBSFGDQYpPaLF7N3jwLT5CTvbwoNqeuBbuzITIYOrMVYzXZh1DrACDt0JJY+HZSLIRKLW0NjUa8TlTcODRkJoDmSwjHysJ6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736532; c=relaxed/simple;
	bh=uo1c3yTNaSxAlcCbr/1mBVju1rFds1wly6gCrD8iPyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCvOkkGnwVe0cCIkQhwsrprcfCJLrUSm7HVlM7Rd0hmVBo/3AA9G/Pro1fjUGmqGZCFpQ9Opm36pYfyFgmXItEwdx0VzxzT3ELOMF13Xx0+3X0afQOxOOKfbTQyWXnMAXazlMZg+cZXilniCcKM57XiEsjSHV3WencRX06MosMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StBktxvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DEAC433F1;
	Mon, 12 Feb 2024 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736531;
	bh=uo1c3yTNaSxAlcCbr/1mBVju1rFds1wly6gCrD8iPyE=;
	h=From:To:Cc:Subject:Date:From;
	b=StBktxvFHyn67q2hEjeae6pKPu/BiLUdPx1sor2wf4iT9AHW+f1dWDwwGG6ziYOBU
	 OTINq0ur4d+Q3EkYFewMb51bq8WbVox5pM4AqvsELv7tvovwUCH7MFTZ/uy3E84tNL
	 ufjNT6NKW3LxBvJm5hrWrH5Byh8uj7uuiMGcNjopYeul0Jfve6LiUy+xzJfq7uhXq1
	 I470IHTIHB+57v96b+E/l2AuezAsjKy8XJ7BCt0brn9usAvZ6tuRb0oPtDwNsSA+Tv
	 HP6jK9k0rMBLocFRMbGf4EzfpdylmJrtcvFwOwJr/Raw+MgBNddr5z2jP/QfR3YbpP
	 bQr0EntlBrK7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jean Delvare <jdelvare@suse.de>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leds: qcom-lpg: add QCOM_PBS dependency
Date: Mon, 12 Feb 2024 12:15:02 +0100
Message-Id: <20240212111526.829122-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The lpg driver fails to link now when the pbs driver is in a loadable module:

x86_64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `lpg_brightness_set':
leds-qcom-lpg.c:(.text+0xe7f): undefined reference to `qcom_pbs_trigger_event'
x86_64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `lpg_probe':
leds-qcom-lpg.c:(.text+0x16a5): undefined reference to `get_pbs_client_device'

Add a dependency to avoid the broken configuration. Apparently there is still
a use for lpg with pbs disabled entirely for certain chips, so allow both
but not LEDS_QCOM_LPG=y with QCOM_PBS=m.

Fixes: 214110175679 ("leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/rgb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index e66bd21b9852..eaeafdd5eaae 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -41,6 +41,7 @@ config LEDS_QCOM_LPG
 	tristate "LED support for Qualcomm LPG"
 	depends on OF
 	depends on PWM
+	depends on QCOM_PBS || !QCOM_PBS
 	depends on SPMI
 	help
 	  This option enables support for the Light Pulse Generator found in a
-- 
2.39.2


