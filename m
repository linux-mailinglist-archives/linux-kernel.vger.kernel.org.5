Return-Path: <linux-kernel+bounces-113578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88539888571
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DD81C24CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07E1C9876;
	Sun, 24 Mar 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPPK1lGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEC1C985D;
	Sun, 24 Mar 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320381; cv=none; b=WelaQrxWjXLyHY3SvdMYlApUsv+nuXiJ2/7m9c/yN/Z1b5nMfN7Gu20y+71GyyKVOTBcO6xJA6eeIsGoqX8I+oc81P+X3et2PfXQ30WaHKwXQnXnl0hOgL0+xRYTgLHLjdoHuuW4sRAtI6kT/WEY1urkQTyVAtAxrUJQ4wJfLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320381; c=relaxed/simple;
	bh=bF7GE1W3zXbp8SDL+EKrXe62S2HrG2hpuza1NbZUjCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtCBd1545FTDRtaW4MhxAIHkuWpe3TErg/49dEIVctJW12jVBZLhkj4CpHU3bBvdxyv0qn1p9PZYBBE8RkZJsdZKOlizlib7Rk4zqE2V9hXB2LwtkLpe9RhLE+ruGIWikYAsxupqxBkKmlfcsqQvNcstDVE7j95dtZvE+qy6x6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPPK1lGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083C2C43399;
	Sun, 24 Mar 2024 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320381;
	bh=bF7GE1W3zXbp8SDL+EKrXe62S2HrG2hpuza1NbZUjCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPPK1lGbYpZx/PegbJXqXG6KlGnf0tGQpfang8DzOFEBKuoD+MQJ3lOWlw/iiJYJk
	 Onngxbxz9vgt5yTl6109ct1bMqXe5EjQ6YtIElmMMKXzv8sNJCtMAQWn9VlztljRE0
	 DP/s9kmaqyUVfY0lakHfhtRHKsqkbElokDwO+IqeWZpeywC1f8ZuLTuly6QRgDldXS
	 nKZGfWuK8fEH5jithCW7zZw42RL53P7uc66JNFqFnrcYrtDxmGGJOFVvmaIziF/g2N
	 VMJdfcvYaLByzlJOJx/vnfy22dTQsHuicKzW0kqRWRavSFePkBqy+6pBWb03hE/WWb
	 WLIXtEyJNddxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Frank Hsiao <frankhsiao@qnap.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 687/715] ceph: stop copying to iter at EOF on sync reads
Date: Sun, 24 Mar 2024 18:34:26 -0400
Message-ID: <20240324223455.1342824-688-sashal@kernel.org>
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
index abe8028d95bf4..3d1cd079dbf16 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1138,7 +1138,12 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
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
 
@@ -1167,15 +1172,13 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
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


