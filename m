Return-Path: <linux-kernel+bounces-124558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE88919ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2261F24D34
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E78152181;
	Fri, 29 Mar 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwlOfhRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F45150997;
	Fri, 29 Mar 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715409; cv=none; b=kzrKEm0BsQ1j2nuuatoiH9hPwXoM+f4Mjd+T1NDYiHTx/ybq4Omf+o9JHV8HsEgjvO7DfpmvwKTfZloIVAIUyRghOFfhsfNHIXm502C7SXVueWF3Qg/i1BHh5ULn1XgQMG/4pUh/4aqXMVaC4PTWl0BqDwCbwYJ5+zyTVm7wuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715409; c=relaxed/simple;
	bh=WasJpCSSIFNcR7eK7Br91kvJYRBw+AnpK17WiTx7Ozs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quDTX8yhj+UJ2J6Snyh/w7ahCkgHtaMWfrULHVdzA53fcDdwGjdaqLDdXGM7F/pgytz2ZHSvVVkQZlscw3iv2ZkgwQdv3eCra4OQqm+WnoPNOCKlltRcs7fgnoW2Ywl58eKbldW4ev/aGyVT7mHe+szMOmmJndDCMFTm7uDijNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwlOfhRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315B3C43394;
	Fri, 29 Mar 2024 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715408;
	bh=WasJpCSSIFNcR7eK7Br91kvJYRBw+AnpK17WiTx7Ozs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwlOfhRa2cbU9FfB6d47vbAe6gP0t8eAJrho0LCUo13uRdp3TSNr8KtbB7VBvd9G/
	 cFqo5nQZlPGsN1rtNwGQmcRpHZDIf65dltS4ZzZEEkOjK84KpzEK4V1y6fCLByxSGZ
	 a0g7FG+jFyFg2XEZp08f6ZsJlZ4FOoesOC1wJ2mmw06iZoHFZ+J31RkOeaHmEdwhUW
	 RCeU2WATrBUdqjb83fM8pOmCFl42Iqeafi66JRMtBII4GdcewpFFHstMdQnh5HSvMo
	 6DuJh7VRaEaUB1AEWbNvqXeETPaxRUbHs5LWBuMecwpKpjj2NFSzlITLvReha0fHs9
	 HPv1nHGzbuvWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/52] wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor
Date: Fri, 29 Mar 2024 08:28:38 -0400
Message-ID: <20240329122956.3083859-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit c108b4a50dd7650941d4f4ec5c161655a73711db ]

Hardware puts RX descriptor and packet in RX DMA buffer, so it could be
over one buffer size if packet size is 11454, and then it will be split
into two segments. WiFi 7 chips use larger size of RX descriptor, so
enlarge DMA buffer size according to RX descriptor to have better
performance and simple flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240121071826.10159-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 2f3d1ad3b0f7d..4259b79b138fb 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -559,7 +559,7 @@
 #define RTW89_PCI_TXWD_NUM_MAX		512
 #define RTW89_PCI_TXWD_PAGE_SIZE	128
 #define RTW89_PCI_ADDRINFO_MAX		4
-#define RTW89_PCI_RX_BUF_SIZE		11460
+#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40) /* +40 for rtw89_rxdesc_long_v2 */
 
 #define RTW89_PCI_POLL_BDRAM_RST_CNT	100
 #define RTW89_PCI_MULTITAG		8
-- 
2.43.0


