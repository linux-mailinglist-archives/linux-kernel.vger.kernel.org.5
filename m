Return-Path: <linux-kernel+bounces-113419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D454288842C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5E728806D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA41A83CD;
	Sun, 24 Mar 2024 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNZQeg75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C713A419;
	Sun, 24 Mar 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320221; cv=none; b=iJuPuQJS3ondjKQt58fwcuRydd7TQJsLSVug8nFdY1Gzp/8C3dixA3c6sg3NOBzN9v5+YFFfKm+kbFjiSp5unyhJAibSADUVpMrSC0wzBqnBs0ssXZYoeJ0+weBj19pIrOISYjacsXK+o9+cNxgK7HcjhW7sfR0tG64Bry1pEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320221; c=relaxed/simple;
	bh=vXv6RwD2T4GSRX/k7xQwPN1CXiLLNq2tTZjiE206sV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT/GBqR0RaA66+gAW6Ex6VtrAgoAItBIyS+krDAGzwsRl/ibpgjkWrbDQk2aHMH8spYKNJLhZbOq7RDRHDHll/KCq8okqS+QoUXBATSAPh/XZfSa8CPKx0/VRMVBH39Ro00j63+hhHudzGw0soBvUgFSJS9TVlrW/U/b/ZoJaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNZQeg75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1CC433F1;
	Sun, 24 Mar 2024 22:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320220;
	bh=vXv6RwD2T4GSRX/k7xQwPN1CXiLLNq2tTZjiE206sV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNZQeg75BK/xzfxTmYUnIxqLoBvSiIvZArkOPVghAEdVFKs/PQTiqkRB/i2EoIoh3
	 og1yMxM6xqsj/hwtUjHArIWqKRuHxSQZLBhtzKZq4G2l6IC3Y8jHJFyDs6mTvZRhJu
	 bqeJaz8L3jeeyo8F9EJpeVqc6fUIvxMe77QrIHFGCf6oVWMOjMpHeK60NjSG8zsIMa
	 Iyt3qi3PXiHJx+e7xfb6t/HMP4ZS1jCFVvV4Nwdc3NRfZJ5evNolPbNBEU0KVn/uvK
	 YF1XS5+IlrSULeQTeBAgQfgERevd/Rxch9/KPs8d3tzvErDQriiefNd8m0vvgxDZlT
	 MS6CmDYVrqmog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 528/715] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:31:47 -0400
Message-ID: <20240324223455.1342824-529-sashal@kernel.org>
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

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit 392346827fbe8a7fd573dfb145170d7949f639a6 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-4-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index d1a14b0db265b..31f97230ee506 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


