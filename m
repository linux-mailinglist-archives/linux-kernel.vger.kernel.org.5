Return-Path: <linux-kernel+bounces-113693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B90888611
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D840328F632
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366E1E3847;
	Sun, 24 Mar 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+XTHiCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0F1D449E;
	Sun, 24 Mar 2024 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320669; cv=none; b=sRyj2ymmrqGxog0BIWdw/DxaLKDRiYKxAe3vnnjR1bnAl+AGPjs/TNjQy0qH0l3rUxZqkKJCwc4hlZFqYruPptporPJwwuVd7mgmMNKWnf5JMBttWIIbHKBZxru/FHON2SLZZQF9CoKzggex5Xz/nQXUds6XIYQTCgmhCPuWujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320669; c=relaxed/simple;
	bh=Zo8E7sPDfcA+uBjrOSgy9Ane8vCACYqLqX3xklvIW4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOm4Qc5rBplKhRbJv+zSLtNcP0pmtquDV7tsoSUwIwO9A65HC4Wo1CZCywD/RDm62/EZlF0E9IC1N8+7c0Qo6Z1D425LJZ2fAdGaLVvM9nyYFpD0XzOUXgY7bdC9hZWp8M2Q+yN09ap3irtuaVvv3IrEDvZSVTgmMmGRc0SD7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+XTHiCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B399DC43390;
	Sun, 24 Mar 2024 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320668;
	bh=Zo8E7sPDfcA+uBjrOSgy9Ane8vCACYqLqX3xklvIW4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+XTHiCTVXCDOfyIs3RNYZMerjkIb0lWEB05emnzOLouIdlqWWTrW2ShRyq9SKtSu
	 SOB1Hbr/xwWOU3rxAcdV2u2RHnOz8GNxtHSgTmgbndTUvwZ4JYGk19h/D7jnRXTvBh
	 REpECxfkX/VgPuTZgFmJSN6K7LheSrHfEaidxz/9VIvSeWSl6qTexhHhd/BfUdhqSN
	 ZlUrn5sxOXU5fNDuWDbLsrMFS0P2Jnm9UUKjsvshDTe31T+KVjfQAnxxSI+pnCvp6+
	 1KVH5vn/gPybvuB8xw3RXbh+6RetE34AHUxH09zbJyx+HdWpNoPHStY/m3QEsw2bdS
	 KkzlKiAOfhHxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 231/713] s390/pai: fix attr_event_free upper limit for pai device drivers
Date: Sun, 24 Mar 2024 18:39:17 -0400
Message-ID: <20240324224720.1345309-232-sashal@kernel.org>
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
index 39a91b00438a7..fc2dff1e4f796 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -715,7 +715,7 @@ static int __init attr_event_init(void)
 	for (i = 0; i < ARRAY_SIZE(paicrypt_ctrnames); i++) {
 		ret = attr_event_init_one(attrs, i);
 		if (ret) {
-			attr_event_free(attrs, i - 1);
+			attr_event_free(attrs, i);
 			return ret;
 		}
 	}
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index e7013a2e89605..32b467c300603 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -604,7 +604,7 @@ static int __init attr_event_init(void)
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


