Return-Path: <linux-kernel+bounces-154314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4D8ADAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2313AB29FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E6184127;
	Mon, 22 Apr 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODCpPlnQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C41184102;
	Mon, 22 Apr 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830298; cv=none; b=Sl0lHhTOk8+LUzmOmXoLfOnCxONOUn5UU+IZkpk6lM1LsEQ1XdoTza9lUdet1bQtEI5IWCdiz6RZDF7KNxu6NTTQt7xTqNWpegYr4niU2VAn8f/dVymWxrgVXwii4TNa3HIS4PwvYZtRW3uQAUV2dZ7WuvJCZtGraBVZRvtdkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830298; c=relaxed/simple;
	bh=aLMKqhF13Ri9k7BNPWedMZLP/rrfvJ7vXCsezow3Ymc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM0es7SaxFz5n7jrgCtu/Z8ZxBA3NAnCR0BQ2xi88JLjHqqNTApvA6fb/mEanimdaPvlhs+gzA98gPEsK6cerhBlYSIePrKdA8M3QEg6fF3jXDoaXOTxV1kfJ7F/jbMJr/+j4c8vmfMrNW9+U2Wn0YZtZt6ASiaWLJ37ftfCXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODCpPlnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0712BC2BD11;
	Mon, 22 Apr 2024 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830297;
	bh=aLMKqhF13Ri9k7BNPWedMZLP/rrfvJ7vXCsezow3Ymc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODCpPlnQUh2J/eHWL60XLgvOY2aem24U2+W/6VpXdrtjjBsveKt4Qoo6FhQo+dpkZ
	 ZQkfaqQQIjW3jeA2JhK3iH478u7vttZOpVpxYcrOzlxct+i0Mgj82dQeGrPa+mL/rk
	 9nMeBPTd/5s0X33MTpgLm8dj9zBCb/mLG5s91BxTOf0VgO112/j3hvTOjh/FjLjCww
	 GP4n6Tx5hY4EtiE459Vo0kWyxrOllKHv/jlYkzDabRvzDvYxVYBZP74ZGeMfm61dx+
	 q3qBnINb+bhGyJy/8gx3VhOEXMsKQaeylf6Hh+8ha35pXxwV3JklgAHTB9wG/IO6cf
	 RDEjzQAtSrhow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/10] scsi: target: Fix SELinux error when systemd-modules loads the target module
Date: Mon, 22 Apr 2024 19:19:18 -0400
Message-ID: <20240422231929.1611680-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
Content-Transfer-Encoding: 8bit

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 97a54ef596c3fd24ec2b227ba8aaf2cf5415e779 ]

If the systemd-modules service loads the target module, the credentials of
that userspace process will be used to validate the access to the target db
directory.  SELinux will prevent it, reporting an error like the following:

kernel: audit: type=1400 audit(1676301082.205:4): avc: denied  { read }
for  pid=1020 comm="systemd-modules" name="target" dev="dm-3"
ino=4657583 scontext=system_u:system_r:systemd_modules_load_t:s0
tcontext=system_u:object_r:targetd_etc_rw_t:s0 tclass=dir permissive=0

Fix the error by using the kernel credentials to access the db directory

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Link: https://lore.kernel.org/r/20240215143944.847184-2-mlombard@redhat.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_configfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 023bd4516a681..30ce3451bc6b0 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3566,6 +3566,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3642,11 +3644,21 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
+	/* We use the kernel credentials to access the target directory */
+	kern_cred = prepare_kernel_cred(&init_task);
+	if (!kern_cred) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	old_cred = override_creds(kern_cred);
 	target_init_dbroot();
+	revert_creds(old_cred);
+	put_cred(kern_cred);
 
 	return 0;
 
 out:
+	target_xcopy_release_pt();
 	configfs_unregister_subsystem(subsys);
 	core_dev_release_virtual_lun0();
 	rd_module_exit();
-- 
2.43.0


