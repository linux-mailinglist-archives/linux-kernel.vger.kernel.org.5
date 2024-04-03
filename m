Return-Path: <linux-kernel+bounces-130312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC09C8976AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3671F2D704
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E41553A5;
	Wed,  3 Apr 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdZjzuFi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7617315991C;
	Wed,  3 Apr 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164712; cv=none; b=Uu/hzg72gRP/ekymvKjPLiRvk5ksP1w0kol2JV9pDEZSeLf9tqOtLX2+AfCaRDpTScq36FjozLVZ6x9hUCamkdncP6Ju7PNz+UzgqxXO4UgRILfDyq1TgqiQdaWrJb7iL3aIvsyLxWAdoTlKXEnT8v7Lqf3CER5P51s/qLhYPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164712; c=relaxed/simple;
	bh=paWaZtmcXgHCCM0Kdr/8NGNi2OLdGEnwir78cGBYVFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLuCK8yBXhJUN3EmJpCb/c8O92/4DwmCqOO9irP/lvNnYZ4E5rakxtjaS/x2vkTapZ3FVk3YZ1LWDSNrW9Kgj9CGvUuhRrety9wD6XFdKjGCxWskzncAczId310cvjGqJuu/b/9cCwYfctVmRumY1ztueV/VSJP/0gkg8pvKcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdZjzuFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43446C433F1;
	Wed,  3 Apr 2024 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164712;
	bh=paWaZtmcXgHCCM0Kdr/8NGNi2OLdGEnwir78cGBYVFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdZjzuFi7l9UDaE9Lhr/6MDH/dVZ11zIqGym5UzRaU3K4abKBPsCYERRhKJp/jO71
	 JzUYFCfmABQLQuJL70Q/Lfgm0PMzzNHqYP/rvQ7sRXky/75sgWc6UwrGk5k/tze/Lv
	 LlecDTXh7V2DHNPE96aUBKzuvWUbsc/reJVRTUZMC1te5Ckre/1LXE2vLLDKJn0azE
	 9UzsyVc4LRwzOBHrB7NkkR/Rwz2kao9CZgMLQefA37fR2WMFvdDvvDmQ8GrTRThgNl
	 IHeTCsxAq27hmJ7918wD8vB+GJblz8GC0vtqSQqFDEvFlJgdves063Za+0gO3Fbg/4
	 1+THG+mbVvM8Q==
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
Subject: [PATCH AUTOSEL 6.6 08/20] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Wed,  3 Apr 2024 13:17:49 -0400
Message-ID: <20240403171815.342668-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
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
index 0ee3e6e29bb17..7118551827f6a 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -889,6 +889,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.43.0


