Return-Path: <linux-kernel+bounces-28193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D650982FB67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FAB1C25E94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456D16508E;
	Tue, 16 Jan 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdiqySor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A92165075;
	Tue, 16 Jan 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435418; cv=none; b=Y0Fwty49eqSZ1Mnae+obZ6HTDLngN/+H8eRJ0oOWrD1ov/4+7U/Lg1P/b39LpgprjywWcsvf5Gl+MUzpXNEvRmj8fLse7+o3CdvXvMMvDhpHRremDdWtnRpgO5KvL7OPop36PehiPpa/5vUFKFK3pCnnihl136qY5zXiBM2tBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435418; c=relaxed/simple;
	bh=n7IPx4XIssv8uc461znxElMzShES4xZYDqG6n5n7bq4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=WkyzU54OgN9vrM+ucwsqhgaySY+K3BF+/ke8+p2JT73CNJ3skg0vyJ+3yJ8d0ov1Xr6tTprMnadtClClrRpboVzC1Bu4WBgIWkkjtjhu1UQHLxzeRxDW1xGVlspUudjL2ke0/1YBJ4CQ+Mwf6UbTbHGHmwIZa1Pi2qaJQ2mHdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdiqySor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4960C43390;
	Tue, 16 Jan 2024 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435418;
	bh=n7IPx4XIssv8uc461znxElMzShES4xZYDqG6n5n7bq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdiqySorZBPz9RXkP0d4keT1GJ34nDr6A0b3BA7QsL3yoFeM2BKrcr/n3p6mc2a9+
	 1P1I9bFkNdlmWzt+6F0kdeN8k/jLDSlqvSkar/egriUn5ysq9d92CLLQTHakjDCkdL
	 4VHxaMVpr0CyVvfsuR7B/QAJWi6Gd/41agvH/g7sLUz3LCAWsPds3+/8Rt4gcmi1qC
	 /bbwg7kG7cwtbvxYZY+H9DBrGvWDQhXyGLyOSl28FdwOgHhdY1RDyKXfpM98Hpo7hh
	 M4IweJ8rj4/7xPoxUSuIIMqcGP0TfRXC9dtOSoodh4kQRQ1V/NyYrOx4ZTMvuVsmgg
	 X98VM7zDn78Rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/31] scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
Date: Tue, 16 Jan 2024 15:02:22 -0500
Message-ID: <20240116200310.259340-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 22e286f920f4..5e00ee0645f2 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1685,7 +1685,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
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


