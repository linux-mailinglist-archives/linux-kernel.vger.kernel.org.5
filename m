Return-Path: <linux-kernel+bounces-73299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC085C09A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401EE1C22E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B578B74;
	Tue, 20 Feb 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaFLIczn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318078B62
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444914; cv=none; b=pJlRwRuRFWL0Y4iD7Ua/9yRBuzpYmv4odou9Rb4DZkEyj4tDZxIUNoM6EZzrpvsE+ePUIMnNefUmrknDTdzc5B5BQBid8aNSjZO8vUp0zDFVWbeSp76YGBfTlLxEj6xpjx4GggUTvOMA+2pPtPWHSgZG3xWW7ruaGj2bn9cNzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444914; c=relaxed/simple;
	bh=bjw5M0Bg5Q4a2AeJGBArD9cWV2Am4IdXIRrTLz0HAmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jt7Z70nevb/nFozFQyo7eKxJEjQtZeSdj0bLHvvc6F2YNYMBKuvbdXHm2gYnri9hfcKlPNpup3cFFvRTXp0MUN80iYlxz+azxQWafDmBnC1ULj+Te6Cd040yS1W4eQhudHGvxstFR1WZC6YV7PeCMHag7y2VQvydCDHjFg67ovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaFLIczn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A5FC43601;
	Tue, 20 Feb 2024 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444914;
	bh=bjw5M0Bg5Q4a2AeJGBArD9cWV2Am4IdXIRrTLz0HAmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaFLIcznFHO3DUJ7vomtekSwlbGjdVSWLcXLl7iz4ut7cwN/squHMDEVR2UDEi59n
	 ndUpxr4F6NUoSTIjHgG8NQk+GpxF06raIrvd6jgbx1+z5HpNPxUUz4JBVvI3lWtlAW
	 TLGIq1DC7gNsE/1C+YNw5397p1xanTt/s5hcCk8vo+NW9BDuBuwliD+WUJm+Moqt8k
	 nGh6VvXLPtDx12piuoKbWXEaF/GMcuNTKrK4yXulKiLIE0rFX8qrrbX3WfrldbqIUq
	 iZCVnCWF1/vyI5nr4CDBNV1HZwpR3tefBY9D7+ZHTUesask+bGTzXo903uHZDzIzOr
	 oScpFMr60AUdA==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 13/13] accel/habanalabs: modify pci health check
Date: Tue, 20 Feb 2024 18:01:29 +0200
Message-Id: <20240220160129.909714-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ofir Bitton <obitton@habana.ai>

Today we read PCI VENDOR-ID in order to make sure PCI link is
healthy. Apparently the VENDOR-ID might be stored on host and
hence, when we read it we might not access the PCI bus.
In order to make sure PCI health check is reliable, we will start
checking the DEVICE-ID instead.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 3b9e8a21d7df..8f92445c5a90 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1035,14 +1035,14 @@ static void device_early_fini(struct hl_device *hdev)
 
 static bool is_pci_link_healthy(struct hl_device *hdev)
 {
-	u16 vendor_id;
+	u16 device_id;
 
 	if (!hdev->pdev)
 		return false;
 
-	pci_read_config_word(hdev->pdev, PCI_VENDOR_ID, &vendor_id);
+	pci_read_config_word(hdev->pdev, PCI_DEVICE_ID, &device_id);
 
-	return (vendor_id == PCI_VENDOR_ID_HABANALABS);
+	return (device_id == hdev->pdev->device);
 }
 
 static int hl_device_eq_heartbeat_check(struct hl_device *hdev)
-- 
2.34.1


