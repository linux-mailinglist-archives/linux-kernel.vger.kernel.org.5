Return-Path: <linux-kernel+bounces-113061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A48888127
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4B2818CE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DB145B3C;
	Sun, 24 Mar 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qugSufB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA681474B8;
	Sun, 24 Mar 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319869; cv=none; b=kR0gDChwuedRSfVH/uNfVjCAVwpgITTUVzHizXvI+qClcOgW6a1c13AOgAxbn1RioBzEs1JqpdFqABItkNR9LKUhlCPWTZ61ryV8xLgM4rFucVQyqtIadcqvwA9NffkX9c/nA2Ag3OWJUVpcURu8BWJKU4kWG4FtBajunXhMxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319869; c=relaxed/simple;
	bh=xZvsKGoR/svHEqZp3qpLgCTKbWwG471nH+E4WozJpus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQDV2GeLjuNTiCx+YiqHYuVLqbqTPhUVuDqu2/7MXIvDdisaLaPJampwZPhN4vEtlerxFcTZ3i5U2tb58LZ5QWvU9WHiAiF/tb/y9H4fIui07p37IjCdNMdBtg/jvkpeINGD63bmCuaiADDmkAP0AvaAwqxrJpQHF1/XzH04T/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qugSufB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9843C433A6;
	Sun, 24 Mar 2024 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319869;
	bh=xZvsKGoR/svHEqZp3qpLgCTKbWwG471nH+E4WozJpus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qugSufB3lcB5u/n14s843SFK+QmLjZA7eApTyMBm89zio4MySYMCozsmu1PjTj6Uf
	 +8grHeCvpPtTrrF2eNQcrZ/v67fmz48fgFQ5/+n1gj4AA8caWOtQwNqxscOfgtK2E1
	 9/F0tJSnmpVbYCLyJUBqg3vYVg/OMnhzrOJbcak3ZnhfKsAAE0sl3p/gNsGPi+1reE
	 IxolHAm13vtZ+rwNxnWjHw+zJJ5IHsCvHwqpUQK2oROHyTILLxO7vzzPshMV/7UlCK
	 jCVC8jdrsDsRMFVyHmFpfOs9vWr5pqjgYt4erFJXRLO3pqq1VYn3z4LTK6nf7XRSe6
	 QYxiZex6r8kbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 174/715] s390/pai: fix attr_event_free upper limit for pai device drivers
Date: Sun, 24 Mar 2024 18:25:53 -0400
Message-ID: <20240324223455.1342824-175-sashal@kernel.org>
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
index bf8a672b15a41..522a5ea0a9f49 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -721,7 +721,7 @@ static int __init attr_event_init(void)
 	for (i = 0; i < ARRAY_SIZE(paicrypt_ctrnames); i++) {
 		ret = attr_event_init_one(attrs, i);
 		if (ret) {
-			attr_event_free(attrs, i - 1);
+			attr_event_free(attrs, i);
 			return ret;
 		}
 	}
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index af7f2b538c8fd..95d1a890640a3 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -611,7 +611,7 @@ static int __init attr_event_init(void)
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


