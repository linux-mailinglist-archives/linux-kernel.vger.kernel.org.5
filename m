Return-Path: <linux-kernel+bounces-11207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7481E335
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB20EB20C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F344368;
	Tue, 26 Dec 2023 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l08BFTo2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933D44364;
	Tue, 26 Dec 2023 00:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29513C433C8;
	Tue, 26 Dec 2023 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550059;
	bh=zF4otZIt+lMUKIFWNrITLIV7/l+UmEx2S5/AymxJq1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l08BFTo2vnJ1VwaVcbAYhfG4i/dDZUUNqr7f9m1P5p/6qDuYMbGX4kQPtQT7NddYL
	 AbsmWaZhcb5isyprhOqRavtAc4YT+c3Nw5/W0TCm6tRCNo7A4QNb+jBFVL/093aP4m
	 xY8gK72trYG7lPcQqPHKc+XMM978ucWlQjHoOZxcLkZOxqd8jT95TnoXh62CA/cD26
	 5xdJG21hpSpA5r4nWUJezRR0RvV717tJ3lkTzJJz/LtDw6bGUDszW54XxFv6YcDHke
	 +vit+IZk10W4JfbqvN1w+KYCyUy3Hx9xhzvP+xnT+wkkBIkOlGrd+H9WTsUUGsfN20
	 qRjOR96HCZcOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	gregory.greenman@intel.com,
	kvalo@kernel.org,
	benjamin.berg@intel.com,
	ansuelsmth@gmail.com,
	pagadala.yesu.anjaneyulu@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/39] wifi: iwlwifi: pcie: avoid a NULL pointer dereference
Date: Mon, 25 Dec 2023 19:19:04 -0500
Message-ID: <20231226002021.4776-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit ce038edfce43fb345f8dfdca0f7b17f535896701 ]

It possible that while the rx rb is being handled, the transport has
been stopped and re-started. In this case the tx queue pointer is not
yet initialized, which will lead to a NULL pointer dereference.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20231207044813.cd0898cafd89.I0b84daae753ba9612092bf383f5c6f761446e964@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4614acee9f7ba..586e1f860c169 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1385,7 +1385,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		 * if it is true then one of the handlers took the page.
 		 */
 
-		if (reclaim) {
+		if (reclaim && txq) {
 			u16 sequence = le16_to_cpu(pkt->hdr.sequence);
 			int index = SEQ_TO_INDEX(sequence);
 			int cmd_index = iwl_txq_get_cmd_index(txq, index);
-- 
2.43.0


