Return-Path: <linux-kernel+bounces-116308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2388895E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6847299D42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C423D0CF1;
	Mon, 25 Mar 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PArOGCLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC11836C8;
	Sun, 24 Mar 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324223; cv=none; b=FjnATCIw8m2daBAG/bSQOgZSlqquxt+C9EbpZS2FnU4gPVZd6jSiQ722209ZWqMxr9MAhY7/DQLR90JT37/fTzJChvAF1YeG1FgE6VHdWnV3669QUr7JEJuynWcCTfrJXFSWLuETgSPNOaQkOtOUrAr1u9UeYa86Ba/7g9CAsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324223; c=relaxed/simple;
	bh=paOHW1kIZrwXOBOt+eRefXVJRjuNEshaUz8HY4Qj0Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1AtcUacJrbmZ4jyYcWJyRBLtZzSMHuBtsiu4MbqpzQqFaysPfLO/BWLCAAQ6NBsnw739GsS9m9qJB56t7TfVBCQtdikpv9igvzLloRT6OP6ADzkIYlXMnMQGfs0NiWHgjTKIAqSUdJPXqX8Iutx5X2CNyV3aRS5+4Zuxa81Tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PArOGCLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15640C433C7;
	Sun, 24 Mar 2024 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324223;
	bh=paOHW1kIZrwXOBOt+eRefXVJRjuNEshaUz8HY4Qj0Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PArOGCLXf/SXW/MASWdAIdee/OMuosdoNqKwQr/xADF72ZbMZupMTEJoi41zz/kzy
	 8JGdDS2QJk1XOZrvW/+b93nNT3vlHd1SnC5vea3q3lrQVy9F+bsh9Izu1yGivT/fP5
	 CLon2djfsNhl0mK/0917tJnfZ1JoC70baxs6Rx4AyEjmWF4po2hrT+Ebdz4hHDDmWM
	 sLTFxZUFSA5j1kvt/0QfYQSHhKTVRFAZ9Nb3AYdO+qVaJdyiY/IaS89jHYnQ5X9Z04
	 obTcokdnpcgKMLJF6NPDJqna0R2UxqhqMoEXk/WcciUqeeQ6stkTejEObnaVaJ5Y7c
	 s/fP1jvC1kGcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/148] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 19:47:51 -0400
Message-ID: <20240324235012.1356413-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 447ac667f4b2b..7588c2c11a879 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5584,7 +5584,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
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


