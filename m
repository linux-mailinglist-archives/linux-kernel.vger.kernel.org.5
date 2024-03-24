Return-Path: <linux-kernel+bounces-115575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4F889C84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A281F35A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6F1F3019;
	Mon, 25 Mar 2024 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNyPaLEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE31F30B0;
	Sun, 24 Mar 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321124; cv=none; b=KWjXpuWMW1NrvRLLXjgi1zczzAHs8hut1T2vd8VPD64L22EpizMW7prKwJEZK1cny54jTFwLGYhsvf0w7Ikdt8yglPHh8tWG4ARcynrNUISqUi8eAlpYZ2efDxODM6yYa5GdiXeOQdHLYcjNXf199BWWVIkK8B2FRetdr3zFOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321124; c=relaxed/simple;
	bh=klOIANNcSD6uUUBwawVG7HMyBUU/vv9lKS8+Lyajj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb/k1lxzIFZZ7yJiwi7YyVbcBtUuJxe01CA7tKuMuBkJb380UwIVOcPQFBA6CM9YPwq/NuuDvQbE9+FUq1toBZm131Lq3agK07xyON/0vuJDIA5RG/3sjFDsoZqyb0yleImGwcdpfWnHl5/LkfoM1Vxvsa9Zxage1KHjysJbIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNyPaLEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B1C43390;
	Sun, 24 Mar 2024 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321124;
	bh=klOIANNcSD6uUUBwawVG7HMyBUU/vv9lKS8+Lyajj6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNyPaLEFkeqMafYXZZVEcQva2G1DGGDihJ0qQI6fCDH1xufIeuELWSO+fL92zUOuF
	 F2WIpqBlPgqdCXcEoHiRvir6C19clboRGifI4M6J5+zAzPdPvb/M0alCSihHtGi2eK
	 sAOGIiD2muH9axy2/NT6qSM5i3JK4Vlth34de15LJpz06gaG9901z6myZMmcKqfi/c
	 0ikmXVLJmJPWJLHbJF/YkMasPMAtcZubJHUbcOQOsMOFrDnhPFoHRsWuPMIbDvy9j2
	 ILc6xBLfqgCDHlVcrNg32TYhCSNQ9kpVO3ir75ru4dTrwkcbpk+2njPP6mGbhs0/OJ
	 dQCG0rHMn5CGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Frank Hsiao <frankhsiao@qnap.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 685/713] ceph: stop copying to iter at EOF on sync reads
Date: Sun, 24 Mar 2024 18:46:51 -0400
Message-ID: <20240324224720.1345309-686-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 1065da21e5df9d843d2c5165d5d576be000142a6 ]

If EOF is encountered, ceph_sync_read() return value is adjusted down
according to i_size, but the "to" iter is advanced by the actual number
of bytes read.  Then, when retrying, the remainder of the range may be
skipped incorrectly.

Ensure that the "to" iter is advanced only until EOF.

[ idryomov: changelog ]

Fixes: c3d8e0b5de48 ("ceph: return the real size read when it hits EOF")
Reported-by: Frank Hsiao <frankhsiao@qnap.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Frank Hsiao <frankhsiao@qnap.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3b5aae29e9447..523debc6f23e0 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1135,7 +1135,12 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		}
 
 		idx = 0;
-		left = ret > 0 ? ret : 0;
+		if (ret <= 0)
+			left = 0;
+		else if (off + ret > i_size)
+			left = i_size - off;
+		else
+			left = ret;
 		while (left > 0) {
 			size_t plen, copied;
 
@@ -1164,15 +1169,13 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	}
 
 	if (ret > 0) {
-		if (off > *ki_pos) {
-			if (off >= i_size) {
-				*retry_op = CHECK_EOF;
-				ret = i_size - *ki_pos;
-				*ki_pos = i_size;
-			} else {
-				ret = off - *ki_pos;
-				*ki_pos = off;
-			}
+		if (off >= i_size) {
+			*retry_op = CHECK_EOF;
+			ret = i_size - *ki_pos;
+			*ki_pos = i_size;
+		} else {
+			ret = off - *ki_pos;
+			*ki_pos = off;
 		}
 
 		if (last_objver)
-- 
2.43.0


