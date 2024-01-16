Return-Path: <linux-kernel+bounces-28042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4582F977
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D8DB259AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1955FDB7;
	Tue, 16 Jan 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpNsY49m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F614377F;
	Tue, 16 Jan 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434964; cv=none; b=kwGKbc249F7enKk3uF2Sx0USygjWK0JnA0cEFT2eXosklumHa3qhGycXx0idgE7y49NKEd/xYq/+mjBhQswXx2DSgF7FpvJalvsUFEKQNrao5QLtCmfkBxco311mn0yu/cikD7/dSMQLPn2/hL4gmYVnGlflhLsulVzkdABVtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434964; c=relaxed/simple;
	bh=ucOR01tQxbSQYvNkQ21i1Zn9JGJ1tZOEd/21cZ/km/A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=YPYeEVQSb7anVkSKwIbmNSpIPIL4dcgYF0nLlHY1CWAjU/489XxHpZFFp1+LgO8p/xun7eIYeCQi9WisP2vTKBOcljw4lDpmlfMyEpQ1xuZq1w+UhMLSgry+tNqNCIb5VZ/Vb5yYh2JEKsth7JPz4zeeANpWy3jHjif4Y3fcAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpNsY49m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1667C433A6;
	Tue, 16 Jan 2024 19:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434964;
	bh=ucOR01tQxbSQYvNkQ21i1Zn9JGJ1tZOEd/21cZ/km/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpNsY49melFnAAG9d6IuqTPOtIKtG1MWnfhV8w2vxCBJteQdVrUFhYmat71KfAB1M
	 ElXzxYDRHexkDN3ZI2qku3eVvEtycgJKmvjiN+pvqBIY+N+4A/18xL9np5mrcYBUmY
	 Zezz2Ypb/HKHHkNLwHWJK2nDXh3F7kkQ8Ed4wa+wHvqxZLgyAn7TXSYSmKbemP24lK
	 vXZmaFbGB9GOEud2UYx1Dstf3u/OyTiD7cfR3optOjyTTEqQLYfyLnEOrGbvqkmjJs
	 IA8iM38uU+sblfBcrBFjk9lJCd5JVh5aJOcGCZsUhEQi/RIo0BD+bi7RqBhcDbQETz
	 szHqCHcRpuvQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 25/68] scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
Date: Tue, 16 Jan 2024 14:53:24 -0500
Message-ID: <20240116195511.255854-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 53122a49f49796beb2c4a1bb702303b66347e29f ]

We should set the status to FC_TIMED_OUT when a timeout error is passed to
fc_fcp_rec_error().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20231129165832.224100-3-hare@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_fcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 3f189cedf6db..05be0810b5e3 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1676,7 +1676,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		if (fsp->recov_retry++ < FC_MAX_RECOV_RETRY)
 			fc_fcp_rec(fsp);
 		else
-			fc_fcp_recovery(fsp, FC_ERROR);
+			fc_fcp_recovery(fsp, FC_TIMED_OUT);
 		break;
 	}
 	fc_fcp_unlock_pkt(fsp);
-- 
2.43.0


