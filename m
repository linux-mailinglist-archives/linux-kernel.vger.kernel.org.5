Return-Path: <linux-kernel+bounces-113235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A488893A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5C32962E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF9184321;
	Sun, 24 Mar 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed1B3//0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EA184308;
	Sun, 24 Mar 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320036; cv=none; b=II5tCYyCRpvW/oqfABB4QkuUPPTl9khPWWGNtdaxz+V4ZXca2MMAQbbh5ubl+PVJc4Ql9a7BHPVtu5hpUFUA8QuUcPqnZciStX9txldZ4WFoGYZelAnx+clhNbFtN7rwir+5D5GDLjARSvcRkHGY4rztYnydvahqCHPjeJaaa+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320036; c=relaxed/simple;
	bh=FPBnRQhKMIBc/J0qBo7uQGtzOxuQ2Val9MKzDoQgzUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlRG3UH5AG3I/pab28psBCO+dr4CL9tIV66bURdaeodTzxjg9fqxLbWXnHGXkNaVkRxiauwUY2pl5vhbHvjO1KWtCYx2DBKnGbFaBO8UPvVj9ETtsNODdQsehXuHdUpfj99tjbZZtYUJr9U+XttP5ufkwhl38Xf5dSMK412oRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed1B3//0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38714C433A6;
	Sun, 24 Mar 2024 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320035;
	bh=FPBnRQhKMIBc/J0qBo7uQGtzOxuQ2Val9MKzDoQgzUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ed1B3//0d5zhR3A+Znr5aoOgBuYZxlQb2DGCejR/BRDlIitfW0irSmP9qpHXSbWxH
	 K177OcfQmmwn0MQ1lPtnzg8nlnvg/IwH2EPS/1cGTf4RHrXKvpIxlwdxM1MSTv53YJ
	 8utEaFzxJVanesvyGwa1uhvX4V5Ax5zEQWucePPk9dbvFsX2Zx1MyKr7sTwCPqHF++
	 SGCpSBpWH8Bz8yulGXiVZ/i2seL3+9MLW4aBlp04cHQmMuvbkmjvCRiej5w2R08D6y
	 G+AsrhZKJMd2Um/+uaGHJ9A79Tb6qxAICFIwfjKjg0IadevkWrj3EbQbtTX9OZjJHY
	 SXqS9GNooveJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hayes Wang <hayeswang@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 344/715] r8152: fix unknown device for choose_configuration
Date: Sun, 24 Mar 2024 18:28:43 -0400
Message-ID: <20240324223455.1342824-345-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 46590b545df636aea0f9f7f2100d9963c0af5824 ]

For the unknown device, rtl8152_cfgselector_choose_configuration()
should return a negative value. Then, usb_choose_configuration() would
set a configuration for CDC ECM or NCM mode. Otherwise, there is no
usb interface driver for the device.

Fixes: aa4f2b3e418e ("r8152: Choose our USB config with choose_configuration() rather than probe()")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Link: https://lore.kernel.org/r/20240308075206.33553-436-nic_swsd@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0d0672d2a6545..51fe00c2b896e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10078,7 +10078,7 @@ static int rtl8152_cfgselector_choose_configuration(struct usb_device *udev)
 	 * driver supports it.
 	 */
 	if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
-		return 0;
+		return -ENODEV;
 
 	/* The vendor mode is not always config #1, so to find it out. */
 	c = udev->config;
-- 
2.43.0


