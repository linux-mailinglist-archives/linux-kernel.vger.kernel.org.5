Return-Path: <linux-kernel+bounces-15720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639278230E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CAE1F24B5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB51BDD1;
	Wed,  3 Jan 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4lwkSa4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6071BDC5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55748C433C9;
	Wed,  3 Jan 2024 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704297435;
	bh=3PfcWwd6revmKQ+P7oeW/epk2Jli0IGYdbJw4sDRDcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4lwkSa4/5o6qLH3t+1W4bSQpDY1x1qz8rx9BQ5IzXaVc09MGPcJlf9qb8i8G9s9V
	 mHoHD61mNxrvIjvBM2JDSCcbhVYAIV6LYx60NX8kPw6GFhHkrstb9l17NF9i3Jk4PV
	 9Y8mkwjXJs89ZmniTW/Jxo3S31GOW5khJLCaL4LowShL7iEppnlgYgY/S004CfPyzd
	 dizB9PXsCRq7cDrIPNm7lzF8SH7hwDtE0dhqCFswf/KKcCvXWcT15CSBJ6XUVShz35
	 y8uCvTmeOBh8zBYQsqfi9ysAxNp6OViN+2JthKDzptByOg594agbMnEJ3+h0sIx+/f
	 Y08U1Epw6A87w==
From: Arnd Bergmann <arnd@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme: trace: avoid memcpy overflow warning
Date: Wed,  3 Jan 2024 16:56:56 +0100
Message-Id: <20240103155702.4045835-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103155702.4045835-1-arnd@kernel.org>
References: <20240103155702.4045835-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous patch introduced a struct_group() in nvme_common_command to help
stringop fortification figure out the length of the fields, but one function
is not currently using them:

In file included from drivers/nvme/target/core.c:7:
In file included from include/linux/string.h:254:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);
                        ^

Change this one to use the correct field name to avoid the warning.

Fixes: 5c629dc9609dc ("nvme: use struct group for generic command dwords")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 155334ddc13f..dbb911fd502d 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -84,8 +84,7 @@ TRACE_EVENT(nvmet_req_init,
 		__entry->flags = cmd->common.flags;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
-			sizeof(__entry->cdw10));
+		memcpy(__entry->cdw10, &cmd->common.cdws, sizeof(__entry->cdw10));
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
 		  "meta=%#llx, cmd=(%s, %s)",
-- 
2.39.2


