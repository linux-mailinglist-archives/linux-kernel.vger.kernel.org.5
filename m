Return-Path: <linux-kernel+bounces-99105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9C87837D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535571C21A13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00080657A8;
	Mon, 11 Mar 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLXnKtA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D83F65BA8;
	Mon, 11 Mar 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170068; cv=none; b=XwdgxofIBdgCfkg5JXrdjZlkqF8PiktDNtC8C+80vnns0ctmzjj5WvXRWxtxsio/JRwWJjU3ZUCxCvJkgp0LsQB7khVIoiKVg2Bd8OoyY6BlNYAaa/6AQMEoSuS0XNldl1ELcTCn3Tat260+0cx4tcWIueTZAtADXqbvzifnQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170068; c=relaxed/simple;
	bh=GnWtl6l52l+gUbfZkM8BRybvjTAPzKv3zjCkOuB8YF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQf8OE7B8quCfrq6yUGPVlflZE/X/jeF0Bvqlo3KuWO0B0x5c+aOWPaOyAB8eozr7a9gIxmJlAm4fpmFMQOe7WSmbfU9vKcCMf+Mv7dYnC/MACyhP0vBijupyaicEECoP9cJvuurM6CXLcz84DviQZt+Nj+J8gbhGYDDHb6tpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLXnKtA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA1C433F1;
	Mon, 11 Mar 2024 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170067;
	bh=GnWtl6l52l+gUbfZkM8BRybvjTAPzKv3zjCkOuB8YF4=;
	h=From:To:Cc:Subject:Date:From;
	b=GLXnKtA4At1C1vv84VegEATsfcIQb1gqFx6U+qVls+PvOcb1UYP17ENNHtCwAQ9A0
	 XGXta99tFH/P9mgo+h+9reddTrhDAuw88LyQCrIZNJKeR+majI6YyzL/7nDM2k3PzU
	 H9WdhaGgIe7orkx3K2YcT+Ft9xL7sQM6mANm/xvZjnvQMa7pxxc6bD4IqAm0IZ847K
	 HIgjXGnfHQ/vlB3CpR8PeMYoWplCa4JWMQlWqz3GqbUpMbFzAkEnsUqmCHry9fDeKc
	 2kR20O6stuqRYoBl3v2a8bae6HAZbWXHvWwRimUSglrhsGPa0TEExCPms962iRfI8R
	 Y0vq+mwMz80BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	jejb@linux.ibm.com,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/5] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:14:17 -0400
Message-ID: <20240311151424.318621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit ee0017c3ed8a8abfa4d40e42f908fb38c31e7515 ]

If the driver detects that the controller is not ready before sending the
first IOC facts command, it will wait for a maximum of 10 seconds for it to
become ready. However, even if the controller becomes ready within 10
seconds, the driver will still issue a diagnostic reset.

Modify the driver to avoid sending a diag reset if the controller becomes
ready within the 10-second wait time.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20240221071724.14986-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e524e1fc53fa3..8325875bfc4ed 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7238,7 +7238,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
-- 
2.43.0


