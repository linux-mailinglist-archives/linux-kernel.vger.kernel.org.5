Return-Path: <linux-kernel+bounces-41744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30683F73F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CDE28518E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFF651A3;
	Sun, 28 Jan 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r44wCNEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C4633F0;
	Sun, 28 Jan 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458434; cv=none; b=gJMbSS+YLeVb4Qn3nhwzCtJe1jCIrresclf/OkqX1By+bEOL/oLK7NcIvcPYqg27Eq7RAKw+56dEaXgAiGbU85EiIQbIizGrl20vQScLPLcM+PBq2GIgiZPE2/0BEwS3jqg4qczALz/d7AVThXnP2Dx2nYhIzw0O7rgoiuq/MJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458434; c=relaxed/simple;
	bh=cRNTfXI3V0bi3wKh2SQcjTmC/H3wPCUvLBKT19AZg/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZvlXug8OUeyfUFaZZMfZE1gDDBDrisF8neTWcspHoUnms+G4fwf9+qxErfgy0VUKSzyI4GwUTrm/O5EeICm+XlnE+R0IFLZNjnpIxaEd0VeYT6TfTvZPxRLjPyk8gSBS0xdGZrWAIrefN/Jzezai4Lb+PCYPVcpi7W4mHl6U0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r44wCNEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A97C433A6;
	Sun, 28 Jan 2024 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458434;
	bh=cRNTfXI3V0bi3wKh2SQcjTmC/H3wPCUvLBKT19AZg/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r44wCNELN0hMH5r9XkXCmA0asgblE7iUl4SXTLUC0+EYLrxPiS+LC4AohCttbsSts
	 3/TGA5PUsXwfOSNGjvtK2MEnoYdWx4UKENTmKhpaAmNuQwDcqriyznN62DyxO6dqiI
	 pUtT5LY/IRKAQJu2rTq1EF6nWIs6pTpCj+Fx7XzcGYgyJt5jc8iTn7YEOZrADaYzfO
	 tuKvClAyW/K6G0xcwpn5a3u1xDZ10iMJxw2HSIqJ4fLhIS1Adi3GsxToL8MRULVB4r
	 o7qCEFUtyLIdYYF2Xcc0DG3ficCUIlKTonIoiqVXyXMyB25PMQ0TRX9GHR93JXN7oX
	 SAFq8sQt9/e1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venky Shankar <vshankar@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/31] ceph: reinitialize mds feature bit even when session in open
Date: Sun, 28 Jan 2024 11:12:53 -0500
Message-ID: <20240128161315.201999-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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
index 293b93182955..6d76fd0f704a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4010,11 +4010,11 @@ static void handle_session(struct ceph_mds_session *session,
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


