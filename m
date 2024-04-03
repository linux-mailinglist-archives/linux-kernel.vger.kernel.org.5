Return-Path: <linux-kernel+bounces-130281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7E89765B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328591F2B26A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F1E156665;
	Wed,  3 Apr 2024 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxRAeu5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4F15664C;
	Wed,  3 Apr 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164631; cv=none; b=g+zBq2YIakEkP9dkIc54rbN3P78cbtf0CIXOeoa9+DhKdvZpkkJIu+HInq891/DHaxb0kpikl7Hvs/JxjqRQxXPuVu5oTZbViMoFo5r5Q0LhvIL0H5zmFZiV2h4oCFJIqcZLA0vYywAoKH9Yz0mNf2soxSmNr83lsvTjmj70quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164631; c=relaxed/simple;
	bh=Uzm6IKJUM8TcbFoDluvJMWXhDFfKOHPZyqq0Ks5khyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS4EmWOyzO/WkLYLrn46Sf/w6Kt568+f2I6piuS0xyw2eXe27hthUdKa3PPl3Em0MXzKR6kLvZCe3iv1WId8qwRc0NmRVDVd2mAAytq+cpiGUuDUCuG59uiOp541K86NJaoRxWA02HghZ6uPRyUm/+6Z/4oxJawZ0vuEaum5zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxRAeu5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E166C43330;
	Wed,  3 Apr 2024 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164630;
	bh=Uzm6IKJUM8TcbFoDluvJMWXhDFfKOHPZyqq0Ks5khyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxRAeu5Kg1z4Rhbs0SgSQXWn6l987iEJwKyOHU1k/ZwHV8l+fpC5BEXY6mG0JouFP
	 hxTpGZJNIObMPbXK+EJbV+nphBhRkSDh1SBgdr/5b740IxdBb32TGieexqUhnizLHQ
	 eYrHqTktpuOJ/hB7D3ddunas5wpg8WDAA8DX8Icr73AyYZV/KgVVulksFbau1XCsXv
	 8oOZWjAgqjic9TuJJwEvB85EJxvxIg+NVeMGb54VCrp7jBDuYBMYxNzsmjoZMH4gNJ
	 v5QSAV7UYuAl7pUDHx1jpu476/UT6pmCtPA/IjejeLUbczBhoILzvXhgxT2gBWrj2m
	 ABo3ReZ0wpGPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gil Fine <gil.fine@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 07/28] thunderbolt: Calculate DisplayPort tunnel bandwidth after DPRX capabilities read
Date: Wed,  3 Apr 2024 13:16:09 -0400
Message-ID: <20240403171656.335224-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Gil Fine <gil.fine@linux.intel.com>

[ Upstream commit ccd845021147dc8257a05ed8f5a7f9c61a9101e3 ]

According to USB4 Connection Manager guide, after DisplayPort tunnel was
setup, the DPRX capabilities read is performed by the DPTX. According to
VESA spec, this shall be completed within 5 seconds after the DisplayPort
tunnel was setup. Hence, if the bit: DPRX Capabilities Read Done, was
not set to '1' by this time, we timeout and fail calculating DisplayPort
tunnel consumed bandwidth.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tunnel.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 6fffb2c82d3d1..4f09216b70f90 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1196,17 +1196,13 @@ static int tb_dp_consumed_bandwidth(struct tb_tunnel *tunnel, int *consumed_up,
 		/*
 		 * Then see if the DPRX negotiation is ready and if yes
 		 * return that bandwidth (it may be smaller than the
-		 * reduced one). Otherwise return the remote (possibly
-		 * reduced) caps.
+		 * reduced one). According to VESA spec, the DPRX
+		 * negotiation shall compete in 5 seconds after tunnel
+		 * established. We give it 100ms extra just in case.
 		 */
-		ret = tb_dp_wait_dprx(tunnel, 150);
-		if (ret) {
-			if (ret == -ETIMEDOUT)
-				ret = tb_dp_read_cap(tunnel, DP_REMOTE_CAP,
-						     &rate, &lanes);
-			if (ret)
-				return ret;
-		}
+		ret = tb_dp_wait_dprx(tunnel, 5100);
+		if (ret)
+			return ret;
 		ret = tb_dp_read_cap(tunnel, DP_COMMON_CAP, &rate, &lanes);
 		if (ret)
 			return ret;
-- 
2.43.0


