Return-Path: <linux-kernel+bounces-27940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B071E82F81A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A507F1C24BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE712CDB3;
	Tue, 16 Jan 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/rrjHoS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98F12CDA0;
	Tue, 16 Jan 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434627; cv=none; b=L70pfo29+BR/LuRqwq0hzZzXMkm8V1IxCou+gNSoVdPR0cRSstKa2m994K/qfX36hrdKgSxcQnfEGs5BIU79buLMfHickbJmjnKfLDZk70EtE7ZlbRlsJrG0gkL+d/YJ1BEtubVHW5C85oXb01vpAnsqijkqYEccY2v3OCpdD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434627; c=relaxed/simple;
	bh=DLXBG8JCaa5ys2bFtaKoPSzsBxvXML071j0o8lBy4tY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=EoWw71KGnXuFwYEjJm35U1EladG/q7V5fx5oM88V/8v7GpGhruy68Eiqt0o8trKedwgJ95kTW+snI5duRpCNWuAZr+4aBXqvR8MFaywOPAV8yWUS8V5ekyyhhVjzVnUBPFIjCpRA+75vxcNrqxlMCPpGBSrAVTGv/Z7BLOn92Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/rrjHoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F63C433B1;
	Tue, 16 Jan 2024 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434627;
	bh=DLXBG8JCaa5ys2bFtaKoPSzsBxvXML071j0o8lBy4tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/rrjHoS2n94V5KVqNbBUeLK0FxLVEhtaOmx1x1yscIwhqvMeiUR37Xc7gkJHRmtn
	 pSi+VXK+ZYad6Z0FtjpT568SymwTlzEcNCB9ptuVgY7rfeBpFD2wSsMdUx2M/oFSLu
	 nZXY3v98BasbONdrp3ks3xUM30xkusRj+JRaEwIyRLoiNC5jAvu7o0AtrXmMpJrzMU
	 00sOnUPb8sIXtCsVOVxMwzOGP6zZ4g+NJKiqFs0yDCPTJNLGZwdyqGlbH3oZTGbwq/
	 XRrRL43219arfQx7ahXN48zpzwUFp2Q8/KwmRhbCx2kM2FjqI2u5WXRz0vb2J8WmBM
	 Z39o5O0g2VDYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 032/104] wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()
Date: Tue, 16 Jan 2024 14:45:58 -0500
Message-ID: <20240116194908.253437-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Minsuk Kang <linuxlovemin@yonsei.ac.kr>

[ Upstream commit 2adc886244dff60f948497b59affb6c6ebb3c348 ]

Fix an array-index-out-of-bounds read in ath9k_htc_txstatus(). The bug
occurs when txs->cnt, data from a URB provided by a USB device, is
bigger than the size of the array txs->txstatus, which is
HTC_MAX_TX_STATUS. WARN_ON() already checks it, but there is no bug
handling code after the check. Make the function return if that is the
case.

Found by a modified version of syzkaller.

UBSAN: array-index-out-of-bounds in htc_drv_txrx.c
index 13 is out of range for type '__wmi_event_txstatus [12]'
Call Trace:
 ath9k_htc_txstatus
 ath9k_wmi_event_tasklet
 tasklet_action_common
 __do_softirq
 irq_exit_rxu
 sysvec_apic_timer_interrupt

Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 672789e3c55d..d6a3f001dacb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -652,9 +652,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
 	struct ath9k_htc_tx_event *tx_pend;
 	int i;
 
-	for (i = 0; i < txs->cnt; i++) {
-		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
+	if (WARN_ON_ONCE(txs->cnt > HTC_MAX_TX_STATUS))
+		return;
 
+	for (i = 0; i < txs->cnt; i++) {
 		__txs = &txs->txstatus[i];
 
 		skb = ath9k_htc_tx_get_packet(priv, __txs);
-- 
2.43.0


