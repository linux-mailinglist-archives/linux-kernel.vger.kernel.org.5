Return-Path: <linux-kernel+bounces-10333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D881D2DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27538B239EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E379F2;
	Sat, 23 Dec 2023 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YIHZ/jTr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698366FB0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id GwISrtTvHv1b4GwITr2eQM; Sat, 23 Dec 2023 08:19:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703315987;
	bh=7Pm9gqt1euiDI+iYLE6mnhNX+j8DK5QWPHTOt7CTwvg=;
	h=From:To:Cc:Subject:Date;
	b=YIHZ/jTrGUqehm8MDEfFw0WRndtqymSzBRiINMxGRKVWr9QbNO8VHzI4Y5S8bV60C
	 TAvgc6CAS1Ra80prgXwamhKmJsVpkgcjOVk64RxPDy2NZTQkWupEYrmT03dM9RYRgC
	 gVW1Kec2wI+JoLICcDclCcLpTkhQBOO+dseDkG7FBg7ugdK/viygLd+InP/J687Chu
	 5ktqXqTEc0LmVM5zYhwLPJXWJlxkZFQg8cg7yJySwAjSVXzAIECnvWqpFku45J1cAg
	 EIb8/SOC/Jt7Lg7GCd4DkboYg3C60WAjLEV/5f69M8t3xQIKaGvtO8VEbMnb1tDpKk
	 4bjbSNqa9CVmw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Dec 2023 08:19:47 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: bnx2i: Use netif_carrier_ok()
Date: Sat, 23 Dec 2023 08:19:43 +0100
Message-Id: <1c8dce4f385ef952a14f056d1d6a621610c586c8.1703315967.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_carrier_ok() instead of hand-writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index 6c864b093ac9..813de64be827 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -96,7 +96,7 @@ static void bnx2i_adjust_qp_size(struct bnx2i_hba *hba)
  */
 static void bnx2i_get_link_state(struct bnx2i_hba *hba)
 {
-	if (test_bit(__LINK_STATE_NOCARRIER, &hba->netdev->state))
+	if (!netif_carrier_ok(hba->netdev))
 		set_bit(ADAPTER_STATE_LINK_DOWN, &hba->adapter_state);
 	else
 		clear_bit(ADAPTER_STATE_LINK_DOWN, &hba->adapter_state);
-- 
2.34.1


