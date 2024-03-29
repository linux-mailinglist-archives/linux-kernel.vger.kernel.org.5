Return-Path: <linux-kernel+bounces-124491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15F68918D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAD1C243FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5287513C3C2;
	Fri, 29 Mar 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccOYJ0xM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73C13BC1A;
	Fri, 29 Mar 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715229; cv=none; b=sDJWsYjydBRajlOxvwCBBpYJVA9kegAkR8gtwecSrf/DyteVFQ8xBw0GpZmn9WDFIqbCva3MgnF4bLoRgkt9rmNiM2aQuScoW5PYOA+ebzHbGDxSZQdG3oCYQM/ScEprXgWWN3RSkAsYFMRwUuLEO6HTK/hgLZVXEWtC82VDd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715229; c=relaxed/simple;
	bh=iTtPs1UkYDCKErrw7S7VcrYNg2NXuh8ZRHig070AaZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooJ+OxEcRNoGPFdiB7fHzMrTdG811XTddnqa1dlJMH43Vzt4aY1eTtMYR0Z7v1NePce/x82rRkKGcFGf9oa03GgWwJUy2LQ0w7hEMeOfvBUV51MyeP0r3ReNAfRdEUKPf4jP5dZrv7p3b7kBLQEqxDtdu222A/INDiDxaPFEY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccOYJ0xM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C5BC43394;
	Fri, 29 Mar 2024 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715229;
	bh=iTtPs1UkYDCKErrw7S7VcrYNg2NXuh8ZRHig070AaZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccOYJ0xMEKwRBgbtYnB6IU/Setv0AvVf+xYCbyIgyLwwZrt4sEOQFUMDaQe7MObVI
	 V5XzTkI99aTz9cqgRD6DnXNb7lBz52op40rJo1GRPw2obvUl7i1jv3XkSZYcpTfxWa
	 zVStWXG8uHMw/w/S+T4M0FzbYzUJIMhc4x9m/Z/LJXISK4st+wILvnqKTvMgkoMwX+
	 6sKGwF1a6cIo3R7fPCV9lgFOKjzSWr60RDJKbXO13zZpZmBMiTaiVLu9pEF3udz0qC
	 mNo8KDK/ncYTu9lnHnSU7WHzwv7DXvzCV/WeQoXAZ9ZweCnSZ7tMYrxb7smYs4dwkH
	 wGvnjGgld7hxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 10/68] wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor
Date: Fri, 29 Mar 2024 08:25:06 -0400
Message-ID: <20240329122652.3082296-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 83a36358504f4..772a84bd8db6b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -996,7 +996,7 @@
 #define RTW89_PCI_TXWD_NUM_MAX		512
 #define RTW89_PCI_TXWD_PAGE_SIZE	128
 #define RTW89_PCI_ADDRINFO_MAX		4
-#define RTW89_PCI_RX_BUF_SIZE		11460
+#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40) /* +40 for rtw89_rxdesc_long_v2 */
 
 #define RTW89_PCI_POLL_BDRAM_RST_CNT	100
 #define RTW89_PCI_MULTITAG		8
-- 
2.43.0


