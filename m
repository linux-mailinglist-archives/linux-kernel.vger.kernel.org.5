Return-Path: <linux-kernel+bounces-101705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A587AACF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F648B240A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09535481C2;
	Wed, 13 Mar 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bOmBWm1O"
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CD47F73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345385; cv=none; b=YkTMaKwfLIRB87Y5uhEJVFArb1bSYt7PMoS7MmMWWXOpWBy0WMGzHI/ZEPN83x3VFn41vEjotwNUBLjccnQGqx5JD8M3JakoE/Ny6gaiOVOQVdI3zj3VPDR14ihcWrIu1zWay0qf1BOYBODuXv5c0PgQ7C3caGzjJSF99JCr0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345385; c=relaxed/simple;
	bh=pp4LXFngDF4+q8ji9AIpWk8RWrPps5a8vPpc/kK6tXI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gVhqoNc/aezg8MQNSp8/+1fOH2tShZcg8igOXYeCpQOHuziChf7+CkATA7oACQGQWWa2Ftznp2gNaPQo5Vf21+35YZUNLFG5zVv2y9MMc5i3Ytx+SoBOqe5HFOb6cyfWorHmHZd88T5dOWJIJUIXpROUcsKnAaellO/9k/qXCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bOmBWm1O; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710345376; bh=HQifFwfX0M8y8rGR0NY8EFcblQgmXddYWZb64uaH1do=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=bOmBWm1OPJP1byMx8kVAq8RzeVPbDvX9Ex7j9Z5obv7m8cz8wo8To/6tyhFqWq5McnoL0W9TAhK/ODGiW9GCCcqFx4h1aMjShkKYc3SCO/SXMCFKE59Hf8Hki7Tqkid9RlUFnliWnTaSHH14vdpnpJkWWZlNRQf4slj+ARSCs39WoiQ2Vp5VIrsXL6kXSXs0JytXFBRhT8JjUpFkA/O9gokushK/4n0G148ojazjOHZ28XrSEYDeWGoV5PekjTyrb7wYeg+kpXCasBO0rXN1siGFMuSUWTB6JnbKhZBPjSnokAY3JIyXkUyUbvQNH/4Ou4d+6VzAbb6eKJlGJQyH5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710345376; bh=1dXyWB88sInwaog4+SySHNcbPi1wuEJizdAvgbaiPCe=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ihPQOPF6/SAjYIGJL8Xdsf14E8OOgealy5WfnWBgKUNlJV9kSwBFChylnRIQPnxeNcmtrF04aJPe6RWEqD80mpzfcz+gH0PKINNGJLGuect6nilGTPVIol1Zcc9//RKB3r5TAu9QjAjXyBE9CfGhOebeAwa9Yor1YLruW+rWCcFK3rJc6aJvHGEK2Mym5B4IrP6Ifj0tmP/glqtxBPhmdpnCrTV92FVt6zhT6zN7vBmt+y+6gYtfziGnHTr+m/tJ+MN1o8X35rB/pYFPbl6JoW5qV+5rdjw6iyzPjxpeATUyGnFDsg2pzU9nCVwTYVAkuS3B9E+3gwlv1az4W3SOIA==
X-YMail-OSG: BO106gQVM1ms7EUlA6QCAC2afvbSJ.wx60Q33uIABxg6taTrgPUOJxDyv53SXeO
 VIlSXC0fpNVfxefSZE9Hn7IU5UGIXWDg8wOxpClibzvsg7.5vgyXCqCwD8BmSohZlHjv5TF1udAP
 wAc8pHa_E7wxVFAjCuL.KQ3mHcSdpadtLM251q.NQz6xSLs4KqLCMKLuza822phQocDQ2L296HBy
 ofqUBwXlYo9AXVdG.6CAJY4HxBLhZYNqdBmOp4b20_ijbHjzF9bkJwV4kxfEE3q13X5Rq9hyh8b8
 I9QI7VJq1D0794MS0qmVL60bId_bKXJ7oRNCixGd_NbCPmFqMnC6nq776MnFak_vD5mbIPdnBvRY
 HdmJ_gT6hK.2jisPWGmd7nqcdAZcZevZtbbLWuu6JSnKLQrqVc1zQpmFDvJutO3KXOx2h3go2DGR
 t6iPXw5sD2lXWkM42gZS3i0IVLvcAAbHs_aBTRiHx9qKBdZa2Txk.a0Ep3Xg3GxbTxJWnI7v6wad
 cgDeJmuBNhcUTwtMVaR0PSOVgO4zJ4wENkPHVpcjdNKlRm1bkM253GS4P13X.d72bC3lBIgCekYA
 2LlPy2JdZtIvY457Hry5xPTOfXnCp8uYeCtIBxmT92f2tNKeuUG6EX_SikRDpivfe4G7.uz1nEQu
 7kxJUvOMjKwC6PjpKdyHTogKne4MIYb4I5bxcQ9bgTZU6gN.gWvo5se9nTfwYaHgo._WMbrAB2Fc
 Xsm9FleFjjPUVEQ17MFcdD89Mglveam3AbN6193.FHrqiRcJxEPDH3Cvq23xNsq3WVSfw5uPqqUr
 uuEWFHgNXV5.uaWQNdmGr8ZS6iYg8RVwQ1A_u2bMUVT.wFgRbdQ1KztKDkdbaRsUKKpaD7P81Hiv
 GE6KovhwysPitsw4YbWLb881q4.SMekWmw_CXyoCrrxVtcd3yjMc3UNQVEe9SZQUEibPyxld20aH
 awVVMe2Yid_XogtrXeDzxpp1RYpRePb_4qG1e2Txaj2cixX9zMsTgdR37pHTPHwt8cerxRYyxtJk
 CPswyhLDxa9Ddf.DFnockFy3665dMvPImCETU6OiP1Ndrf0u_c21NFEff1pBK6NIXvNwrMizMN9M
 DyXkptP0xNlQdjrkRKKkxaQpF4wGkfGbBrXN2SaeJfwIlLn.odGtRmmV1ifgun690qyxkCwEroRh
 B25KBFu1nKp8G4zTTplwCbqYmsS1vaZqgVTGUAq_G3D_HCX37RxdGZupbOvZEZmCS7JJBwE1q_rW
 2ICu5eoo3lahfJ8v_SQEGWPxda_UubBAehVB41UaGz7xK4aZm53rnWViWUT3wRQpBx2pyRcbxOMc
 furjc0NV_S2XY4eKtabN.scuHWW9BEbKEbh18cSQRMMO0fGZLD1MhkqwFrbWTm0IqY7keDbfQOxB
 8HKY.0sQ5R297wTW8rUqC4sMbgGkBsO4eSMN61sX1NSo8aQhvaYLmvxhOBuoONeXJtxQzzO1rpFM
 kClSz29uFW9Q.pwXgKH7114JBZjEzSSVQpj3GVwWWm1B60MeaN4Iy_F4Gv26ge5dG0_8omD7nU_N
 qGfAvQw4p6h_C79vFvuTEK6PJHdCCejzQcYBcmHytZIw9pucnt8v9a9fJyhMIwK2c61cnBqIYRh4
 EFDhtz9FsMfbFv0ZFM.iph4ZB8wrrAYHWEiXsI.x3Jtf0D8_RpZ_0D5yBhnJPyyUiccXX6GFVpIz
 pKf988KvjRb935i.QzSqJn9lwtPHxdpgjrBEdN7V2V_StDFV1DKuh3EUtPmRlVZdsCLRIGRnZ7sr
 yZQwJlawHaXNonbRhAf9tDfmxB.HGGXFduRCDqNWuBGv5Iah41CPEOECPkz4peWf.e_ZMV59MNLN
 O6t9Rbd1VX235liRFmb37TyHs5.IEkqWv6PqNAYvEgieCozWvzolXObqTpKCileyjzcCA5X8F_PJ
 L5Vi_SZERjMMeBHrgwZ2JUrPr33cITVl0J0UVT.ZkS0qUP6F8UkcUNkCAvPtfXdIt2CdeRacyq41
 unfr8f5DsU92r996Nj1bJkAJDRLE7mDy5g4oVL00F0bKGTQMZgIrrCa3ZD4A_tohbITsPDh6EBk1
 ExLguuj0iiHd53yT2fwLeCDkUBA8KMWrgQsodtMyv7iOqX2g9jDiN.p8hvk3ofbbYQmtOdGlybfB
 xWzIETttkMODDijAZLp2opwhmKWXXHkIQ5tH0QlX1cO2x15cFtFzfqcwGG3DK9dSdrn0310HfvCe
 ZoSfeE3cC7ZeRFHL28CLZbkt6q3xry7s6e5YPI2syR3V7D4G46UGylJYFURGuEbPgMiqlgnTX_56
 bWWZD2nu.rsMKmM4UnT.t
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 84784da5-6766-425d-871d-e04113d1b9a1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Mar 2024 15:56:16 +0000
Received: by hermes--production-gq1-5c57879fdf-vxz7c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b737881f63ff71b9e355884c7c9546fa;
          Wed, 13 Mar 2024 15:56:13 +0000 (UTC)
Message-ID: <045f54ea-4057-43b8-81e2-5cc1b3966d04@schaufler-ca.com>
Date: Wed, 13 Mar 2024 08:56:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2] LSM: use 32 bit compatible data types in LSM syscalls.
To: "Dmitry V. Levin" <ldv@strace.io>, Paul Moore <paul@paul-moore.com>,
 LSM List <linux-security-module@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 linux-api@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, James Morris <jmorris@namei.org>,
 Serge Hallyn <serge@hallyn.com>, John Johansen
 <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <00734a64-a5fe-420c-bf6e-bee27c9d83be.ref@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <00734a64-a5fe-420c-bf6e-bee27c9d83be.ref@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

LSM: use 32 bit compatible data types in LSM syscalls.

Change the size paramters in lsm_list_modules(), lsm_set_self_attr()
and lsm_get_self_attr() from size_t to u32. This avoids the need to
have different interfaces for 32 and 64 bit systems.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h                        |  4 ++--
 include/linux/security.h                             |  8 ++++----
 security/apparmor/lsm.c                              |  4 ++--
 security/lsm_syscalls.c                              | 10 +++++-----
 security/security.c                                  | 14 +++++++-------
 security/selinux/hooks.c                             |  4 ++--
 security/smack/smack_lsm.c                           |  4 ++--
 tools/testing/selftests/lsm/common.h                 |  6 +++---
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 12 ++++++------
 tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
 11 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..f9b5baf1b5f4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -265,9 +265,9 @@ LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
 LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
-	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
+	 struct lsm_ctx __user *ctx, u32 *size, u32 flags)
 LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
-	 struct lsm_ctx *ctx, size_t size, u32 flags)
+	 struct lsm_ctx *ctx, u32 size, u32 flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..3180d823e023 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -478,9 +478,9 @@ int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			 size_t __user *size, u32 flags);
+			 u32 __user *size, u32 flags);
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			 size_t size, u32 flags);
+			 u32 size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -494,7 +494,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
-int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
@@ -1434,7 +1434,7 @@ static inline int security_locked_down(enum lockdown_reason what)
 	return 0;
 }
 static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
-				    size_t *uctx_len, void *val, size_t val_len,
+				    u32 *uctx_len, void *val, size_t val_len,
 				    u64 id, u64 flags)
 {
 	return -EOPNOTSUPP;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9a3dcaafb5b1..cef8c466af80 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -779,7 +779,7 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 }
 
 static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
-				size_t *size, u32 flags)
+				u32 *size, u32 flags)
 {
 	int error = -ENOENT;
 	struct aa_task_ctx *ctx = task_ctx(current);
@@ -924,7 +924,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
 }
 
 static int apparmor_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
-				size_t size, u32 flags)
+				u32 size, u32 flags)
 {
 	int rc;
 
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 5d391b1f7e69..8440948a690c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -53,7 +53,7 @@ u64 lsm_name_to_attr(const char *name)
  * value indicating the reason for the error is returned.
  */
 SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
-		ctx, size_t, size, u32, flags)
+		ctx, u32, size, u32, flags)
 {
 	return security_setselfattr(attr, ctx, size, flags);
 }
@@ -75,7 +75,7 @@ SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
  * a negative value indicating the error is returned.
  */
 SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
-		ctx, size_t __user *, size, u32, flags)
+		ctx, u32 __user *, size, u32, flags)
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
@@ -93,11 +93,11 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
  * required size. In all other cases a negative value indicating the
  * error is returned.
  */
-SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 		u32, flags)
 {
-	size_t total_size = lsm_active_cnt * sizeof(*ids);
-	size_t usize;
+	u32 total_size = lsm_active_cnt * sizeof(*ids);
+	u32 usize;
 	int i;
 
 	if (flags)
diff --git a/security/security.c b/security/security.c
index 7035ee35a393..a0f9caf89ae1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -785,7 +785,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
  * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
  * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
  */
-int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len,
 		      u64 id, u64 flags)
 {
@@ -810,7 +810,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 	nctx->ctx_len = val_len;
 	memcpy(nctx->ctx, val, val_len);
 
-	if (copy_to_user(uctx, nctx, nctx_len))
+	if (uctx && copy_to_user(uctx, nctx, nctx_len))
 		rc = -EFAULT;
 
 out:
@@ -3918,14 +3918,14 @@ EXPORT_SYMBOL(security_d_instantiate);
  * If @size is insufficient to contain the data -E2BIG is returned.
  */
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
-			 size_t __user *size, u32 flags)
+			 u32 __user *size, u32 flags)
 {
 	struct security_hook_list *hp;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
-	size_t total = 0;
-	size_t entrysize;
-	size_t left;
+	u32 entrysize;
+	u32 total = 0;
+	u32 left;
 	bool toobig = false;
 	bool single = false;
 	int count = 0;
@@ -4011,7 +4011,7 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
  * LSM specific failure.
  */
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
-			 size_t size, u32 flags)
+			 u32 size, u32 flags)
 {
 	struct security_hook_list *hp;
 	struct lsm_ctx *lctx;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 338b023a8c3e..71e6e7079d7f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6556,7 +6556,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
  * There will only ever be one attribute.
  */
 static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			       size_t *size, u32 flags)
+			       u32 *size, u32 flags)
 {
 	int rc;
 	char *val = NULL;
@@ -6571,7 +6571,7 @@ static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 }
 
 static int selinux_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
-			       size_t size, u32 flags)
+			       u32 size, u32 flags)
 {
 	int rc;
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..0891fcc11e40 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3641,7 +3641,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  * There will only ever be one attribute.
  */
 static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			     size_t *size, u32 flags)
+			     u32 *size, u32 flags)
 {
 	int rc;
 	struct smack_known *skp;
@@ -3762,7 +3762,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
  * Returns 0 on success, an error code otherwise.
  */
 static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
-			     size_t size, u32 flags)
+			     u32 size, u32 flags)
 {
 	int rc;
 
diff --git a/tools/testing/selftests/lsm/common.h b/tools/testing/selftests/lsm/common.h
index d404329e5eeb..06d12110d241 100644
--- a/tools/testing/selftests/lsm/common.h
+++ b/tools/testing/selftests/lsm/common.h
@@ -7,7 +7,7 @@
 
 #ifndef lsm_get_self_attr
 static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
-				    size_t *size, __u32 flags)
+				    __u32 *size, __u32 flags)
 {
 	return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
 }
@@ -15,14 +15,14 @@ static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 
 #ifndef lsm_set_self_attr
 static inline int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
-				    size_t size, __u32 flags)
+				    __u32 size, __u32 flags)
 {
 	return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
 }
 #endif
 
 #ifndef lsm_list_modules
-static inline int lsm_list_modules(__u64 *ids, size_t *size, __u32 flags)
+static inline int lsm_list_modules(__u64 *ids, __u32 *size, __u32 flags)
 {
 	return syscall(__NR_lsm_list_modules, ids, size, flags);
 }
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
index e0e313d9047a..288302a444e0 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -40,7 +40,7 @@ TEST(size_null_lsm_get_self_attr)
 TEST(ctx_null_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 	int rc;
 
 	rc = lsm_get_self_attr(LSM_ATTR_CURRENT, NULL, &size, 0);
@@ -57,7 +57,7 @@ TEST(size_too_small_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = 1;
+	__u32 size = 1;
 
 	ASSERT_NE(NULL, ctx);
 	errno = 0;
@@ -76,8 +76,8 @@ TEST(flags_zero_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size;
+	__u32 *syscall_lsms = calloc(page_size, 1);
+	__u32 size;
 	int lsmcount;
 	int i;
 
@@ -117,7 +117,7 @@ TEST(flags_overset_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size;
+	__u32 size;
 
 	ASSERT_NE(NULL, ctx);
 
@@ -140,7 +140,7 @@ TEST(flags_overset_lsm_get_self_attr)
 TEST(basic_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 	struct lsm_ctx *ctx = calloc(page_size, 1);
 	struct lsm_ctx *tctx = NULL;
 	__u64 *syscall_lsms = calloc(page_size, 1);
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 9df29b1e3497..868641dbb309 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -31,7 +31,7 @@ TEST(size_null_lsm_list_modules)
 TEST(ids_null_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	errno = 0;
 	ASSERT_EQ(-1, lsm_list_modules(NULL, &size, 0));
@@ -43,7 +43,7 @@ TEST(size_too_small_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size = 1;
+	__u32 size = 1;
 
 	ASSERT_NE(NULL, syscall_lsms);
 	errno = 0;
@@ -58,7 +58,7 @@ TEST(flags_set_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	ASSERT_NE(NULL, syscall_lsms);
 	errno = 0;
@@ -72,7 +72,7 @@ TEST(flags_set_lsm_list_modules)
 TEST(correct_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 	__u64 *syscall_lsms = calloc(page_size, 1);
 	char *sysfs_lsms = calloc(page_size, 1);
 	char *name;
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
index e9712c6cf596..66dec47e3ca3 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -25,7 +25,7 @@ TEST(size_too_small_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
@@ -41,7 +41,7 @@ TEST(flags_zero_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
@@ -57,7 +57,7 @@ TEST(flags_overset_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	char *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
 
 	ASSERT_NE(NULL, ctx);


