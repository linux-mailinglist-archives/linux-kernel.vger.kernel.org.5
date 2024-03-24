Return-Path: <linux-kernel+bounces-115689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9DA889710
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC751C309B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA922257FE9;
	Mon, 25 Mar 2024 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9eIqu3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4526139581;
	Sun, 24 Mar 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321633; cv=none; b=ur3po0aYY/G1wUhWyhDmvbrtig4/2F0xu8WiQ1UvF8g3WoXKOT4zDmSlvzHpBJLbLS26hIlHT32uh23oj8p7VLiSUZ2kCrAir43ZxSXA/KYLS92DQHFcYOys3EX+IfRDOvcxvr/eSJPY0WpJd9P68zIVfm0hCVl9AY9lIYU9qjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321633; c=relaxed/simple;
	bh=YAyf/zcJ3EcipuXFZPJaTEX6O9w5ToHm7vdXp2Vnz7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NchSo6p+RnPnRK31x7ym/87VT8poUdfEnX5gMEBbG3qiYNUuuUkI3pXki/+hn6z9OCXofExKjMswgo12ZSV9aVRkQtVDpSxuTg7IHrEoQhKFttmuNfPRrt3m00K2nGjoQs5tUYuyCrbbPBKatvFPTnUTrodoCsmceVEjgv+F2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9eIqu3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD8C43390;
	Sun, 24 Mar 2024 23:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321633;
	bh=YAyf/zcJ3EcipuXFZPJaTEX6O9w5ToHm7vdXp2Vnz7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9eIqu3Sri09N8wl3Lm4mcBYEtvSJDlUR6CGLWzTLHGIUR4pz/u/NimMR7DXcI54w
	 muK9bnHlob3wPtt+ivw0ObEEzwoMFS6WmTFT2oh0JQAMJqDXuL5RBqdLQfhwsRvXBa
	 1OKt0LuMKJusbYccPPbh+L6V+rQ1XF2eiShtemwegw7PdJ7BeSNO7jWvBm4cGZRFQe
	 CcT0Nbu1GrL7L2gt3apExUcSoe9gOzZrgmTo1hflpJh5+1sKIhfcbAmhmfOESowLpE
	 GA50QWeaJ4KwSostJeoFAw6o1odL4uV4YihLry9N0RmB9eSOvbc6x2eoMG/rthOGAx
	 ru9OHEy0zwNog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 364/638] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 18:56:41 -0400
Message-ID: <20240324230116.1348576-365-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 6568d82512b0a64809acff3d7a747362fa4288c8 ]

The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading from
the first DWORD, so we print only the first PIO TLP Prefix (duplicated
several times), and we never print the second, third, etc., Prefixes.

Add the iteration count based offset calculation into the config read.

Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
Link: https://lore.kernel.org/r/20240118110815.3867-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: add user-visible details to commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de416..b4818007788f9 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -230,7 +230,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
-- 
2.43.0


