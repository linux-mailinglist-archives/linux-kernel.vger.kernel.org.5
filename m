Return-Path: <linux-kernel+bounces-130343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F5897820
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093D0B3383F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637B16ABEB;
	Wed,  3 Apr 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrcoheaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700916C435;
	Wed,  3 Apr 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164790; cv=none; b=kKkC+AKwcBeeyCK9zU6P0XGzyvQATTxF9IG9Tg9m8bNiY+yhbFxb0Qh7PGkvs6gULBIOA3ahMCAx5JmmTuoQj/Y8MhYxl1WgDlyWXVLwRUxvN7Bk9MQkjvtsV0+cZq2L4WOeuuLXlV9YaCI7xV4JEmeloKZ+6URxSqAcMtSsRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164790; c=relaxed/simple;
	bh=m5CY6uzPdkdGZdndPJAd5V3PSA3YWVy2YMzLcV42FCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REIZS6diu+exOnXw9Kc4iDsE65yPfooYSqTfLnZs9DdxCpSaNzfOUtOKEh9BJbqwiutMh/RFN9mYvgpo9F+0lM3ietv2msQ4mUfpogfNwD/uk7JVpBGCAEOWu9W9p0bMATMcmOEiWb3xuQl4lYaES9teF5yfT5IlXlTQf3J4EpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrcoheaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB7C433C7;
	Wed,  3 Apr 2024 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164790;
	bh=m5CY6uzPdkdGZdndPJAd5V3PSA3YWVy2YMzLcV42FCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrcoheaUeO04BQeNc/WlEeGCnaIlKCmd+7rD8oREVpM7xx+WIFx+sdNumFk7238dj
	 9CeJig1glhgrG7mNJvlIbHblV/qMYn1qT597KLU+/IDLuGEJOI2WQBeBaAXnS35hoU
	 Ofl2owiNfB2OCGj/O6aUprKstmvFxJVcAlyl2ntJKijvutujw9F/plu1EmGKNMWKts
	 5svlB4y0axtsBmEbaHYMAelJfuwwkSWo7ihbApar1W3/pYMJRo+5bySmbDeXtVG1xK
	 bO90T9Xg2w3GFpJ+PWY+xwoqfw8LGqmD9ZW2GyK0f/bC6bfZLzKi0IPQtJB9uCjwCN
	 kshCBTfHuibDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rdbabiera@google.com,
	festevam@denx.de,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/8] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Wed,  3 Apr 2024 13:19:36 -0400
Message-ID: <20240403171945.350716-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171945.350716-1-sashal@kernel.org>
References: <20240403171945.350716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 8774ea7a553e2aec323170d49365b59af0a2b7e0 ]

The driver already support the tcpci binding for the i2c_device_id so
add the support for the of_device_id too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240222210903.208901-3-m.felsch@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index a7b0134d382b8..e047a15e67347 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -899,6 +899,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.43.0


