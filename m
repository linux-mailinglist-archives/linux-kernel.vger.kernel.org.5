Return-Path: <linux-kernel+bounces-87523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A386D578
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E971C2284E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1116F87D;
	Thu, 29 Feb 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzWTRaSm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF816F866;
	Thu, 29 Feb 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239332; cv=none; b=Zy+Yl7ER3dI/cjoI823WnsDS7QC14rqfM2awAr0HKO/vINMj14B1CMVT0LKRMqdqSeE3h36hxDqywGQqhlpD2zSz/uuupK2keCG3fpqvKcoBmy85ToQjNMWmqcpmb5hUIse4dQfAIpZ612vWNJcDJXCvXLMsH5YB+7OdR+dp3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239332; c=relaxed/simple;
	bh=1jDYd53jim3o+DnL/gcsQfkGwzdeqRP4MNNLaXnXoPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9Vchc4EiNXop+trgyrvLJpG5kLyWbB6Bxd0HoeSXhQF5lVno/T12e3Lf1qEpKzBpPkXmnk+cY24cuZ6j4UnN1MTpIQMO4D4EIEmW1I6aqkwdh41cNK7/sI1DAYsDkuK2TEVb6tRzKSAFRqZVrGwfznOmfp9hpH+mkW2zkqoXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzWTRaSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7395DC433F1;
	Thu, 29 Feb 2024 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239331;
	bh=1jDYd53jim3o+DnL/gcsQfkGwzdeqRP4MNNLaXnXoPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzWTRaSm7EIJXkUA0Mv21/vLxudZiAt8gSZqXophOtKAbifAGi4O1QLvFSS99wq8D
	 I/FdOER5CqXSvXGQDiOHpnUJrVYH1syqZUPGj0I/bCtgay5FeeDOWgS2YA3iKMStf6
	 B7rBxa/a/kLa+iHMYGIlfYWLqf9gxF1owAMfGK9RpE+JF/7A+j8fU5hUY0YOPeReqm
	 nsQlUyNhfAfe3uKCzI21nFXh+Jx84H/Cm5wWp2GGZ0O2mOskg18Xbza5T33deJL/2g
	 EzaIJBCmwc92XbVNet/JcNmUUL+eWjEVMptNs/wfhL0ow/HX1xhByq6Zq8hcb3EHcb
	 YYyn94+J4Gn1w==
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
Subject: [PATCH AUTOSEL 4.19 2/4] net/iucv: fix the allocation size of iucv_path_table array
Date: Thu, 29 Feb 2024 15:42:02 -0500
Message-ID: <20240229204208.2862333-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204208.2862333-1-sashal@kernel.org>
References: <20240229204208.2862333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.307
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
index aacaa5119b456..da4cee91fc63d 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -192,7 +192,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -603,7 +603,7 @@ static int iucv_enable(void)
 
 	get_online_cpus();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


