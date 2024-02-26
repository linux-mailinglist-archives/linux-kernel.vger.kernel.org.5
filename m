Return-Path: <linux-kernel+bounces-82349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91956868319
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA5828AA95
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF513175B;
	Mon, 26 Feb 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vZsFFDfr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797F130AEA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983102; cv=none; b=PlqSZL3ZOcsr6QZRaebQVYVAUpLpKEttpQma5P4zPAN2zBgoIeiQKkvDQFmOv1qn/wIvESD/pWv8ED+ThrjrmmnBnJ4wEBto6bwAPlmSKCwMFx3lWAcK3xJaiATL+ubGo8iyOTk/zj1cZ53ct368p0qZ/hS9SPrNE8ssGo9POng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983102; c=relaxed/simple;
	bh=Nw8AqS3nu8azYAdACy/sJRukGGhmKt9W7YfvtYGs9vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UmGpopW6o6mJYlHdZilSeXN0Itm/XWG+t9X/QLxF782c7WPSeQSIBuZS1LCuuQEFoWJqS3iMcZOVpr8pP8SF3uNZudPxxhf2xD/XYjSeX0hZq94pBcuD3y1Rs3AEtyHo0bEqYXawGl4I7eQRBYK5G1XPv0eekBwZByiDf593H0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vZsFFDfr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708983099;
	bh=Nw8AqS3nu8azYAdACy/sJRukGGhmKt9W7YfvtYGs9vU=;
	h=From:Date:Subject:To:Cc:From;
	b=vZsFFDfr3tqoQUbJYo1Y8oY/iBf7c396i8DkxKlJL/PFsU46fj1tdhbNK1gXRpxkl
	 maRB5srslRsUlKsXw/4u7xpVkYBMtpAHOWaOpX30ZlObwjG1tYCI06GnVWJUTzitnj
	 Z+y4NU7KVOuKj8W9F7SQUPobZA1+SC2dIgPGM7Gzm3g65OMLrD6amaRTpudMnWDJxo
	 DU4sluuy61XFb/mRdFEEQaS88Zp5EBTIL5rtS8M6BqhWaXS22RR6MMk01LyPzeYEzy
	 Gj52FWF4t7ylzPwOesB1SJWp/QVmC+vMsqqhQ/Fi/cI5MFinsZqUj7nuB/nvXupaPp
	 C+cPEHvohW7Zg==
Received: from [192.168.1.151] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 610EB3782075;
	Mon, 26 Feb 2024 21:31:37 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 26 Feb 2024 16:31:33 -0500
Subject: [PATCH] soc: mediatek: cmdq: Don't log an error when
 gce-client-reg is not found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com>
X-B4-Tracking: v=1; b=H4sIADQD3WUC/x3MQQqDMBBG4avIrB1Io9XWq4iLmPwdBySWRKQg3
 t3Q5bd476SMpMg0VCclHJp1iwWPuiK/uChgDcVkjW2NtR2LB/tVEXdOEF434TALPx3eXdM780K
 gEn8TPvr7j8fpum4s7kuzaAAAAA==
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Most of the callers to this function do not require CMDQ support, it is
optional, so the missing property shouldn't cause an error message.
Furthermore, the callers that do require CMDQ support already log at the
error level when an error is returned.

Change the log message in this helper to be printed at the debug level
instead.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..2130ff3aac9e 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -55,7 +55,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
 					       "mediatek,gce-client-reg",
 					       3, idx, &spec);
 	if (err < 0) {
-		dev_err(dev,
+		dev_dbg(dev,
 			"error %d can't parse gce-client-reg property (%d)",
 			err, idx);
 

---
base-commit: 41913bcddc83b131649ee8ff0d9ff29e01731398
change-id: 20240226-gce-client-reg-log-dbg-5ae9637a08ed

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


