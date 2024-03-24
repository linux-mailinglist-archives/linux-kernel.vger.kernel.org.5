Return-Path: <linux-kernel+bounces-116197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B2889D77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9882A5D92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5B3BB1C0;
	Mon, 25 Mar 2024 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT9JMWCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87217CF44;
	Sun, 24 Mar 2024 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323806; cv=none; b=t8NfVRmMC0uqohe8THivOMklGl7AM6twTvmR3bhPvg998b0YHyzSSruMuBDy5AGxPSRR1LE8K3m+wxJVnPDdHncaHfgNe+to/tIT2a8zJNuGCJTa40Se5M+Bz5fmmVWY0japbJ4uQ3Qgw74cf+Divamt7yn5fjRF7GW3fzymBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323806; c=relaxed/simple;
	bh=wKblKOnclTeKSAoujBU//Prn5MTCOKTjOvtWnq63Pws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDKGK0OupUy17emRDov8PfjEfUiXnabQMxx8ToDPl+PioG503t6TAxW54v6vAem8nYQv5BW6YQe1n8MXI8K1ql0J8GPUTRUSStWmCyQR6jvt5yXNA5FveJDWGLizUh63wOdqMTj4W2AOdCFElqi5Sry6WNhmhYmzdqU6LldsOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT9JMWCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E99BC43394;
	Sun, 24 Mar 2024 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323805;
	bh=wKblKOnclTeKSAoujBU//Prn5MTCOKTjOvtWnq63Pws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iT9JMWClFQReHIihI6+Vn2fd6CTk7cpyw4uWl5Xs+VjBBWleTVraCb05twsj9zcSu
	 ZNb5FGfOv3nezfFiqP9+lTAfCfHVQqYbtcLIRvaEym5vhfLQpoFIKLfZlD2I6w74y3
	 uVxpyF37JyeuYW6xkI0ANxpu9ao8ul6V9O3UfzDrBPqNRoWEYOBa2j22OGxPb/lpVX
	 2cgMYzkmG/IhtYD49OMBugWOhmb+8k0SdKF6bhGQD4LU6H+YdDL5IGP+iX9zcsJc//
	 mjCFP1bBLyNkVWmb5LPU6Aq2LvvBiP27VCKjVnlM3q+rV31jOWqmRcminDulNX/UJf
	 18whMyT3TccfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 183/238] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 19:39:31 -0400
Message-ID: <20240324234027.1354210-184-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit ad9aeb0e3aa90ebdad5fabf9c21783740eb95907 ]

The backlight_properties struct should be initialized to zero before
using, otherwise there will be some random values in the struct.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 419b0334cf087..2aade66db3cf4 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -339,6 +339,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
-- 
2.43.0


