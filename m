Return-Path: <linux-kernel+bounces-101973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4D87AD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1151F25C52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F114564F;
	Wed, 13 Mar 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASNAI3Jc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F06341F;
	Wed, 13 Mar 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348182; cv=none; b=T7J4K8FzoT0gvR87UeKKl0UIn4h6XfxuqhdkmDRBD6P3ikLSOZg4pqm1+CEBtPmcyquw1XGiMNmOK0iKajEmPFBGE2tCC7g2rNISn+NUVcyJYy6It2Ko14T6pXdyd2vHYHR3+KT7wRJppTZGh410hu17fN8wqzV85QHRimjIGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348182; c=relaxed/simple;
	bh=L3YXKMWNBC7K/C/TGW/wJXP/alvbOQPZAj9zj67+GfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8kaksA1oKghkqlfijK+z2oJGvasWaWKFiN1j0N/6LuN7ACGIZ0lLHyMsWzRiMY2PDpVr3uAp9n0FX30pxiFg3q4YAzTHD8TaSKeOABUhrb0YTHznheBMca2huTsnCxpkVTG7vV18Bwt+XJ1w3AuQT5FrFdMuhwldPPTA22K4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASNAI3Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD02C43390;
	Wed, 13 Mar 2024 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348182;
	bh=L3YXKMWNBC7K/C/TGW/wJXP/alvbOQPZAj9zj67+GfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASNAI3Jc6WXxpmdEfVrAXFh9JeCZiveMaZFLWcG1k3jsYvvK90j4Lex4lIbLHysMK
	 ll/RLwiGzlvpxOHnlcQICxkCe1E0FWE6xaUFtwNNvRTjoQNEJGwwLQDSL2u9xjGyWJ
	 8zsogMtq3JrBYaMng5+Gz3UmqP4R54WHo7YQEt2wXin/u1YdoEsANt0h5o9j8eKWG+
	 mMgicip5CV4DkVtIsEG9KSaKKH+1qO/Bu+/RH2bIKtucvskxg9ypCxivURFJ2WOFB2
	 qO51QH/BWeopbDw9hTIgTeE78UAnOwJ3uMYkFipjcv+fv2U40yYnGR7VXBUhRBEltw
	 Uwjq8olTMIYEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 33/76] ALSA: usb-audio: Correct the return code from snd_usb_endpoint_set_params()
Date: Wed, 13 Mar 2024 12:41:40 -0400
Message-ID: <20240313164223.615640-34-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 9355b60e401d825590d37f04ea873c58efe9b7bf ]

snd_usb_endpoint_set_params() should return zero for a success, but
currently it returns the sample rate.  Correct it.

Fixes: 2be79d586454 ("ALSA: usb-audio: Split endpoint setups for hw_params and prepare (take#2)")
Link: https://lore.kernel.org/r/20221009104212.18877-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 486ef6b022552..80ead3db4d1c7 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1388,6 +1388,8 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
 	err = update_clock_ref_rate(chip, ep);
+	if (err >= 0)
+		err = 0;
  unlock:
 	mutex_unlock(&chip->mutex);
 	return err;
-- 
2.43.0


