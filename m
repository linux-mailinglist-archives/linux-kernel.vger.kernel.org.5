Return-Path: <linux-kernel+bounces-114344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06720888FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37ECD1C2C079
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1525171E48;
	Sun, 24 Mar 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejLNnlIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6513B2BB;
	Sun, 24 Mar 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321732; cv=none; b=WXJvi4Ff1ATNCxxJAy5avq+tImbTlKxKiukwKRI+FldSeJUyIzrmWA6oAaJcR8AGdKAnNBGdecb4xLBPoI/scuXkpzM+CSF59nYnSHZfac8vugnstyBlV0QlDeDaKe2asDFJzmdOfDVYH2QTQJEZHCn/bnpH/M3mTJah86a2jTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321732; c=relaxed/simple;
	bh=kHv9No8I6LDPw0P6eGHj7N9MFtUF53asyk1Zu9Yl0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRe3vEJJSvQwuoFrnlJRsiD3aub3713Fu0B8qLm+MLGwoVmDS0Kr6w4dAO1kZoj/V0K9mm2EFd+1rdM5H1GnJS5GV4y2lasqLRUYAcivRR5+FHq9gUiI3StagQTls6MNoRJaRO7q0eoL4MuxKM+Tb3+3iAvmdmN1ORyWgrpECmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejLNnlIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD4DC43399;
	Sun, 24 Mar 2024 23:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321731;
	bh=kHv9No8I6LDPw0P6eGHj7N9MFtUF53asyk1Zu9Yl0Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejLNnlIhWEqEYUI9xdwXnrKKJyAQoHa4u+geFUPAqBlA8Z8G9rDykRn+GoWWBHU8+
	 kiRdmU4H68aLNjbTwqPLkcfEbqkC+wOKE5MBdvhnh4cgZEXT8WDg6iOLAvPloofmj4
	 m80Fv73SFj/9+QO8APAWLAz6Rqf7+1DPFki49Xt3FthuavaijCpkrxpys1y3JBDVAz
	 b40w8QECPinqm7y3Vq7oRLxomq7bPpxnQyavdtY64c6ziSfkGZMD6GuEj28sYm12dg
	 Y0vY9jsQgP9Qt/kEGoKAPWvi0olOcOczY8k6YGiV3uRNSjIX3O1pN7s+tXNWUBq1he
	 liGINRmQ0rGIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 459/638] HID: amd_sfh: Update HPD sensor structure elements
Date: Sun, 24 Mar 2024 18:58:16 -0400
Message-ID: <20240324230116.1348576-460-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit bbf0dec30696638b8bdc28cb2f5bf23f8d760b52 ]

HPD sensor data is not populating properly because of wrong order of HPD
sensor structure elements. So update the order of structure elements to
match the HPD sensor data received from the firmware.

Fixes: 24a31ea94922 ("HID: amd_sfh: Add initial support for HPD sensor")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 70add75fc5066..05e400a4a83e4 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -90,10 +90,10 @@ enum mem_use_type {
 struct hpd_status {
 	union {
 		struct {
-			u32 human_presence_report : 4;
-			u32 human_presence_actual : 4;
-			u32 probablity		  : 8;
 			u32 object_distance       : 16;
+			u32 probablity		  : 8;
+			u32 human_presence_actual : 4;
+			u32 human_presence_report : 4;
 		} shpd;
 		u32 val;
 	};
-- 
2.43.0


