Return-Path: <linux-kernel+bounces-144336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E9C8A44BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5173D1C21173
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B34E136649;
	Sun, 14 Apr 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPd6yaiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD03135A49;
	Sun, 14 Apr 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120500; cv=none; b=tCQpTaBHea3z3MBAPnBh7OL38PXstW+LVcXsrO4vhHaorbzyZP7f0T56LCA8OgwUbIgZAcfkn76tLXlyj88lfIdP9RRA1RUiRrunxlc21reJ1ZdDyt+hfLY4X97DFC7RfPmCPvz4uBoVcCzCSyu1Wl/u8R7QL8LCVWd4RdvK+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120500; c=relaxed/simple;
	bh=n7wgW58QvGruDrxcgPHZ72/9XELas9m3qnwPa8llWsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAJZQv5nu79xzHONyfjzrZD9Jy/+Cfc/781ItXNip6LzdiKxucVfjEFyGVwuX7ScowBKgkrrdRD0yxnWPvLXJSsiQMa26GtPIuj9iA48k8iSQL0ApaFRC0mX/IDU26kUQcMaiC85hcYtKZUC4xY3A4ijEkR6kGP1tjHHVJeAExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPd6yaiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D636C3277B;
	Sun, 14 Apr 2024 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120500;
	bh=n7wgW58QvGruDrxcgPHZ72/9XELas9m3qnwPa8llWsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oPd6yaiKERZRfVPjEQ6paFa3Eued9/3Zifbwe7+YeE4e533+9/koXTx2XhCt6kRit
	 EQgi+4+k7govpa6V9WlHHpvihWLlkvbrFif2qTCCV5ABSe9Qf+mIy1LQd7vR0s7G/O
	 DWpNAjy6OMi7KvQgNR7Jx+cVOQelggwEvINbHWWlwEqh65rwhCHM+eF6CRn4RHqHBN
	 qlMXJyQdEjJhVmNOooyGx4bgNEWpTD4o4gT99mG2Ct3oPuPpcHCHPDqGT6Am0+hEV+
	 GcARU4SBUVRixOBB+8/l918GpHJe8hbVkU4v4L8V1TwfQDkmQQUzi6CoDaHaP7D681
	 apGvQQcm4JetQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:29 +0200
Subject: [PATCH 04/14] ASoC: SOF: Constify stored pointer to
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-4-8f53ee5d981c@kernel.org>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
In-Reply-To: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=krzk@kernel.org;
 h=from:subject:message-id; bh=n7wgW58QvGruDrxcgPHZ72/9XELas9m3qnwPa8llWsk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTHoHVG8jIRMuSyEz6gw6s3WlC+CMzYEr3rQ
 MYLccCWoXGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkxwAKCRDBN2bmhouD
 10RkD/9D3WRc5sgDCLrfb2gtoEJht5UdUfaYqmyCGnC4zF64/kGjFd3mRP0+XjHAYrAPJU2U0ev
 +aMgqK7guv6mDoeOaa1DIa9L+PQMlTnOwx/s5ZtUTvx/nSFrNhx4Yppt30QM3m0xsPtaKnc92HS
 mnvNs/dTZ4EcY9wd+VMwlxUEOOI9IJIGC5qZlh6f3eJuMx7q6Q68yiFUh/mCf2vQ4Q8cE7WK06S
 sxKQgICNKHgU5BO5szTlIoxYC9n7uu4Xlpdlf0VDPFPjsDLV+gK/bkpTkHirHXP6qRew9nqfg4t
 ilQ6oHvKLZ2rU/eyZD5bpFL06PLMMkFSNlAZVo4sSlXVpMG7/j/sQJUm4fWjTDIzIZi9Gzqp9Tl
 o4g6viiNkC49EkHiYKdtjsC3Ib3pczn2pmoTm6q6Vz8N2TCGcFS2CabtiKFKIdzkhRMMFi62u33
 2JdLLGvqf0q205Ytt/yYUVQzkezPBRMeqESRUD5PqelX+RkYSaHz0ktt0Awm0Ox2QR4aV7dCohj
 JBTrq2cR56i3Z/RD43Yz1kqtX1sMVaiC00QKUBDnMp7DfMe6bBcfvKXpwHRNjnvSVD06XfLUkO0
 h5lIdUzl6YlPnPYCvpHKxiUWwDBc/i6Dy+gUZfz06k669fkV21AYu3fspJ4Kt64ccqjp0spzr+7
 ngqZjikSKjwv0iA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The core code does not modify the 'struct snd_sof_dsp_ops', stored in
'struct sof_dev_desc'.  Make the pointer to 'struct snd_sof_dsp_ops'
const to annotate this, make code a bit safer and allow individual
drivers to also define this structure as const.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/sound/sof.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 05213bb515a3..780c1a755917 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -166,7 +166,7 @@ struct sof_dev_desc {
 	/* default firmware name */
 	const char *default_fw_filename[SOF_IPC_TYPE_COUNT];
 
-	struct snd_sof_dsp_ops *ops;
+	const struct snd_sof_dsp_ops *ops;
 	int (*ops_init)(struct snd_sof_dev *sdev);
 	void (*ops_free)(struct snd_sof_dev *sdev);
 };

-- 
2.34.1


