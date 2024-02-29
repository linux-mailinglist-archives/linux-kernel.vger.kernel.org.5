Return-Path: <linux-kernel+bounces-87490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF086D510
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103BCB26643
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC415CA98;
	Thu, 29 Feb 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce5Dpriv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A715CA80;
	Thu, 29 Feb 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239252; cv=none; b=VLkQUvCevwdCOWc51T61p/IxxvyywYkqQaqwsJOGD4pecS3q3Y4nTSLuefQuNPWisobmWPWH34tcpGzSwLvYfIR3ZuHi6pcqoaNxsB47Nh2XclJbH2aC5rTa/uVuA8q0QxFmLXHfwWUreF1+h3k8smAlX4jgAnw9aUnLtlGNfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239252; c=relaxed/simple;
	bh=74kBJTUxv1Q4HgbcKWpYMeYUi0KuiFLvBp1n22KuFJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpa0vxhK0IQXtq+ukRESvXloeYaWITsJK2ywWqyODCuoh3Q9FY/KrqN/jiUNdShQIWXZFxAI/WnilkVNKlyLltzwPEyjHzhV7uEro+fWShGfjuPyRnHDKDFYwjmEdxYlejfrNAMdLJjTDWEJpH+CotkCnvXGMsDvUSJyek4qMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce5Dpriv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBCFC433C7;
	Thu, 29 Feb 2024 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239252;
	bh=74kBJTUxv1Q4HgbcKWpYMeYUi0KuiFLvBp1n22KuFJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce5Dpriv6xqSS+1if9tmuN75n5ljt3A62gLUL8SMfggqlkQrnL2YdTxTfUQSed4Fd
	 UzkYKPZemvgWk9DkhA3jz7/bRV0UDkbXoBRNJSt4r8sYbO8zGuIOxwVaiHiC8oHxqK
	 c/KIrJasraTkEjYQSGHTLy6EnI0U+8DL2QcwHCaCDusTAcqqvLNuouwj+hBnkLWtNn
	 SMQ3w48KzFHL36iIy/WN/pjZ91Hkus2zXk4NmLLAl9kT5CZ5RuAjbOzrYaC39WGG02
	 UNHB/oqw6RdEGMhz+ZUxDoA1zYPqoBhPHBaD1PVHP7x0+AI1twtq+/d2jI/gU/Z1pl
	 UV/dxWcr1vPmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	twinkler@linux.ibm.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/12] net/iucv: fix the allocation size of iucv_path_table array
Date: Thu, 29 Feb 2024 15:40:29 -0500
Message-ID: <20240229204039.2861519-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit b4ea9b6a18ebf7f9f3a7a60f82e925186978cfcf ]

iucv_path_table is a dynamically allocated array of pointers to
struct iucv_path items. Yet, its size is calculated as if it was
an array of struct iucv_path items.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/iucv/iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index fc3fddeb6f36d..f66b5f74cd83a 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -156,7 +156,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -544,7 +544,7 @@ static int iucv_enable(void)
 
 	cpus_read_lock();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


