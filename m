Return-Path: <linux-kernel+bounces-102155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B187AEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B61C22F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA4F76417;
	Wed, 13 Mar 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1hD/cqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDDF76401;
	Wed, 13 Mar 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349372; cv=none; b=Z+YRcZL5qgtS7Hv/dzjYCPrCSfghFKeWGZHSp6kEb48Q16ctm5AqGonX2HU83Bc8pasXbS2U+WoxCDuwNgDF2YDm5OrqaAu1kn8dI8JkiMV7oy6iTijyu5P/xyFOQDbZf9SfLEz+7EAeu+PZA80rSPL7qCtNvE8sEzqflAcu4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349372; c=relaxed/simple;
	bh=EKaTR6HEk70CFzC9DU8eMr06ay9esnZrPVG2OliLbXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfVa46VqMdujHjZoDIXxEuBF8JzE4/he1ZACZHtXZgkAreTuBBKy1rR6g6HxoZgVmR/6/emX48dSojHYN7Er4SZKg9f5ILBQ3hJhj1Crv6Gns7GFl4pYycWiKquBmNd7munT+Z6gJbEsYN+DQA7KfjZ2XqPlxxCHwtxdRUFL6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1hD/cqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086E7C43394;
	Wed, 13 Mar 2024 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349371;
	bh=EKaTR6HEk70CFzC9DU8eMr06ay9esnZrPVG2OliLbXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1hD/cqePGja2lSlmTZ8SHe/VH7y1LvT36cSIoiX4gHu4ErBBCPzAY7UZuU85a25s
	 j0v4ZxY4wb05zBoR2iL/59QiQC2UbjkSMzDrx+NjBVVIGWOSCSZv6pqKA8zy3rLJSI
	 1LsdBgugEhj5lpTEggziZoNomQn2unKiu5RC5Xbxd8aldsGETaalk7nn9IW92+SC4K
	 oAQ9vZ1zfLsocdCKhQo0GzW5euwFEzjaUGxIhvRJCvJBckbaZnPLtc3kVB2gC2AvcS
	 wkOOr9MZBNHgVDuOCCFJkt+fOwJ0GgJ6EgvrdULvvGqRrZmsb6AjAMFEHdCdqsFV2M
	 R56KI0krImD1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 34/51] Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU
Date: Wed, 13 Mar 2024 13:01:55 -0400
Message-ID: <20240313170212.616443-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 1ab7f27bc9062..4ae96bd56253c 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1179,6 +1179,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
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


