Return-Path: <linux-kernel+bounces-164970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087798B859D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3603F1C218C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDE3A1AB;
	Wed,  1 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tINNV4jH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF97F;
	Wed,  1 May 2024 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714545509; cv=none; b=G3SxsJnwaimFrkxyChK2zvf7ujVuanWDv5Vn8AysFsQGJJ43OwqdXTs5ialLOlolYO+FzQN0VvcPjtFEBdswCSmvd7a2ld9C0+s41D3HJcKJaOsKhtPzzGWRuo5hrwsCgn/MoRESZmdYQA01epc3X688dWe03xKy4V3cI4cVyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714545509; c=relaxed/simple;
	bh=GgOMexD4ak2pHmlX701c4dP3+z5taFdQAY8Z5LSFuVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXkU4abWEmrmYio3F6IDnKebN/hCqmtTg5Zia5WihBF09v/RLWbp+RFh8Qblkyjh4qK0tOmWRoVEam8JI48ENBIqT3Zofrn/zxIr+ty2pSJ0cQE5hchg33TknLMCDsgK3083yxkSog+G+bfbJfDWw0A8kx/Rz3GP+QOkhHwfhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tINNV4jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F10C113CC;
	Wed,  1 May 2024 06:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714545508;
	bh=GgOMexD4ak2pHmlX701c4dP3+z5taFdQAY8Z5LSFuVE=;
	h=From:To:Cc:Subject:Date:From;
	b=tINNV4jHz9NQ3DFyT32nHJ4RoB2Lo5Jm9HG0hOY19cca7iA13OaeewMUbpKx5/u7E
	 GkT7rnxqtcqqRmVKfef9NG+S8cu1llKbBDTKcc+2EEpZd78r+dYj7ArlFMPip6fzWB
	 /8i+vr7BV8prQGAJYZIQIhovr+DYX8k79n7tI1wpJcKcwXpvM9gswr8xOEQ0J4SjVN
	 MMpd+bbht1wJ3saAeyuv3E2VFj3rVMnclYAFNWFRbI1YXdCvEZDVW8j+EYkwvcHqNd
	 Pr213hfCPNPYXKcF5nkbMhcETK1MW1KMbL1uPrxlYvEYLAG8OZ4zbLSKg7GRb9viS3
	 fb8bLIYjKhhpw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s23bp-000000008Ly-3o1R;
	Wed, 01 May 2024 08:38:30 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: fix firmware check error path
Date: Wed,  1 May 2024 08:37:40 +0200
Message-ID: <20240501063740.32066-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit fixed the code that parses the firmware files before
downloading them to the controller but introduced a memory leak in case
the sanity checks ever fail.

Make sure to free the firmware buffer before returning on errors.

Fixes: 6fb81c405bfa ("Bluetooth: qca: add missing firmware sanity checks")
Cc: stable@vger.kernel.org      # 4.19
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Luiz,

Sorry for not catching this before posting v2.

Feel to free to squash this fix into commit 6fb81c405bfa ("Bluetooth:
qca: add missing firmware sanity checks") in the bluetooth-next branch
if you prefer.

Note that the commit id in the Fixes tag above won't match if you cherry
pick both commits to the fixes branch.

Johan


diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 125f140e012a..59e384fa1a0c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -676,7 +676,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
 
 	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
 	if (ret)
-		return ret;
+		goto out;
 
 	segment = data;
 	remain = size;
-- 
2.43.2


