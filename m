Return-Path: <linux-kernel+bounces-27812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6582F641
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286C1B24131
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029082D022;
	Tue, 16 Jan 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkcXuZ2B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2372CCB4;
	Tue, 16 Jan 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434248; cv=none; b=ONXTbkn+hk4afTk++if+oIrvtgU2wp9ktvwKr9PzRjEzSgtl0zhRLV7ZZzQLDKwbDpORd2Aj02mNjj8c5+q/Sjmre643H+xrWvpJje4oNyENBK8gN9vcDJCKtpQbG7xRzGxCCvHjgKRtCw6qRkiYXt/6FL0jmrC20qIp7ymAM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434248; c=relaxed/simple;
	bh=ucOR01tQxbSQYvNkQ21i1Zn9JGJ1tZOEd/21cZ/km/A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Uw3ass56lh5Ce78xOzPvAuUbqamAeGmlylb9GfuX6w7IVftC8sqIegjdwPiwPjaMXIiy4f9Gte/BNb0vrmvJySZ8PUaugj631eAZK8AjpypQwu/fA6uB6XMAnJz9IKsymCrop0TAFa+ZQFdGlyh7rXKe0bNbT4vHQQPKqAnb5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkcXuZ2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F2C43394;
	Tue, 16 Jan 2024 19:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434247;
	bh=ucOR01tQxbSQYvNkQ21i1Zn9JGJ1tZOEd/21cZ/km/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkcXuZ2B9KZM6oJo+1oCCIKsoPPiW5/fghVJ+13rAdsIQn9I6qkkb97Vq4McRLeF6
	 kAOsIUEO3ceC2H5YxZ/Yy/5TiVsa8lFzqEItm51I3BOvRuVKWk0wLCYD4IUMHaSYms
	 AwsONGRh11Fq7FbQH74gkAtEqT/9AA5cx1V0QxoK2hJAzVKFrWJjuE7Kx/45alsV2C
	 bLw5Luezis/bLhybgtTgujZ9V+WJVBY22Bv00UZjf8XN30jk3ulnOhVzjbQkq06G1F
	 N1jMFHvAm5m7hsDSsNjzXITzDu6aCCkT506sPsdZbndNgd0XgiOUlfBsZBXj57sVui
	 yuaubhHDcrGUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 042/108] scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
Date: Tue, 16 Jan 2024 14:39:08 -0500
Message-ID: <20240116194225.250921-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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


