Return-Path: <linux-kernel+bounces-128583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE132895CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A4F281D51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DE15B99F;
	Tue,  2 Apr 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="J3ADQfrM"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0315B962;
	Tue,  2 Apr 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086527; cv=none; b=JZ1uz+xUXCEM09bowIWrESs2gLAWxjyMs/C4pqZdLZCN6bS88Ph6VuLmRZ+J/P449l3VPWVQlvOPe4ydH5KF+2CnhZLhWoTp8REaGgqOIyWxG81L3FPpIq2JEgcUVUt02MGpVvGgXQI9ss20M7W8RpkO4c8U0RgCu+rVomRPN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086527; c=relaxed/simple;
	bh=+AGgKD6Tmq9lM58FzmpAuALw4Ata2Tvc0YArRJgl6kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQAjrgoSmJ8DzNxEDac7ttBdB9gfS/Hk61xq+LLaa/4tdRseXqK4q/63YZXD/A7K9x/4xexLGR1u2payVrfoMh/5eCLdzbnD3KtDFUcPCnWaHp1v85jB/20DSs7OfrcpCDVNo2eBW4dBOwBHDlQUF0+vwdKcypbokYSyuZaHoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=J3ADQfrM; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjul-003lfo-1J;
	Tue, 02 Apr 2024 21:35:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JZvK80tTRWAuZejNRWV8wWoUaoCWXbTiAE55SjVVMvs=; b=J3ADQfrMDwUPI42xlCfk1ueFHF
	2Xwmr1IJJHUltjZYRsA/B11+UXLrL7OfwVLDflEEDMedaoxqSEG1n+T57vKKA6mmlYcxnKKV0zSUF
	FJJUotOn+PGEG6W+EOPXfDvzgtjyFqHPUYh7QlRLvtBX5cJmJYrFkXOk1x+TtJIDcPdgOxB8IAFWh
	ORLOxx3ucjkjYCcye9/yImPQnUPXACRNRk4E5uUK85cpyBkxe+jyQOQsHqF2YbffFNtPB9+r+rDSK
	HLhv3gSAA4dMOCFvyAKmUGPhlag1C+3e2V3TjLW85OzlyON1pEx/I7ErRYcy/u9R2RA0g34TddM6s
	NUfbNMGA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjui-000J30-0P;
	Tue, 02 Apr 2024 21:35:20 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjuh-0029e5-3B;
	Tue, 02 Apr 2024 21:35:20 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] mfd: rohm-bd71828: Add software-compatible variant BD71879
Date: Tue,  2 Apr 2024 21:35:15 +0200
Message-Id: <20240402193515.513713-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402193515.513713-1-andreas@kemnade.info>
References: <20240402193515.513713-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the BD71879 PMIC which is software-compatible to the BD71828, so reuse
the same device_type enum.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd71828.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 4a1fa8a0d76a..f0b444690d4d 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -585,6 +585,10 @@ static const struct of_device_id bd71828_of_match[] = {
 	{
 		.compatible = "rohm,bd71828",
 		.data = (void *)ROHM_CHIP_TYPE_BD71828,
+	}, {
+		.compatible = "rohm,bd71879",
+		/* equivalent from a software point of view */
+		.data = (void *)ROHM_CHIP_TYPE_BD71828,
 	}, {
 		.compatible = "rohm,bd71815",
 		.data = (void *)ROHM_CHIP_TYPE_BD71815,
-- 
2.39.2


