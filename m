Return-Path: <linux-kernel+bounces-102009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC3987AD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F24C1C223E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E414D43A;
	Wed, 13 Mar 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEjDxbOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773F14CADE;
	Wed, 13 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348222; cv=none; b=d9YEQIfUHNfk/pPxYRxOcoxs6VJjLSk7tTvmUqZDsGRqSumZSLZ5X7idTrZtvW+FHaUC9arZBZCqiqUq1n6CQoeLBKyzz+dnnnFX6opfJswnY0N4qH5Ce3NKO06yS+YyfTIltRi17PFHsIAxz8gxZM7z17jWIeEGuI6GAyA9HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348222; c=relaxed/simple;
	bh=6dxmNiCCcPORI/dA+Z0VsqZXbOzR01ZPsdvJA7HTG90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo/aR2mZjy57lWLmlaVYWUd9Yn0kmZEUNtml90AEJXYiZQNiZFzS/dAbAjkIV8dmjmeM60oNWh+vuBOjAZ5WTTCIHDe38lUlWplM0wL4AL3vIrOB3rcb6IPKvcfE+d3jwkU3cMz/SH8l8VMgtN7jX1qNSO02jwwpCNKtrNhek4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEjDxbOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87382C433F1;
	Wed, 13 Mar 2024 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348222;
	bh=6dxmNiCCcPORI/dA+Z0VsqZXbOzR01ZPsdvJA7HTG90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEjDxbOk4ASmaihi2yzCB60hXT5KNYcUWen59yS+PI2ff2IFp6Q2PxKjCDb025VBc
	 kTbUYnFZnBLAh8YRBovwC3ACQaTEzjIqkPe52sIE/gQJwpKj7/hJvBdZpsQN6zpUi2
	 jjwM5Mp1xctFeScwM67WTjTlu0AEXHMWL4Taa6Joi5ouKL2DzAdv/+BgCzv1F/M3vN
	 a4iI+AzFy1p2uiXnDy9eWqQH/0PjhWZ5HRr2/v/pKkmKvOvu+/cta4Ze1B2AZ9HRQ5
	 5B0wrZhcZL83+fQrryy+kFK0Nkz7GOHNJU7G8rqFwTsSff3DnOAQMKFljVBlYTGtsp
	 psmvuy9TSPIWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wan Jiabing <wanjiabing@vivo.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 68/76] ALSA: usb-audio: Fix wrong kfree issue in snd_usb_endpoint_free_all
Date: Wed, 13 Mar 2024 12:42:15 -0400
Message-ID: <20240313164223.615640-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Wan Jiabing <wanjiabing@vivo.com>

[ Upstream commit 03a8b0df757f1beb21ba1626e23ca7412e48b525 ]

Fix following coccicheck error:
/sound/usb/endpoint.c:1671:8-10: ERROR: reference preceded by free on line 1671.

Here should be 'cp' rather than 'ip'.

Fixes: c11117b634f4 ("ALSA: usb-audio: Refcount multiple accesses on the single clock")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Link: https://lore.kernel.org/r/20220518021617.10114-1-wanjiabing@vivo.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 26af199f3836e..8188113ca83f2 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1720,7 +1720,7 @@ void snd_usb_endpoint_free_all(struct snd_usb_audio *chip)
 		kfree(ip);
 
 	list_for_each_entry_safe(cp, cn, &chip->clock_ref_list, list)
-		kfree(ip);
+		kfree(cp);
 }
 
 /*
-- 
2.43.0


