Return-Path: <linux-kernel+bounces-41687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40883F664
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD761C21D35
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E261288A7;
	Sun, 28 Jan 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNCEk38w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A58321B0;
	Sun, 28 Jan 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458299; cv=none; b=sseKKtiOkIGoS9E5uPmM/4HmO5a3LY7Ew1TQkTkKO+6SEd0geiLVIoBXb4wYS2npqJA0iDyFFDKCMA1VTziTQ4E4ggah6Gd8c06q3sdwD7USJiHZEl/JLZXjwRHeM1voKpdhCCpq0+SIo0gbtaCxNe6Zk84T8w2eyQCfRk2YlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458299; c=relaxed/simple;
	bh=gL25tZW+oDdybgmrusSLsw8xBCDBD0WxxVan4IYL3WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/69B+XDV0tA9MM6kvJV5aOzS2d38t8MWG+b11A/hM2+Fe1P6TxtPQajJknTpBQG0f4nhrBHxHGxmi5Bk4sNleUdcyoq+iuC5KDwg/T9ZgvrLA5Ixh6pR4bVEWpInuwcdJ4Ie6mYNvxRfyjDy1XFp9xS99w1Jbj5yxuFG5GL+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNCEk38w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53AC433C7;
	Sun, 28 Jan 2024 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458299;
	bh=gL25tZW+oDdybgmrusSLsw8xBCDBD0WxxVan4IYL3WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNCEk38wwquUQgVBIvGw1SrjGh4ARIF0Bctyrp+alqOBuyQD11Js32mgv6vvD7pB9
	 qWCZF5pzmtoB+7BL695i5BF6HTNmWTN6wdQ+LJmuamrG1Jg5qHOA3O3cWJzHYZv56f
	 UnAsJ182LWCUdKY+i17IBiuyiGSq7Gwg69BfUTVg+AGPNGuKYXECT0zQnPLibzyr8T
	 z90b9J00Fk4g3Frn4mjsAAFEORz6sq95VCDRCN+IMXMP8reV9Z35ZirSP8UeGG5vw7
	 W422VS7Pl4oIOKr28lgGKQeelyMs5uJXB27fZKnk/DX86eVebCeZCKX5jP4pUp+qDt
	 hCBExfGJro0uQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	myungjoo.ham@samsung.com
Subject: [PATCH AUTOSEL 6.7 05/39] extcon: fix possible name leak in extcon_dev_register()
Date: Sun, 28 Jan 2024 11:10:25 -0500
Message-ID: <20240128161130.200783-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

[ Upstream commit e66523c72c9aae0ff0dae6859eb77b04de1e8e5f ]

In the error path after calling dev_set_name(), the device
name is leaked. To fix this, moving dev_set_name() after the
error path and before device_register.

Link: https://lore.kernel.org/lkml/TYZPR01MB4784ADCD3E951E0863F3DB72D5B8A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com/
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 6f7a60d2ed91..e7f55c021e56 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1280,8 +1280,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 
 	edev->id = ret;
 
-	dev_set_name(&edev->dev, "extcon%d", edev->id);
-
 	ret = extcon_alloc_cables(edev);
 	if (ret < 0)
 		goto err_alloc_cables;
@@ -1310,6 +1308,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	RAW_INIT_NOTIFIER_HEAD(&edev->nh_all);
 
 	dev_set_drvdata(&edev->dev, edev);
+	dev_set_name(&edev->dev, "extcon%d", edev->id);
 	edev->state = 0;
 
 	ret = device_register(&edev->dev);
-- 
2.43.0


