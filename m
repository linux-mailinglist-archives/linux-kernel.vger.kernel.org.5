Return-Path: <linux-kernel+bounces-154342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A728ADAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AF8285FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F08200125;
	Mon, 22 Apr 2024 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkZkQzZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E200106;
	Mon, 22 Apr 2024 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830369; cv=none; b=nFQT5k2CbU3PBPqBvczgTJwapQTBswGfh/PcILaXAzzMwKLv5r5+ACvcjtC9LYZmpwa+XtrvHwoQa5XEeC4oJZjrFHKp64zBzUN7KiHHQDhjZ37du4aWALphCbYhkdkuWTpj1mzBfhcRFUhUksmLUwGrw4aTaptSEUWKOVARW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830369; c=relaxed/simple;
	bh=IXYU0oV9HyFUX2KPKaztr5WrKO/mFdj3zWK9i50s2Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEQnX354qdmTiCXURbUa2Phkm9yVUxNL8KUKzRdvg3ZXclktnqr6EL7ZeL8AdYDXFtvEk5TJzDY2G9IOPqwBCrYmSETLa4r25GnCJji15o/z99rVQSqs+QLNyfKG9vVKTEBiofBr7YCoXQW+/eiO47drq7vmPdVZQ7dauwQV8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkZkQzZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2BCC2BD11;
	Mon, 22 Apr 2024 23:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830369;
	bh=IXYU0oV9HyFUX2KPKaztr5WrKO/mFdj3zWK9i50s2Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkZkQzZ4rz60OY1j0X8+PRInHoJ2KKVkLFDmyxwGWepwPDQML1PRSv/oSYoNZGBdf
	 BlOB68MtstglAW9fwDgJL0PwxA4ADebXfxuNmlfUbq9ugdU/vwIrslynU2oxevL7q/
	 f+PprwADx/AJ7vdjGtdD+MzP3c//x5Nclhsw4GRC4bcJomliEeZEYr1Cxy2Ymt4nFR
	 UX0fPJF45OLWdgizEufhrvdFBghjEu7IIbSzD5g4ZX6ezCYyTcXOoH250/sMrG0a8v
	 WhcTlnKFvs58XDB25UcWfeGJkfBLKwjuWTx+idpm2E581SLluPgR2pB74rOy3/dNaP
	 vRk+5JNoRp4MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/7] scsi: target: Fix SELinux error when systemd-modules loads the target module
Date: Mon, 22 Apr 2024 19:20:37 -0400
Message-ID: <20240422232040.1616527-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232040.1616527-1-sashal@kernel.org>
References: <20240422232040.1616527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index f6b1549f41422..10fbfa7df46ab 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3240,6 +3240,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3316,11 +3318,21 @@ static int __init target_core_init_configfs(void)
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


