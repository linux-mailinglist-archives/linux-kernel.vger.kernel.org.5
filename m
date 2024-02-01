Return-Path: <linux-kernel+bounces-48957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F88463A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AC91F275A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84146557;
	Thu,  1 Feb 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRvTnHDz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421541232;
	Thu,  1 Feb 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827572; cv=none; b=nX5r98+0Ni+KNaU8zVwqWlNGje2tWMH3TKmbfV56roXCoxLPH7+0tulYGx5If0Svv8EaFnuew+wQydzNU9IHv+K738eeMGRqIyyF08z3PFM16YgxFlA9dXgCROqA5m8PUfsyEp7NjT/2uQJgx0g/XpTeSKI7AG2lzc2foUpn9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827572; c=relaxed/simple;
	bh=YJS+2cuu7/F2wdO4i1rFQNUC6HDTDFemAVViu5UIbAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkBA+jj9c2Fuk7zkzKQX0zgmH1KQOGq1mkQ6vS3dqqRQ2ES+MugdxJZL3YO1vfqvV/jr2m4mYbkP4TsZTTDJ+k3nBwwzGlEmvrRbPh5FeJi1Ut6d8EGEBlHiv3NALAmKskerSrG4BBXgbEBZy9Q3CNs7TmHSKvt0iHNe7X39aYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRvTnHDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF17C43143;
	Thu,  1 Feb 2024 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706827571;
	bh=YJS+2cuu7/F2wdO4i1rFQNUC6HDTDFemAVViu5UIbAM=;
	h=From:To:Cc:Subject:Date:From;
	b=kRvTnHDzVYF4uQlE13BUkFgITbueGryC1RYcfbpff6uIjk9ePxXLod89vLFV+PjCQ
	 UXwxQhEWJwi3P0e3yTna4Qr+bT0vPwI+I/02ovZ3gWKE/cN8U7kTUYFDoeJ+9Wq19C
	 VDeuptVOHhBM3Y0mCbguz7k/+xoDB2vkgqf+bSd6yXpCByy7LGXGdIK8NYmsX08Y7C
	 ng+j0eiuYwY1UnTH1va8/0eyKjdkerkBPqRvSude/ReEqpatHWFWWpoziZFtbuGaII
	 /7s8Skk966NryO8c2oZVhXDBNoc7kQkTVckqdytraNuFVTmWgG65iYKK16l8bLOVTr
	 Z8cLmYJD1gZNg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rVfou-00H4ug-Fq;
	Thu, 01 Feb 2024 22:46:08 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] md/linear: Get rid of md-linear.h
Date: Thu,  1 Feb 2024 22:45:49 +0000
Message-Id: <20240201224549.750644-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, yukuai3@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Given that 849d18e27be9 ("md: Remove deprecated CONFIG_MD_LINEAR")
killed the linear flavour of MD, it seems only logical to drop
the leftover include file that used to come with it.

I also feel that it should be my own privilege to remove my 30 year
old attempt at writing kernel code ;-). RIP!

Cc: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/md/md-linear.h | 17 -----------------
 1 file changed, 17 deletions(-)
 delete mode 100644 drivers/md/md-linear.h

diff --git a/drivers/md/md-linear.h b/drivers/md/md-linear.h
deleted file mode 100644
index 5587eeedb882..000000000000
--- a/drivers/md/md-linear.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINEAR_H
-#define _LINEAR_H
-
-struct dev_info {
-	struct md_rdev	*rdev;
-	sector_t	end_sector;
-};
-
-struct linear_conf
-{
-	struct rcu_head		rcu;
-	sector_t		array_sectors;
-	int			raid_disks; /* a copy of mddev->raid_disks */
-	struct dev_info		disks[] __counted_by(raid_disks);
-};
-#endif
-- 
2.39.2


