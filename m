Return-Path: <linux-kernel+bounces-113377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56618883D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A221F2665A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB3919F537;
	Sun, 24 Mar 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjCNH6SI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C919F51B;
	Sun, 24 Mar 2024 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320178; cv=none; b=IPl1PO1tXMlg2j624TWRVS9jUVKJTPH6JYlbo1/LudEBdovswDhsSHUy1G/DoK4zL66l3m7m7PJQ0Te7MfEknBLxl1tTdYtwW+9Gwl+bNriBhcjlh5nu6EUjzwg5sGC+ycD0su3lgmtJB4K6tCHZ/8FMTKHDaFJoKnmwknbdjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320178; c=relaxed/simple;
	bh=kHv9No8I6LDPw0P6eGHj7N9MFtUF53asyk1Zu9Yl0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr+EqlUKZGlPlxIV0+vHsm6etvTPHWsbL+z4E7evnbb4/hZH92iYEwgXX0529MdWrcCXthz/jfEeCwNX8Tw0yVmBhv+dcZkBATKcmnOoNt4fuVdlXiNKgI5H6ys9lZe1m4JJ1hZF+HjEcCGzDx2QLwxcIlN8r667v0N6VE0/cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjCNH6SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B768EC43399;
	Sun, 24 Mar 2024 22:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320178;
	bh=kHv9No8I6LDPw0P6eGHj7N9MFtUF53asyk1Zu9Yl0Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjCNH6SISW9b5md3TQdH+LutSio1QKEny/bv+DHOB02a5qbrgV1gl3RU7AdpJ3Qoa
	 J/M0TdLEkPnc8AaX2SHvA0+qtinlZlkJLketNy9OQASrCjt5sorwDfNcpxz/OH3gQY
	 3909aYt7FmZ1xSFh8YUj6O5ptr9w4okqBnIH52qEQ00uAjKny99uNBbB+Pr1V0fnNC
	 yF4Yldu7zJkQ6pCpkFIWpzE4hjMAWlGe4iMszWhCVGrlY3+9A/tLpDWkYVC3LQ/7U3
	 hqP+5s30BFBkGn2BQmOHnx/pOgZi3DKJOaREWe1Qwi0Jg3fgZ2s4MdbxVAHhx0H54V
	 hWpXnpcnAGu0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 486/715] HID: amd_sfh: Update HPD sensor structure elements
Date: Sun, 24 Mar 2024 18:31:05 -0400
Message-ID: <20240324223455.1342824-487-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


