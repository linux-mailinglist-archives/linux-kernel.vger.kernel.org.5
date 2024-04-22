Return-Path: <linux-kernel+bounces-154333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78B8ADADB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BB628246E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1771C6888;
	Mon, 22 Apr 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y16p5PeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2201C6613;
	Mon, 22 Apr 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830349; cv=none; b=oHhAUN3HeC+tKwMW/YnUIbhtoOYSY4HVpoWQQ9zUSRGtYNvQxbfs+pKQH18xGjVh2BGkadob0Yp4ws6gzSUcpxIU0FrryPSqIKyX0zO5b6ns/R5es5Paxnptszd/QoB33GOqt1DQ8RkgIS4aNUsYf7KM/95OERIqHZHNJrCkh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830349; c=relaxed/simple;
	bh=i8QgY+5mtwteE0p1EWllKNEPkB0GTFOHgTfblTkxWnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJxOABmdghHjG5GMZrl1Nd6Kizr2s+vLnpYcFyGSyPvuTEHv38D8mv7vVaiYqCD35LZ4nfHUZSh6U36L7sqiMtuuahDjOf6jlxsI5tfsQqTeC6/V56Xp5dEpxrB+ixnzEsf8wMlnr61jrL1KfmEhr/KGV7f6bn1X8I4axVXbzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y16p5PeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC97C113CC;
	Mon, 22 Apr 2024 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830348;
	bh=i8QgY+5mtwteE0p1EWllKNEPkB0GTFOHgTfblTkxWnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y16p5PeXZR4NKdKbh5aSxyXvlPY9gU6Hd+QJQKJt3ToQteySK3NN+2o+ptMYvJPMC
	 AmC9B3vPsQwXAZJmtCwL6U8wNRZ94lL61MSlViEsfX8AYBPJfwPii+ZadZkTzcGjqD
	 npTnb/csif8EObzla+6yXp3HUbMtq0pzfqSXFytx9JYwAY74RkZBAMVqei31vVdhkI
	 ZqK7gXTVm1jEPzVJ+rczR15LsxM5HQ8RBPxNOjn521Aq/Il3e+QPsgd9H4OpPYBkYD
	 9FOQnwGoBgSoqb3qoxxJMCj3qqSMglvTiQ6LC4xLJCsM6RH6NMSceeiUhzsZVAWpBK
	 1txegHJ5si0hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/9] scsi: target: Fix SELinux error when systemd-modules loads the target module
Date: Mon, 22 Apr 2024 19:20:10 -0400
Message-ID: <20240422232020.1615476-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index e6e1755978602..4edabab65b879 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3458,6 +3458,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3534,11 +3536,21 @@ static int __init target_core_init_configfs(void)
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


