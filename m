Return-Path: <linux-kernel+bounces-33283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC88367F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086161F29B53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084355B5DE;
	Mon, 22 Jan 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUYgGO23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7955B5CE;
	Mon, 22 Jan 2024 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935600; cv=none; b=CIsWs74iDctAq4C5xn1ieIxxIQ+ajyi442TAptuJK0w//Dd14KRSmdOV8fatvIWrcUUqX2Rm5HL7Y48qk4s+kmN8HP2zVVTwufkiXtRCwJADlBoB1pa8JZK0f42dgedBLVJQlARnYo9lCztrcisvXYbj9GwzXkji6+4fYOpB+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935600; c=relaxed/simple;
	bh=9M4Bh447WXbW82Sc6GAht9rq9SrdziELRfSzU927JYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWXvpiKOUv5SXhPEHYDmllY03Esm41OsIA5gERrCPgYnT9l1igxR6fITzb+BqlCA2ES3luy6PJhptjN/N0JFaUNLAwpUvLJxAtR3Ov2KgeaX+uRNvODw7DPeftrOrUKrSIYTg+tc7Qb+QuH4VvW3KnP6tcTXhrzrrDGXU+XObxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUYgGO23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D083C43390;
	Mon, 22 Jan 2024 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935600;
	bh=9M4Bh447WXbW82Sc6GAht9rq9SrdziELRfSzU927JYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUYgGO233//A1p5WfAcpKJuGCGDR5Ai7XSGPIP9KgeShKcDRIJtXeUlnmKgwuaJxC
	 F79sqbTvIznMJ8VN4WPA7vlHPJPqkWeNAjn04scoqdQOUCDrR8sgYreNs7IqRv16ab
	 X2qs8vJhs30z+4Z8G/6NQo9tPWJU/yvlzkFjZBy1x8gxEtlTbbCUbny97dkZ+l5wPj
	 sAaldbJbkElSmrAKZ7fklSgfVxz8mV7otdZ8T2cRUNInJbUZAJrkYBiu/HmIZ8f9BV
	 wqob+8bI7mYhL5/AGjZT+Sth9JdKhQJMBX/uLPHyeS8PQCrpZI4ktLov8YAG+91yZ1
	 97WNh8hcYgDww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>,
	xingyu.wu@starfivetech.com,
	samin.guo@starfivetech.com,
	linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 61/88] watchdog: starfive: add lock annotations to fix context imbalances
Date: Mon, 22 Jan 2024 09:51:34 -0500
Message-ID: <20240122145608.990137-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit f77999887235f8c378af343df11a6bcedda5b284 ]

Add the necessary __acquires() and __releases() to the functions
that take and release the wdt lock to avoid the following sparse
warnings:

drivers/watchdog/starfive-wdt.c:204:13: warning: context imbalance in 'starfive_wdt_unlock' - wrong count at exit
drivers/watchdog/starfive-wdt.c:212:9: warning: context imbalance in 'starfive_wdt_lock' - unexpected unlock

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20231122085118.177589-1-ben.dooks@codethink.co.uk
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/starfive-wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 5f501b41faf9..49b38ecc092d 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -202,12 +202,14 @@ static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
 
 /* Write unlock-key to unlock. Write other value to lock. */
 static void starfive_wdt_unlock(struct starfive_wdt *wdt)
+	__acquires(&wdt->lock)
 {
 	spin_lock(&wdt->lock);
 	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
 }
 
 static void starfive_wdt_lock(struct starfive_wdt *wdt)
+	__releases(&wdt->lock)
 {
 	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
 	spin_unlock(&wdt->lock);
-- 
2.43.0


