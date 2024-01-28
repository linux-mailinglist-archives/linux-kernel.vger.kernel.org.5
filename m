Return-Path: <linux-kernel+bounces-41775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9E83F792
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059A51F24C04
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC786145;
	Sun, 28 Jan 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnpfjvmb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8185C72;
	Sun, 28 Jan 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458499; cv=none; b=A7mw52kUh8vw8xNKIqCWSoaOEHct+K01HPi4Z17lUgX9PeEA99iqNwD+JEwjIhrntwOF3if7oIbcFuiqxEKkNgHYcK5QunWU0WwZPQbBmJ82urw0HzFUhTIAIPlXyGJJJu8j28uTaKEjv5a5lRb+zyfRv3vzdJD1upVB1jF+6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458499; c=relaxed/simple;
	bh=OQh/WkUxd9pGHLShgHQD+MmfBJhAHHbHq4FOwNrwc50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOq7ULIe9nZnwNjiXffc58+TugJW6zh2fNulrE5KPc/bWVG4fGdNGjVFwLaZpns5xgWPONJ2DN+sVcCOOCrrQ0as/3dLG+TqXLL956/oAFeHBDHsU8xDlDAz9JgAhyaYLEWV8ABuhIkr+foB3A5XHeH2DqzWC2tCx4m4wq8LrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnpfjvmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D28C433C7;
	Sun, 28 Jan 2024 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458499;
	bh=OQh/WkUxd9pGHLShgHQD+MmfBJhAHHbHq4FOwNrwc50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rnpfjvmb6qbKXI7dC8LIeM47yAfok6s674cO2psLBztsSiJqgjHkrfU6vrFYCoctq
	 SlGRq0gUn0gEiEiRKdamB9gt1t+Id787K68glOVLxajItrCYVQ30wjNIXAlXh2w1uy
	 zEmFOnUBii2AcW1m9sQ726bzRID7aha6+jbqf2U5WWBNda68sSoZ8iS/KMZ2jZOik9
	 NPoobDKLxnuRAFembaWT+VKeTbWIu7/MczSsI726x/Rqjg0J4XFtGYR1qVv03X3EZl
	 bv3bVXEKCpHiYkAsld9fX0W0pCwYCd0obXn1Xc24BhcEHuvcgaecbuAAzGibgC8jz6
	 0J5ViOEIzeGcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venky Shankar <vshankar@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 20/27] ceph: reinitialize mds feature bit even when session in open
Date: Sun, 28 Jan 2024 11:14:05 -0500
Message-ID: <20240128161424.203600-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
Content-Transfer-Encoding: 8bit

From: Venky Shankar <vshankar@redhat.com>

[ Upstream commit f48e0342a74d7770cdf1d11894bdc3b6d989b29e ]

Following along the same lines as per the user-space fix. Right
now this isn't really an issue with the ceph kernel driver because
of the feature bit laginess, however, that can change over time
(when the new snaprealm info type is ported to the kernel driver)
and depending on the MDS version that's being upgraded can cause
message decoding issues - so, fix that early on.

Link: http://tracker.ceph.com/issues/63188
Signed-off-by: Venky Shankar <vshankar@redhat.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 82874be94524..da9fcf48ab6c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3650,11 +3650,11 @@ static void handle_session(struct ceph_mds_session *session,
 		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info("mds%d reconnect success\n", session->s_mds);
 
+		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
 			pr_notice("mds%d is already opened\n", session->s_mds);
 		} else {
 			session->s_state = CEPH_MDS_SESSION_OPEN;
-			session->s_features = features;
 			renewed_caps(mdsc, session, 0);
 			if (test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
 				     &session->s_features))
-- 
2.43.0


