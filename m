Return-Path: <linux-kernel+bounces-115775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6263D8897AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DC61C30EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490036D898;
	Mon, 25 Mar 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD0p4BeS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EA14532D;
	Sun, 24 Mar 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321976; cv=none; b=tG9awgrb385HNY09VZaIgLllUHHUe7s9GWEjfrFwDRTSQrsDzll4zMBCif8qQAsrgi89GQQkk09GwgY+ayGa8xUwGvrURj+zelnDYIz93jK7mrPBV62eJQ2GJ1hjLuS1A/HDqqjwzEF9+VrhkpfG8d7qe5CB29W01JxCY/PapL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321976; c=relaxed/simple;
	bh=pXzBRU0ZX7LOA6s9J9tgTTGpBz2qJ1n+h5JdCsC+IRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGokZpWbAZ7BTWaMf24sTmu+7BhNZmSxlCGPVk3k48ON9yeJy2zptJ/Cgym2mzQPbCTkeWriS/YWIngjxJOolG008Kk9TMsgUuXCSoEkZa543otir4cgaJQfICoK5zr+812WF1iQCFrNpWga0dYtRxPWHS8QiOSD/grOttg9Nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD0p4BeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B552C433C7;
	Sun, 24 Mar 2024 23:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321975;
	bh=pXzBRU0ZX7LOA6s9J9tgTTGpBz2qJ1n+h5JdCsC+IRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD0p4BeStSJK5VTUkid2+k8zXIFbBzqi7H1xremZKf7wXDw3dTSQ8hFmPVJN/8+ut
	 9WtLz1LafbSsM7VUFg3BUseohcbhLAOQIH+ZDkZuiS0hdKnc+iXmLvCnziC/FIoSM0
	 Dzuar5imwTcByY991yop02aITq54oavasEfDzQzo25t2Cf/eqtgCsIU6lKw5UyFSAy
	 nRej8EwhnamQhP/BUX4ZqafED11BBE0TgusJw08d6qYdGsxJ9g++PaX5Dy3f8pcN/c
	 pFf5ZkJRb7rQP9FnkqYwt5YaCh1yOEJOKoy2hA+E8pnqnMZjPvD2admOKoywUbVwdp
	 Vm31S6caE6Msw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 048/451] ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
Date: Sun, 24 Mar 2024 19:05:24 -0400
Message-ID: <20240324231207.1351418-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jiawei Wang <me@jwang.link>

[ Upstream commit ed00a6945dc32462c2d3744a3518d2316da66fcc ]

Like many other models, the Lenovo 21J2 (ThinkBook 16 G5+ APO)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240228073914.232204-2-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0568e64d10150..e0f406b6646ba 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


