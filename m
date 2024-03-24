Return-Path: <linux-kernel+bounces-114592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDD889079
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC71C2C3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8C2317F1;
	Sun, 24 Mar 2024 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwalqnQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C162310E8;
	Sun, 24 Mar 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322241; cv=none; b=dKbsVxD2cQ2hw0qz60FgeoXzpWOcHAAqMjnzE+fNa0lYZLa6XLl5nCMfRCT4Ti5os3c7h/oSOmttYFDoZgg7xvfN9XCTcgpk5W1yS0yk0Uo/X9+T5xXnA8fma9+YsqXtdKxAoLm+AHzp8RByes5DuDTUUBS7Y/RyEQ6Z3dQJGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322241; c=relaxed/simple;
	bh=bUlKsHmC2HAmFh3QAs7fY6/5QARRikTHMFtZxool6Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im+THeZtaQiLFtZeZ0n/+JyzsNBC3DA6MNehszpuXp4GKwx3X1kL8fSMPe7LYGzEu5lSreKvtD6t7JQRXS6qDPV2b/lBoXqno2PWcjub4JN23/6/ido/OJ8HCoVr+rJPP0sVxe+zM2GCM7eGX68XHddJLaFGN0j63BReHSldpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwalqnQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177CEC433B1;
	Sun, 24 Mar 2024 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322239;
	bh=bUlKsHmC2HAmFh3QAs7fY6/5QARRikTHMFtZxool6Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwalqnQmBDPJPkbUKFI5wLhzSN3RStkwrfZVlP2K0YynSAwv7BLwK/EfnITYzq4Go
	 ODDmVR2Lgs8dHU8QulwubR9l3LKh0orIBlX+3UPsGvNI5DaBZIRRn8CfQqT/w3ci+W
	 CGffARPXk6qJmdjYcYURxTKyk534N0vvh/2V2AyOfAGNEwyVF1ZskMihd0UXq6IY5U
	 Ty68e8XX3LE/eLZ1X57foWnzt8M+2ryg9BBa34o3St50RdZvVeTXVUQmjC0Q4u3aCs
	 U43V2inzG2HYwofSnL82ajX/lgdOXIBrNiRBOHstUfCLWcOKZctditc7e7Y4k5bUXY
	 WIchw444iwx7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 321/451] HID: amd_sfh: Update HPD sensor structure elements
Date: Sun, 24 Mar 2024 19:09:57 -0400
Message-ID: <20240324231207.1351418-322-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index dfb7cabd82efe..2b125cd9742cb 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -89,10 +89,10 @@ enum mem_use_type {
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


