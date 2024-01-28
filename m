Return-Path: <linux-kernel+bounces-41713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602F83F6E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30151F275E7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F555E7C;
	Sun, 28 Jan 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiVIUZ/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3A55E42;
	Sun, 28 Jan 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458361; cv=none; b=lV/CQfVjphBfKC5eFSW5PsrrOYkTdx55sn2sV0q6tC78csLfFwB31sCUVQq+w1knLSQB6jVxdpHbZig9v5QXkpk1nGxgfm/KUsr0Izdf9Z+TI95ot6MOOy5mu7XfhYwBhrCdvUuB5NXrMoVu9gR3+U7tN/u9MZHoY8r+d8DwZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458361; c=relaxed/simple;
	bh=4k9nqVGQh0LBC+PNpDzpSxYqznixZdGVN25GvS4gXNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW3v6FOGH9mK3mwP95DjgL+1C1o4iX6PeXk/ayt/PuvUcF5XJCjaxsMEyjGCDYk9NW2nmW32sN+RCm6CNaWiVStk+JYnKyd2nX6uocBWXnDOehKv2h1uvbGwmPmlNAdXWI939ZWrld3BFpVf30CC+Ech93Nn/8mumxgS3WSdGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiVIUZ/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8FAC433C7;
	Sun, 28 Jan 2024 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458361;
	bh=4k9nqVGQh0LBC+PNpDzpSxYqznixZdGVN25GvS4gXNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiVIUZ/6UpMJtdjDmZ1+PUKnbV1HluXx5Xu52T1uDsMFo4FyhGiaCQRyfxgeiSK+z
	 IGxYlsxf1Q4F2HrWv7EMNX91bvgPZYY5qAV/SSV+eaqPhqZeisnyc+cqca6E4SdjAZ
	 0bLhnAH7QDDnDS/AJrplCK6PUqCP263bk5LViAXJdzCqen6Z6IatnnP/qrJb+bWZoG
	 LAQAczlQiMEBu60KpPK9oGaXEjyfwyVq0Q0IRbMfm6kQMShFxEQDcjVDbQsgrlYGji
	 v5a5n2cTxk1XzU1wVu6VdASGSmXSJFb/V4877NF4OGMy6rneSrKzaMHhrK8Rpjf8xh
	 2DZf86wdaV6SA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venky Shankar <vshankar@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 31/39] ceph: reinitialize mds feature bit even when session in open
Date: Sun, 28 Jan 2024 11:10:51 -0500
Message-ID: <20240128161130.200783-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index d95eb525519a..558c3af44449 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4128,12 +4128,12 @@ static void handle_session(struct ceph_mds_session *session,
 			pr_info_client(cl, "mds%d reconnect success\n",
 				       session->s_mds);
 
+		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
 			pr_notice_client(cl, "mds%d is already opened\n",
 					 session->s_mds);
 		} else {
 			session->s_state = CEPH_MDS_SESSION_OPEN;
-			session->s_features = features;
 			renewed_caps(mdsc, session, 0);
 			if (test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
 				     &session->s_features))
-- 
2.43.0


