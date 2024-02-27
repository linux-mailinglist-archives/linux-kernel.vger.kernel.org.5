Return-Path: <linux-kernel+bounces-82550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5967F86863E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9471C238FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7875D53E;
	Tue, 27 Feb 2024 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5VWn8dP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1A2916;
	Tue, 27 Feb 2024 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998349; cv=none; b=o/yMwPzMqufWkUzk/rjBp6W2M44mlXauMqRiTdTKy3bUtZVnHCk9CJJ+3Y8Ia0dYe1MWQpTa8DK/CQx3Xk7K83++FX6uy0LP99NG6K1C/Cpkx+S3fJQacJMkdRi9hgC9OZW8nVUcay+rOetq1JnPK7I78M7VepbbVBwzWFTogOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998349; c=relaxed/simple;
	bh=SCXTahozD0TxiPX08IBsjicUaCXkNVF/+0u0TFeGY0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gFVcC15jdQlKc9qpygUl5zHFTgUy2K3GwCz2IoYj1PxGT4yiC2dExQxOVidKn8eSsBBSU1sAR0ZZ1r/SiI0xx8PRE0xRp4KRLKzxXgPqOjUdjuJMN5+RpzpATo0K1HSd8s7wo0gxovmvbSipjgrdBnAIyIQwHtLhhYGa4TDZYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5VWn8dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91AB6C433F1;
	Tue, 27 Feb 2024 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708998348;
	bh=SCXTahozD0TxiPX08IBsjicUaCXkNVF/+0u0TFeGY0I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=T5VWn8dPeHK/BBBoReSynEEv2vsnw2mgT+50PP5WMZn5QWRppdg3qhNAtJWbVG8mw
	 K2qZXAuICBrlc4chwCrYja/aWcxhztOBun55O6kdCGDPnt7nMywIX2xe0/Ev8KzFyA
	 TzxH9xeeNsFGfC6+U0jBvGZzWPiSubayJsafM68G3BYVg9a5uq6ePqLOVmhb2YKDMz
	 ZoXpx7xEF4SQghz8q/x5yxByMhwaWi+7/vlRfTlnrXZFQeoIPiDM3a+8OPn9bLivfU
	 qyN123mGd6GlLAcE7qiKGbUNiE2GptW8L82QXeisl4DEuraUijFLwkK7la6UE/2Nwy
	 dCq5Wgr7oNZuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB0C48BF6;
	Tue, 27 Feb 2024 01:45:48 +0000 (UTC)
From:
 Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>
Date: Mon, 26 Feb 2024 17:49:57 -0800
Subject: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMQ/3WUC/x2MwQqDMBAFf0X27EIMbWz9FfEQ40tdaGPYgBTEf
 zd4nIGZgwpUUGhoDlLsUmRLFbq2obD69AHLUpmssQ9jrWPNvzUvjOTnLzhsmqAc5c/hCdNH9PP
 75ajmWVH1vR6n87wAZf/r0WoAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
 stable@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3004;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=8TOgtVhYO01rdpfAVMwK9WI6pflXIuB4DQQcEbm8Zmw=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBl3T/r3KXQprzkHna4SseXUKD0ooMTxVhZKDW9m
 mWQ0+8CJmiJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZd0/6xUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUW4w//YlZS5dc2FBsqrTddOHzidbibnEQwzDs1tWPmyqH
 jKcngixr+2OP4XYmR/HEBprSaEe/UXls884Ema6ucg5EQtpOIrMqfxWHEptQljfkVwuhHxiav5y
 hR9pSDgBfIkmZYnlp+AI8VM+pQyqQB3nTZ0mgu1YTxtEIomgOZ8ifzTXMPvSrtWtU0pEXDpzE8y
 amaeZShoEQMs238EpgfWhbFTKWqPlUKCdVmjyjIZ/TAnE4haRDpKnCInDvpGaTXJSeK+X1cdzAu
 Iduu4QSFutGx/mTaLJF3I4UqWzUrFmEy/apAtGhOGnpNTkrAjR/euygJQY9OREp0OEvM+FEfjzj
 yn0Xi/zNqMBnEzn5vd7340NM6wSq6oHBJp9dmzLyIAimCcN9A5z769c8SZ+hacWXEZlNqdizJ34
 Wv8iaWi/Rkzc7XUG/Tlx+jtdEqS1313uA1f3HPDfr3VtQ+mN4t7Ex3z4qLFKaslXbunA4AEBLK9
 INzGCitwuDBUSh2NtR0fu5ZOAiQCb7g+gIMON1aDQcD39lbnwfX8rMxYv9zNYZvtnr7z4NbUkAF
 0G/5IeNCRrIoQ42hHlRhVCkG5WnjZRGZbgLEIxHyxLHVUnNPXs+bCCftycKzr4BIUDfIK9W4TGz
 /ltQREquxuqJMmPH8tYwmHjE2s2CdDyeBQHzWutRavxA=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Endpoint-Received:
 by B4 Relay for quic_bjorande@quicinc.com/default with auth_id=118
X-Original-From: Bjorn Andersson <quic_bjorande@quicinc.com>
Reply-To: <quic_bjorande@quicinc.com>

From: Bjorn Andersson <quic_bjorande@quicinc.com>

Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
the domain")' aimed to make sure that a power-domain that is being
enabled without any particular performance-state requested will at least
turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
required-opps properties.

But in the event that aggregation happens on a disabled power-domain, with
an enabled peer without performance-state, both the local and peer
corner are 0. The peer's enabled_corner is not considered, with the
result that the underlying (shared) resource is disabled.

One case where this can be observed is when the display stack keeps mmcx
enabled (but without a particular performance-state vote) in order to
access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
is flushed the state of the peer (mmcx) is not considered and mmcx_ao
ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
several times, but has been painted over in DeviceTree by adding an
explicit vote for the lowest non-disabled performance-state.

Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
Cc:  <stable@vger.kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
This issue is the root cause of a display regression on SC8280XP boards,
resulting in the system often resetting during boot. It was exposed by
the refactoring of the DisplayPort driver in v6.8-rc1.
---
 drivers/pmdomain/qcom/rpmhpd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 3078896b1300..47df910645f6 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -692,6 +692,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int active_corner, sleep_corner;
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+	unsigned int peer_enabled_corner;
 
 	if (pd->state_synced) {
 		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
@@ -701,9 +702,11 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 		this_sleep_corner = pd->level_count - 1;
 	}
 
-	if (peer && peer->enabled)
-		to_active_sleep(peer, peer->corner, &peer_active_corner,
+	if (peer && peer->enabled) {
+		peer_enabled_corner = max(peer->corner, peer->enable_corner);
+		to_active_sleep(peer, peer_enabled_corner, &peer_active_corner,
 				&peer_sleep_corner);
+	}
 
 	active_corner = max(this_active_corner, peer_active_corner);
 

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240226-rpmhpd-enable-corner-fix-c5e07fe7b986

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


