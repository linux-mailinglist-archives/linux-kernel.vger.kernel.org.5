Return-Path: <linux-kernel+bounces-87517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3BC86D566
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F048B2564F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA46151CE5;
	Thu, 29 Feb 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQxTzMQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95414374C;
	Thu, 29 Feb 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239317; cv=none; b=nAXENRX7Q/Z2v4JT8YYSqwMSfH0vdNR+z2JOjArfOH2TeLthWFL4PXBQZAHBV0qwXVAMWndIaC6cyCMkqBzMeXhbe4zd1O5p820iM/buGC2xgvdjZIogCVQxHwb67YISyCFlDK2yJ6NsQ0yKKTN31J2wLNXuKkrB0SDA7wtSgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239317; c=relaxed/simple;
	bh=C0gSXFhMFIQyyEvs+6TeLlPz+LAlhzCRatW1d/j8fyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4urEnNxBcCUvILSCAzwBxrrENrqLo0eAccrBWlgdGmZUhqJTT8GE6RaEcxfrIGlIymRoT+nMqOKmhxxxUFi4ubVVwWFhNWcHfFhkYlLgeXLo1VU/dbfRheuHeei7Pu+JsNqf3ZVxEeO2k4qL72P25+V0yXCPoA7dAMHWPp/Uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQxTzMQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6A6C43394;
	Thu, 29 Feb 2024 20:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239317;
	bh=C0gSXFhMFIQyyEvs+6TeLlPz+LAlhzCRatW1d/j8fyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQxTzMQGyf6Ijcdo5ux5YEEHRhYhh1+5k445Ws/9mtQRJMhwcgSAS/Bw8onE8Dxz4
	 n1wcPhkm2fP3kPg3Ux2CK7g6iXSpFIWQURMR/0QJDn1bOGxe3Z/qRBHfNNYna1HPBt
	 HJQf9OW9MtoDT+MQmJlCP21fpUGeSXy7tRmwj2izYmBmjofmK0vYKTtuLZW0JNqiPA
	 SXvDQ5F2cRMQRtdUVay71dNxiaAxxL/DORrXUyDkDeb1TGogZf/RfK1UiDjaec10mw
	 70ohRq6IzcOljPN1oXaATe8+HjOa2+btaC12O5AkDPeW/G4PKRjcvU14/udfhZ9lSz
	 eOV2E7xeE/F+Q==
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
Subject: [PATCH AUTOSEL 5.4 3/6] net/iucv: fix the allocation size of iucv_path_table array
Date: Thu, 29 Feb 2024 15:41:43 -0500
Message-ID: <20240229204150.2862196-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204150.2862196-1-sashal@kernel.org>
References: <20240229204150.2862196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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
index 392f8ddf97191..8b5b8cc93ff8b 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -179,7 +179,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -590,7 +590,7 @@ static int iucv_enable(void)
 
 	get_online_cpus();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


