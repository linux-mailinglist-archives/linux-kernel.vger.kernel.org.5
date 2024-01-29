Return-Path: <linux-kernel+bounces-42612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B058403C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE00B22EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68D5BAD4;
	Mon, 29 Jan 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8fAALCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BE5BAC0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527672; cv=none; b=HhRHuycmRuBYGKLJqQuOdtmX76Y/ZyWcGFYDVDgGyhioK5VmLfiW/YZMeMKn+7ymOCGWi9q6unInGcTXSWPNLi3IEB1huOAmTpIKTECo6Q1oieR+RGCRvCP0C8fj/CAks28JimM216R9NyAGcq1bKbeQTAxoT3GTu3OuRxVz45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527672; c=relaxed/simple;
	bh=K+SoEOU6xu54KZgacf/5Gi6Jlpq+URdws/owLbfDtyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rrdh0SsAj1e8/7buMuJh15mXpHDoMZnXsaDAdsXsK25MnG+Rhqbju/4sMFfWUtPpJPoUaI0suidjXmQ7p2Ug9lp/QTxJRPQod1W0qOabiPNnhQ4wScFUocWUktY+OPkpm/HrEL88GF8ABeD2+9x22B9cIVOI9F9ZtPdJtf1rQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8fAALCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A2CC433C7;
	Mon, 29 Jan 2024 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706527672;
	bh=K+SoEOU6xu54KZgacf/5Gi6Jlpq+URdws/owLbfDtyk=;
	h=From:To:Cc:Subject:Date:From;
	b=N8fAALCAOzGymJZPOGyuPKdywZ0KLY/CSMt6p06Q9Bbrmk6oDIyrzEcXpTGJmhuGj
	 tED0fFlgYtd4ws09ioEWHM47oJoVKdEcfpZD/LrWzbp/TvPjhkC7ZgAcMhVLr2RVLY
	 j28kR4dgZIV6pQbimFWM4cR6mDMHioxsf+p1GLheWLyKUreMLC8z/8wtPhwiJxgvkZ
	 ExRyyIxF5zXCh4d21vlAYesFzpRCKrqTruKTIOZPfi1ow7bZMAwsD3K2waD3w9qCA0
	 frhZFsB96kX5eFFl6mN0k9i0Ja/+N8NH0VEMmkvn92HqpPcWXALHye47KkfN9AZysD
	 HYsl+FD2PsJrQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: zone: fix to wait completion of last bio in zone correctly
Date: Mon, 29 Jan 2024 19:27:40 +0800
Message-Id: <20240129112740.1908649-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to check last zone_pending_bio and wait IO completion before
traverse next fio in io->io_list, otherwise, bio in next zone may be
submitted before all IO completion in current zone.

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f45ecb810ae6..8cdbc5ae44db 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1006,7 +1006,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	f2fs_down_write(&io->io_rwsem);
-
+next:
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
 		wait_for_completion_io(&io->zone_wait);
@@ -1016,7 +1016,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	}
 #endif
 
-next:
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
-- 
2.40.1


