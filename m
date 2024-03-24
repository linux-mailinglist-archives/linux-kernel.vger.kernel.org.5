Return-Path: <linux-kernel+bounces-113622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EEA888E15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028DC1C2A396
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422901422C6;
	Sun, 24 Mar 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NycIqt/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CC7640D;
	Sun, 24 Mar 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320456; cv=none; b=WRCyeYa0hIzYlOs9Axwk+ZEZP/MZXdaiuUYXJYnlTi4WCMCWg41fFijonPe354ZYYemQPt5dd71+ZsUQyZWT1n0p6R/hBGSAGVj9NDKmU2xUGZRUgSnu7WTtbAqP/+glRHorRhkqpI+CQvBPNwxjNH62dJEB+21cvOMPm93LdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320456; c=relaxed/simple;
	bh=TVn0K55l25BpswqOak4H/Qan8tlImkF4R9suQP0gmms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0IYZkohR3ksNQk5icWp7baBk0ytPvvgUcS+r77m0ubVKQdgtD4V0DYugCe+wLQ67wm59MzygBbsBgvECXT8X2PRrdxU+QIGssH3RJ3r7ZeuyYBsACEQQ5IJSHhLXBvp6amvOgbG1lzFKqO5RjiZpSKJFiE0Geh5eiDgUC9lGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NycIqt/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FFAC43394;
	Sun, 24 Mar 2024 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320456;
	bh=TVn0K55l25BpswqOak4H/Qan8tlImkF4R9suQP0gmms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NycIqt/cGZemNRAziuN6p/hgCx0QY8Y3vXYHULG2xx9X5GROrc0wur14TMVZJxzub
	 Kx9nh+tLudMwufbpA7VPybklCoB61/bzhPJhjDhzQMfSExtWFZdPbQDwgtAwYH+EXW
	 fxObNCMLt54SeD9DH8uwyZHS8Trk1YOjM0sw6kVkpq9ibXnMoSj7MgREfN474tGX60
	 5faZRDU2+wFTfvwIEWbt2HCY+WcbXlbq6Pty5JLJFi0eExFjB4oAOSjJwqKze02O7F
	 kAhL+vigr9PTUFr8UbQkfNzJNQZIWOX8qAYl8hawtz6DO+ZH9BAU8DgRbyDV0ScNyy
	 KwAQbrnd6FZMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 015/713] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Sun, 24 Mar 2024 18:35:41 -0400
Message-ID: <20240324224720.1345309-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Attila Tőkés <attitokes@gmail.com>

[ Upstream commit f7fe85b229bc30cb5dc95b4e9015a601c9e3a8cd ]

Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Attila Tőkés <attitokes@gmail.com>
Link: https://msgid.link/r/20240210193638.144028-1-attitokes@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 80ad60d485ea0..cc231185d72c3 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


