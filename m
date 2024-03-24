Return-Path: <linux-kernel+bounces-115716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C7889732
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6741C30B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE81360889;
	Mon, 25 Mar 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAztOXoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D521732E;
	Sun, 24 Mar 2024 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321772; cv=none; b=VPzN6qcAK8CniA1s1q+8z/UL4ZK1Bzj9eIcJH25+imd+XJgd2YC1lenf8KyrDPAPeB+z7WZ4OonQlZ7Sl1P305X6cGxduqcxfTZgx9AMdu1ZRPuaE/RGKOEjjaIfKKTQm0x/Da0FOUsxewjLvKfaE3vUTlN5u78K3ju+z1B9hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321772; c=relaxed/simple;
	bh=vv2sS5ZBNzCodlx/Ot+fHLRKMuLIU9lAqduoL99PZSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGchAy9h0Fb2uDoIQQHlMwnF2sd0i+kHvcRihFaU01RPwWK+un1zDQJJBvoRSfojM1D21WAPyAUwzN+J+3MAJpw6AGXuPQudReWq+Njge25UluwxAnw1XyISro800YJszpSFU85Tyo4FmWMHQ4Xz3lFie5rN8ZwDAjZfkVJpfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAztOXoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F54C43390;
	Sun, 24 Mar 2024 23:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321772;
	bh=vv2sS5ZBNzCodlx/Ot+fHLRKMuLIU9lAqduoL99PZSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAztOXoZ0OaJaBOeVNzT/LgOzcZ/+aZ3OJNcsDCLLm8ZORW1s/U8lreHpa74rUK9m
	 hW/1G7z7qwmHnScj2WtU5Imr0+JCnZpYMg+TzjrCbP1e/XbX5qbnvR77whj+t10amV
	 xJIhxg/s+kt5HF9tdP2tbFAOqc10B3rCe5fm1ZP6WIx/lQYnevmVrqZ7kaZuenztM6
	 VySb15QxzY8LaWaY/Yx6ZQwGtrGp1Xj3wDn28iH7oXSFnOXo03QeWgIpDQpHgp4Xn3
	 PghZwzGi1tCxfRB5+aLTqMo6i46YSqLLSTULD+poVey2284cgO5sqOVoJ7ufcGAjAr
	 U4WqPbgJrEDXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 499/638] ALSA: hda/tas2781: use dev_dbg in system_resume
Date: Sun, 24 Mar 2024 18:58:56 -0400
Message-ID: <20240324230116.1348576-500-sashal@kernel.org>
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
index 26928d5ae5f70..1abe04e2685d9 100644
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


