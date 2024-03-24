Return-Path: <linux-kernel+bounces-114376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC83888A17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B3C29083E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25A270C61;
	Sun, 24 Mar 2024 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tov/2cPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884A217DE9;
	Sun, 24 Mar 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321778; cv=none; b=fyDYimmmFnEKXoxjrncd8BDZB923j3aWp5Wle9B7BLmUyQpf6FY7s/lhUKIbqmm5TCe1LTZhjnhqPkuxhZRmbIQ51a4LAtKLNsoivqZqXPgKsD08HEgx0MIPpuE+Nkj8F8wvdTkugFQKj4ECN8fowvvoQOEzuxukelYwke2RvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321778; c=relaxed/simple;
	bh=t5k8VbrrI3dDuxkErCjj7dA7KEoptyLScVabWaDsg1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrZnQPIfAYoEy6iwMtiZPyg/BBfj+yc9pTGaxs8+PmyaJuL/0WwZ/SGUlrNy05hmpzTY1F53c4WS2jbH+iWWgw8rBVebfBE5F4MJzDSiGWCAvXoc2FAmRWgTIddJ+cRccQLXp6BPgBLyPT/oivhRX+nDgmDi5yaUgzgxF09Un7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tov/2cPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE40C43394;
	Sun, 24 Mar 2024 23:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321776;
	bh=t5k8VbrrI3dDuxkErCjj7dA7KEoptyLScVabWaDsg1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tov/2cPboM5741rO/i70CJBoIgSenBjR8YSrI0/KJk+n/nZrN3jq76Qbu6xLJ9Pcz
	 gZJcR3rfuWImYyciA8ZgeE1Z4JHOA+vmGRrTnpQgV6zcCyFOfb5u0IqYeZVi4rPru6
	 H0pbR+UAvs4dNT4Z4T0eKDO63f/VN/n4yfFYr1N6yQp/TT7aAPefjZ8D2GfGzsxWr6
	 NcshTPTwsyyvGJVgfPpR8oKyPic6fZfNjJRrdXy7csAzVhQQ6daBneD47LqLsJnc1c
	 WDcEi0t/dk2yWG+sNqdFcOCsML8llmg8H/3HeJHPXlkg7UeetBI3xpiy8aqCFI9wFK
	 yQu7/ZCpVFJ/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 504/638] ALSA: hda/tas2781: configure the amp after firmware load
Date: Sun, 24 Mar 2024 18:59:01 -0400
Message-ID: <20240324230116.1348576-505-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit 68f7f3ff6c2a0998be9dc07622bd0d16fd1fda20 ]

Make the amp available immediately after a module
load to avoid having to wait for a PCM hook action.
(eg. unloading & loading the module while listening
music)

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/7f2f65d9212aa16edd4db8725489ae59dbe74c66.1703895108.git.soyer@irl.hu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 9fc91a6fe37c ("ALSA: hda/tas2781: restore power state after system_resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 57070a1364dd0..a63860f0e283d 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -584,6 +584,8 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	 */
 	tasdevice_save_calibration(tas_priv);
 
+	tasdevice_tuning_switch(tas_hda->priv, 0);
+
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
 	if (fmw)
-- 
2.43.0


