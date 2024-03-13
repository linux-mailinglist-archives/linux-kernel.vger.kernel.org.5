Return-Path: <linux-kernel+bounces-102215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB787AF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475591F23B67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821D1A1031;
	Wed, 13 Mar 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC9komB+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80976C9F;
	Wed, 13 Mar 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349509; cv=none; b=aCRtLMCD4JUYslO0l/JbwkT4xz0IdJwpw+A8d7YQG0ScE3Zgbc3pSiF2SOGmKy2VDNXi9LOnghrN3xYaVve8KRtZHCv8EurURken7KlcoIXLrtlLPaah3wg3fUY103rlrG5RIEFrhjbXGObCSSFhZL33wQEIzZmTxGl0bHAM8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349509; c=relaxed/simple;
	bh=WmEHShAVioLu0qe229qhXUrIhwgvEz/ImnTxaOfpfGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3M5nO67m47t3WrJFFcJnMGNzO8ueM8516CbcnK8IYNbuv16Jg+q/KkVGJc1BLl5UDp4ExmQFgzId6xuN5g3KVLq+O+HdEdG7VLFZgx9Z96hLq2zts3j5Vg+5qfAP+TSPMAHwI1GUrnj1U5TEcdtMMNZ345ZJ9RJEvqObUgToMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC9komB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D153C43394;
	Wed, 13 Mar 2024 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349509;
	bh=WmEHShAVioLu0qe229qhXUrIhwgvEz/ImnTxaOfpfGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gC9komB+FoEwdKH+AtKfoI4kv4CDxFl14b1/Yl/ch5csQ4Hj+RhOV3f/jOSUUxKrk
	 cDtqdqNI6Mh3JLbmQBotCA0cm/VAm+kbiQKUvOrfIBIacZKibFs1BsfwHVmkZMKO90
	 1Yz4odrn5w513bapU+z/4gMDTfem2UQov4Qx4Y6JWWFWoKh4/Z41YMqh0h7iUDOfzm
	 sxLcF7AyYI04PMGdFvkOuCfSv2v+7iYonTGsMq+45J0obPx7PD6Cx7AyRIawt88AqJ
	 n4k7ux07siV8bri3xFBTmvMSAAqCPsa1CazJXi5gQAR3C2035FKMJ412Cx3763HbXA
	 EYSSvOBoUSqJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/41] Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU
Date: Wed, 13 Mar 2024 13:04:22 -0400
Message-ID: <20240313170435.616724-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Werner Sembach <wse@tuxedocomputers.com>

[ Upstream commit a60e6c3918d20848906ffcdfcf72ca6a8cfbcf2e ]

When closing the laptop lid with an external screen connected, the mouse
pointer has a constant movement to the lower right corner. Opening the
lid again stops this movement, but after that the touchpad does no longer
register clicks.

The touchpad is connected both via i2c-hid and PS/2, the predecessor of
this device (NS70MU) has the same layout in this regard and also strange
behaviour caused by the psmouse and the i2c-hid driver fighting over
touchpad control. This fix is reusing the same workaround by just
disabling the PS/2 aux port, that is only used by the touchpad, to give the
i2c-hid driver the lone control over the touchpad.

v2: Rebased on current master

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231205163602.16106-1-wse@tuxedocomputers.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 06d99931519bd..ce9209f336957 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1183,6 +1183,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
 					SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
-- 
2.43.0


