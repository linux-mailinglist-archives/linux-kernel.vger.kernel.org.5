Return-Path: <linux-kernel+bounces-115867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF588985C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D6E1C30658
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09531591E9;
	Mon, 25 Mar 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etgnbJhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B7146008;
	Sun, 24 Mar 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322063; cv=none; b=pMjbzYuv8fm2gVdoj4VERUIu7MEQazLJpj5Yoa+6y0Q12puof01kEHS2RCtD1thizEJQ4qOxMk9zjESwb+5PvhsUwFYW74/N1R6liRH2Zlnju5CZcTuMtQJ1SFt/m310SYRHHMYDA+kBltMGOh0UPmOE3HgJT7I3/3hmdYS+KaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322063; c=relaxed/simple;
	bh=4wew/RSvJCKd70KkUzTO7tnMZFfdWo4VyC7/kEuXCSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5JHFSNJSvmJ29AEaGsBUjsvWKS3rKiFKP4Ro02KZ47UJFVqFkxtG+f+t0FUV5BYEFSYd3v3jNkPpVWX4AXgfFIRZ1xF09jeacnKoZG1qquKpcMJxjX0HPALZh6iEhHCaQ4/KONXM/AT/cNtdpA76j3Tx7PYPvU5chZJpxBTFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etgnbJhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD01EC433C7;
	Sun, 24 Mar 2024 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322063;
	bh=4wew/RSvJCKd70KkUzTO7tnMZFfdWo4VyC7/kEuXCSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etgnbJhMKkw5rdGEaiSQrVbJVZlwx6Qjg2u2DQyP0F8TWYCV870+1JEZVnn7no5lY
	 BhAky3tcpUmClUpAVOBfdrmGzObMEZxpwXgqpBXvQIpz1GGckhm3MkHYj3L5kJLLmE
	 Mpr9qGePHQB3z5B4XjdhknxXkdtBSGixaBFU0DiViFPwOMIE7lFGXsET9R9bO/Gn5n
	 Ui0HMN90H8LnSlYt7VGnjhd3lSTtGVY0+OYla4Sq7p/PRx0m7rMxD6Waxj995bfrsW
	 W01FwjvpRyrV3YGTE7ba9DfUDFoUznmwduNisbkIosRdF9fE+U/EXzAlznuMeSD8RP
	 IiUcPiMtD+lKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/451] s390/pai: fix attr_event_free upper limit for pai device drivers
Date: Sun, 24 Mar 2024 19:06:52 -0400
Message-ID: <20240324231207.1351418-137-sashal@kernel.org>
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

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 225d09d6e5f3870560665a1829d2db79330b4c58 ]

When the device drivers are initialized, a sysfs directory
is created. This contains many attributes which are allocated with
kzalloc(). Should it fail, the memory for the attributes already
created is freed in attr_event_free(). Its second parameter is number
of attribute elements to delete. This parameter is off by one.
When i. e. the 10th attribute fails to get created, attributes
numbered 0 to 9 should be deleted. Currently only attributes
numbered 0 to 8 are deleted.

Fixes: 39d62336f5c1 ("s390/pai: add support for cryptography counters")
Reported-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_pai_crypto.c | 2 +-
 arch/s390/kernel/perf_pai_ext.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 6826e2a69a216..f61a652046cfb 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -647,7 +647,7 @@ static int __init attr_event_init(void)
 	for (i = 0; i < ARRAY_SIZE(paicrypt_ctrnames); i++) {
 		ret = attr_event_init_one(attrs, i);
 		if (ret) {
-			attr_event_free(attrs, i - 1);
+			attr_event_free(attrs, i);
 			return ret;
 		}
 	}
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 74b53c531e0cd..b4d89654183a2 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -612,7 +612,7 @@ static int __init attr_event_init(void)
 	for (i = 0; i < ARRAY_SIZE(paiext_ctrnames); i++) {
 		ret = attr_event_init_one(attrs, i);
 		if (ret) {
-			attr_event_free(attrs, i - 1);
+			attr_event_free(attrs, i);
 			return ret;
 		}
 	}
-- 
2.43.0


