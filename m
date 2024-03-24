Return-Path: <linux-kernel+bounces-113891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF188872C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583011C26012
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3D13A25F;
	Sun, 24 Mar 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRxXWc/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86F1ED73F;
	Sun, 24 Mar 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320995; cv=none; b=Nme9D9ez6o9c3P/okjOWff7h3jXwQSFEDyL6hv28h4ye6AMLweBiBBbTCq9qZslZowCyHzKNsKUGR1mEfGqCfHfo8dpu+WNVf9TGybuIfoWCdpwiwS9ppqxKhaVZo619jUH+tCodGEc/KvhQiyBvaC8dbjMSAVaUlbxVYuFlnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320995; c=relaxed/simple;
	bh=E5Wrq7Gz9HeqfWiBi72Qv+1hoPP8IyLLFnOGhZKyAPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ46DYddNtZ26hqYzqmctpKEOHGRA24i9Jtk/FAMy5ZmET9s9FXIqXd7g8SK+Y+tAplUtj/jdBC/SvbB7DYr+eeIOQOC/TeR0gUTSbEAExr009d2iE9HoPo6o1vGBJa1TWybq55zhq35KNDd1KQgGZcwIHTNuyIEfQfub8M9QPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRxXWc/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0324C43394;
	Sun, 24 Mar 2024 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320994;
	bh=E5Wrq7Gz9HeqfWiBi72Qv+1hoPP8IyLLFnOGhZKyAPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRxXWc/vXHA0KtgXWgq9pUEptkPgY2GcjL0GLMfOJYropB96xk+uLzMnv3s4+t/2g
	 kyhHJOtQhm6HCo0USELvNQFEK0Xz+3tXW7dv3nwnPy6/EmtGMfkrdBflh/X0Ka/j5f
	 8tnxjZfjL9D9Ek1ey/TN88PgUfJVl9wuPGbUqPyDdKz7uWpyOdARMaLzTbjTPGn+fZ
	 kmJZrqOqkTuACI0wOzEbfbbhfPO4ckXAMhaX+y5n7EYen9bceft2R3WwiCeyXNkdVJ
	 VOXP7XIA861u+0mTWj05RbWl7hOiPT5N7d/KUkjC57XzZi0Mb9Y60yWZHVoAxHERiM
	 ORY4BkaU17NNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 556/713] ALSA: hda/tas2781: use dev_dbg in system_resume
Date: Sun, 24 Mar 2024 18:44:42 -0400
Message-ID: <20240324224720.1345309-557-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit c850c9121cc8de867ce3ac36b9ae9d05f62bef14 ]

The system_resume function uses dev_info for tracing, but the other pm
functions use dev_dbg.

Use dev_dbg as the other pm functions.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <140f3c689c9eb5874e6eb48a570fcd8207f06a41.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 9f98965742e83..c39a5404fb392 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -813,7 +813,7 @@ static int tas2781_system_resume(struct device *dev)
 		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 	int i, ret;
 
-	dev_info(tas_hda->priv->dev, "System Resume\n");
+	dev_dbg(tas_hda->priv->dev, "System Resume\n");
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-- 
2.43.0


