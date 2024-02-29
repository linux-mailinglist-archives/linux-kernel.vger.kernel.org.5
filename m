Return-Path: <linux-kernel+bounces-87382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E6A86D3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAB2B21A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB313C9F2;
	Thu, 29 Feb 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xsaX8nb5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3313C9CD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236277; cv=none; b=gFCmGr/k6eKRftpKFAomSl1eT7kDif79tRA9o1JDePE9QLSbI0OztAvxUr7MwgFJKpaapuXF3zbnYblefsPyRTzg8nUY5q8XuLoGoIvtmq6gclsHjoasp/aSE/onh+d5sfz7s08Mj3UObeZTK1O62L3NAO57JqbdCKWrLBcRaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236277; c=relaxed/simple;
	bh=bj3pI6xkKLINn85t9EjrFuhDT8EzhA7/C3H9O7fd9gI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PG/WKlfNyJC7nfNkyk2/4foK6iDuSfFR4ltRml4oV5wiDYpONafYtT55f9qYsz1CGJ5AT0UJoQrSAeDlvCTUKzgrbaw4DqKW/D/cCU6/bPzyU2/4dAHe5cCJXYjdYy+/tJqo/j+ewDYGoI5J83o1Ufwn1sKJOHOccnHriHqbQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xsaX8nb5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709236274;
	bh=bj3pI6xkKLINn85t9EjrFuhDT8EzhA7/C3H9O7fd9gI=;
	h=From:Date:Subject:To:Cc:From;
	b=xsaX8nb5bz0HkDPjdymTlmxtjZ9vQMYIIaJjKCIstMDsbbjVsntTs6aT/xbIUI4JX
	 wD6a6bfD5j//1GtwgA4RwBX4cbezYpcZ/Sa6WZEM33nOH0mf2bthkECr2X7IgzbWP4
	 yWQgTfgTPOfWupXhihDzXVbPSzEkPlKhSMoSNeAHTHAmM6kCv/LDU6MnakaNDweL3V
	 4FQ2yqAOq7blHwJoL5rZD+HSZ9fv3xkkF+XAsAQtmxaIwcrEQwwv+b05XiRpeaU9sd
	 WzCKB/ymX+2zSp+DO34CqRDVIxBz6N5uWNlr2+7+ECbZdqHWXfI/UPjKg0AAxl+PG1
	 yzkygNrQCMTNw==
Received: from [192.168.1.200] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5334337820ED;
	Thu, 29 Feb 2024 19:51:12 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 14:51:08 -0500
Subject: [PATCH v2] soc: mediatek: cmdq: Don't log an error when
 gce-client-reg is not found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-gce-client-reg-log-dbg-v2-1-4975077173d0@collabora.com>
X-B4-Tracking: v=1; b=H4sIACvg4GUC/4WNQQ6CMBBFr0Jm7ZhSFMSV9zAsyjAtk1RKWkI0h
 LtbuYDL95L//gaJo3CCe7FB5FWShCmDPhVAo5kcowyZQSt9UVrX6IiRvPC0YGSHPjgceodXw21
 dNUbdeIA8niNbeR/hZ5d5lLSE+Dl+1vJn/ybXEku0ylrbNlQpah4UvDd9iOZM4QXdvu9frQhqg
 8AAAAA=
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Most of the callers to this function do not require CMDQ support, it is
optional, so the missing property shouldn't cause an error message.
However, it could result on degraded performance, so the fact that it's
missing should still be alerted. Furthermore, the callers that do
require CMDQ support already log at the error level when an error is
returned.

Change the log message in this helper to be printed at the warning level
instead.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Changed from debug to warning level
- Tweaked commit message to mention performance penalty of not having
  GCE
- Link to v1: https://lore.kernel.org/r/20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..943e9055dd1f 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -55,7 +55,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
 					       "mediatek,gce-client-reg",
 					       3, idx, &spec);
 	if (err < 0) {
-		dev_err(dev,
+		dev_warn(dev,
 			"error %d can't parse gce-client-reg property (%d)",
 			err, idx);
 

---
base-commit: 41913bcddc83b131649ee8ff0d9ff29e01731398
change-id: 20240226-gce-client-reg-log-dbg-5ae9637a08ed

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


