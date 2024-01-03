Return-Path: <linux-kernel+bounces-15719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9038230E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B741C23A65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A61B284;
	Wed,  3 Jan 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faOA7cXY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E21B270
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B40C433C7;
	Wed,  3 Jan 2024 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704297428;
	bh=NpPuzQFBGbgeu9AeAOqJOV1DXdhIz90+Va4NzPBZOdM=;
	h=From:To:Cc:Subject:Date:From;
	b=faOA7cXYIXfg6x8l7HMNTrgs7Nbr/DyiDw0mx6ONZ5H2KlMWcmx54k8Gx+Xwi16gz
	 0W9fvhrfuIbCevzLuUA+4IV5SSRSCT6H45ldbvYJ1PU4d1/iTC4i/bkEJ7RdSwTgVR
	 u80wcRWQnHpjXylTi3JdpOyLFKl40YElLrvZXuOje7RijnPVP+ba8RlX8Pel9U1c60
	 CMIoa2ePFb37x0xNySPhjXmSf4fA/2yX4rvadYY3f2TMaBfcH9Rcyu6tJPljr2eDk9
	 SbFnj04EgcDwbiNhlVlMB7E/gyHXO1s8J2mG2PVqX+Jh82+aABEsLsDdpTtBET5N3T
	 H0N0q5+gvut8Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Date: Wed,  3 Jan 2024 16:56:55 +0100
Message-Id: <20240103155702.4045835-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An earlier patch had tried to address a warning about a string copy with
missing zero termination:

drivers/nvme/target/trace.h:52:3: warning: ‘strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]

The new version causes a different warning with some compiler versions, notably
gcc-9 and gcc-10, and also misses the zero padding that was apparently done
intentionally in the original code:

drivers/nvme/target/trace.h:56:2: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]

Change it to use strscpy_pad() with the original length, which will give
a properly padded and zero-terminated string as well as avoiding the warning.

Fixes: d86481e924a7 ("nvmet: use min of device_path and disk len")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 6109b3806b12..155334ddc13f 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strncpy(name, req->ns->device_path,
-		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
+	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
 }
 #endif
 
-- 
2.39.2


