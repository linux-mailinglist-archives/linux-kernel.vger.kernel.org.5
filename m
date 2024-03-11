Return-Path: <linux-kernel+bounces-99114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B719D878397
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D8F284BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A86994A;
	Mon, 11 Mar 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgh+SEIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5069314;
	Mon, 11 Mar 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170089; cv=none; b=UZQDpbyIcCHScEQO/CMjx32ci/KpkSwxSbrdGWpYvEdtuVIM2bDMQ50m2sNweHFnlFXxYndnzPBd4FB9O/sO/51iIJhXi1V+K0JPTyu0LKUX9/zDVNU1fpJAqNO5eDVXOlbytJpjMwPprdl7jqvTU7/5cg5tBUMoRh1oT9yCkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170089; c=relaxed/simple;
	bh=LE8jwGkMU5Hm6hrhMTyPiG6zSNHB4RBSwMNNmbZ1gpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW9228s/htk3XRDNiD2szaLqq/zpfCQ/eHiMvj2RXk8SEqwbS0C+F4StcWWIYiUdxdetFLFocZXJexefUecc2wrnX244T/EvkfcKEBNgBsnOZwHIzrJIYQFQbCsjecVi570h1jaAQdNk4d64knkMB4gwK6s+KcffctgiAnX/2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgh+SEIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71536C433C7;
	Mon, 11 Mar 2024 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170089;
	bh=LE8jwGkMU5Hm6hrhMTyPiG6zSNHB4RBSwMNNmbZ1gpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgh+SEIg0aT+7DJy+w6jdUqMSH5pd67Kp0utf/rxgZKNJhQr/UhTvHR6Bm0YzsTZV
	 iXv+G0q8BDYYvPM9hVGPpGZhy18Il4VJ3blTxf8Gp9YgkRfTQojPGDmXjZsv1a4PyX
	 gHXrSG2E+ZH/2eehPGeTSySUfv8yj4CCQDsf+3wwhN9cUOSJ9pFf3s+JN1WcOHQoQZ
	 XXV9WwVTRJzghLThYEdUKTtcBjroLXpPzwx95dNvKPSzcKdiJnkvfh9BT6U4BLmeT5
	 VwsKyzfDyeKza5nE0QWfV6UoKfA9aEDaOSHZwvwj7tus0vLUVZ6rYLnTdipgxpNNX8
	 b/l9TbZfKKDGg==
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
Subject: [PATCH AUTOSEL 5.4 2/4] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:14:42 -0400
Message-ID: <20240311151445.318822-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151445.318822-1-sashal@kernel.org>
References: <20240311151445.318822-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
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
index e72f1dbc91f7f..04fa7337cb1ef 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6040,7 +6040,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
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


