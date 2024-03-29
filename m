Return-Path: <linux-kernel+bounces-124608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A215891A87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CAE1F2554C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A246315AAAE;
	Fri, 29 Mar 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNac0YUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C115A4B8;
	Fri, 29 Mar 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715535; cv=none; b=ToyP4RGT+4Mpb04NxM2t58F+0QqM9bud3up2a9JhWnXYNcfLGyDkdKCii3ov7mDTfWNJlRCuAG2Ep5bBpG4khv6Bqvmf2MWMzdMhRoE6LHwdgz2rYmhSUlNaP34V1nNhq8ro97Uau+6EZwL1yKB56fSjq2FW8JQNQmSC/3GTmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715535; c=relaxed/simple;
	bh=hfeqKvdcam+Hx23J93TUs+OCkyZddn32IYf69gkKRwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URMOeZ8h+64WWE9pENp9LgYmlakGwcU5vvfyvi4IzWbJqmIbXxWOnOC1MUoyIfDz0/Cn9urqUe9GzTqibgIZJIIr6266y/jLvtpA7byXBduPPNbPx9SrAoO56Qx1kHsn2Za7HdVu5Rq7NiH+z47hQhTlOi/FR4D3IYpslFjNiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNac0YUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0BC433C7;
	Fri, 29 Mar 2024 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715534;
	bh=hfeqKvdcam+Hx23J93TUs+OCkyZddn32IYf69gkKRwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNac0YUQ/tkaIQDD4xSXGyGmbg/zrVsd2LTQ1IdeGlSXlL2dFvKO3W1bbPYPvSKWe
	 11Rk6NOzwTr0ipno9Sb42oMrnKQeLzDpd9BjmGWpct/OqOex9OSPLDibXsFX/ETtEp
	 +rspgFnGI+hkVkITczfTagTWmQHAcXdjpp4R8TZPltAyuT+i8fF4aaHQgjh+LEPpZ3
	 yTMIqGmXHVA9cYRMeikT59JpMNAspKczMYOvDwfxUVlsQAXIbid5jTtFtOKhpT5GVY
	 QdZzwso1/QgyUf54f+rnGbXGJ202QAK9A2NqiP3sFIZkwwd22cIO66O96U7NApCWEy
	 rtnvUhyf5WY9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/31] wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor
Date: Fri, 29 Mar 2024 08:31:24 -0400
Message-ID: <20240329123207.3085013-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 179740607778a..d982c5dc0889f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -546,7 +546,7 @@
 #define RTW89_PCI_TXWD_NUM_MAX		512
 #define RTW89_PCI_TXWD_PAGE_SIZE	128
 #define RTW89_PCI_ADDRINFO_MAX		4
-#define RTW89_PCI_RX_BUF_SIZE		11460
+#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40) /* +40 for rtw89_rxdesc_long_v2 */
 
 #define RTW89_PCI_POLL_BDRAM_RST_CNT	100
 #define RTW89_PCI_MULTITAG		8
-- 
2.43.0


