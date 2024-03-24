Return-Path: <linux-kernel+bounces-114814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19288916C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9798292619
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5342BEC23;
	Mon, 25 Mar 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUVAY+yl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38817652F;
	Sun, 24 Mar 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323430; cv=none; b=NDAcrrVey1tK/7N1qvQxlXwgevew9anvMIdSySBLjZzSgjWBWn++tK/6QytC0Dpxyu+wZSBRH0EQgHg++EWfMmne9+d8pAHdLJw3pttuXyWP85QthraJCbIBlynBFsy5lmsENVqqUXDbQ/gvkaqLcuY0JUmE8tAxyU7iQHJEz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323430; c=relaxed/simple;
	bh=qWPlS/qcsnHUT0bA+3xVg1Wjvy8As0j+UUf925zBuOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGFNmtsECbAVl+2ibi+3BLzTkHgvOb8uxzDMYpdX0PhyhSP11KYJlY0ySoHumpAYMpibUkVd7c+sM1uolL0FQ+0fiHHnkhfQqEuKVhcHG28x2Bmjm7X8qmT0Cu99CgFUiV+L93QiDTMmavuoq2oZXalCBV3gwz2glDy6AS8AXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUVAY+yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60912C433F1;
	Sun, 24 Mar 2024 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323428;
	bh=qWPlS/qcsnHUT0bA+3xVg1Wjvy8As0j+UUf925zBuOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUVAY+ylvpbaK1JFlwu9YeY5LHLCNMov3GZEzNj6OHaWAfnnUQmF7ra80V7GNciPW
	 S6pcnqRWuWliYUwiOzzPqt3itmPj/4MbIms9b+7GVb7vCWnq3NMvvFWvh1G/W/Ct3f
	 XnBnnaJxwcmhOuhjZNb1q2SpmxyI6S5uf6vLl/lWWiDQoo/w7PTQ5n9Ek7vbTGVriA
	 C7LSnIxakDjI61n16jOwZYRNq86vCgEFTsRZsSkDSz5oEkb9hOcjXGzhTWfSvELaOU
	 5tKojFcGB6bYs0EzvYnNd+vqTleX7HaKRTcdwspefwQmCz/61BRYuKjsHHwExGolQq
	 lwV3u0B5zXlBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 131/317] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 19:31:51 -0400
Message-ID: <20240324233458.1352854-132-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 81137162bfaa7278785b24c1fd2e9e74f082e8e4 ]

struct hci_dev_info has a fixed size name[8] field so in the event that
hdev->name is bigger than that strcpy would attempt to write past its
size, so this fixes this problem by switching to use strscpy.

Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a8854b24f4cfb..8a3c867bdff03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2187,7 +2187,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
-- 
2.43.0


